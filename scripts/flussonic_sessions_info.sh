#!/usr/bin/env bash
# Author: Eynikov S.V.

source /usr/libexec/zabbix-extensions/scripts/flussonic.cfg
HEADER_CONTENT_TYPE="Content-Type: application/json"

BLOCK_FILE="${TMP_DIR}/loadblock"
SESSIONS_JSON="${TMP_DIR}/sessions.json"

function sendData {
	if [ $key == 'maxsessionscount' ]; then
			result=$(cat ${SESSIONS_JSON} | grep \"ip\" | awk -F "\"" '{print $4}' | sort | uniq -c | sort | awk -F " " '{print $1}' | tail -n 1)
	elif [ $key == 'maxsessionsip' ]; then
		result=$(cat ${SESSIONS_JSON} | grep \"ip\" | awk -F "\"" '{print $4}' | sort | uniq -c | sort | awk -F " " '{print $2}' | tail -n 1)
	else
		result=0
	fi
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
