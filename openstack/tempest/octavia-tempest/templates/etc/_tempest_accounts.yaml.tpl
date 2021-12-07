- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest-admin1
  roles:
  - cloud_network_admin
  - admin_role
  - observer_role
  - member_role
  - global_observer_role
  types:
  - admin
  username: neutron-tempestadmin1
