From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Two problems with system sleep
Date: Mon, 22 Feb 2010 23:35:22 +0100
Message-ID: <201002222335.22172.rjw__23826.7570654445$1266878309$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1002221713090.1393-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1002221713090.1393-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, dri-devel@lists.sourceforge.net, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Monday 22 February 2010, you wrote:
> On Mon, 22 Feb 2010, Rafael J. Wysocki wrote:
> 
> > > Here's what I got:
> > > 
> > > [    3.349334] PM: Resume from disk failed.
> > > [    3.350060]   Magic number: 0:141:321
> > > [    3.352583]   hash matches drivers/base/power/main.c:477
> > > [    3.355144] tty tty46: hash matches
> > > [    3.357742] i915 0000:00:02.0: hash matches
> > > 
> > > So it appears that the video driver is indeed the culprit.  Is there 
> > > any way to narrow it down further?
> > 
> > Not without adding some debug code to the driver.
> > 
> > Which version of the kernel is this?
> 
> 2.6.33-rc8.  The same problem occurs with earlier versions, such as
> Fedora 12's 2.6.31.9 (which is what I'm running now).

I _think_ think the i915 KMS doesn't work on your box for some reason.

Doesn the screen switch to the graphics framebuffer when booted with
vga=0?

If not, you probably need to enable framebuffer console in .config (the i915
KMS depends on that actually).

> > > Here's my /proc/acpi/wakeup:
> > > 
> > > Device	S-state	  Status   Sysfs node
> > > P0P4	  S4	 disabled  pci:0000:00:1e.0
> > > MC97	  S4	 disabled  
> > > USB1	  S4	 disabled  pci:0000:00:1d.0
> > > USB2	  S4	 disabled  pci:0000:00:1d.1
> > > USB3	  S4	 disabled  pci:0000:00:1d.2
> > > USB4	  S4	 disabled  pci:0000:00:1d.3
> > > EUSB	  S4	 disabled  pci:0000:00:1d.7
> > > PS2K	  S4	 disabled  pnp:00:09
> > > PS2M	  S4	 disabled  pnp:00:0a
> > > GBEN	  S4	 disabled  
> > > 
> > > It appears that PS2K is the keyboard.  If I write "PS2K" to 
> > > /proc/acpi/wakeup, I get:
> > > 
> > > ACPI: 'PS2M' and 'PS2K' have the same GPE, can't disable/enable one seperately
> > > 
> > > Apart from the misspelling, this doesn't bode well for making the
> > > keyboard a wakeup device.
> > 
> > This only means both will be enabled at the same time.
> > 
> > > Furthermore, these values are not properly tied to the values in sysfs.
> > 
> > They are independent and the sysfs values probably don't matter for these
> > devices.  What are the contents of /proc/acpi/wakeup after writing PS2K to it?
> 
> Unchanged -- both PS2K and PS2M continue to be disabled.

That sounds like a bug.  Please try to write 'PS2M' to it too.

> Why are the values independent from the wakeup settings in sysfs?  
> Aren't they supposed to mean the same thing?

Not really.  There are two separate flags for wakeup.  One of them is a
property of the "physical" device object (eg. PCI device structure) and that
one is set/unset via sysfs.  The other is a property of the device's ACPI
"shadow" object and is set/unset through /proc/acpi/wakeup (this mechanism
is regarded as obsolete, but it looks like some devices have not been converted
to the sysfs-based one yet).

Rafael
