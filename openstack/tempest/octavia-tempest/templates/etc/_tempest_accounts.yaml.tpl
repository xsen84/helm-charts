- username: 'neutron-tempestadmin1'
  project_name: 'neutron-tempest-admin1'
  project_domain_name: 'tempest'
  user_domain_name: 'tempest'
  domain_name: 'tempest'
  password: {{ .Values.tempestAdminPassword | quote }}
  types:
     - 'admin'
  roles:
    - 'admin'
