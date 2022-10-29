#!bin/bash

#Log file path
LOGFILE=/home/vagrant/altschool/assignment/ram_cronjob.log

# Email recepient
EMAIL="oluwaseyi_akinnawo@rocketmail.com"

# Format Date
SENDTIME=$(date +%H%M)

# Create log
function createLog() {
	if test -f $LOGFILE; then
		free -h >> $LOGFILE
	else
		touch $LOGFILE
		date >> $LOGFILE
		echo "Exercise 7" >> $LOGFILE
		free -h >> $LOGFILE
	fi
}

if [[ $SENDTIME == 0015 ]]; then
	createLog
	echo "A copy of the system memory (RAM) usage log sent at midnight" | mail -s "Exercise 7 Ram Usage" -A $LOGFILE $EMAIL
fi
