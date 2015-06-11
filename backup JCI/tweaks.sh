#! /bin/sh

if [ -d "/mnt/sd?1/backup" ]; then
	cp /jci /mnt/sd?1/backup
	/jci/tools/jci-dialog --title="Video Fix" --text="JCI Backup complete!" --ok-label='OK' --no-cancel &
  else
  /jci/tools/jci-dialog --title="Video Fix" --text="JCI Backup did not run!" --ok-label='OK' --no-cancel &
fi

sleep 10

killall jci-dialog