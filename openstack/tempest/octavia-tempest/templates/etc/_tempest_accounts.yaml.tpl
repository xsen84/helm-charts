- username: 'neutron-tempestadmin1'
  user_domain_name: 'tempest'
  domain_name: 'tempest'
  password: {{ .Values.tempestAdminPassword | quote }}
  types:
     - 'admin'
  roles:
    - 'admin'
    - 'reader'

- username: 'neutron-tempestadmin2'
  user_domain_name: 'tempest'
  domain_name: 'tempest'
  password: {{ .Values.tempestAdminPassword | quote }}
  types:
     - 'admin'
  roles:
    - 'admin'
    - 'reader'

- username: 'neutron-tempestadmin3'
  user_domain_name: 'tempest'
  domain_name: 'tempest'
  password: {{ .Values.tempestAdminPassword | quote }}
  types:
     - 'admin'
  roles:
    - 'admin'
    - 'reader'

- username: 'neutron-tempestadmin4'
  user_domain_name: 'tempest'
  domain_name: 'tempest'
  password: {{ .Values.tempestAdminPassword | quote }}
  types:
     - 'admin'
  roles:
    - 'admin'
    - 'reader'

- username: neutron-tempestuser1
  project_name: 'neutron-tempest1'
  project_domain_name: 'tempest'
  user_domain_name: 'tempest'
  domain_name: 'tempest'
  password: {{ .Values.tempestAdminPassword | quote }}
  roles:
    - 'admin'
    - 'reader'

- username: neutron-tempestuser2
  project_name: 'neutron-tempest2'
  project_domain_name: 'tempest'
  user_domain_name: 'tempest'
  domain_name: 'tempest'
  password: {{ .Values.tempestAdminPassword | quote }}
  roles:
    - 'admin'
    - 'reader'

- username: neutron-tempestuser3
  project_name: 'neutron-tempest3'
  project_domain_name: 'tempest'
  user_domain_name: 'tempest'
  domain_name: 'tempest'
  password: {{ .Values.tempestAdminPassword | quote }}
  roles:
    - 'admin'
    - 'reader'

- username: neutron-tempestuser4
  project_name: 'neutron-tempest4'
  project_domain_name: 'tempest'
  user_domain_name: 'tempest'
  domain_name: 'tempest'
  password: {{ .Values.tempestAdminPassword | quote }}
  roles:
    - 'admin'
    - 'reader'

- username: neutron-tempestuser5
  project_name: 'neutron-tempest5'
  project_domain_name: 'tempest'
  user_domain_name: 'tempest'
  domain_name: 'tempest'
  password: {{ .Values.tempestAdminPassword | quote }}
  roles:
    - 'admin'
    - 'reader'

- username: neutron-tempestuser6
  project_name: 'neutron-tempest6'
  project_domain_name: 'tempest'
  user_domain_name: 'tempest'
  domain_name: 'tempest'
  password: {{ .Values.tempestAdminPassword | quote }}
  roles:
    - 'admin'
    - 'reader'

- username: neutron-tempestuser7
  project_name: 'neutron-tempest7'
  project_domain_name: 'tempest'
  user_domain_name: 'tempest'
  domain_name: 'tempest'
  password: {{ .Values.tempestAdminPassword | quote }}
  roles:
    - 'admin'
    - 'reader'

- username: neutron-tempestuser8
  project_name: 'neutron-tempest8'
  project_domain_name: 'tempest'
  user_domain_name: 'tempest'
  domain_name: 'tempest'
  password: {{ .Values.tempestAdminPassword | quote }}
  roles:
    - 'admin'
    - 'reader'

- username: neutron-tempestuser9
  project_name: 'neutron-tempest9'
  project_domain_name: 'tempest'
  user_domain_name: 'tempest'
  domain_name: 'tempest'
  password: {{ .Values.tempestAdminPassword | quote }}
  roles:
    - 'admin'
    - 'reader'

- username: neutron-tempestuser10
  project_name: 'neutron-tempest10'
  project_domain_name: 'tempest'
  user_domain_name: 'tempest'
  domain_name: 'tempest'
  password: {{ .Values.tempestAdminPassword | quote }}
  roles:
    - 'admin'
    - 'reader'

