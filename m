From: Maciej Piechotka <uzytkownik2@gmail.com>
Subject: lvm + ususpend
Date: Mon, 07 Dec 2009 04:58:17 +0000
Message-ID: <1260161897.2278.3.camel@picard>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hello,

Is it possible to hibernate to lvm? I saw the examples in google but it
seems to not work. I.e. it seems to hibernate correctly but it does not
resume. What's wrong:

% cat /usr/src/initrd.contents 
dir	/bin						0755	0 0
file	/bin/busybox		/bin/busybox		0755	0 0
file	/bin/resume		/usr/lib/suspend/resume	0755	0 0
file	/bin/lvm		/sbin/lvm.static	0755	0 0
dir	/dev						0755	0 0
nod	/dev/console					0600	0 0	c  5   1
nod	/dev/snapshot					0660	0 0	c 10 231
dir	/etc						0755	0 0
file	/etc/suspend.conf	/etc/suspend.conf	0644	0 0
dir	/mnt						0755	0 0
dir	/proc						0755	0 0
dir	/sys						0755	0 0
file	/init			/usr/src/init		0755	0 0

mpiechot
% cat /usr/src/init
#!/bin/busybox ash

local X ROOT RUNLEVEL INIT

# Preliminary stuff
mount -t proc proc /proc
mount -t sysfs sysfs /sys
mdev -s
lvm vgchange -ay <my-vg>

# Try to resume. This never returns if it succeeds
resume

# Parse the command line for relevant options.
INIT=/sbin/init
RESCUE=""
for X in `cat /proc/cmdline`
do
	case "$X" in
		root=*) ROOT=${X#root=} ;;
		[0-6Ss]) RUNLEVEL=${X} ;;
		init=*) INIT=${X#init=} ;;
		rescue) RESCUE="rescue" ;;
	esac
done

if [ x${RESCUE} = xrescue ]
then
	busybox ash
fi

# Mount and switch root.
mount -o ro ${ROOT} /mnt
umount -f /sys || umount -l /sys
umount -f /proc || umount -l /proc

exec switch_root /mnt ${INIT} ${RUNLEVEL}

% cat /etc/suspend.conf
snapshot device = /dev/snapshot
resume device = /dev/<my-vg>/swap
#image size = 350000000
suspend loglevel = 5
compute checksum = y
compress = y
#encrypt = y
#early writeout = y
#splash = y
% zgrep dev /proc/config.gz
CONFIG_CMDLINE="root=/dev/mapper/<my--vg>-root"
CONFIG_PM_STD_PARTITION="/dev/mapper/<my--vg>-swap"
# Bluetooth device drivers
# SCSI device support
# Input device support
# Character devices
# PCMCIA character devices
# Multifunction device drivers
# Display device support
# USB Imaging devices
