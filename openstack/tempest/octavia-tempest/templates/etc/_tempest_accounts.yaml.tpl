- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest-admin1
  roles:
  - cloud_network_admin
  types:
  - primary
  - admin
  username: neutron-tempestadmin1
