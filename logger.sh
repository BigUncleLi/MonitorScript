# Author : Austin

function debug_log {
	local time=`date '+%Y-%m-%d %H:%M:%S'`
	echo $time "D:" $*
}

function error_persistence {
	echo "---------------------" >> "${log_file_name}"
	echo "|"$* >> "${log_file_name}"
}

function error_log {
	local time=`date '+%Y-%m-%d %H:%M:%S'`
	echo $time "E:" $*
	error_persistence $time"| E:" $*
}

function log_init {
	if [ ! -d log ]; then
		mkdir log
	fi
	local currentTime=`date '+%Y-%m-%d_%H:%M:%S'`
	log_file_name="log/"${currentTime}".log"
	touch $log_file_name
}