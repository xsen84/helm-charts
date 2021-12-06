- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest-admin1
  roles:
  - cloud_network_admin
  - admin
  types:
  - admin
  - primary
  username: neutron-tempestadmin1
- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest-admin2
  types:
  - admin
  - primary
  roles:
  - cloud_network_admin
  - admin
  types:
  - admin
  - primary
  username: neutron-tempestadmin2
- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest-admin3
  types:
  - admin
  - primary
  roles:
  - cloud_network_admin
  - admin
  username: neutron-tempestadmin3