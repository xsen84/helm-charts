- username: 'admin'
  domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: 'admin'
  types:
    - admin

- username: 'neutron-tempestadmin1'
  user_domain_name: 'tempest'
  domain_name: 'tempest'
  project_name: 'neutron-tempest-admin1'
  password: {{ .Values.tempestAdminPassword | quote }}

- username: 'neutron-tempestadmin2'
  user_domain_name: 'tempest'
  domain_name: 'tempest'
  project_name: 'neutron-tempest-admin2'
  password: {{ .Values.tempestAdminPassword | quote }}
