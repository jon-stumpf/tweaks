#! /bin/sh
MYDIR=$(dirname $(readlink -f $0))
TIMESTAMP=$(date "+%m%d%Y-%H%M%S")
LOGFILE=${MYDIR}/${TIMESTAMP}.txt

echo "Disabling Watchdog Service" >> ${LOGFILE}
echo 1 > /sys/class/gpio/Watchdog\ Disable/value
echo "Mounting filesystem read/write" >> ${LOGFILE}
mount -o rw,remount /
echo "Modifying systemApp.js permissions" >> ${LOGFILE}
chmod 755 /jci/gui/apps/system/js/systemApp.js
echo "Modifying disclaimer timeout" >> ${LOGFILE}
sed -i 's/this._disclaimerTime.remaining = 3500/this._disclaimerTime.remaining = 100/g' /jci/gui/apps/system/js/systemApp.js
echo "Disabling speed restrictions" >> ${LOGFILE}
/jci/scripts/set_lvds_speed_restriction_config.sh disable
/jci/scripts/set_speed_restriction_config.sh disable
/jci/tools/jci-dialog --title="Tweaks Applied" --text="Tweaks have finished running" --ok-label='OK' --no-cancel &
echo "Finished applying all tweaks" >> ${LOGFILE}

echo "Sleeping for 10" >> ${LOGFILE}
sleep 10

echo "Killing dialog box" >> ${LOGFILE}
killall jci-dialog
