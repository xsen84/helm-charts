- username: 'tempestuser1'
  domain_name: 'tempest'
  project_name: 'tempest1'
  password: {{ .Values.tempestAdminPassword | quote }}
  resources:
    network: share-service
- username: 'tempestuser2'
  domain_name: 'tempest'
  project_name: 'tempest2'
  password: {{ .Values.tempestAdminPassword | quote }}
  resources:
    network: share-service
- username: 'admin'
  domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: 'admin'
  resources:
    network: share-service
  types:
    - admin
