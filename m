From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: Power Mangement Interfaces
Date: Sun, 1 Apr 2007 10:56:01 -0600
Message-ID: <20070401165601.GA13389__43658.0219692134$1175446576$gmane$org@cosmic.amd.com>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200703311157.03975.david-b@pacbell.net>
	<20070401010155.GA10151@cosmic.amd.com>
	<200703312001.55231.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703312001.55231.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, devel@laptop.org
List-Id: linux-pm@vger.kernel.org

A few of your comments made me wonder if I haven't been clear enough -
despite this being an x86 platform, we are not using ACPI for power =

management, for a variety of reasons, including the fact that we have
our own open source firmware and a very specific hardware platform
So, for better or worse, we are implementing a new power management
manger.  Here is the code: =


http://dev.laptop.org/git.do?p=3Dolpc-2.6;a=3Dblob;h=3De6e19ac32a881be962db=
7190f2cb460e9f60a9da;hb=3Dpowermgmt;f=3Darch/i386/kernel/olpc-pm.c

On 31/03/07 20:01 -0700, David Brownell wrote:
> > The =

> > story is much more muddled for x86 - there is no direct mapping of inte=
rrupts
> > to wakeup sources, and the PIC has nothing to do with handling wake eve=
nts.
> =

> Right.  Plus there often seems to be an assumption that some "embedded
> (micro)controller" (EC) manages system bringup/wakeup/runtime.

Or, the southbridge, or in the case of the OLPC platform, both.

> =

> > On the Geode, we have 17 possible wake sources, all of which are ORed
> =

> What are those?  You mentioned four before.  (RTC alarm, two GPIOs,
> and the power button.)  I'd guess various PCI devices can also issue
> wakeups.  (And if USB is one of them, up to 126 USB devices hooked
> up to each USB host controller!)

The silicon can handle wakeups from RTC, a sleep button, a power button, =

8 GPIO groups, the USB controller (covering any and all USB events),
UART1, UART2, SMbus and the PIC.

OLPC really only cares about 4 of those, because our only sleep state
is ~S3, and the PIC, smbus, UARTs and USB are off in S3.  We also only
have the power button, and all the rest of the wakeup sources come from
the GPIOs.

> > This looks very good, and is pretty close to what I was proposing.  =

> > Replace the acpi_*_event() calls with a generic pm_ infrastructure, and
> =

> Inside ACPI ... why?

I'm not saying inside ACPI - I'm saying at the driver level.  Something
like this (where name could be a string like ACPI does, but it would be
more portable if it was a #define'ed value).

pm_set_event(name) {
   pm_ops->set_event(name, 1);
}

pm_clear_event(name) {
   pm_ops->set_event(name, state);
}

And then each subsystem that defines a struct pm_ops adds a set_event() that
does the right thing.

In OLPC's case  we would do something like this:

olpc_pm_set_event(name, state) {
	switch(name) {
		case PM_WAKEUP_RTC:
			pm1_wakeup |=3D (1 << 9);
			break;

			...
	}
}

And so forth.  Like the AT91, we enable the wakeup events prior to
suspending. I'm willing to bet that other PM methods like ACPI
could pick this up pretty quickly too. =


> > add hooks to the pm_ops for each individual PM system to handle the wak=
eups
> > in whatever way they see fit, and we're there.  It would be slightly mo=
re
> > complex for AT91 and friends to match this (since they have the advanta=
ge
> > of a 1:1 mapping right now), but in the long run, I think everybody wou=
ld
> > benefit.
> =

> I guess I don't see why this isn't already sufficiently generic ...
> =

> As a rule, all those embedded drivers are platform-specific and have
> no need for more than a few enable_irq_wake() calls, in addition to
> whatever controller setup and clock management they do.  Since they
> can't be very portable, they don't need to generalize such stuff.

enable_irq_wake() just doesn't work for x86, unfortunately.  It seems
to me to be more logical to move the wakeup intelligence to the PM subsyste=
m,
and then let that code distribute it to where it is needed.  In the case
of x86, the logic would stay in the PM method, for other processors, it =

might involve a call to the interrupt mapper.

> And for PCI based things, pci_enable_wake() encapsulates everything
> that needs doing.  Not that ACPI actually *does* anything yet!  But
> the stuff that writing /proc/acpi/wakeup enables should happen in that
> routine ... and eventually PCI runtime wake events should work too.
> (So:  no drivers would ever call ACPI directly, and they already have
> the generic call that ACPI should hook.)
> =

> That seems to cover most drivers in Linux, without a need for any
> new generic PM infrastructure.  Did I overlook something important?

No, I don't think so - we're very close on agreeing here.  I just don't know
if enable_irq_wake() is the best way to provide the generic call.  Moving
it into the PM infrastructure seems the best way to handle everybody
equally, regardless of the relative intelligence or stupidity of their =

hardware implementation.

> > The only other issue then, is how we could define and manage wakeup eve=
nts
> > for events that aren't associated with specific devices, like power but=
ton
> > and lid events.  We'll need some way to control those somewhere in sysf=
s -
> > if not in /sys/power/wakeup like I had proposed, then somewhere under t=
he
> > platform or system hierarchy .
> =

> I see /sys/devices/acpi_system:00/button_power:00 on this system; and
> /sys/devices/acpi_system:00/device:00/PNP0C0D:00 has path \_SB_.LID_ ...
> such device nodes already exist, even though they're not really hooked
> up to anything much.  Notably, their "wakeup" state is not initialized.
> =

> And while it seems that the three USB controllers on this system show up
> as /sys/devices/acpi_system:00/device:00/PNP0A03:00/device:{01,02,03} I
> have no idea which one is /sys/devices/pci0000:00/0000:00:02.2 versus
> 0000:00:02.1 or 0000:00:02.0 ... I know that USB0 is device:01 and so
> on (by reading "path"), but associating one with a PCI device seems to
> involve pure guesswork.

I guess we'll probably have to do something similar for our OLPC PM code
- but thats the sort of platform specific fragmentation thing I was trying
to avoid.

Jordan

-- =

Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>
