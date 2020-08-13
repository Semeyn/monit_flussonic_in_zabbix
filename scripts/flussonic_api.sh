#!/usr/bin/env bash
# Author: Eynikov S.V.

STIME=$(date +%s)
source /usr/libexec/zabbix-extensions/scripts/flussonic.cfg

rm -f -R "${MEDIA_DIR}"
if ! [ -d ${TMP_DIR} ]; then
	mkdir ${TMP_DIR}
fi

if ! [ -d ${MEDIA_DIR} ]; then
	mkdir ${MEDIA_DIR}
fi

HEADER_CONTENT_TYPE="Content-Type: application/json; charset=utf-8"
VAR_PID=$$
BLOCK_FILE="${TMP_DIR}/loadblock"
MEDIA_JSON="${TMP_DIR}/media.json"
SERVER_JSON="${TMP_DIR}/server.json"
SESSIONS_JSON="${TMP_DIR}/sessions.json"

if [ -f $BLOCK_FILE ] ; then
	PID_BLOCK=`head -n 1 $BLOCK_FILE`
	if [ -d /proc/$PID_BLOCK ] ; then
		exit
	else
		rm -f $BLOCK_FILE
	fi
fi
echo $VAR_PID > $BLOCK_FILE

SERVER_URL="${API_URL}server"
curl -s -X GET ${SERVER_URL} -u "${API_USER}:${API_PASS}" -H ${HEADER_CONTENT_TYPE} | jq "." > ${SERVER_JSON}

MEDIA_URL="${API_URL}media"
curl -s -X GET ${MEDIA_URL} -u "${API_USER}:${API_PASS}" -H ${HEADER_CONTENT_TYPE} | sed "s/ /%20/g" | jq "." > ${MEDIA_JSON}

SESSIONS_URL="${API_URL}sessions"
curl -s -X GET ${SESSIONS_URL} -u "${API_USER}:${API_PASS}" -H ${HEADER_CONTENT_TYPE} | jq "." > ${SESSIONS_JSON}

#cat ${MEDIA_JSON} | jq -r ".[].value.name" > ${MEDIA_LIST}

media_json=$(cat ${MEDIA_JSON} | jq -c ".[]")
for media in ${media_json}
do
	name=$(echo ${media} | jq -r ".value.name")
	echo ${media} | sed "s/%20/ /g" | jq "." > "${MEDIA_DIR}/$name"
done

rm -f $BLOCK_FILE
TIME_FILE="${TMP_DIR}/time"
echo $(($(date +%s)-$STIME)) > ${TIME_FILE}
