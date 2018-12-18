#!/bin/bash

# Strip only the top domain to get the rr keyword
export DOMAIN=$(expr match "$CERTBOT_DOMAIN" '.*\.\(.*\..*\)')
export SubDOMAIN=$(expr match "$CERTBOT_DOMAIN" '\(.*\)\..*\..*')

# Create TXT record
export RECORD_VALUE="$CERTBOT_VALIDATION"
python3 ./alidns.py
