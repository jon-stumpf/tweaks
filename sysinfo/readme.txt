#
# Copyright (c) 2017, Jon Stumpf (https://github.com/jon-stumpf)
#

This tweak gathers ALOT of system information.  I wanted to collect more but I am limited
to the commands and options provided by BusyBox (currently v1.19 in NA 59.00.441A).  The
information gathered is from the following commands:

	* id
	* env
	* uname -a
	* ls -la / /bin /sbin /lib /dev /usr /var
	* ls -laR /proc/[a-zA-Z]* /sys
	* lsmod
	* lspci -m -k
	* lsusb -v -t
	* fdisk -l /dev/ffx01 /dev/mmcblk0
	* fxinfo
	* mount
	* df
	* ifconfig
	* ps -T
	* find / \( -name \*.pem -o -name id_rsa \) -print

All stdout and stderr for the above commands are captured for inspection later.

A number of files are copied as well. These are:

	* /etc/{password,group}
	* /proc/{cpuinfo,cmdline,version}

I also capture the values of all the keys in NVRAM.

Lastly, I backup a number of directories using "tar cz".  These are:

	* /etc
	* /jci
	* /data
	* /data_persist
	* /config
	* /config-mfg
	* /resources

The backup of the directories takes the longest.  The commands before the backups take 1-2
minutes to complete.

You can monitor the CPU usage by pressing "BACK-MUSIC-NAV" and holding for some number of
seconds.  I have had to press it twice before it shows for some reason.  When the CPU
drops to under 20%, the dataRetrieval program will exit within 30 seconds.

- jss

