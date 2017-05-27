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

JCI_DIR="/jci"
JCI_BIN="${JCI_DIR}/tools"

PATH="${JCI_BIN}:${PATH}"
export PATH

PROGRAM="SysInfo"
PROG_DESC="System Information"

TIMESTAMP="$(date '+%Y%m%dT%H%M%S')"
CURR_DIR="$(dirname $(readlink -f ${0}))"
DATA_DIR="${CURR_DIR}/data-${TIMESTAMP}"

log_message()
{
    MESSAGE="${*}"

    echo "${MESSAGE}"

    jci-dialog \
	--title="${PROG_DESC}" \
	--text="${MESSAGE}" \
	--ok-label='OK' \
	--no-cancel &
}

mkdir "${DATA_DIR}"

if [ -d "${DATA_DIR}" ]
then
    exec 1> "${DATA_DIR}/stdout.log" 2> "${DATA_DIR}/stderr.log"

    echo "${0}: ${@}"
    echo ""
    echo "${CURR_DIR}: current directory"
    echo "${DATA_DIR}: data directory"
    echo ""

    cd "${DATA_DIR}"

    id > id.out
    cp /etc/passwd > passwd
    cp /etc/group > group
    ls /etc > etc.ls

    env > env.out

    uname -a > uname.out

    for i in cpuinfo cmdline version version_signature
    do
    	cp "/proc/${i}" .
    done

    lsmod > lsmod.out

    lshw -quiet -html > lshw.html
    lshw -quiet > lshw.out

    lspci -t -vv -nn > lspci.out
    lsusb -t -v > lsusb.out

    mount > mount.out
    df > df.out

    cp /boot/grub/grub.cfg .

    lsof -iTCP -n > lsof.out

    ps --forest -F -H -e > ps.out

    find / \( -name \*.pem -o -name \*.pem -o -name id_rsa \) -ls > keys.list

    tar cjf etc.tbz2 /etc
    tar cjf jci.tbz2 "${JCI_DIR}"

    log_message "Information captured.  Remove USB."
else    
    log_message "${DATA_DIR}: could not create directory."
fi

sleep 5

killall jci-dialog

