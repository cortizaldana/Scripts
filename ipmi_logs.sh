#!/bin/bash

IPMI_USER=" "
IPMI_PASS=" "

ipmitool -H "$1" -U "$IPMI_USER" -P "$IPMI_PASS" sel list | tail -n 10
