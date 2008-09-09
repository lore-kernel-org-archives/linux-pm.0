From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 3/5] pci wakeup handler
Date: Mon, 8 Sep 2008 21:04:07 -0700
Message-ID: <200809082104.07756.david-b__5344.48440089381$1220933282$gmane$org@pacbell.net>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
	<200809081956.42663.david-b@pacbell.net>
	<76780B19A496DC4B80439008DAD7076C01AC7F326A@PDSMSX501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <76780B19A496DC4B80439008DAD7076C01AC7F326A@PDSMSX501.ccr.corp.intel.com>
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
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 08 September 2008, Li, Shaohua wrote:
> >> +static int pci_pm_wakeup_event(struct device *dev)
> >
> >If wakeup notifications were bus-specific this would
> >take "struct pci_dev *pdev" ... and we're missing a
> >key part of this stuff, namely the code to sort out
> >which devices get this call.
> 
> This device is suspected to invoke a wakeup event, might
> not be true. I suppose other bus requires the same
> mechanism, so should be a 'struct device'.

But *THIS* call is PCI-specific, and will need to be
called from PCI bridge code which knows that it only
has to cope with PCI devices as sources of the PCI
specific wake events.  Nothing generic there...

But I'd rather see that addressed in the context of
my comments to your patch [1/5].



> >Another rather important case is bridges.  I observe that with ACPI
> >the way PME# is handled for add-in cards _seems_ to be that the bridge
> >for that PCI bus segment gets a GPE (presumably matching the PME#
> >signal for that bus segment, and maybe for its subsidiaries).  That
> >suggests the bridge will need to scan its children to find out which
> >one(s) issued PME#.  You didn't include such code here, where that
> >notification will be received...
>
> In GPE case, it appears BIOS will detect the exact wakeup device.

The laptop on which I'm typing this response has two GPEs which
are shared by several devices each.  (Not PCI devices though.)

And ... read what I wrote more closely.  BIOS doesn't know anything
about add-in cards, just mainboard devices.  If I have a board with
six PCI slots, ACPI delivers a notification to the bridgesince that
is the only mainboard device.  The bridge then has to sort out which
add-in card issued the wakeup event.


> In native PME case, if a device is a pcie device, npme will
> detect the exact device too.  If the device is a legacy device,
> then npme driver will check devices under bridges, please see
> the npme_pme_target().

This file relates to PCI not PCIE; I referred to PCI bridges
not PCIE ones.  Are you saying the PCIE code is what I have
to look at to see PCI bridge support?  Extremely confusing if
that's the case!  Not to mention wrong ... since I have several
systems here that have PCI support but not PCIE.  Linux will
be supporting such things for a LONG time to come.


> We can directly scan children in pci_pm_wakeup_event() too,
> but GPE case doesn't require it and actually is broken in GPE
> case as duplication will be added.  
> 
> I thought this covers all cases in IA platform, right?

Not the case I introduced above:  PCI bridges, where there's
no PCIE in the house.  I've not looked at other cases.


> >> +     /* I see spurious GPE here, just ignore it for now */
> >
> >Comments about GPEs shouldn't be included here; they're ACPI-specific.
> >This is PCI-generic code!
>
> A typo, it should be PME. And actually I found this in npme case instead of ACPI.

OK, I guess.  But in that case are you sure it was really
spurious?  Rather than just not being able to tell which
device issued the PME until you checked the PME status bit?

It'd really be routine to get a PME# event and then need
to scan several devices to find which one raised it.  Not
all those devices would have enabled PME# either...


> >Or perhaps more generically -- since I still have yet to
> >hear an argument why resume() shouldn't suffice to handle
> >the wakeup event processing, at least for PCI -- just
> >
> >        if (pdev->driver->wakeup)
> >                return pdev->driver->wakeup(pdev);
> >        if (pdev->driver->resume)
> >                return pdev->driver->resume(pdev);
> >
> >Although I don't know what the return value here should
> >be interpreted to mean.  Would it be better to return
> >void, and just log all "interesting"/error cases?
> 
> In my mind, .wakeup_event() just returns if the device
> invokes a wakeup event, ACPI or NPME will call corresponding
> .resume method. Suspected device might not invoke wakeup
> event as you said the bridge case.

I think I see some of what's going on here.  This routine
is getting more attention than I think it deserves, because
you have placed what I'd call a PCI-internal utility -- to
find which devices have issued PME# signals -- into a driver
model method rather than hiding it in the internals of code
that dispatches PME# notifications (or some ACPI GPEs).

I thought you were providing a set of patches grouped by
functionality:  PCI, PCIE, ACPI.  Evidently not...

PCI support for PME# would have an entry for use by an IRQ
handler (on most non-ACPI hardware) or an ACPI GPE ... and
everything else should be internal to that bus, except for
the driver notification callback (which I'm happy to think
is just the existing bus-specific resume method).

You've almost made my case that there shouldn't be such a
hook in the driver model PM core.  :)

- Dave
