#!/bin/bash
set -e

lunaclient () {
    curl https://repo.eu-de-1.cloud.sap/hw-firmware/hsm/minimal-client/610-000401-004_SW_Linux_Luna_Minimal_Client_V10.4.0_RevA.tar --output 610-000401-004_SW_Linux_Luna_Minimal_Client_V10.4.0_RevA.tar 
    mkdir -p /root/luna-docker
    mkdir -p /root/luna-docker/config
    mkdir -p /root/luna-docker/config/certs
    mv 610-000401-004_SW_Linux_Luna_Minimal_Client_V10.4.0_RevA.tar /root/luna-docker
    tar -xf /root/luna-docker/610-000401-004_SW_Linux_Luna_Minimal_Client_V10.4.0_RevA.tar -C /root/luna-docker
    cp /root/luna-docker/LunaClient-Minimal-10.4.0-417.x86_64/Chrystoki-template.conf /root/luna-docker/config/Chrystoki.conf
    export ChrystokiConfigurationPath=/root/luna-docker/config
    export MIN_CLIENT_DIR=/root/luna-docker/LunaClient-Minimal-10.4.0-417.x86_64
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s Chrystoki2 -e LibUNIX -v $MIN_CLIENT_DIR/libs/64/libCryptoki2.so
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s Chrystoki2 -e LibUNIX64 -v $MIN_CLIENT_DIR/libs/64/libCryptoki2_64.so
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s Misc -e ToolsDir -v $MIN_CLIENT_DIR/bin/64
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "LunaSA Client" -e SSLConfigFile -v $MIN_CLIENT_DIR/openssl.cnf
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "LunaSA Client" -e ClientPrivKeyFile -v /root/luna-docker/config/certs/dockerlunaclientKey.pem
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "LunaSA Client" -e ClientCertFile -v /root/luna-docker/config/certs/dockerlunaclient.pem
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "LunaSA Client" -e ServerCAFile -v /root/luna-docker/config/certs/CAFile.pem
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "Secure Trusted Channel" -e ClientTokenLib -v $MIN_CLIENT_DIR/libs/64/libSoftToken.so
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "Secure Trusted Channel" -e SoftTokenDir -v /root/luna-docker/config/stc/token
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "Secure Trusted Channel" -e ClientIdentitiesDir -v /root/luna-docker/config/stc/client_identities
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "Secure Trusted Channel" -e PartitionIdentitiesDir -v /root/luna-docker/config/stc/partition_identities
    $MIN_CLIENT_DIR/bin/64/vtl createCert -n hsm01_qade2_luna_container
    }
{{- if eq .Values.hsm.enabled true }}
lunaclient
{{- end }}