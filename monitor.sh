#!/bin/bash
# Author : Austin
# Version : 1.0.0
# Date : 2017-11-01

function handleIp {
	local ip=$1
	debug_log "start to ping" $ip
	local avgPingTime=`ping $ip -c ${try_number_every_ping} | grep avg | awk -F / '{print $5}'`

	if [ -z "$avgPingTime" ]; then
		error_log "ping [" $ip "] failed"
		return 0
	else 
		if [ `echo "${avgPingTime} > ${time_out_second}"|bc` -eq 1 ]; then
			error_log "ping [" $ip "] time out, average ping time : " $avgPingTime"ms"
		else 
			debug_log "ping " $ip " success, average ping time : " $avgPingTime"ms"
		fi
	fi
}

function traverseAllIp {
	cat ip.txt | while read line
	do
		handleIp $line
	done
}

function traverseAllTheTime {
	if [ $1 -eq 0 ]; then
		while true
		do
			traverseAllIp
			sleep ${sleep_gap_second}
		done
	else
		traverseAllIp
	fi
}

function main {
	traverseAllTheTime 0
}

. ./config.sh
. ./logger.sh
log_init
main