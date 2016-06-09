From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Platform-specific suspend/resume code in drivers
Date: Thu, 9 Jun 2016 11:05:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1606091054140.1697-100000@iolanthe.rowland.org>
References: <57588D80.4010502@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:33494 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932073AbcFIPF0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2016 11:05:26 -0400
In-Reply-To: <57588D80.4010502@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Sebastian Frias <sf84@laposte.net>, Mark Rutland <mark.rutland@arm.com>

On Wed, 8 Jun 2016, Mason wrote:

> On 08/06/2016 19:45, Alan Stern wrote:
> 
> > On Wed, 8 Jun 2016, Mason wrote:
> > 
> >> On 07/06/2016 17:06, Alan Stern wrote:
> >>
> >>> On Tue, 7 Jun 2016, Mason wrote:
> >>>
> >>>> Another point of confusion for me is this: drivers are supposed to
> >>>> be shared among platforms, right? So my platform-specific suspend
> >>>> code should be enabled only if my platform is detected at run-time?
> >>>
> >>> Is your device platform-specific?  If it is then the driver is also
> >>> platform-specific, and so no part of the driver will be called at
> >>> runtime unless your platform is detected.
> >>
> >> Specifically, my platform uses
> >> drivers/net/ethernet/aurora/nb8800.c  => 3 entries in of_match_table.
> >> drivers/tty/serial/8250/8250_core.c (CONFIG_SERIAL_8250_RT288X variant)
> >>
> >> and also the XHCI USB3 driver, and AHCI SATA driver, wouldn't I need to
> >> save the context for these too?
> > 
> > Those drivers should already take care of their own contexts.  Is 
> > there anything platform-specific you need to do in addition?
> 
> Take the eth driver, for example:
> 
>   http://lxr.free-electrons.com/source/drivers/net/ethernet/aurora/nb8800.c
> 
> It doesn't have any suspend/resume callbacks.
> 
> Would that make the suspend request fail?

There are plenty of drivers that don't have suspend/resume callbacks.  
(Fewer than there used to be, fortunately.)  They don't make suspend
fail; rather, the PM core just skips over them when carrying out a
suspend.

Of course, if a driver needs suspend support but doesn't include it, 
then it's quite likely the driver will not work properly after the 
system has been resumed.  But that's not a platform-specific issue.

> > Consider xHCI as an example case -- what more does it need?
> 
> Lemme see...

...

> (Side note: they guarded the code with CONFIG_PM_SLEEP, rather
> than CONFIG_SUSPEND. Why?)

CONFIG_PM_SLEEP covers both suspend (AKA suspend-to-ram) and 
hibernation (AKA suspend-to-disk).

> Looking at xhci_suspend, it does call xhci_save_registers()
> so perhaps this specific driver already saves the context
> required to resume correctly after a full power-down.
> 
> >>> If the device isn't platform-specific then the driver has to work on a 
> >>> bunch of different platforms.  It should be written to be 
> >>> platform-independent as much as possible.
> >>>
> >>>> So this means I need to add in the probe function, for every driver
> >>>> my platform uses:
> >>>>
> >>>>   if (platform == MY_PLATFORM) {
> >>>>     ops.suspend = my_suspend;
> >>>>     ops.resume  = my_resume;
> >>>>   }
> >>>>
> >>>> Is that correct?
> >>>
> >>> No.  For one thing, you only have to worry about the 
> >>> platform-independent drivers -- you know that the platform-specific 
> >>> ones won't get used unless your platform is present.
> >>
> >> I guess the thermal driver is platform-specific, but most devices
> >> are third-party IP blocks, so there is a "common" driver upstream.
> >> But I would need a platform-specific suspend/resume sequence,
> >> just for my platform.
> > 
> > Why?  What sort of platform-specific things do you need to do?
> 
> Save the value of the MMIO registers which will be lost when the
> chip is powered down.

How did these registers get set in the first place?  Wherever the code 
is that sets them up initially, that's where these registers should be 
reinitialized following a resume.  If they were set up by 
platform-specific code then they should be reinitialized by 
platform-specific code.

> >>> For another, the driver should be written in a way that doesn't require
> >>> this sort of code.  The ops pointer (not any of the structure's members
> >>> -- a pointer to the structure) should be set by the platform-dependent
> >>> part of the driver that handles initialization.
> >>
> >> I don't understand. If my platform loses context on suspend, then
> >> I must save/restore it. But this wasteful operation should not be
> >> imposed on other platforms.
> > 
> > More details, please.
> 
> I'm confused. I must have misunderstood something fundamental, and my
> explanations come out wrong. Let me try again.
> 
> On this SoC (as most SoCs) device registers are mapped into memory.
> When this system is suspended, it was decided that we would
> 1) put the RAM in self-refresh mode
> 2) power everything down, but the RAM
> 
> So the contents of RAM are preserved, but the contents of the device
> registers will be lost. (And this context loss is platform specific;
> other SoCs may decide to keep some devices powered.) Anyway, when
> the chip is powered back up, some/most device registers need to be
> restored to their pre-suspend value.
> 
> For example, the reset value for a CTRL register might default to
> DISABLE_DEVICE, but obviously the probe function would have toggled
> that to ENABLE_DEVICE.
> 
> Am I not making sense?

Sure.  A driver's resume routine is supposed to recognize when the 
register contents have been lost due to lack of power during suspend or 
hibernation.  It should reinitialize any registers the driver needs.

During hibernation, for instance, it is nearly certain that all the 
device context will be lost.  Drivers have to be prepared to handle 
this.

Alan Stern

