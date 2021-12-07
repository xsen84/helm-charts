- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest-admin1
  roles:
  - cloud_network_admin
  types:
  - admin
  username: neutron-tempestadmin1
