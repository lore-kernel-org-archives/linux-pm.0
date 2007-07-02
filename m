From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC][PATCH -mm 2/9] ACPI: Add
	acpi_pm_device_sleep_state helper routine
Date: Mon, 2 Jul 2007 10:24:57 -0700
Message-ID: <200707021024.58693.david-b__25953.0115094551$1183397396$gmane$org@pacbell.net>
References: <200706302257.17556.rjw@sisk.pl>
	<200707012249.14143.david-b@pacbell.net>
	<200707021017.01295.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707021017.01295.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Monday 02 July 2007, Rafael J. Wysocki wrote:
> On Monday, 2 July 2007 07:49, David Brownell wrote:

> > Also, recall that this was originally PCI-specific.  A generalized
> > approach would return a range of states, not a single state that
> > embeds a particular policy that may not be universally appropriate...
> 
> Via pointers and the return value equal to 0 on success?

It could as easily be one pointer:  "int minmax[2]".
Then min == minmax[0] and max == minmax[1], and the
ACPI calls could write the caller's data directly.

But in general, yes -- pointer, not single return value.


> > The logic was that PCI devices can all support PCI_D0 and PCI_D3.
> > For non-PCI devices we can't actually know that.  So "min" should
> > probably default to ACPI_STATE_D0.  If this returns a range, then
> > such issues can stay out of this code.
> 
> The ACPI spec says that all devices must support D0 and D3.

ISTR that it actually says they must "recognize" D3.  That's
not the same as actually implementing a software controllable
power-off state ... and not the same as imposing a "use the
biggest numbered D-state" policy at this level.


> > > +	/*
> > > +	 * If _PRW says we can wake from the upcoming system state, the _SxD
> > > +	 * value can wake ... and we'll assume a wakeup-aware driver.  If _SxW
> > > +	 * methods exist (ACPI 3.x), they give the lowest power D-state that
> > > +	 * can also wake the system.  _S0W can be valid.
> > > +	 */
> > > +	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
> > > +	    (dev->wakeup.state.enabled &&
> > 
> > This used device_may_wakeup() before.  That ACPI flag is not a
> > direct analogue ... without looking again at the issues, I'd
> > say the right solution is to phase out the ACPI-only flags in
> > new code.
> 
> Hm, I'm not sure.  This is an ACPI routine after all ...

It's in the Linux kernel, talking about Linux devices.
Some of them have ACPI support; many don't.  (Like the
USB device nodes, and anything else layered on top of
mainboard devices.)


> > Maybe just expect the caller to pass the results 
> > of device_may_wakeup() in ... or update the signature to accept
> > a "struct device", and fetch the handle from there.  (That'd
> > be a better match for most callers, I'd think...)
> 
> In that case it would be nicer to pass 'struct acpi_device *' rahter than
> 'struct device *', IMO.

I'll disagree.  Outside of the ACPI code, virtually nothing
has any reason to see an "acpi_device" ... but virtually
everything has reason to see a "device".  Even ACPI code
can rely on there being a "device" inside "acpi_device"!


This touches on a different problem.  The ACPI device tree
is parallel to the "real" tree.  In the cases there's a
one-to-one correspondence, there's no confusion; any
acpi_device corresponds to one "real" device, and vice
versa.  BUT ... there are cases where the correspondence
isn't one-to-one.  Those cases need to be addressed, by
moving towards a one-to-one correspondence.

Cases like PCI bridges can be easily dealt with now, given
some resequencing of init logic:  use the PNP node instead
of faking out a toplevel /sys/devices/pci0000:00 node.

But things like PS2 keyboard and mouse nodes are funkier.

- Dave
