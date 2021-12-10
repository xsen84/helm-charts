- username: 'tempestuser1'
  domain_name: 'tempest'
  project_name: 'tempest1'
  password: {{ .Values.tempestAdminPassword | quote }}
  resources:
    network: share-service
  roles:
    - reader

- username: 'tempestuser2'
  domain_name: 'tempest'
  project_name: 'tempest2'
  password: {{ .Values.tempestAdminPassword | quote }}
  resources:
    network: share-service
  roles:
    - reader

- username: 'admin'
  domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: 'admin'
  resources:
    network: share-service
  types:
    - admin

- username: 'neutron-tempestadmin1'
  domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: 'neutron-tempest-admin1'
  resources:
    network: share-service
  types:
    - admin

- username: 'neutron-tempestadmin2'
  domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: 'neutron-tempest-admin2'
  resources:
    network: share-service
  types:
    - admin
