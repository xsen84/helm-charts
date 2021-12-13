- username: 'tempestuser1'
  domain_name: 'tempest'
  project_name: 'tempest1'
  password: {{ .Values.tempestAdminPassword | quote }}
  resources:
    network: share-service
  roles:
    - reader
    - lb_admin


- username: 'tempestuser2'
  domain_name: 'tempest'
  project_name: 'tempest2'
  password: {{ .Values.tempestAdminPassword | quote }}
  resources:
    network: share-service
  roles:
    - reader
    - lb_member

- username: 'admin'
  domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: 'admin'
  resources:
    network: share-service
  roles:
    - lb_member2
  types:
    - admin

- username: 'neutron-tempestadmin1'
  domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: 'neutron-tempest-admin1'
  resources:
    network: share-service
  types:
    - admin
  roles:
    - admin
    - reader
    - lb_global_observer


- username: 'neutron-tempestadmin2'
  domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: 'neutron-tempest-admin2'
  resources:
    network: share-service
  types:
    - admin
  roles:
    - admin
    - lb_observer
