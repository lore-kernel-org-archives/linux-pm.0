From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Two problems with system sleep
Date: Tue, 23 Feb 2010 13:49:20 -0800
Message-ID: <20100223214920.GA14313@core.coreip.homeip.net>
References: <Pine.LNX.4.44L0.1002231051270.1308-100000@iolanthe.rowland.org>
	<201002232202.05029.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 23, 2010 at 10:02:04PM +0100, Rafael J. Wysocki wrote:
> On Tuesday 23 February 2010, Alan Stern wrote:
> > On Mon, 22 Feb 2010, Rafael J. Wysocki wrote:
> > 
> > > On Monday 22 February 2010, you wrote:
> > > > On Mon, 22 Feb 2010, Rafael J. Wysocki wrote:
> > > > 
> > > > > > Here's what I got:
> > > > > > 
> > > > > > [    3.349334] PM: Resume from disk failed.
> > > > > > [    3.350060]   Magic number: 0:141:321
> > > > > > [    3.352583]   hash matches drivers/base/power/main.c:477
> > > > > > [    3.355144] tty tty46: hash matches
> > > > > > [    3.357742] i915 0000:00:02.0: hash matches
> > > > > > 
> > > > > > So it appears that the video driver is indeed the culprit.  Is there 
> > > > > > any way to narrow it down further?
> > > > > 
> > > > > Not without adding some debug code to the driver.
> > > > > 
> > > > > Which version of the kernel is this?
> > > > 
> > > > 2.6.33-rc8.  The same problem occurs with earlier versions, such as
> > > > Fedora 12's 2.6.31.9 (which is what I'm running now).
> > > 
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
> 
> ...
> > I was wrong (don't know why).  Writing PS2K does indeed enable both.  
> > And sure enough, doing that allows the system to wake up in response to
> > a key press.  It still hangs during the video resume, though.
> > 
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
> 
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
> 
> I guess it's better to invite Dmitry into the discussion at this point.
> 

Yes, I agree, we need a genric mechanism for PNP to emable wakups. It
was discussed a bit here:

	http://bugzilla.kernel.org/show_bug.cgi?id=8286

but David was too hung up on the fact that number of devices in ACPI
does not map directly onto number of serio ports when i8042 is in active
multiplexing mode that it id not go anywhere.

-- 
Dmitry
