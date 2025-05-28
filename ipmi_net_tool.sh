#!/bin/bash

IPMI_USER=" "
IPMI_PASS=" "
TOOL="$1"
IPADDR="$2"
ID="$3"

case $TOOL in 

status)
ipmitool -H "$IPADDR" -U "$IPMI_USER" -P "$IPMI_PASS" chassis status ;;

logs)
ipmitool -H "$IPADDR" -U "$IPMI_USER" -P "$IPMI_PASS" sel list | tail -n 10 ;;

id)
ipmitool -H "$IPADDR" -U "$IPMI_USER" -P "$IPMI_PASS" sel get "$3" ;;

on)
ipmitool -H "$IPADDR" -U "$IPMI_USER" -P "$IPMI_PASS" power on ;;

off)
ipmitool -H "$IPADDR" -U "$IPMI_USER" -P "$IPMI_PASS" power off ;;

sdr)
ipmitool -H "$IPADDR" -U "$IPMI_USER" -P "$IPMI_PASS" sdr list ;;

*)
echo "./ipmi_net_tool status|logs|id|on|off|sdr| IP";;
esac
