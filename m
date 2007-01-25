From: Len Brown <lenb@kernel.org>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs functions in sysfs
Date: Wed, 24 Jan 2007 23:14:22 -0500
Message-ID: <200701242314.23169.lenb@kernel.org>
References: <1168083306.5619.34.camel@localhost.localdomain> <20070107055424.GA24853@srcf.ucam.org> <200701071931.20306.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200701071931.20306.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.osdl.org, Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Sunday 07 January 2007 22:31, David Brownell wrote:

> > However, I'm not entirely sure /how/ that integration should happen. If 
> > both the Linux driver and ACPI know how to enable wakeup for a device,
> > what should writing to power/wakeup do?

If a native hardware device driver knows how to talk to the device,
then it should win, and ACPI should lose.

ACPI, after all, is intended to fill in the missing gaps in native hardware drivers.

> Writing to power/wakeup sets the policy for that device:  should it
> issue wakeup events, or not?  The answer is "yes" by default, but when
> the hardware is broken, or the user doesn't want that, the policy can
> be changed without a kernel recompile.

For ACPI wakeup devices, the default is "no", except IIR for the power button.

> The driver stack needs to know that policy in order to act properly.
> 
> For example, USB devices should only be told to use remote wakeup if
> their ancestral USB host controller is wakeup-enabled.  And when that
> controller isn't wakeup-enabled, it can often enter states which save
> more power.  (E.g. turn off oscillators and switch off VBUS power.)
> 
> You will notice, by the way, that the USB peripherals will never be
> showing up in those ACPI tables... which is a trivial demostration
> of the fact that the ACPI wakeup infrastructure is insufficient to
> manage system wakeup on Linux.  That USB keyboard, or mouse, that
> wakes the system does not appear in those ACPI tables.

Oh?

> Also, a network driver needs to know that it should configure WOL, and
> in this mode not that one, etc.
> 
> I'd expect drivers and ACPI to cooperate more or less by having the
> driver do the standard stuff (like enabling PCI PME#, and enabling
> wakeup irqs)), and ACPI not being driver-visible while it does
> whatever it must to make those driver directions actually work.
> 
> 
> > > > 	So /proc/acpi/wakeup is deprecated by
> > > > 	/sys/devices/acpi_system/.../xxx/sleep_state && wakeup. 
> > > 
> > > Why is ACPI still not coupling such information to the REAL device
> > > nodes?  On my laptop, right now without any wakeup-capable USB
> > > devices attached, the appended script produces:
> > 
> > So for example, the PCI0 device on my Thinkpad is an ACPI wakeup device. 
> > Investigating the DSDT suggests that this is just a wrapper around a 
> > bunch of platform devices, including the ISA bridge. In this case, what 
> > real device should we be associating it with?
> 
> I'd guess the root bridge... I have a desktop that seems to have the
> same structure.  The PS2K and PS2M devices have separate entries in
> /proc/acpi/wakeup but the DSDT for PCI0 also talks about them.  A
> quick look suggests to me that /proc/acpi/wakeup is discarding the
> device tree internal to ACPI ... _SB_.PCI0.SBRG.PS2K._PRW gets
> morphed to "PS2K" and discards the PCI0 parentage.
> 
> On the other hand, I think that particular ACPI table must have a
> habit of being flakey.  I have one machine that claims to have four
> different USB host adapters, where the silicon only has three; and
> what I'm assuming is a firewire device (S139), where the silicon
> most certainly does not have one of those.  And another machine
> lists an MMCI (MMC/SD?) that certainly does not exist ...

The DSDT is whatever the BIOS writer typed in.
We've seen many times that for a new machine they start
with the DSDT for an old machine and modify it until
Windows boots, then claim victory and go home:-)

> So it may well be that doing the work to connect those ACPI tables
> to the system hardware will let Linux discard all the bogus data,
> so it can work better.  :)

Agreed.

-Len

