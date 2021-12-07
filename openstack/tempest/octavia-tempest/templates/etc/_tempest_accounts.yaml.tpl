- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest-admin1
  types:
  - primary
  username: neutron-tempestadmin1
