# SNMP-Collector
SNMP Collector using shell script

This script for check brand also hosname using snmp 

need install snmp in server.

#this command for get data
-v : snmp version
-c : community
sysDescr.0 : MiB

snmpwalk -v 2c -c xxx $ip sysDescr.0
