#!/bin/sh
#
# Copyright (c) 2017, Jon Stumpf (https://github.com/jon-stumpf)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License (GPL), version 3,
# as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

########################################
# Begin Program
#

TIMESTAMP="$(date '+%Y%m%dT%H%M%S')"
CURR_DIR="$(dirname $(readlink -f ${0}))"
DATA_DIR="${CURR_DIR}/data-${TIMESTAMP}"

##########
# Create directory to hold information
#
mkdir "${DATA_DIR}"

if [ ! -d "${DATA_DIR}" ]
then
	exit 1
fi

# The thing it is expecting before we capture all output
cat "/jci/version.ini"

# Capture all standard output and error
exec 1> "${DATA_DIR}/stdout.log" 2> "${DATA_DIR}/stderr.log"

echo "${0}: ${@}"
echo ""
echo "${PWD}: present working directory"
echo "${CURR_DIR}: current directory"
echo "${DATA_DIR}: data directory"
echo ""

cd "${DATA_DIR}"

id > id.out
cp /etc/passwd /etc/group .

env > env.out

uname -a > uname.out

for i in cpuinfo cmdline version # version_signature
do
	cp "/proc/${i}" .
done

ls -la / > ls-root.out

for i in bin sbin lib dev usr var
do
	ls -la "/${i}/." > "ls-${i}.out"
done

ls -laR /proc/[a-zA-Z]* > lsR-proc.out
ls -laR /sys > lsR-sys.out

lsmod > lsmod.out

# lshw -quiet -html > lshw.html
# lshw -quiet > lshw.out

# lspci -t -vv -nn > lspci.out
lspci -m -k > lspci.out
lsusb -v -t > lsusb.out

for i in ffx01 mmcblk0
do
	fdisk -l "/dev/${i}" > "fdisk-${i}.out"
done

fxinfo > fxinfo.out

mount > mount.out
df > df.out

# cp /boot/grub/grub.cfg .

ifconfig > ifconfig.out

# lsof -iTCP -n > lsof.out

ps -T > ps.out

find / \( -name \*.pem -o -name id_rsa \) -print > keys.list

for i in etc jci bootchart data data_persist config config-mfg resources
do
	tar czf "${i}.tgz" "/${i}"
done

(cd /sys/class/nvram/nv-config/keys; for i in *; do echo -n "${i}: "; cat "${i}"; done;) > nvram-keys.out

exit 0

