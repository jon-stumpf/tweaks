#! /bin/sh
echo 1 > /sys/class/gpio/Watchdog\ Disable/value
mount -o rw,remount /
chmod 755 /jci/gui/apps/system/js/systemApp.js
sed -i 's/this._disclaimerTime.remaining = 3500/this._disclaimerTime.remaining = 100/g' /jci/gui/apps/system/js/systemApp.js
/jci/scripts/set_lvds_speed_restriction_config.sh disable
/jci/scripts/set_speed_restriction_config.sh disable
/jci/tools/jci-dialog --title="Tweaks Applied" --text="Tweaks have finished running" --ok-label='OK' --no-cancel &

sleep 10

killall jci-dialog