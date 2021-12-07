- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest-admin1
  roles:
  - cloud_network_admin
  - observer_role
  - member_role
  - global_observer_role
  types:
  - primary
  username: neutron-tempestadmin1
