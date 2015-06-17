#! /bin/sh
MYDIR=$(dirname $(readlink -f $0))
TIMESTAMP=$(date "+%m%d%Y-%H%M%S")
LOGFILE=${MYDIR}/${TIMESTAMP}.txt

echo "Checking ${MYDIR} for test.mp4" >> ${LOGFILE}
if [ -e "${MYDIR}/test.mp4" ]; then
  echo "Found test.mp4, attempting to play file" >> ${LOGFILE}
  gst-launch filesrc location=${MYDIR}/test.mp4 typefind=true ! aiurdemux name=demux demux. ! queue max-size-buffers=0 max-size-time=0 ! vpudec ! mfw_v4lsink demux. ! queue max-size-buffers=0 max-size-time=0 ! beepdec ! audioconvert ! 'audio/x-raw-int, channels=2' ! alsasink
else
  echo "Did not find test.mp4" >> ${LOGFILE}
  /jci/tools/jci-dialog --title="Video Playback Error" --text="Unable to play video" --ok-label='OK' --no-cancel &
fi

echo "Sleeping for 10" >> ${LOGFILE}
sleep 10

echo "Killing dialog box" >> ${LOGFILE}
killall jci-dialog
