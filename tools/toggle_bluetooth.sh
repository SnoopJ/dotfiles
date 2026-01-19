#!/bin/bash

# A helper script to toggle the bluetooth connection of my bluetooth headset


declare -r HERE="$(readlink -f $(dirname "${BASH_SOURCE[0]}"))"
declare -r ICON=${HERE}/vaultboy.png
#
# NOTE: Bluetooth ID in separate not-committed file, because privacy. You may want to change the device name, too
DEVICE_ID=$(cat ${HERE}/shokz_id)
DEVICE_NAME="Shokz"

APPNAME="toggle_shokz"
OPTS="--app-name ${APPNAME} --icon ${ICON}"
ID=$(notify-send --app-name ${APPNAME} --print-id --expire-time=10000 "Bluetooth toggle" "Attempting to toggle connectivity ${DEVICE_NAME} state")

if bluetoothctl info ${DEVICE_ID} | grep "Connected: yes" &> /dev/null ; then
    bluetoothctl disconnect ${DEVICE_ID} && notify-send ${OPTS} --replace-id ${ID} "Bluetooth disconnected" "${DEVICE_NAME} disconnect successful"
else
    bluetoothctl connect ${DEVICE_ID} && notify-send ${OPTS} --replace-id ${ID} "Bluetooth connected" "${DEVICE_NAME} connect successful"
fi
