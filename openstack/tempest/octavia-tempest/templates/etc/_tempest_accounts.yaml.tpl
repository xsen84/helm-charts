- username: 'neutron-tempestadmin1'
  user_domain_name: 'tempest'
  domain_name: 'tempest'
  password: {{ .Values.tempestAdminPassword | quote }}
  types:
     - 'admin'
  roles:
    - 'admin'
    - 'reader'
