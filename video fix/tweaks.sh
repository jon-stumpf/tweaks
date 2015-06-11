#! /bin/sh

if [ -d "/mnt/sd?1/config" ]; then
	echo 1 > /sys/class/gpio/Watchdog\ Disable/value
	mount -o rw,remount /
	mv /CMU-root/usr/lib/gstreamer-0.10/libmfw_gst_v4lsink.so /CMU-root/usr/lib/gstreamer-0.10/libmfw_gst_v4lsink.so.old
	cp /mnt/sd?1/config/libmfw_gst_v4lsink.so /CMU-root/usr/lib/gstreamer-0.10/
	rm -rf /mnt/sd?1/config
  else
  /jci/tools/jci-dialog --title="Video Fix" --text="Video Fix was not applied or may have already been applied" --ok-label='OK' --no-cancel &
fi

sleep 10

killall jci-dialog