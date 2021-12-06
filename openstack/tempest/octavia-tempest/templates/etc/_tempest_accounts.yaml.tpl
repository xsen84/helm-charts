- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest-admin1
  types:
  - cloud_network_admin
  username: neutron-tempestadmin1
- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest-admin2
  types:
  - cloud_network_admin
  username: neutron-tempestadmin2
- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest-admin3
  types:
  - cloud_network_admin
  username: neutron-tempestadmin3