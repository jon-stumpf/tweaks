#! /bin/sh

if [ -d "/mnt/sda1/check" ]; then
  gst-launch filesrc location=/mnt/sda1/test.mp4 typefind=true ! aiurdemux name=demux demux. ! queue max-size-buffers=0 max-size-time=0 ! vpudec ! mfw_v4lsink demux. ! queue max-size-buffers=0 max-size-time=0 ! beepdec ! audioconvert ! 'audio/x-raw-int, channels=2' ! alsasink
elif [ -d "/mnt/sdb1/check" ]; then
  gst-launch filesrc location=/mnt/sdb1/test.mp4 typefind=true ! aiurdemux name=demux demux. ! queue max-size-buffers=0 max-size-time=0 ! vpudec ! mfw_v4lsink demux. ! queue max-size-buffers=0 max-size-time=0 ! beepdec ! audioconvert ! 'audio/x-raw-int, channels=2' ! alsasink
elif  [ -d "/mnt/sdc1/check" ]; then
  gst-launch filesrc location=/mnt/sdc1/test.mp4 typefind=true ! aiurdemux name=demux demux. ! queue max-size-buffers=0 max-size-time=0 ! vpudec ! mfw_v4lsink demux. ! queue max-size-buffers=0 max-size-time=0 ! beepdec ! audioconvert ! 'audio/x-raw-int, channels=2' ! alsasink
elif  [ -d "/mnt/sdd1/check" ]; then
  gst-launch filesrc location=/mnt/sdd1/test.mp4 typefind=true ! aiurdemux name=demux demux. ! queue max-size-buffers=0 max-size-time=0 ! vpudec ! mfw_v4lsink demux. ! queue max-size-buffers=0 max-size-time=0 ! beepdec ! audioconvert ! 'audio/x-raw-int, channels=2' ! alsasink
elif  [ -d "/mnt/sde1/check" ]; then
  gst-launch filesrc location=/mnt/sde1/test.mp4 typefind=true ! aiurdemux name=demux demux. ! queue max-size-buffers=0 max-size-time=0 ! vpudec ! mfw_v4lsink demux. ! queue max-size-buffers=0 max-size-time=0 ! beepdec ! audioconvert ! 'audio/x-raw-int, channels=2' ! alsasink
elif  [ -d "/mnt/sdf1/check" ]; then
  gst-launch filesrc location=/mnt/sdf1/test.mp4 typefind=true ! aiurdemux name=demux demux. ! queue max-size-buffers=0 max-size-time=0 ! vpudec ! mfw_v4lsink demux. ! queue max-size-buffers=0 max-size-time=0 ! beepdec ! audioconvert ! 'audio/x-raw-int, channels=2' ! alsasink
elif  [ -d "/mnt/sdg1/check" ]; then
  gst-launch filesrc location=/mnt/sdg1/test.mp4 typefind=true ! aiurdemux name=demux demux. ! queue max-size-buffers=0 max-size-time=0 ! vpudec ! mfw_v4lsink demux. ! queue max-size-buffers=0 max-size-time=0 ! beepdec ! audioconvert ! 'audio/x-raw-int, channels=2' ! alsasink
else
  /jci/tools/jci-dialog --title="Video" --text="Unable to play video" --ok-label='OK' --no-cancel &
fi

sleep 10

killall jci-dialog