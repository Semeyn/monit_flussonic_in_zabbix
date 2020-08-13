#!/usr/bin/env bash
# Author: Eynikov S.V.

source /usr/libexec/zabbix-extensions/scripts/flussonic.cfg
HEADER_CONTENT_TYPE="Content-Type: application/json"

BLOCK_FILE="${TMP_DIR}/loadblock"
SERVER_JSON="${TMP_DIR}/server.json"

function sendData {
	result=$(cat ${SERVER_JSON} | grep -m 1 \"${key}\" | awk -F ": " '{print $2}')
	result=$(echo $result | sed "s/,//g" | sed "s/\"//g")
	echo $result
}


if [ -n "$1" ]
then
	key=$1
	count=0
	while [ -f $BLOCK_FILE ]
	do
		(( count++ ))
	done
	sendData
fi
