From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Two problems with system sleep
Date: Tue, 23 Feb 2010 11:12:09 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002231051270.1308-100000@iolanthe.rowland.org>
References: <201002222335.22172.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002222335.22172.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, dri-devel@lists.sourceforge.net, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Mon, 22 Feb 2010, Rafael J. Wysocki wrote:

> On Monday 22 February 2010, you wrote:
> > On Mon, 22 Feb 2010, Rafael J. Wysocki wrote:
> > 
> > > > Here's what I got:
> > > > 
> > > > [    3.349334] PM: Resume from disk failed.
> > > > [    3.350060]   Magic number: 0:141:321
> > > > [    3.352583]   hash matches drivers/base/power/main.c:477
> > > > [    3.355144] tty tty46: hash matches
> > > > [    3.357742] i915 0000:00:02.0: hash matches
> > > > 
> > > > So it appears that the video driver is indeed the culprit.  Is there 
> > > > any way to narrow it down further?
> > > 
> > > Not without adding some debug code to the driver.
> > > 
> > > Which version of the kernel is this?
> > 
> > 2.6.33-rc8.  The same problem occurs with earlier versions, such as
> > Fedora 12's 2.6.31.9 (which is what I'm running now).
> 
> I _think_ think the i915 KMS doesn't work on your box for some reason.
> 
> Doesn the screen switch to the graphics framebuffer when booted with
> vga=0?

Yes, it does switch.

> If not, you probably need to enable framebuffer console in .config (the i915
> KMS depends on that actually).

It's already enabled.  That is, CONFIG_FB and 
CONFIG_FRAMEBUFFER_CONSOLE are both set to 'y'.

> > > > Here's my /proc/acpi/wakeup:
> > > > 
> > > > Device	S-state	  Status   Sysfs node
> > > > P0P4	  S4	 disabled  pci:0000:00:1e.0
> > > > MC97	  S4	 disabled  
> > > > USB1	  S4	 disabled  pci:0000:00:1d.0
> > > > USB2	  S4	 disabled  pci:0000:00:1d.1
> > > > USB3	  S4	 disabled  pci:0000:00:1d.2
> > > > USB4	  S4	 disabled  pci:0000:00:1d.3
> > > > EUSB	  S4	 disabled  pci:0000:00:1d.7
> > > > PS2K	  S4	 disabled  pnp:00:09
> > > > PS2M	  S4	 disabled  pnp:00:0a
> > > > GBEN	  S4	 disabled  
> > > > 
> > > > It appears that PS2K is the keyboard.  If I write "PS2K" to 
> > > > /proc/acpi/wakeup, I get:
> > > > 
> > > > ACPI: 'PS2M' and 'PS2K' have the same GPE, can't disable/enable one seperately
> > > > 
> > > > Apart from the misspelling, this doesn't bode well for making the
> > > > keyboard a wakeup device.
> > > 
> > > This only means both will be enabled at the same time.
> > > 
> > > > Furthermore, these values are not properly tied to the values in sysfs.
> > > 
> > > They are independent and the sysfs values probably don't matter for these
> > > devices.  What are the contents of /proc/acpi/wakeup after writing PS2K to it?
> > 
> > Unchanged -- both PS2K and PS2M continue to be disabled.
> 
> That sounds like a bug.  Please try to write 'PS2M' to it too.

I was wrong (don't know why).  Writing PS2K does indeed enable both.  
And sure enough, doing that allows the system to wake up in response to
a key press.  It still hangs during the video resume, though.

> > Why are the values independent from the wakeup settings in sysfs?  
> > Aren't they supposed to mean the same thing?
> 
> Not really.  There are two separate flags for wakeup.  One of them is a
> property of the "physical" device object (eg. PCI device structure) and that
> one is set/unset via sysfs.  The other is a property of the device's ACPI
> "shadow" object and is set/unset through /proc/acpi/wakeup (this mechanism
> is regarded as obsolete, but it looks like some devices have not been converted
> to the sysfs-based one yet).

It looks like the inline routines defined in include/linux/pm_wakeup.h 
should call corresponding platform-specific routines.  Apparently _no_ 
drivers have been converted in this way -- since the conversion needs 
to be part of the core.  In fact, there isn't even a platform-specific 
hook for enabling or disabling wakeup devices; we should have a 
platform_wakeup_ops structure.

Would such a thing be acceptable?

Alan Stern
