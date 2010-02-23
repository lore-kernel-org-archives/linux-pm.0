From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Two problems with system sleep
Date: Wed, 24 Feb 2010 00:08:27 +0100
Message-ID: <201002240008.27228.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1002231620350.1308-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1002231620350.1308-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Tuesday 23 February 2010, Alan Stern wrote:
> On Tue, 23 Feb 2010, Rafael J. Wysocki wrote:
> 
> > > > I _think_ think the i915 KMS doesn't work on your box for some reason.
> > > > 
> > > > Doesn the screen switch to the graphics framebuffer when booted with
> > > > vga=0?
> > > 
> > > Yes, it does switch.
> > 
> > OK
> > 
> > > > If not, you probably need to enable framebuffer console in .config (the i915
> > > > KMS depends on that actually).
> > > 
> > > It's already enabled.  That is, CONFIG_FB and 
> > > CONFIG_FRAMEBUFFER_CONSOLE are both set to 'y'.
> > 
> > Well, so the KMS suspend-resume doesn't work on your system.
> > 
> > I guess that would require some detailed debugging, so it may be a good idea to
> > open a Bugzilla entry for this issue.
> 
> Okay, I'll set it up later.
> 
> > > > > Why are the values independent from the wakeup settings in sysfs?  
> > > > > Aren't they supposed to mean the same thing?
> > > > 
> > > > Not really.  There are two separate flags for wakeup.  One of them is a
> > > > property of the "physical" device object (eg. PCI device structure) and that
> > > > one is set/unset via sysfs.  The other is a property of the device's ACPI
> > > > "shadow" object and is set/unset through /proc/acpi/wakeup (this mechanism
> > > > is regarded as obsolete, but it looks like some devices have not been converted
> > > > to the sysfs-based one yet).
> > > 
> > > It looks like the inline routines defined in include/linux/pm_wakeup.h 
> > > should call corresponding platform-specific routines.  Apparently _no_ 
> > > drivers have been converted in this way -- since the conversion needs 
> > > to be part of the core.  In fact, there isn't even a platform-specific 
> > > hook for enabling or disabling wakeup devices; we should have a 
> > > platform_wakeup_ops structure.
> > 
> > There is one for PCI devices, actually.  It's struct pci_platform_pm_ops()
> > defined in drivers/pci/pci.h.
> > 
> > For PCI devices we have pci_enable_wake() that sets up the platform to
> > wake up the system using given device on the basis of the device's sysfs
> > setting.  The ACPI flag shown by /proc/acpi/wakeup is not taken into account
> > in that case.
> 
> That's not what I meant.  Writing to /sys/devices/.../power/wakeup 
> should have the same effect as writing to /proc/acpi/wakeup (if the 
> device has a "shadow" ACPI counterpart, of course).

That really is not worth it.  The information about the sharing of a GPE is
only useful for debugging purposes and only in "really broken" cases.

> It looks like /proc/acpi/wakeup does nothing but set
> acpidev->wakeup.state.enabled and warn about duplicate GPE usage.

That's correct, although the warning itself doesn't really make sense,
because the sharing of the GPE doesn't mean we _have_ _to_ enable both devices
to wake up (the devices usually require some more preparations than just
setting the GPE).

> It would make sense to issue the warning when writing to the sysfs file.

That's not worth the added code complexity IMO.

> And wakeup.state.enabled shouldn't be needed at all;

Right, but it was there before.

> the ACPI code should always use the physical device's may_wakeup flag instead
> (unless there is no corresponding physical device).

No, it shouldn't, because it doesn't know if the device has actually been set
up for wakeup at its bus type level.

> If writes to the sysfs file called a platform hook, we could warn about 
> duplicate GPEs when the wakeup setting is changed.

As I wrote above, this is not worth it IMO.  Moreover, that doesn't really
matter, because the GPEs will be enabled as needed anyway and there's no real
need to tell the user which of them are shared except for debugging (at the
fairly low level).  Furthermore, the GPE refrence counting code we're going to
add shortly changes that quite a bit.

Generally speaking, I'd like to get rid of /proc/acpi/wakeup altogether or
maybe leave it as read-only without the "disabled/enabled" column.

However, there still are devices that don't have an alternative mechanism for
enabling wakeup, so we can't just drop it right now.

Rafael
