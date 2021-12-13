- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest-admin1
  types:
  - admin
  username: neutron-tempestadmin1
- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest-admin2
  types:
  - admin
  username: neutron-tempestadmin2
- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest-admin3
  types:
  - admin
  - reader
  username: neutron-tempestadmin3
- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest-admin4
  types:
  - admin
  - reader
  username: neutron-tempestadmin4
- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest1
  username: neutron-tempestuser1
  types:
  - admin
  roles:
  - member_role
- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest2
  username: neutron-tempestuser2
  types:
  - admin
  roles:
  - member_role
- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest3
  username: neutron-tempestuser3
  types:
  - admin
  roles:
  - observer_role
- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest4
  username: neutron-tempestuser4
  types:
  - admin
  roles:
  - observer_role
- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest5
  username: neutron-tempestuser5
  types:
  - admin
  roles:
  - global_observer
- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest6
  username: neutron-tempestuser6
  types:
  - admin
  roles:
  - global_observer
- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest7
  username: neutron-tempestuser7
  types:
  - admin
- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest8
  username: neutron-tempestuser8
  types:
  - admin
- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest9
  username: neutron-tempestuser9
  types:
  - primary
- domain_name: tempest
  password: {{ .Values.tempestAdminPassword | quote }}
  project_name: neutron-tempest10
  username: neutron-tempestuser10
  types:
  - primary
