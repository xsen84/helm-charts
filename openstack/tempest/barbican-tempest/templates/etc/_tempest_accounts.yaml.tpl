- username: 'tempestuser1'
  password: {{ .Values.tempestAdminPassword | quote }}
  tenant_name: 'tempest1'
  project_name: 'tempest1'
  role: key-manager:service-admin
- username: 'tempestuser2'
  password: {{ .Values.tempestAdminPassword | quote }}
  tenant_name: 'tempest2'
  project_name: 'tempest2'
  role: key-manager:service-admin
- username: 'admin'
  password: {{ .Values.tempestAdminPassword | quote }}
  tenant_name: 'admin'
  project_name: 'admin'
  role: key-manager:service-admin
  types:
  - admin
