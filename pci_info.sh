#!/bin/bash

dmidecode -t slot | \

awk '/Designation:/,/Bus Address:/' | \

grep -vE "Characteristics:|ID:|Length:|3.3|SMB|PME|5.0 V|Data|Handle|System" | \

awk '1; NR % 4 == 0 {print ""}' 
