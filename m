From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Two problems with system sleep
Date: Tue, 23 Feb 2010 16:35:52 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002231620350.1308-100000@iolanthe.rowland.org>
References: <201002232202.05029.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002232202.05029.rjw@sisk.pl>
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
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Tue, 23 Feb 2010, Rafael J. Wysocki wrote:

> > > I _think_ think the i915 KMS doesn't work on your box for some reason.
> > > 
> > > Doesn the screen switch to the graphics framebuffer when booted with
> > > vga=0?
> > 
> > Yes, it does switch.
> 
> OK
> 
> > > If not, you probably need to enable framebuffer console in .config (the i915
> > > KMS depends on that actually).
> > 
> > It's already enabled.  That is, CONFIG_FB and 
> > CONFIG_FRAMEBUFFER_CONSOLE are both set to 'y'.
> 
> Well, so the KMS suspend-resume doesn't work on your system.
> 
> I guess that would require some detailed debugging, so it may be a good idea to
> open a Bugzilla entry for this issue.

Okay, I'll set it up later.

> > > > Why are the values independent from the wakeup settings in sysfs?  
> > > > Aren't they supposed to mean the same thing?
> > > 
> > > Not really.  There are two separate flags for wakeup.  One of them is a
> > > property of the "physical" device object (eg. PCI device structure) and that
> > > one is set/unset via sysfs.  The other is a property of the device's ACPI
> > > "shadow" object and is set/unset through /proc/acpi/wakeup (this mechanism
> > > is regarded as obsolete, but it looks like some devices have not been converted
> > > to the sysfs-based one yet).
> > 
> > It looks like the inline routines defined in include/linux/pm_wakeup.h 
> > should call corresponding platform-specific routines.  Apparently _no_ 
> > drivers have been converted in this way -- since the conversion needs 
> > to be part of the core.  In fact, there isn't even a platform-specific 
> > hook for enabling or disabling wakeup devices; we should have a 
> > platform_wakeup_ops structure.
> 
> There is one for PCI devices, actually.  It's struct pci_platform_pm_ops()
> defined in drivers/pci/pci.h.
> 
> For PCI devices we have pci_enable_wake() that sets up the platform to
> wake up the system using given device on the basis of the device's sysfs
> setting.  The ACPI flag shown by /proc/acpi/wakeup is not taken into account
> in that case.

That's not what I meant.  Writing to /sys/devices/.../power/wakeup 
should have the same effect as writing to /proc/acpi/wakeup (if the 
device has a "shadow" ACPI counterpart, of course).  It looks like 
/proc/acpi/wakeup does nothing but set acpidev->wakeup.state.enabled 
and warn about duplicate GPE usage.

It would make sense to issue the warning when writing to the sysfs
file.  And wakeup.state.enabled shouldn't be needed at all; the ACPI
code should always use the physical device's may_wakeup flag instead
(unless there is no corresponding physical device).

If writes to the sysfs file called a platform hook, we could warn about 
duplicate GPEs when the wakeup setting is changed.

> Generally, you can think of two levels one can enable wakeup at.
> First, there is the device level controlled by the sysfs wakeup setting.  This
> is how we would like to control wakeup.  Second, however, there is the
> /proc/acpi/wakeup interface allowing you to access the _internal_ ACPI
> representation of devices directly and you can use that to set up the platform
> to use the device for wakeup even if the device level mechanism doesn't work
> or is not implemented for it (like in your case).
> 
> IOW, the /proc/acpi/wakeup thing only tells us if the device is forced to do
> the wakeup at the low level and it only takes the ACPI aspect of the wakeup
> into account, which may not be sufficient.  For exmaple, network adapters
> (and other PCI devices) generally need to have the PME signaling enabled
> in addition to the platform setup and the chip has to be enabled to take
> wakeup packets from the network.
> 
> If /proc/acpi/wakeup shows "enabled" this means "turn on the wakeup power
> for this devices and enable its wakeup GPE unconditionally before suspend".
> If it shows "disabled", it means "leave that to someone else" (that's analogous
> to the "on" and "auto" settings for devices/.../power/control, but the names
> are misleading for historical reasons).
> 
> So, it looks like we need a counterpart of pci_enable_wake() for PNP devices. 

That sounds reasonable.  ACPI could be made to work without such a 
thing, but other platforms probably would need it.

Alan Stern
