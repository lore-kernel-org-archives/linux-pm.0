From: David Brownell <david-b@pacbell.net>
Subject: Re: Power Mangement Interfaces
Date: Sat, 31 Mar 2007 11:57:03 -0700
Message-ID: <200703311157.03975.david-b@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com> <200703310952.43696.david-b@pacbell.net> <20070331181612.GD8091@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070331181612.GD8091@cosmic.amd.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-pm@lists.linux-foundation.org, devel@laptop.org, linux-acpi@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Saturday 31 March 2007 11:16 am, Jordan Crouse wrote:
> On 31/03/07 09:52 -0700, David Brownell wrote:

> > You seem to be completely ignoring the /sys/devices/..../power/wakeup
> > event attributes.  Why?
> 
> Complete and total ignorance that they even existed.   I guess I should
> pay more attention to linux-pm then I do.. :(.    My impression is that
> this infrastructure allows the devices to configure themselves to wake
> up the system, 

Actually the model is that those files offer a per-device userspace
policy knob, defaulting to "yes, this can wake the system up" (since
otherwise such knobs will rarely be turned on!).  That should be
initialized before the device is registered.

Device driver responsibility is to check that setting in suspend()
and do the appropriate juju; and undo it in resume().  Other than
that, they don't "configure themselves".


> but it doesn't seem to address enabling the system to 
> allow those events to wake it.  It is the latter that I am concerned about.  

That's a split responsibility.  One part is in the device driver, since
it's the only thing that can really understand the mechanism involved;
for example, making sure the relevant device clocks are active, issuing
the enable_irq_wake() calls, and so on.  (PCI has its own magic.)

The other part is the platform code.  On embedded hardware that's usually
just calling device_init_wakeup() before registering the platform devices,
and supporting enable_irq_wake().  On x86 that gets messy; ACPI is there,
and PCI initialization can't set device_init_wakeup() because of conflicts
with how PPC initializes PCI.


> The Geode (and most other platforms, I presume) allows us to configure
> which wakeup events are actually allowed to wake the system.  Currently,
> we are permanently enabling the power button as a wakeup source, but I
> want to eventually be able to pick and chose from any of our main wakeup
> sources:
> 
> * Power button
> * RTC Alarm
> * LID event (GPIO26)
> * wake event from the EC (GPIO27) 

Yes ...


> Of the four, the only device that can actually be configured to do anything
> is the RTC alarm, and for that we would use the /sys/devices/../power/wakeup
> infrastructure, but we would still need something in place to allow the 
> software to tell the hardware to enable the RTC event to wake the system.

As in "echo enabled > /sys/devices/.../power/wakeup" (to get the default),
or "echo disabled > ..." to disable it.  For PCs, with ACPI, that involves
two patches I just posted to the RTC list (and CC'd Len on), and replacing
the ancient/legacy/ACPI-only /proc/acpi/alarm interface.

 
> I suppose we could just globally enable all sources, but that seems silly,
> seeing as though we do have very fine tuned control over the wake sources.
> I'm sure other platforms have this concern as well - what do they do?

Well, go look at the AT91 code and you'll see a fully worked example of
how the /sys/devices/.../power/wakeup files work for pretty much every
platform device (except the ethernet controller, where the driver doesn't
support any kind of WOL right now).

   * drivers/usb/host/ohci-at91.c ... remote wakeup supported, except
     in sleep states where the 48 MHz PLL is unavailable

   * drivers/usb/gadget/at91_udc.c ... similarly

   * drivers/pcmcia/at91_cf.c ... card detect GPIO or card IRQ can both
     be wakeup event sources

   * GRR, drivers/mmc/at91_mci.c seems to have dropped the wakeup GPIO
     updates, that *WAS WORKING* but someone discarded that code.

   * ... more, including UARTS

In general, not many platforms have general purpose wakeup event support
yet.  Lack of ACPI support -- and hence scarcity of models -- is a part
of it, but another part is project that stopped after they got their four
essential wakeup events to behave by hard-wiring the wake events in their
custom board-specific code.

For example:  in arch/arm/mach-pxa, grep for PWER (wakeup enable register).
There's a patch pending to teach PXA how enable_irq_wake() should work (by
updating PWER) -- an API that's been around for years! -- but until that
merges, wakeup events on every PXA system get hard-wired in *_pm.c files
that embed all kinds of limited-functionality grot.  (No way for USB to
wake those systems, as another example ... that code doesn't support any
of the sleep states from which it can issue wakeups.)

- Dave
