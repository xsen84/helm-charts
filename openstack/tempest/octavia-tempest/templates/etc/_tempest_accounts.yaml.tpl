- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest-admin1
  roles:
  - admin
  types:
  - primary
  username: neutron-tempestadmin1
