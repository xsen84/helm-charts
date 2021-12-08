- username: 'neutron-tempestadmin1'
  project_name: 'neutron-tempest-admin1'
  domain_name: 'tempest'
  password: {{ .Values.tempestAdminPassword | quote }}
  types:
     - 'domain_admin'
  roles:
    - 'admin'
