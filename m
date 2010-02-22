From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Two problems with system sleep
Date: Mon, 22 Feb 2010 23:00:21 +0100
Message-ID: <201002222300.21557.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1002221623430.1264-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1002221623430.1264-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Monday 22 February 2010, Alan Stern wrote:
> On Mon, 22 Feb 2010, Rafael J. Wysocki wrote:
> 
> > On Monday 22 February 2010, Alan Stern wrote:
> > > On Sun, 21 Feb 2010, Rafael J. Wysocki wrote:
> > > 
> > > > > > Anyway, we need to check if control gets back to acpi_suspend_enter().
> > > 
> > > Would PM_TRACE_RTC help?
> > 
> > In my opinion that's worth doing.
> 
> Here's what I got:
> 
> [    3.349334] PM: Resume from disk failed.
> [    3.350060]   Magic number: 0:141:321
> [    3.352583]   hash matches drivers/base/power/main.c:477
> [    3.355144] tty tty46: hash matches
> [    3.357742] i915 0000:00:02.0: hash matches
> 
> So it appears that the video driver is indeed the culprit.  Is there 
> any way to narrow it down further?

Not without adding some debug code to the driver.

Which version of the kernel is this?

> > > By concentrating on the video drivers, you may be missing part of 
> > > the problem.  Have you considered why pressing a key on the keyboard 
> > > doesn't wake the system up?  Nothing happens -- the power LED on the 
> > > desktop case just keeps on blinking.
> > 
> > We may just not set up the keyboard as a wakeup device.  The other option is
> > that the BIOS has a problem with resume handling, in which case I have no
> > idea what to do.
> 
> Here's my /proc/acpi/wakeup:
> 
> Device	S-state	  Status   Sysfs node
> P0P4	  S4	 disabled  pci:0000:00:1e.0
> MC97	  S4	 disabled  
> USB1	  S4	 disabled  pci:0000:00:1d.0
> USB2	  S4	 disabled  pci:0000:00:1d.1
> USB3	  S4	 disabled  pci:0000:00:1d.2
> USB4	  S4	 disabled  pci:0000:00:1d.3
> EUSB	  S4	 disabled  pci:0000:00:1d.7
> PS2K	  S4	 disabled  pnp:00:09
> PS2M	  S4	 disabled  pnp:00:0a
> GBEN	  S4	 disabled  
> 
> It appears that PS2K is the keyboard.  If I write "PS2K" to 
> /proc/acpi/wakeup, I get:
> 
> ACPI: 'PS2M' and 'PS2K' have the same GPE, can't disable/enable one seperately
> 
> Apart from the misspelling, this doesn't bode well for making the
> keyboard a wakeup device.

This only means both will be enabled at the same time.

> Furthermore, these values are not properly tied to the values in sysfs.

They are independent and the sysfs values probably don't matter for these
devices.  What are the contents of /proc/acpi/wakeup after writing PS2K to it?

Rafael
