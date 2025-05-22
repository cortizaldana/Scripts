#!/bin/bash

# Prints Memory Information
sudo dmidecode -t 17 | \

# Pattern Matching Memory Device And Rank
awk '/Memory Device/,/Rank/' | \

# Greps for certain lines
grep -E "Locator:|Type:|Size:|Part" | \

# Does Not Show Lines With Bank
grep -v "Bank" | \

# Adds an empty line after every 4 lines 
# (NR % 4 == 0 {print ""} = Number of records is 4 divided by 4 is 0
awk '1; NR % 4 == 0 {print ""}'
