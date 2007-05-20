From: David Brownell <david-b@pacbell.net>
Subject: Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately
	resumes after STR
Date: Sun, 20 May 2007 11:38:04 -0700
Message-ID: <200705201138.05146.david-b__36784.6700632528$1179686392$gmane$org@pacbell.net>
References: <20070518071523.GA3195@inferi.kami.home>
	<20070519000413.75badb6f.akpm@linux-foundation.org>
	<20070520061408.GA3325@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070520061408.GA3325@inferi.kami.home>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mattia Dongili <malattia@linux.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 19 May 2007, Mattia Dongili wrote:
> On Sat, May 19, 2007 at 12:04:13AM -0700, Andrew Morton wrote:
> > On Sat, 19 May 2007 15:48:29 +0900 Mattia Dongili <malattia@linux.it> wrote:
> > 
> > > On Fri, May 18, 2007 at 12:22:40AM -0700, Andrew Morton wrote:
> > > > On Fri, 18 May 2007 16:15:24 +0900 Mattia Dongili <malattia@linux.it> wrote:
> > > > 
> > > > > Hello,
> > > > > 
> > > > > After finally catching fw-{ohci,core} to be problematic during resume,
> > > > > I'm now experiencing an immediate resume after suspending.
> > > > > 
> > > > > 2.6.21-rc7-mm* didn't even suspend, my last known suspend-and-resuming
> > > > > kernel was 2.6.21-rc5-mm3 (I know one other vaio SZ user could STR with
> > > > > 2.6.21-rc6-mm* after the cpuidle fixes).
> > > > > 
> > > > > my .config is: http://oioio.altervista.org/linux/config-2.6.22-rc1-mm1-1
> > > > > and a str cycle with PM_DEBUG=y:
> > > > > http://oioio.altervista.org/linux/dmesg-SRT-immediately-resumes.txt

Can you also provide /proc/acpi/wakeup and /proc/bus/usb/devices?
Plus "ethool eth0" and "ethtool -i eth0"?

And, for a bit more info, the output of the appended script.

(That's all *with* the patch listed below -- not reverted.)


> > > ...
> > > 
> 
> but very very close:
> acpi-driver-model-flags-and-platform_enable_wake.patch

Which only affects PCI devices at this time, FWIW ...

This is a symptom of a device or driver misbehaving.  You can
work around that; update the relevant /sys/devices/.../power/wakeup
value(s) to "disabled", pending a driver bugfix (or workaround).

In fact, you could turn them all off (see appended diagnostic
script) then turn them on one at a time to highlight problems

Reverting that patch just papers over the problem...


My suspicion, based on the dmesg and seeing what drivers actually
try to enable wakeup, would be the 'sky2' driver.  The other two
obvious candidates are EHCI (which behaves for me on non-Intel
hardware) and UHCI ... but USB has had a fair amount of testing
in terms of wakeup mechanisms, so that seems a bit less likely
to me (assuming no hardware bugs).

However, since after reverting the patch above you still saw
other problems (immediate re-suspend) I'm suspecting this isn't
a single simple problem you're finding.

- Dave


==========	CUT HERE
#!/bin/bash

# show the wakeup-capable devices and what's enabled/disabled

# class_label *:* ==> $type
class_label ()
{
	case $1 in
	# recognize common types of wakeup-capable devices
	i2c-dev:*)	type="smbus     "; return 0;;
	input:*)	type="input     "; return 0;;
	mmc_host:*)	type="mmc_host  "; return 0;;
	net:eth*)	type="lan       "; return 0;;
	net:*)		type="net       "; return 0;;
	pcmcia_socket:*)type="pcmcia    "; return 0;;
	rtc:*)		type="rtc       "; return 0;;
	sound:*)	type="modem     "; return 0;;
	tty:*)		type="tty       "; return 0;;
	usb_host:*)	type="usb_host  "; return 0;;
	esac
	return 1
}

# interface_label $PATH ==> $type
interface_label ()
{
	for F in $(cd $1 >/dev/null 2>&1 ; echo *:*)
	do
		class_label $F && return
	done
}

# devtype $PATH ==> $type
devtype ()
{
	local F T

	# fixed length, currently ten spaces
	type=""

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
				type="hub       "
				return
			fi
			type="(usb)     "
			continue;;
		*:*)	class_label $F && return ;;
		esac

	done

	if [ "$type" = "" ]
	then
		for T in $(cd $1 >/dev/null 2>&1 ; echo fw-host*/ieee1394_host:*)
		do
			if [ ! -L "$1/$T" ]
			then
				break;
			fi
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
