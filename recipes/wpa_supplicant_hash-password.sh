#!/bin/bash

# Helper script for hashing a WPA2 password for use with wpa_supplicant.conf
# (see below)

# invocation: 
#    wpa_supplicant_hash-password.sh MyWPA2Secret

#network={
#  ssid="Gibson_WLAN"
#  scan_ssid=1
#  key_mgmt=WPA-EAP
#  pairwise=CCMP
#  group=CCMP
#  eap=PEAP
#  proto=WPA2
#  identity="ZeroC00L"
#  password=hash:xxx
#  phase2="auth=MSCHAPV2"
#}

hashed=$(echo -n $* | iconv -t utf16le | openssl md4 | cut -f2 -d'=' | tr -d [:blank:])

echo "password=hash:$hashed"
