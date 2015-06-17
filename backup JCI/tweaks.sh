#! /bin/sh
MYDIR=$(dirname $(readlink -f $0))
TIMESTAMP=$(date "+%m%d%Y-%H%M%S")
LOGFILE=${MYDIR}/${TIMESTAMP}.txt
BACKUPDIR=${MYDIR}/${TIMESTAMP}

echo "Starting backup script\n" >> ${LOGFILE}
echo "Creating backup directory\n" >> ${LOGFILE}
mkdir ${BACKUPDIR}
if [ -d ${BACKUPDIR} ]; then
	echo "Backing up /jci to ${BACKUPDIR}\n" >> ${LOGFILE}
	cp -R /jci ${BACKUPDIR}
	/jci/tools/jci-dialog --title="JCI Backup Success" --text="JCI Backup complete!" --ok-label='OK' --no-cancel &
else
	echo "Backup directory ${BACKUPDIR} does not exist\n" >> ${LOGFILE}
	/jci/tools/jci-dialog --title="JCI Backup Failed" --text="JCI Backup did not run!" --ok-label='OK' --no-cancel &
fi
echo "Finished backup script\n" >> ${LOGFILE}

echo "Sleeping for 10\n" >> ${LOGFILE}
sleep 10

echo "Killing dialog box\n" >> ${LOGFILE}
killall jci-dialog
