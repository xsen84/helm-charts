#!/bin/bash
set -e

lunaclient () {
    curl {{ .Values.lunaclient.repo }}
    mkdir -p /root/luna-docker
    mkdir -p /root/luna-docker/config
    mkdir -p /root/luna-docker/config/certs
    mv 610-000401-004_SW_Linux_Luna_Minimal_Client_V10.4.0_RevA.tar /root/luna-docker
    tar -xf /root/luna-docker/610-000401-004_SW_Linux_Luna_Minimal_Client_V10.4.0_RevA.tar -C /root/luna-docker
    cp /root/luna-docker/LunaClient-Minimal-10.4.0-417.x86_64/Chrystoki-template.conf /root/luna-docker/config/Chrystoki.conf
    export ChrystokiConfigurationPath=/root/luna-docker/config
    mkdir -p /root/.putty/
    curl {{ .Values.lunaclient.known_hosts }} --output sshhostkeys
    mv sshhostkeys /root/.putty/
    export MIN_CLIENT_DIR=/root/luna-docker/LunaClient-Minimal-10.4.0-417.x86_64
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s Chrystoki2 -e LibUNIX -v $MIN_CLIENT_DIR/libs/64/libCryptoki2.so
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "LunaSA Client" -e ClientPrivKeyFile -v /root/luna-docker/config/certs/"$HOSTNAME"Key.pem
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "LunaSA Client" -e ClientCertFile -v /root/luna-docker/config/certs/$HOSTNAME.pem
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s Chrystoki2 -e LibUNIX64 -v $MIN_CLIENT_DIR/libs/64/libCryptoki2_64.so
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s Misc -e ToolsDir -v $MIN_CLIENT_DIR/bin/64
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "LunaSA Client" -e SSLConfigFile -v $MIN_CLIENT_DIR/openssl.cnf
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "LunaSA Client" -e ServerCAFile -v /root/luna-docker/config/certs/CAFile.pem
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "Secure Trusted Channel" -e ClientTokenLib -v $MIN_CLIENT_DIR/libs/64/libSoftToken.so
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "Secure Trusted Channel" -e SoftTokenDir -v /root/luna-docker/config/stc/token
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "Secure Trusted Channel" -e ClientIdentitiesDir -v /root/luna-docker/config/stc/client_identities
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "Secure Trusted Channel" -e PartitionIdentitiesDir -v /root/luna-docker/config/stc/partition_identities
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "VirtualToken" -e VirtualToken00Label -v {{ .Values.lunaclient.VirtualToken.VirtualToken00Label }}
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "VirtualToken" -e VirtualToken00Members -v {{ .Values.lunaclient.VirtualToken.VirtualToken00Members }}
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "VirtualToken" -e VirtualTokenActiveRecovery -v {{ .Values.lunaclient.VirtualToken.VirtualTokenActiveRecovery }}
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "VirtualToken00SN" -e VirtualToken00Label -v {{ .Values.lunaclient.VirtualToken00SN.VirtualToken00Label }}
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "VirtualToken00SN" -e VirtualToken00Members -v {{ .Values.lunaclient.VirtualToken00SN.VirtualToken00Members }}
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "VirtualToken00SN" -e VirtualTokenActiveRecovery -v {{ .Values.lunaclient.VirtualToken00SN.VirtualTokenActiveRecovery }}
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "HASynchronize" -e {{ .Values.lunaclient.VirtualToken.VirtualToken00Label }} -v {{ .Values.lunaclient.HASynchronize.sync }}
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "HAConfiguration" -e haLogStatus -v {{ .Values.lunaclient.HAConfiguration.haLogStatus }}
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "HAConfiguration" -e reconnAtt -v {{ .Values.lunaclient.HAConfiguration.reconnAtt }}
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "HAConfiguration" -e HAOnly -v {{ .Values.lunaclient.HAConfiguration.HAOnly }}
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "HAConfiguration" -e haLogPath -v {{ .Values.lunaclient.HAConfiguration.haLogPath }}
    $MIN_CLIENT_DIR/bin/64/configurator setValue -s "HAConfiguration" -e logLen -v {{ .Values.lunaclient.HAConfiguration.logLen }}
    ln /root/luna-docker/LunaClient-Minimal-10.4.0-417.x86_64/libs/64/libCryptoki2.so /usr/lib/libcrystoki2.so
    rm /root/luna-docker/610-000401-004_SW_Linux_Luna_Minimal_Client_V10.4.0_RevA.tar
    $MIN_CLIENT_DIR/bin/64/vtl createCert -n $HOSTNAME
    $MIN_CLIENT_DIR/bin/64/pscp -pw {{ .Values.lunaclient.conn.pwd }} /root/luna-docker/config/certs/$HOSTNAME.pem admin@{{ .Values.lunaclient.conn.ip }}:.
    $MIN_CLIENT_DIR/bin/64/pscp -pw {{ .Values.lunaclient.conn.pwd }} admin@{{ .Values.lunaclient.conn.ip }}:server.pem /root/luna-docker/config/certs/
    $MIN_CLIENT_DIR/bin/64/vtl addserver -n {{ .Values.lunaclient.conn.ip }} -c  /root/luna-docker/config/certs/server.pem
    #echo "client delete -c $HOSTNAME" > /root/luna-docker/config/$HOSTNAME.txt
    echo "client register -c $HOSTNAME" -h $HOSTNAME > /root/luna-docker/config/$HOSTNAME.txt
    echo "client assignPartition -c $HOSTNAME -p {{ .Values.lunaclient.conn.par }}" >> /root/luna-docker/config/$HOSTNAME.txt
    echo "exit" >> /root/luna-docker/config/$HOSTNAME.txt
    $MIN_CLIENT_DIR/bin/64/plink {{ .Values.lunaclient.conn.ip }} -ssh -l admin -pw {{ .Values.lunaclient.conn.pwd }} -v < /root/luna-docker/config/$HOSTNAME.txt
    cp /root/luna-docker/config/Chrystoki.conf /etc/Chrystoki.conf
    }

{{- if eq .Values.hsm.enabled true }}
lunaclient
{{- end }}
