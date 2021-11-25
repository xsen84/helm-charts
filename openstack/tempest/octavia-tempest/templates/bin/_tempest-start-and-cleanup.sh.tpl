#!/usr/bin/env bash

set -o pipefail

{{- include "tempest-base.function_start_tempest_tests" . }}

function cleanup_tempest_leftovers() {

  echo "Run cleanup"
  for user in neutron-tempestadmin1 neutron-tempestadmin2 neutron-tempestadmin3 neutron-tempestadmin4; do
    let COUNTER++
    export OS_USERNAME=$user
    TEMPESTPROJECT=neutron-tempest-admin$COUNTER
    export OS_TENANT_NAME=$TEMPESTPROJECT
    export OS_PROJECT_NAME=$TEMPESTPROJECT
#    for lb in $(openstack loadbalancer list -f json | jq -r .[].id); do openstack loadbalancer delete $lb -f json; done
  done
}

{{- include "tempest-base.function_main" . }}

main
