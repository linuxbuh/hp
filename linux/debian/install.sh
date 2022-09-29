#!/bin/bash

PROLIANT=$1

cp -f ./buster/etc/apt/* /etc/apt

wget -O- http://downloads.linux.hpe.com/SDR/hpPublicKey1024.pub | apt-key add -
wget -O- http://downloads.linux.hpe.com/SDR/hpPublicKey2048.pub | apt-key add -
wget -O- http://downloads.linux.hpe.com/SDR/hpPublicKey2048_key1.pub | apt-key add -
wget -O- http://downloads.linux.hpe.com/SDR/hpePublicKey2048_key1.pub | apt-key add -

apt-get update

if [ $PROLIANT = G6 ]; then

apt-get install -y ssa ssacli ssaducli hponcfg hp-smh-templates hpsmh hp-health hp-snmp-agents amsd snmpd snmp

cp -f ./buster/etc/snmp/* /etc/snmp

systemctl enable snmpd
systemctl enable hp-health
systemctl enable hpsmhd

systemctl restart snmpd
systemctl restart hp-health
systemctl restart hpsmhd


else

apt-get install -y ssa ssacli ssaducli hponcfg hp-smh-templates hpsmh hp-health hp-snmp-agents hp-ams amsd snmpd snmp

systemctl enable hp-ams
systemctl enable amsd
systemctl enable snmpd
systemctl enable hp-health
systemctl enable hpsmhd

# Для безопасности
#groups user1
#usermod -a -G root user1

cp -f ./buster/etc/snmp/* /etc/snmp

systemctl restart snmpd

fi

