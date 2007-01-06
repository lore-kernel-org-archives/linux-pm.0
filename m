From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs
	functions in sysfs
Date: Sat, 6 Jan 2007 14:21:41 -0800
Message-ID: <200701061421.41342.david-b@pacbell.net>
References: <1168083306.5619.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1168083306.5619.34.camel@localhost.localdomain>
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
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Saturday 06 January 2007 3:35 am, Zhang Rui wrote:
> This patch set is against acpi-test sysfs branch, and will duplicate
> several ACPI procfs functions in sysfs. =

> As struct subsystem power_subsys is referred and the interface under
> /sys/power/ is changed by this patch series, =

> I wish to receive some comments from linux-pm too.

First, please be sure your mailer wraps TX lines well before the end
of an 80 character line.  (I had to do that manually in this reply.)

Second, I'm glad to see attention paid to those /proc/acpi files,
which AFAICT have been mostly left alone for many years now; that
neglect has been puzzling, given the driver model and sysfs plus
the general deprecation of procfs for operational tasks.

Third, stuff in /sys/power should be generic, and not depend on ACPI
infrastructure or models ... it should for example work for embedded
platforms where Linux runs on the bare metal.  Moreover, in general
an ACPI-specific interface should be the very last (and non-portable,
worst) choice, not the first/default/preferred one.


Which means in particular that:

> Patch 03-05:
> 	add ACPI sleep attributes in sysfs.
> 	/proc/acpi/sleep is already deprecated by /sys/power/state.
> 	/proc/acpi/alarm is deprecated by /sys/power/alarm.

A /sys/power/alarm thing conflicts with ongoing RTC framework work.

You may have missed the patches I've sent making RTCs be "just another
wakeup-capable device" -- an interface that already works with multiple
RTCs, is not in the least bit coupled to ACPI, and is on track to work
with on more platforms -- or the proposal to provide sysfs support for
activiting alarms within the RTC framework.

The latest patches relevant to the RTC used by ACPI are:

 http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D116802017116195&w=3D2
 http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D116802044406838&w=3D2
 http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D116802044531547&w=3D2
 http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D116802044532646&w=3D2

(Only that last one touches ACPI directly.)

Note that like it says in the first message, this version doesn't
have the "remove /proc/acpi/alarm" stuff, mostly to simplify merging
of the core driver code; that will be done later, and in any case the
old drivers/char/rtc.c code didn't interact with it either.  It worked
in earlier versions of the patch.  (Modulo the fact that ACPI wakeup
from STR seems to usually be a total lose.)  One such version:

 http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D116406177605472&w=3D2

You'll observe those ACPI bits are kind of messy.  The clean
approach I have in mind is to have callbacks in platform_data,
with which ACPI -- or EFI etc -- can do whatever nastiness it
needs to let the RTC alarm trigger wakeup from system sleep state.
A "bare metal" platform would just enable_irq_wake(); ACPI would
set a magic PM1 bit or whatever; etc.

(In terms of userspace tools, I posted an "rtcwake.c" tool working
on several platforms, including x86 PCs with the above patch plus
some ARM systems, notably AT91rm9200, with rtc wakeup irqs.)


> 	For those devices that support "wake" attribute,

Please tell me you mean "devices with a /sys/devices/.../power/wakeup"
attribute.  And that ACPI is finally going to start working with those
attributes ...


> 	two files, =

> 	"sleep_state" and "wakeup", are created for these devices. =


I'm going to be assuming your "wakeup" attribute has the same semantics
as that existing one.  If it doesn't, you should either fix your model,
or justify changing the Linux-wide model.


As for sleep_state:

> 	"sleep_state" indicates the lowest sleeping state that can be
> 	entered while still providing wake functionality. =


I understand that /proc/acpi/wakeup exposes this information.  I don't
understand how userspace is expected to use it.  Or, for that matter,
how this model ought to work on non-ACPI systems.  But most especially,
if it's useful, I don't understand why it would be ACPI-only.

(Yes, there are huge gaps in Linux-PM wakeup support.  Weak ACPI suppport
for it, especially from STR -- without swsusp -- is a big factor.  I
was pleased to see RTC wakeup from ACPI S4 actually work ... first time
I've ever seen ACPI wakeup ever work correctly.)


> 	"wakeup" can be used to enable/disable the device's
> 	ability to wake a sleeping system. =


We've found a need to nuance that a bit.  So for example a USB root
hub sure ought to support the USB "remote wakeup" mechanism in that
way, and by and large the BIOS will declare that it does.  (Not that
I've ever observed that to work from ACPI STR, mind you!!)

However, it appears out that on some boards remote wakeup doesn't
work right ... either there's a chipset bug, or some board wiring
problem, or something of that ilk.  This impacts _runtime_ power
management as well as system-wide sleep states.  So "wakeup" also
gets used to disable runtime PM techniques like suspending USB
devices to reduce system power drain (since that relies on remote
wakeup).  The hardware mechanism isn't used only to wake sleeping
systems; so the sysfs attribute isn't limited to that role either.


> 	So /proc/acpi/wakeup is deprecated by
> 	/sys/devices/acpi_system/.../xxx/sleep_state && wakeup. =


Why is ACPI still not coupling such information to the REAL device
nodes?  On my laptop, right now without any wakeup-capable USB
devices attached, the appended script produces:

% pm-wake
lan        on  pci0000:00/0000:00:0a.0/0000:01:01.0
           on  pci0000:00/0000:00:06.1
hub        on  pci0000:00/0000:00:02.2/usb3
usb_host   on  pci0000:00/0000:00:02.2
hub        on  pci0000:00/0000:00:02.1/usb2
usb_host   on  pci0000:00/0000:00:02.1
hub        on  pci0000:00/0000:00:02.0/usb1
usb_host   on  pci0000:00/0000:00:02.0
           on  pci0000:00/0000:00:01.1
rtc        on  pnp0/00:06
%  =


That's with various patches applied, notably one to transfer the
PCI PM "can issue PME#" flags to the device's wakeup flag.  (Much
the same patch circulated when the wakeup flag was added.  Works
fine on x86, but there was an PCI init sequencing issue on PPC
that kept it from getting merged.  And of course, ACPI wants some
additional out-of-band signaling, so only the RTC device is truly
a wakeup source on this system; sigh.)

That 00:06.1 device is a Winmodem, which /proc/acpi/wakeup doesn't
list as a wakeup event source ... maybe for good reason.  The 00:01.1
device is SMBUS, not listed for what I'm guessing is a less good
reason (i.e. it really IS a wakeup device, but managed internally
to ACPI).  I'm guessing RTC is omitted from /proc/acpi/wakeup since
that's really just a dump of one table, and it's not actually a
list of the system's wakeup-capable ACPI devices.

Note that /proc/acpi/wakeup says everything supports wake from S3;
but that's never worked on this system.  (Yes, even after enabling
everything in /proc/acpi/wakeup.)  RTC wakeup from S4 works, but
that's a mode that /proc/acpi/wakeup says doesn't exist, so I might
have been imagining that.  :)
 =

- Dave

#!/bin/bash

# show the wakeup-capable devices and what's enabled/disabled

# class_label *:* =3D=3D> $type
class_label ()
{
	case $1 in
	# recognize common types of wakeup-capable devices
	i2c-dev:*)	type=3D"smbus     "; return 0;;
	input:*)	type=3D"input     "; return 0;;
	mmc_host:*)	type=3D"mmc_host  "; return 0;;
	net:eth*)	type=3D"lan       "; return 0;;
	net:*)		type=3D"net       "; return 0;;
	pcmcia_socket:*)type=3D"pcmcia    "; return 0;;
	rtc:*)		type=3D"rtc       "; return 0;;
	sound:*)	type=3D"modem     "; return 0;;
	tty:*)		type=3D"tty       "; return 0;;
	usb_host:*)	type=3D"usb_host  "; return 0;;
	esac
	return 1
}

# interface_label $PATH =3D=3D> $type
interface_label ()
{
	for F in $(cd $1 >/dev/null 2>&1 ; echo *:*)
	do
		class_label $F && return
	done
}

# devtype $PATH =3D=3D> $type
devtype ()
{
	local F T

	# fixed length, currently ten spaces
	type=3D""

	for F in $(cd $1 >/dev/null 2>&1 ; echo *:*)
	do
		if [ ! -d "$1/$F" ]
		then
			break;
		fi

		# is this a usb interface?
		if [ -f $1/$F/bInterfaceClass ]
		then
			interface_label $1/$F && return
		fi

		case $F in
		# use interface's label if possible, else generic
		usb_device:*)
			read T < $1/maxchild
			if [ 0 -lt $T ]
			then
				type=3D"hub       "
				return
			fi
			type=3D"(usb)     "
			continue;;
		*:*)	class_label $F && return ;;
		esac

	done

	if [ "$type" =3D "" ]
	then
		for T in $(cd $1 >/dev/null 2>&1 ; echo fw-host*/ieee1394_host:*)
		do
			if [ ! -L "$1/$T" ]
			then
				break;
			fi
			type=3D"firewire  "
			return
		done
	fi

	if [ "$type" =3D "" ]
		then
		type=3D"          "
	fi
}

cd /sys/devices
for F in $(find * -name 'wakeup')
do
	# F=3D.../power/wakeup
	read value < $F
	if [ "$value" =3D "" ]
	then
		continue
	fi

	# F=3D...
	F=3D$(dirname $(dirname $F))
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
