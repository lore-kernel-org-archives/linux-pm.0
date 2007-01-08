From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs functions in sysfs
Date: Sun, 7 Jan 2007 19:31:19 -0800
Message-ID: <200701071931.20306.david-b@pacbell.net>
References: <1168083306.5619.34.camel@localhost.localdomain> <200701061421.41342.david-b@pacbell.net> <20070107055424.GA24853@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070107055424.GA24853@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.osdl.org, Zhang Rui <rui.zhang@intel.com>, lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Saturday 06 January 2007 9:54 pm, Matthew Garrett wrote:
> On Sat, Jan 06, 2007 at 02:21:41PM -0800, David Brownell wrote:
> 
> > Please tell me you mean "devices with a /sys/devices/.../power/wakeup"
> > attribute.  And that ACPI is finally going to start working with those
> > attributes ...
> 
> It's not necessarily possible to map from an ACPI object with a wakeup 
> capability to a Linux device, 

That seems singularly useless then.  If there's no such mapping, there's
really no point to the /proc/acpi/wakeup table... why not just always
enable every possible device as a wakeup source, since that information
is evidently not designed to be usable for anything?

Or are you saying that some of the entries there aren't for "devices"
per se, but for busses, bridges, and so on?  If so, that's not an issue.
At least, not until Linux has drivers for those things.


> so there's going to have to be some degree  
> of interface nastiness.

Interface, or implementation?  One expects that the interface would
be the same regardless of whether or not ACPI gets involved.


> However, some devices can be sensibly mapped,  
> and ideally those should be integrated into 
> /sys/devices/.../power/wakeup.

Yes...


> However, I'm not entirely sure /how/ that integration should happen. If 
> both the Linux driver and ACPI know how to enable wakeup for a device,
> what should writing to power/wakeup do?

Writing to power/wakeup sets the policy for that device:  should it
issue wakeup events, or not?  The answer is "yes" by default, but when
the hardware is broken, or the user doesn't want that, the policy can
be changed without a kernel recompile.

The driver stack needs to know that policy in order to act properly.

For example, USB devices should only be told to use remote wakeup if
their ancestral USB host controller is wakeup-enabled.  And when that
controller isn't wakeup-enabled, it can often enter states which save
more power.  (E.g. turn off oscillators and switch off VBUS power.)

You will notice, by the way, that the USB peripherals will never be
showing up in those ACPI tables... which is a trivial demostration
of the fact that the ACPI wakeup infrastructure is insufficient to
manage system wakeup on Linux.  That USB keyboard, or mouse, that
wakes the system does not appear in those ACPI tables.

Also, a network driver needs to know that it should configure WOL, and
in this mode not that one, etc.

I'd expect drivers and ACPI to cooperate more or less by having the
driver do the standard stuff (like enabling PCI PME#, and enabling
wakeup irqs)), and ACPI not being driver-visible while it does
whatever it must to make those driver directions actually work.


> > > 	So /proc/acpi/wakeup is deprecated by
> > > 	/sys/devices/acpi_system/.../xxx/sleep_state && wakeup. 
> > 
> > Why is ACPI still not coupling such information to the REAL device
> > nodes?  On my laptop, right now without any wakeup-capable USB
> > devices attached, the appended script produces:
> 
> So for example, the PCI0 device on my Thinkpad is an ACPI wakeup device. 
> Investigating the DSDT suggests that this is just a wrapper around a 
> bunch of platform devices, including the ISA bridge. In this case, what 
> real device should we be associating it with?

I'd guess the root bridge... I have a desktop that seems to have the
same structure.  The PS2K and PS2M devices have separate entries in
/proc/acpi/wakeup but the DSDT for PCI0 also talks about them.  A
quick look suggests to me that /proc/acpi/wakeup is discarding the
device tree internal to ACPI ... _SB_.PCI0.SBRG.PS2K._PRW gets
morphed to "PS2K" and discards the PCI0 parentage.

On the other hand, I think that particular ACPI table must have a
habit of being flakey.  I have one machine that claims to have four
different USB host adapters, where the silicon only has three; and
what I'm assuming is a firewire device (S139), where the silicon
most certainly does not have one of those.  And another machine
lists an MMCI (MMC/SD?) that certainly does not exist ...

So it may well be that doing the work to connect those ACPI tables
to the system hardware will let Linux discard all the bogus data,
so it can work better.  :)

- Dave

