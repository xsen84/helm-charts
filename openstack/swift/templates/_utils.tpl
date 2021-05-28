{{- define "swift_endpoint_host" -}}
{{- $cluster := index . 0 -}}
{{- $context := index . 1 -}}
{{$cluster.endpoint_host}}.{{$context.global.region}}.{{$context.global.tld}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 24 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fullname" -}}
{{- $release := index . 0 -}}
{{- $chart := index . 1 -}}
{{- $values := index . 2 -}}
{{- $name := default $chart.Name $values.nameOverride -}}
{{- printf "%s-%s" $release.Name $name | trunc 24 -}}
{{- end -}}

{{- /**********************************************************************************/ -}}
{{- define "swift_daemonset_tolerations" }}
tolerations:
- key: "species"
  operator: "Equal"
  value: "{{ .Values.species }}"
  effect: "NoSchedule"
- key: "species"
  operator: "Equal"
  value: "{{ .Values.species }}-multipath"
  effect: "NoSchedule"
{{- end -}}

{{- /**********************************************************************************/ -}}
{{- define "swift_prometheus_annotations" }}
prometheus.io/scrape: "true"
prometheus.io/port: "9102"
prometheus.io/targets: {{ required ".Values.alerts.prometheus.openstack missing" .Values.alerts.prometheus.openstack }}
{{- end -}}

{{- /**********************************************************************************/ -}}
{{- define "swift_conf_annotations" }}
checksum/swift.etc: {{ include "swift/templates/etc/configmap.yaml" . | sha256sum }}
checksum/swift.secret: {{ include "swift/templates/secret.yaml" . | sha256sum }}
{{- end -}}

{{- /**********************************************************************************/ -}}
{{- define "swift_ring_annotations" }}
checksum/account.ring: {{ include "swift/templates/account-ring.yaml" . | sha256sum }}
checksum/container.ring: {{ include "swift/templates/container-ring.yaml" . | sha256sum }}
checksum/object.ring: {{ include "swift/templates/object-ring.yaml" . | sha256sum }}
{{- end -}}

{{- /**********************************************************************************/ -}}
{{- define "swift_daemonset_volumes" }}
- name: swift-etc
  configMap:
    name: swift-etc
- name: swift-account-ring
  configMap:
    name: swift-account-ring
- name: swift-container-ring
  configMap:
    name: swift-container-ring
- name: swift-object-ring
  configMap:
    name: swift-object-ring
- name: swift-drives
  hostPath:
    path: /srv/node
- name: swift-cache
  hostPath:
    path: /var/cache/swift
- name: swift-drive-state
  hostPath:
    path: /run/swift-storage/state
{{- end -}}

{{- /**********************************************************************************/ -}}
{{- define "swift_proxy_volumes" }}
{{- $cluster := index . 0 }}
- name: swift-etc
  configMap:
    name: swift-etc
- name: swift-etc-cluster
  configMap:
    name: swift-etc-{{ $cluster }}
- name: swift-account-ring
  configMap:
    name: swift-account-ring
- name: swift-container-ring
  configMap:
    name: swift-container-ring
- name: swift-object-ring
  configMap:
    name: swift-object-ring
{{- end -}}

{{- /**********************************************************************************/ -}}
{{- define "swift_proxy_containers" }}
{{- $kind       := index . 0 -}}
{{- $cluster_id := index . 1 -}}
{{- $cluster    := index . 2 -}}
{{- $context    := index . 3 }}
- name: proxy
  image: {{ include "swift_image" $context }}
  command:
    - /usr/bin/dumb-init
  args:
    - /bin/bash
    - /usr/bin/swift-start
    - proxy-server
  env:
    - name: DEBUG_CONTAINER
      value: "false"
    - name: HASH_PATH_PREFIX
      valueFrom:
        secretKeyRef:
          name: swift-secret
          key: hash_path_prefix
    - name: HASH_PATH_SUFFIX
      valueFrom:
        secretKeyRef:
          name: swift-secret
          key: hash_path_suffix
    - name: SWIFT_SERVICE_PASSWORD
      valueFrom:
        secretKeyRef:
          name: swift-secret
          key: {{ $cluster_id }}_service_password
    {{- if $context.Values.sentry.enabled }}
    - name: SENTRY_DSN
      valueFrom:
        secretKeyRef:
          name: sentry
          key: swift.DSN.public
    {{- end }}
  {{- $resources_cpu := index $cluster (printf "proxy_%s_resources_cpu" $kind) }}
  {{- $resources_memory := index $cluster (printf "proxy_%s_resources_memory" $kind) }}
  resources:
    requests:
      cpu: {{ required (printf "proxy_%s_resources_cpu is required" $kind) $resources_cpu | quote }}
      memory: {{ required (printf "proxy_%s_resources_memory is required" $kind) $resources_memory | quote }}
    limits:
      cpu: {{ required (printf "proxy_%s_resources_cpu is required" $kind) $resources_cpu | quote }}
      memory: {{ required (printf "proxy_%s_resources_memory is required" $kind) $resources_memory | quote }}
  volumeMounts:
    - mountPath: /swift-etc
      name: swift-etc
    - mountPath: /swift-etc-cluster
      name: swift-etc-cluster
    - mountPath: /swift-rings/account
      name: swift-account-ring
    - mountPath: /swift-rings/container
      name: swift-container-ring
    - mountPath: /swift-rings/object
      name: swift-object-ring
  livenessProbe:
    httpGet:
      path: /healthcheck
      port: 8080
      scheme: HTTP
    initialDelaySeconds: 10
    timeoutSeconds: 1
    periodSeconds: 10
{{- if $context.Values.health_exporter }}
- name: collector
  image: {{ include "swift_image" $context }}
  command:
    - /usr/bin/dumb-init
  args:
    - /bin/bash
    - /usr/bin/swift-start
    - health-exporter
    - --recon.timeout=20
    - --recon.timeout-host=2
  env:
    - name: HASH_PATH_PREFIX
      valueFrom:
        secretKeyRef:
          name: swift-secret
          key: hash_path_prefix
    - name: HASH_PATH_SUFFIX
      valueFrom:
        secretKeyRef:
          name: swift-secret
          key: hash_path_suffix
    - name: DISPERSION_PASSWORD
      valueFrom:
        secretKeyRef:
          name: swift-secret
          key: dispersion_password
  ports:
    - name: metrics
      containerPort: 9520
  resources:
    # observed usage: CPU = ~10m, RAM = 70-100 MiB
    # low cpu allocation results in performance degradation
    requests:
      cpu: "100m"
      memory: "150Mi"
    limits:
      cpu: "100m"
      memory: "150Mi"
  volumeMounts:
    - mountPath: /swift-etc
      name: swift-etc
    - mountPath: /swift-rings/account
      name: swift-account-ring
    - mountPath: /swift-rings/container
      name: swift-container-ring
    - mountPath: /swift-rings/object
      name: swift-object-ring
{{- end}}
- name: statsd
  image: {{ $context.Values.global.dockerHubMirrorAlternateRegion }}/prom/statsd-exporter:{{ $context.Values.image_version_auxiliary_statsd_exporter }}
  args: [ --statsd.mapping-config=/swift-etc/statsd-exporter.yaml ]
  resources:
    # observed usage: CPU = 10m-100m, RAM = 550-950 MiB
    requests:
      cpu: "200m"
      memory: "1024Mi"
    limits:
      cpu: "200m"
      memory: "1024Mi"
  ports:
    - name: statsd
      containerPort: 9125
      protocol: UDP
    - name: metrics
      containerPort: 9102
  volumeMounts:
    - mountPath: /swift-etc
      name: swift-etc
{{- end -}}

{{- /**********************************************************************************/ -}}
{{- define "swift_standard_container" -}}
{{- $image   := index . 0 -}}
{{- $service := index . 1 -}}
{{- $context := index . 2 }}
- name: {{ $service }}
  image: {{ include "swift_image" $context }}
  command:
    - /usr/bin/dumb-init
  args:
    - /bin/bash
    - /usr/bin/swift-start
    - {{ $service }}
  # privileged access required for /usr/bin/unmount-helper (TODO: use shared/slave mount namespace instead)
  securityContext:
    privileged: true
  env:
    - name: DEBUG_CONTAINER
      value: "false"
    - name: HASH_PATH_PREFIX
      valueFrom:
        secretKeyRef:
          name: swift-secret
          key: hash_path_prefix
    - name: HASH_PATH_SUFFIX
      valueFrom:
        secretKeyRef:
          name: swift-secret
          key: hash_path_suffix
  volumeMounts:
    - mountPath: /swift-etc
      name: swift-etc
    - mountPath: /swift-rings/account
      name: swift-account-ring
    - mountPath: /swift-rings/container
      name: swift-container-ring
    - mountPath: /swift-rings/object
      name: swift-object-ring
    - mountPath: /srv/node
      name: swift-drives
    - mountPath: /var/cache/swift
      name: swift-cache
    - mountPath: /swift-drive-state
      name: swift-drive-state
{{- end -}}

{{- /**********************************************************************************/ -}}
{{- define "swift_image" -}}
  {{- if ne .Values.image_version "DEFINED_BY_PIPELINE" -}}
    {{ .Values.global.registryAlternateRegion }}/{{ .Values.imageRegistry_repo }}:{{ .Values.image_version }}
  {{- else -}}
    {{ required "This release should be installed by the deployment pipeline!" "" }}
  {{- end -}}
{{- end }}

{{- /**********************************************************************************/ -}}
{{- define "swift_release" -}}
{{- if ne .image_version "DEFINED_BY_PIPELINE" -}}
    {{ $v := .image_version | split "-"}}{{ $v._0 | lower }}
  {{- end -}}
{{- end }}

{{- /* Generate backend host for sapcc/openstack-ratelimit-middleware */ -}}
{{- define "sapcc_ratelimit_backend_host" -}}
{{- $release := index . 0 -}}
{{- $context := index . 1 -}}
{{- if $context.sapcc_ratelimit.backend.host -}}
{{- $context.sapcc_ratelimit.backend.host -}}
{{- else -}}
{{- $release.Name -}}-sapcc-ratelimit-redis
{{- end -}}
{{- end -}}

{{- /**********************************************************************************/ -}}
{{- define "swift_haproxy_backend" -}}
{{- $cluster_id := index . 0 -}}
{{- $cluster := index . 1 -}}
#option http-server-close
{{- if $cluster.upstreams }}
balance roundrobin
option httpchk HEAD /healthcheck
default-server check downinter 30s maxconn 500
{{- range $index, $upstream := $cluster.upstreams }}
{{- $short_name := splitn "." 2  $upstream.name }}
server {{ printf "%9s" $short_name._0 }} {{ $upstream.target }}:{{ default 8080 $cluster.svc_node_port }} # {{ $upstream.name }}
{{- end }}
{{- else }}
server swift-svc swift-proxy-internal-{{ $cluster_id }}:8080
{{- end }}
{{- end -}}
