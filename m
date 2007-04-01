From: David Brownell <david-b@pacbell.net>
Subject: Re: Power Mangement Interfaces
Date: Sat, 31 Mar 2007 20:01:54 -0700
Message-ID: <200703312001.55231.david-b__10170.1715765104$1175396549$gmane$org@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200703311157.03975.david-b@pacbell.net>
	<20070401010155.GA10151@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070401010155.GA10151@cosmic.amd.com>
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

On Saturday 31 March 2007 6:01 pm, Jordan Crouse wrote:
> On 31/03/07 11:57 -0700, David Brownell wrote:
> > The other part is the platform code.  On embedded hardware that's usual=
ly
> > just calling device_init_wakeup() before registering the platform devic=
es,
> > and supporting enable_irq_wake().  On x86 that gets messy; ACPI is ther=
e,
> > and PCI initialization can't set device_init_wakeup() because of confli=
cts
> > with how PPC initializes PCI.
> =

> enable_irq_wake() looks like it integrates very well with the AT91, since
> it seems that there is a 1:1 mapping of interrupts to wakeup sources. =


The same is true for every embedded CPU I've had reason to look at.


> The =

> story is much more muddled for x86 - there is no direct mapping of interr=
upts
> to wakeup sources, and the PIC has nothing to do with handling wake event=
s.

Right.  Plus there often seems to be an assumption that some "embedded
(micro)controller" (EC) manages system bringup/wakeup/runtime.


> On the Geode, we have 17 possible wake sources, all of which are ORed

What are those?  You mentioned four before.  (RTC alarm, two GPIOs,
and the power button.)  I'd guess various PCI devices can also issue
wakeups.  (And if USB is one of them, up to 126 USB devices hooked
up to each USB host controller!)


> together to form the SCI interrupt. Some of the events, like the RTC,
> UART, and USB wakeup sources are associated with devices that have their
> own interrupts, but there is no correlation between the RTC interrupt, =

> for example, and enabling it as a wakeup source.  It seems overly complex
> to try to map these to individual interrupts, and certainly seems wasteful
> to get the PIC involved in something it just doesn't understand.

I concluded the same thing a while back:  x86 PC platforms seem to have
been architected to isolate PM concerns from runtime concerns.  This is
surely part of why "it only takes 35 Watts!!" counts as "low" power despite
the decimal point being three or more digits left of where it should be!

I wonder what a 35 Watt cell phone would look like?  :)

 =

> > As in "echo enabled > /sys/devices/.../power/wakeup" (to get the defaul=
t),
> > or "echo disabled > ..." to disable it.  For PCs, with ACPI, that invol=
ves
> > two patches I just posted to the RTC list (and CC'd Len on), and replac=
ing
> > the ancient/legacy/ACPI-only /proc/acpi/alarm interface.
> =

> The link is here for the interested:
> =

> http://groups.google.com/group/rtc-linux/browse_thread/thread/ae7fe3436e0=
1e7fa

There are two other messages that may be of interest too, including the one
defining and calling the hooks implemented in that message; click on the li=
st
name to get the archives.


> This looks very good, and is pretty close to what I was proposing.  =

> Replace the acpi_*_event() calls with a generic pm_ infrastructure, and

Inside ACPI ... why?


> add hooks to the pm_ops for each individual PM system to handle the wakeu=
ps
> in whatever way they see fit, and we're there.  It would be slightly more
> complex for AT91 and friends to match this (since they have the advantage
> of a 1:1 mapping right now), but in the long run, I think everybody would
> benefit.

I guess I don't see why this isn't already sufficiently generic ...

As a rule, all those embedded drivers are platform-specific and have
no need for more than a few enable_irq_wake() calls, in addition to
whatever controller setup and clock management they do.  Since they
can't be very portable, they don't need to generalize such stuff.

And for PCI based things, pci_enable_wake() encapsulates everything
that needs doing.  Not that ACPI actually *does* anything yet!  But
the stuff that writing /proc/acpi/wakeup enables should happen in that
routine ... and eventually PCI runtime wake events should work too.
(So:  no drivers would ever call ACPI directly, and they already have
the generic call that ACPI should hook.)

That seems to cover most drivers in Linux, without a need for any
new generic PM infrastructure.  Did I overlook something important?


> The only other issue then, is how we could define and manage wakeup events
> for events that aren't associated with specific devices, like power button
> and lid events.  We'll need some way to control those somewhere in sysfs -
> if not in /sys/power/wakeup like I had proposed, then somewhere under the
> platform or system hierarchy .

I see /sys/devices/acpi_system:00/button_power:00 on this system; and
/sys/devices/acpi_system:00/device:00/PNP0C0D:00 has path \_SB_.LID_ ...
such device nodes already exist, even though they're not really hooked
up to anything much.  Notably, their "wakeup" state is not initialized.

And while it seems that the three USB controllers on this system show up
as /sys/devices/acpi_system:00/device:00/PNP0A03:00/device:{01,02,03} I
have no idea which one is /sys/devices/pci0000:00/0000:00:02.2 versus
0000:00:02.1 or 0000:00:02.0 ... I know that USB0 is device:01 and so
on (by reading "path"), but associating one with a PCI device seems to
involve pure guesswork.

- Dave
