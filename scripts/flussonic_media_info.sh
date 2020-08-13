#!/usr/bin/env bash
# Author: Eynikov S.V.

source /usr/libexec/zabbix-extensions/scripts/flussonic.cfg

BLOCK_FILE="${TMP_DIR}/loadblock"

if [ -z $1 ]
then
	exit
fi
if [ -z $2 ]
then
	exit
fi

media=$1
key=$2

count=0
while [ -f $BLOCK_FILE ]
do
	(( count++ ))
done

MEDIA_FILE="${MEDIA_DIR}/${media}"
if ! [ -f ${MEDIA_FILE} ] ; then
	echo "$media" >> "${TMP_DIR}/error.log"	
	exit
fi

value=$(cat ${MEDIA_FILE} | grep -m 1 \"${key}\" | awk -F ": " '{print $2}')
value=$(echo $value | sed "s/,//g" | sed "s/\"//g")

if [ -n $value ]
then
	if [ $value == 'true' ]; then
		echo 1
        elif [ $value == 'false' ]; then
                echo 0
        else
                echo $value
        fi
else
	echo -1
fi

