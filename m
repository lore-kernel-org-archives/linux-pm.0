From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs functions in sysfs
Date: Thu, 25 Jan 2007 01:35:59 -0800
Message-ID: <200701250136.00185.david-b@pacbell.net>
References: <1168083306.5619.34.camel@localhost.localdomain> <200701071931.20306.david-b@pacbell.net> <200701242314.23169.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200701242314.23169.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.osdl.org, Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 24 January 2007 8:14 pm, Len Brown wrote:
> On Sunday 07 January 2007 22:31, David Brownell wrote:
> 
> > > However, I'm not entirely sure /how/ that integration should happen. If 
> > > both the Linux driver and ACPI know how to enable wakeup for a device,
> > > what should writing to power/wakeup do?
> 
> If a native hardware device driver knows how to talk to the device,
> then it should win, and ACPI should lose.
> 
> ACPI, after all, is intended to fill in the missing gaps in native
> hardware drivers. 

It goes a bit beyond that however.  It goes and defines GPEs that
could be managed by embedded firmware, which may interact with things
like PCI PME# while the ACPI host system is shut down deeply enough
that it can't be woken up that way.  (At least, by my non-expert
reading of bits'n'pieces of the ACPI spec.)

Which implies that if for example a device driver enables PME#, then
ACPI glue may need to notice that and activate an associated GPE ...
or, alternatively, that ACPI may need to check the same flag that the
driver checks.

It's reasonable IMO to expect a PCI driver to know about PCI PM, and
to have it check a simple policy flag.  It's _not_ reasonable that it
ought to understand anything about ACPI, since PCI itself does not
depend on ACPI.


> > Writing to power/wakeup sets the policy for that device:  should it
> > issue wakeup events, or not?  The answer is "yes" by default, but when
> > the hardware is broken, or the user doesn't want that, the policy can
> > be changed without a kernel recompile.
> 
> For ACPI wakeup devices, the default is "no", except IIR for the power button.

Annoying but fixable in userspace.   Got any insights into why that
default is "system acts like <x> doesn't work"?  Given how rarely
defaults get changed (and why: "doesn't work that way"), that's more
or less a "wakeup does not work with ACPI" policy.

 
> > The driver stack needs to know that policy in order to act properly.
> > 
> > For example, USB devices should only be told to use remote wakeup if
> > their ancestral USB host controller is wakeup-enabled.  And when that
> > controller isn't wakeup-enabled, it can often enter states which save
> > more power.  (E.g. turn off oscillators and switch off VBUS power.)
> > 
> > You will notice, by the way, that the USB peripherals will never be
> > showing up in those ACPI tables... which is a trivial demostration
> > of the fact that the ACPI wakeup infrastructure is insufficient to
> > manage system wakeup on Linux.  That USB keyboard, or mouse, that
> > wakes the system does not appear in those ACPI tables.
> 
> Oh?

Yes, of course.  How could the BIOS vendor possibly know what wakeup-capable
USB devices the end user is going to hook up ... so that it can stick them
into a *static* table?  And there are certainly no hooks through which the
ACPI system learns about the USB devices that get hotplugged.  The same
issue comes up with CardBus/PCI devices, though it's been so long since I
used one of those that I don't know if they tend to even support PCI PME#
wakeup event sources.

In a not-dissimilar vein, it doesn't seem to notice if I removed the modem
card from its AMR, CNR, or ACR slot ... /proc/acpi/wakeup still lists "MDM"
in such cases, when wake-on-ring clearly couldn't work any more.


> > On the other hand, I think that particular ACPI table must have a
> > habit of being flakey.  I have one machine that claims to have four
> > different USB host adapters, where the silicon only has three; and
> > what I'm assuming is a firewire device (S139), where the silicon
> > most certainly does not have one of those.  And another machine
> > lists an MMCI (MMC/SD?) that certainly does not exist ...
> 
> The DSDT is whatever the BIOS writer typed in.
> We've seen many times that for a new machine they start
> with the DSDT for an old machine and modify it until
> Windows boots, then claim victory and go home:-)

I had suspected that was the engineering "process" in use.

That's sometimes called "cut'n'paste".  I don't think that it
has a very good assurance rating from the folk evaluating
such processes.  ;)


> > So it may well be that doing the work to connect those ACPI tables
> > to the system hardware will let Linux discard all the bogus data,
> > so it can work better.  :)
> 
> Agreed.

Looking forward to patches someday.  :)

- Dave

