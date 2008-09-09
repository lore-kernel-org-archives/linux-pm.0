From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 1/5] devcore introduce wakeup_event callback
Date: Mon, 8 Sep 2008 22:26:11 -0700
Message-ID: <200809082226.11399.david-b__37619.2464995713$1220938189$gmane$org@pacbell.net>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
	<200809081956.23522.david-b@pacbell.net>
	<76780B19A496DC4B80439008DAD7076C01AC7F328B@PDSMSX501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <76780B19A496DC4B80439008DAD7076C01AC7F328B@PDSMSX501.ccr.corp.intel.com>
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
> 
> >> + * @wakeup_event: Checks if a wakeup event occurs.
> >> + *    If yes, wakeup event should be disabled.
> >
> >And ... what else??  What does the return value indicate?
> >Should anything be done with it other than printing it out
> >if it's nonzero and we're debugging?
>
> Return 0 if the device invokes a wakeup event. In this case, driver 
> should clear/disable wakeup event. 
> Return < 0 if device didn't invoke wakeup.

So it's effectively "bool"?  I'd declare it as "bool" then...
and rename it to sound like a predicate; "is_wakedev()" maybe.


> If device follows standard wakeup mechanism which bus level can
> handle, driver isn't required to provide this callback.

There seems to be a semi-hidden distinction between bus-level
code and device-level code.  Somewhat apparent in later code;
but not at all clear in this initial set-the-stage patch.


> >> @@ -151,6 +153,7 @@ struct pm_ops {
> >>         int (*thaw)(struct device *dev);
> >>         int (*poweroff)(struct device *dev);
> >>         int (*restore)(struct device *dev);
> >> +       int (*wakeup_event)(struct device *dev);
> >
> >My reaction to adding this method is:  why do it here rather
> >than at the bus level?

Your answer probably should have been:  "The recent method
reshuffling makes that method work both at the level of the
'struct bus_type' and at the level of 'struct device'.  So
this _does_ add it at the bus level."

:)


> >In my particular experience there are two basic types of wakeup
> >event:
> >
> > 	...
> >
> >     * ACPI GPEs.  Bus-specific ... and similar to GPIO IRQs.
> >       Also sharable; bytecode is used to map the GPE and
> >       some register state to the ACPI device(s) which
> >       issued that GPE.
>
> This isn't bus specific.

It's bus-specific in the sense of "ACPI bus" (/sys/bus/acpi).
If the DSDT defines a GPE and maps it to an ACPI device, it will
follow those rules.

Devices not on the "ACPI bus" -- like add-on PCI cards, USB
peripherals, and other devices which have some such ACPI device
higher in the driver model tre -- don't use GPEs to wake up.
(An ancestral device may well do so:  a PCI bridge, a USB
host controller, etc.)


> ACPI devices can map to any physical devices, like PCI, IDE
> drive, PNP device. In this case, a bus specific mechanism can't
> handle all.

Sure it can.  And it'd be more natural to do it that way too.
I'd be tempted to call them from ACPI like

	struct device *dev;
	acpi_handle adev;

	/* adev received a wake event notification */

	...
	dev = acpi_get_physical_device(adev);
	if (dev) {
		/* this chunk of code should probably live in
		 * drivers/base/power/... somewhere and be
		 * part of this patch 1/5 so it's more clear
		 * what the infrastructure is doing.
		 */
		if (... && dev->bus->pm.base->is_wakedev(dev)) {
			... call dev->driver->pm.resume(dev)
			... else if resume is null, issue diagnostic
		} else {
			... report suitable generic confusion ...
		}
	} else {
		... report ACPI-specific confusion ...
	}
	...

When that's a PCI device -- bridge or otherwise -- that
would call something resembling your patch #3 (but fixed
to handle the case of PCI bridges, so add-in cards will
work properly).

And for a non-ACPI system, whatever IRQ handler receives the
PME# signal would just call that chunk of code for the PCI
root bridge(s) it handles.  All done.  :)


> For example the UHCI case. A GPE is fired, we need to clear/disable
> the wakeup event. PCI bus can't handle it, as UHCI has special
> registers for this, so we need call into device specific handling.  

So the bus-level PCI operation would end up with a device
that's either (a) known to have fired PME#, or (b) known
to be a device with legacy PM -- like UHCI -- which it's
presuming has been wakeup-enabled.

Then in the (a) case it can clear PME# the normal way, and
would rarely need to do anything else.

While in the (b) case the UHCI driver would need to have
provided some device-specific -- not bus-generic -- op
called like dev->driver->pm.is_wakeup(), to diddle those
registers (only for Intel silicon, not UHCI from VIA or
Genesys or anyone else).


I think I'm getting a bit more clear on what you're trying
to do with this.  Restructure it a bit and I will be able
to see that from reading the code (as will others).  :)

- Dave
