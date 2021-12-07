- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest-admin1
  types:
  - admin
  username: neutron-tempestadmin1
