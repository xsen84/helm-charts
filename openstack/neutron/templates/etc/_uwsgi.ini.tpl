[uwsgi]
need-app = true
http-socket = :{{.Values.global.neutron_api_port_internal | default 9696}}
uid = neutron
gid = neutron
lazy-apps = true
add-header = Connection: close
buffer-size = 65535
hook-master-start = unix_signal:15 gracefully_kill_them_all
thunder-lock = true
enable-threads = true
worker-reload-mercy = 90
exit-on-reload = false
die-on-term = true
master = true
memory-report = true
processes = {{.Values.wsgi_processes | default 4}}
wsgi-file = /var/lib/openstack/bin/neutron-api
stats-push = statsd:127.0.0.1:9125
statsd-no-workers = true
pyargv = --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2-conf.ini --config-file /etc/neutron/plugins/ml2/ml2-conf-aci.ini --config-file /etc/neutron/plugins/ml2/ml2-conf-manila.ini --config-file /etc/neutron/plugins/ml2/ml2-conf-arista.ini --config-file /etc/neutron/plugins/ml2/ml2-conf-asr1k.ini