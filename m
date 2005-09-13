From: David Brownell <david-b@pacbell.net>
Subject: [patch 0/3] driver model wakeup flags
Date: Mon, 12 Sep 2005 19:23:58 -0700
Message-ID: <200509121923.58993.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+gjJDHuP8JC2gF8"
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_+gjJDHuP8JC2gF8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is a refresh of the patch to add wakeup infrastructure to the
driver model, in three parts.  Comments?  Merge?

	pm-wake.patch ... adds the flags, and sysfs support
	pm-usb.patch ... usb devices use it
	pm-pci.patch ... pci devices use it

The default gives the current behavior:  wakeup is enabled on all
devices that support it.  (Assuming ACPI etc don't get in the way...)

This goes back to having the sysfs "wakeup" file be tristate.
Wakeup can be "enabled" or "disabled", and toggled from userspace.
Or it can be unavailable, value "", if the hardware doesn't support
wakeup or if no software has marked the device as supporting wakeup.

I attach a simple script I wrote to show what devices are capable
of wakeup events.  On one system, it reports wakeup allowed for
several builtin devices and a USB keyboard/hub:

  lan        on  pci0000:00/0000:00:0a.0/0000:02:01.0
  modem      on  pci0000:00/0000:00:06.1
  hub        on  pci0000:00/0000:00:02.2/usb1
  usb_host   on  pci0000:00/0000:00:02.2
  input      on  pci0000:00/0000:00:02.1/usb3/3-1/3-1.1
  hub        on  pci0000:00/0000:00:02.1/usb3/3-1
  hub        on  pci0000:00/0000:00:02.1/usb3
  usb_host   on  pci0000:00/0000:00:02.1
  hub        on  pci0000:00/0000:00:02.0/usb2
  usb_host   on  pci0000:00/0000:00:02.0
  i2c        on  pci0000:00/0000:00:01.1

On this system /proc/acpi/wakeup says

  Device  Sleep state     Status
  USB0       3            disabled
  USB1       3            disabled
  USB2       3            disabled
  MAC0       3            disabled

I'm guessing those are the 00:02.* and 02:01.0 nodes.  The hubs and
input device (USB keyboard) use USB-internal wakeups and kick the
usb_host nodes ... ACPI wouldn't know about them.  (I understand
that firewire could do the same sort of thing too.)  The I2C device
is actually SMBUS, waking up from D3hot or D3cold; I suspect that's
handled by ACPI somehow.

- Dave


--Boundary-00=_+gjJDHuP8JC2gF8
Content-Type: application/x-shellscript;
  name="pm-wake"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pm-wake"

#!/bin/bash

# devtype $PATH ==> $type
devtype ()
{
	local F T

	# fixed length, currently ten spaces
	type=""

	for F in $(cd $1; echo *:*)
	do
		case $F in
		# ignore device names by recognizing specific patterns
		net:eth*)	type="lan       "; return;;
		net:*)		type="net       "; return;;
		usb_host:*)	type="usb_host  "; return;;
		sound:*)	type="modem     "; return;;
		i2c-dev:*)	type="i2c       "; return;;

		# avoid really generic labels
		usb_device:*)
			read T < $1/maxchild
			if [ 0 -lt $T ]
			then
				type="hub       "
				return
			fi
			# REVISIT this ignores Ethernet adapters...
			for T in $(cd $1; echo */input:*)
			do
				type="input     "
				return
			done
			type="(usb)     "
			continue;;
		esac
	done

	if [ "$type" = "" ]
	then
		for T in $(cd $1; echo fw-host*/ieee1394_host:*)
		do
			type="firewire  "
			return
		done
	fi

	if [ "$type" = "" ]
		then
		type="          "
	fi
}

cd /sys/devices
for F in $(find * -name 'wakeup')
do
	# F=.../power/wakeup
	read value < $F
	if [ "$value" = "" ]
	then
		continue
	fi

	# F=...
	F=$(dirname $(dirname $F))
	devtype $F

	# for each entry that actually supports wakeup, one line with:
	#  - device type (if recognized)
	#  - wake on/OFF
	#  - /sys/devices/... path
	case "$value" in
	"disabled")	echo "$type OFF $F" ;;
	"enabled")	echo "$type on  $F" ;;
	esac
done

--Boundary-00=_+gjJDHuP8JC2gF8
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_+gjJDHuP8JC2gF8--
