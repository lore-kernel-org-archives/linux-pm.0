From: David Brownell <david-b@pacbell.net>
Subject: Re: Power Mangement Interfaces
Date: Sun, 1 Apr 2007 17:28:10 -0700
Message-ID: <200704011728.10966.david-b__30868.4343858205$1175473733$gmane$org@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200703312001.55231.david-b@pacbell.net>
	<20070401165601.GA13389@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070401165601.GA13389@cosmic.amd.com>
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
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, devel@laptop.org
List-Id: linux-pm@vger.kernel.org

On Sunday 01 April 2007 9:56 am, Jordan Crouse wrote:
> A few of your comments made me wonder if I haven't been clear enough -
> despite this being an x86 platform, we are not using ACPI for power =

> management, for a variety of reasons, including the fact that we have
> our own open source firmware and a very specific hardware platform.

I probably should have known that, but no you weren't clear.


> So, for better or worse, we are implementing a new power management
> manger.  Here is the code: =

> =

> http://dev.laptop.org/git.do?p=3Dolpc-2.6;a=3Dblob;h=3De6e19ac32a881be962=
db7190f2cb460e9f60a9da;hb=3Dpowermgmt;f=3Darch/i386/kernel/olpc-pm.c

Does that work yet with CONFIG_NO_HZ, so that the system idle loop
enters some "almost everyting is turned off" low power state?  Or
would that be something other than a "PM Manager"?


> > > On the Geode, we have 17 possible wake sources, all of which are ORed
> > =

> > What are those?  You mentioned four before.  (RTC alarm, two GPIOs,
> > and the power button.)  I'd guess various PCI devices can also issue
> > wakeups.  (And if USB is one of them, up to 126 USB devices hooked
> > up to each USB host controller!)
> =

> The silicon can handle wakeups from RTC, a sleep button, a power button, =

> 8 GPIO groups, the USB controller (covering any and all USB events),
> UART1, UART2, SMbus and the PIC.
> =

> OLPC really only cares about 4 of those, because our only sleep state
> is ~S3, and the PIC, smbus, UARTs and USB are off in S3.  We also only
> have the power button, and all the rest of the wakeup sources come from
> the GPIOs.

So it's a slightly deeper "S3" than I've usually seen, but not by much.

And correct me if I'm wrong, but your RTC can work with "rtc-cmos", and
the wake hooks I've posted (and which will be in the next MM release)
sound like they'll work just fine (given OLPC-specific implementation,
which is clearly not included in the code above).


> > > This looks very good, and is pretty close to what I was proposing.  =

> > > Replace the acpi_*_event() calls with a generic pm_ infrastructure, a=
nd
> > =

> > Inside ACPI ... why?
> =

> I'm not saying inside ACPI - I'm saying at the driver level.

Whereas in that patch, the only ACPI calls were inside ACPI itself;
and that driver only had a callback.  FWIW that's the first time
I've ever needed to have indirection on wakeup event handling ...


> Something =

> like this (where name could be a string like ACPI does, but it would be
> more portable if it was a #define'ed value).
> =

> pm_set_event(name) {
>    pm_ops->set_event(name, 1);
> }
> =

> pm_clear_event(name) {
>    pm_ops->set_event(name, state);
> }
> =

> And then each subsystem that defines a struct pm_ops adds a set_event() t=
hat
> does the right thing.

What are the "1" and "state" values supposed to signify?

This does assume there's some fairly centralized definition of
that "event" space.  That seems awkward on chips that could have
a few hundred wakeup events.  (Example:  128 GPIOs, plus IRQs
from several dozen on-chip controllers, just on the main SOC
device ... plus the external events which may be multiplexed
onto those event sources.)  Yes, of course any given board will
rarely have more than a couple dozen wake events; but still..

Evolving those systems doesn't work so well if they're highly
centralized, since the next chip rev will change these controllers,
add some, remove some ... very little of that code should change,
but when everything is centralized that tends not to happen.


> In OLPC's case  we would do something like this:
> =

> olpc_pm_set_event(name, state) {
> 	switch(name) {
> 		case PM_WAKEUP_RTC:
> 			pm1_wakeup |=3D (1 << 9);
> 			break;

One big switch statement with potentialy hundreds of entries ... it'd
be better to have callback functions associated with something, like
maybe the device!  (I'm not just saying that because that's how the
cmos-rtc hook now works...)


> =

> 			...
> 	}
> }
> =

> And so forth.  Like the AT91, we enable the wakeup events prior to
> suspending. I'm willing to bet that other PM methods like ACPI
> could pick this up pretty quickly too. =


With AT91 (and most ARMs) the wake events are normal IRQs, and the
irq infrastructure already handles wake events cleanly.  So I'd
claim they don't _want_ to change something that's inexpensive,
already deployed (training, code, testing, etc), and working.

So I hope you'll tolerate me if I view this as less of a "how do
we get a generic solution" and more of a "how does _this_ x86-ish
issue get solved cleanly".


> > > add hooks to the pm_ops for each individual PM system to handle the w=
akeups
> > > in whatever way they see fit, and we're there.  It would be slightly =
more
> > > complex for AT91 and friends to match this (since they have the advan=
tage
> > > of a 1:1 mapping right now), but in the long run, I think everybody w=
ould
> > > benefit.
> > =

> > I guess I don't see why this isn't already sufficiently generic ...
> > =

> > As a rule, all those embedded drivers are platform-specific and have
> > no need for more than a few enable_irq_wake() calls, in addition to
> > whatever controller setup and clock management they do.  Since they
> > can't be very portable, they don't need to generalize such stuff.
> =

> enable_irq_wake() just doesn't work for x86, unfortunately.

And it doesn't need to, either.  Those drivers can't run on x86.

That's just one more mechanism -- like clk_enable()/clk_disable(),
set_irq_type(), or generic GPIOs -- that isn't really available on x86,
despite being fundamental on may other platforms.


> It seems =

> to me to be more logical to move the wakeup intelligence to the PM subsys=
tem,
> and then let that code distribute it to where it is needed.  In the case
> of x86, the logic would stay in the PM method, for other processors, it =

> might involve a call to the interrupt mapper.

But why should a "PM subsystem" be created to abstract something that
already works just fine?

It'd make much more sense to me to come up with a good way to handle
the x86 issues first, and only then think about whether to try
making that work on other systems.

 =

> > And for PCI based things, pci_enable_wake() encapsulates everything
> > that needs doing.  Not that ACPI actually *does* anything yet!  But
> > the stuff that writing /proc/acpi/wakeup enables should happen in that
> > routine ... and eventually PCI runtime wake events should work too.
> > (So:  no drivers would ever call ACPI directly, and they already have
> > the generic call that ACPI should hook.)
> > =

> > That seems to cover most drivers in Linux, without a need for any
> > new generic PM infrastructure.  Did I overlook something important?
> =

> No, I don't think so - we're very close on agreeing here.  I just don't k=
now
> if enable_irq_wake() is the best way to provide the generic call. =


It's not, and I didn't propose doing that either.

Having all drivers try to use the same calls to manage wakeup
mechanisms doesn't seem like the right model.  When the mechanism
is the same -- wakeup irqs, say -- then yes the calls should be
the same.  But when the mechanisms differ -- PCI PME# is very
different from wakeup IRQS, only one per device etc -- then the
calls can reasonably be different.


> Moving =

> it into the PM infrastructure seems the best way to handle everybody
> equally, regardless of the relative intelligence or stupidity of their =

> hardware implementation.

I guess that's where we disagree:  you're assuming "one call to rule
them all", where I'm thinking that IRQ calls should manage IRQs,
PCI calls should manage PME#, and so on.


> > > The only other issue then, is how we could define and manage wakeup e=
vents
> > > for events that aren't associated with specific devices, like power b=
utton
> > > and lid events.  We'll need some way to control those somewhere in sy=
sfs -
> > > if not in /sys/power/wakeup like I had proposed, then somewhere under=
 the
> > > platform or system hierarchy .
> > =

> > I see /sys/devices/acpi_system:00/button_power:00 on this system; and
> > /sys/devices/acpi_system:00/device:00/PNP0C0D:00 has path \_SB_.LID_ ...
> > such device nodes already exist, even though they're not really hooked
> > up to anything much.  Notably, their "wakeup" state is not initialized.
> > =

> > And while it seems that the three USB controllers on this system show up
> > as /sys/devices/acpi_system:00/device:00/PNP0A03:00/device:{01,02,03} I
> > have no idea which one is /sys/devices/pci0000:00/0000:00:02.2 versus
> > 0000:00:02.1 or 0000:00:02.0 ... I know that USB0 is device:01 and so
> > on (by reading "path"), but associating one with a PCI device seems to
> > involve pure guesswork.
> =

> I guess we'll probably have to do something similar for our OLPC PM code
> - but thats the sort of platform specific fragmentation thing I was trying
> to avoid.

Since OLPC isn't using ACPI,  it can be more like embedded Linux,
and just Do The Right Thing ... create platform devices, etc.  :)

My point above was that ACPI isn't yet integrating with the things
it needs to be integrating with.  If you're concerned about how to
work with wakeup events in Linux, don't even bother looking at ACPI.
Look at the embedded implementations; look at USB.  AT91 is by far
the cleanest and most complete (simplest hardware too!!), but some
of the other systems (OMAP, PXA, SA1100, etc) also implement wakeup
using board-specific code.

OLPC _could_ use that same "board-specific hacks" approach found in
most embedded platforms.  I'm glad you're thinking about how to
avoid doing that.

- Dave
