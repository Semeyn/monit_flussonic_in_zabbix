#!/usr/bin/env bash
# Author: Eynikov S.V.

source /usr/libexec/zabbix-extensions/scripts/flussonic.cfg

BLOCK_FILE="${TMP_DIR}/loadblock"

function sendDiscovery {
	media_list=$(ls ${MEDIA_DIR})
	echo -n '{"data":['
	for media in $media_list; do echo -n "{\"{#MEDIA}\": \"$media\"},"; done |sed -e 's:\},$:\}:'
	echo -n ']}'
}

count=0
while [ -f $BLOCK_FILE ]
do
	(( count++ ))
done

sendDiscovery



