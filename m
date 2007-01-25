From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH]switching off autosuspend through sysfs
Date: Wed, 24 Jan 2007 18:15:21 -0800
Message-ID: <200701241815.22007.david-b@pacbell.net>
References: <20070124003221.GA3755@suse.de>
	<Pine.LNX.4.44L0.0701241145140.4368-100000@iolanthe.rowland.org>
	<20070125011523.GA4542@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070125011523.GA4542@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Greg KH <gregkh@suse.de>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, oneukum@suse.de, Alan Stern <stern@rowland.harvard.edu>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org


> > > I don't know, it just really annoys me to see that power directory there
> > > with no use for it for a lot of devices :)
> > 
> > Would it help to add a flag somewhere in struct device (or struct
> > dev_pm_info) for indicating that the device is not cognizant of PM? 

If it would, the semantics would need to be clarified.  Is the problem
that they can't suspend/resume at all?  Or is the problem instead that
they (or their drivers) don't know how to do that without any loss of
functionality ... without a complete reset or whatever?

Most devices can -- if poked and prodded appropriately, and if no
BIOS or uploaded firmware interferes badly enough -- make it through
some kind of system suspend state.  Whether that's the one the user
has chosen ... different issue!  And whether the driver knows how to
do that ... also a different issue!

But the specific problems we're seeing right now with the USB autosuspend
stuff relate to _runtime_ suspend.  I believe some of them are just bugs
in the stack; where better coddling of the devices would let them make it
through unscathed.  But some of them, likewise, probably _do_ have real
problems with real runtime suspend states (that don't map to "off").


> > For 
> > instance, all those USB endpoint pseudo-devices we create -- it's a waste
> > of time to try doing power management on them and it generates a bunch of
> > useless and distracting warning messages in the system log.
> 
> Yes.  In fact we should just make it a "has pm" type flag, as the
> majority of devices do not.
> 
> So, what kind of devices do support these files?  I can think of:
> 	PCI

Actually, PCI still doesn't because of strangeness in the init
sequencing on at least PPC ... I can forward the patch that makes
X86 init the wakeup flag from the PM attributes.

There is however also the issue that on x86, ACPI (in my own
experience) just basically doesn't work as an intermediary for
most wakeup events.  And after all these years, /proc/acpi/wakeup
STILL doesn't hook up to the relevant devices in any useful way.
Drivers have no idea if their devices are expected to support
wakeup events at all.  (That is, assuming ACPI supported it ...)


> 	USB
> and that's it right now.  Do platform devices really use those files?

Depends on the platform.  AT91 is pretty good about it; most of the
platform devices there support wakeup from at least one of the two
power states.   Some of the OMAP devices do, and PXA isn't far from
having at least the IRQ wake mechanisms working.  I've been working
on getting a lot of RTCs to act as wakeup event sources, since that's
one of the few device types that issues wakeup events on most systems.

There's a chicken/egg problem here too ... how to get to a critical
mass of drivers (and platforms) that handle wakeup events properly.

... When most platforms won't even go to _sleep_ properly.

It's actually been a lot *easier* in my experience to get that to
work on an embedded Linux platform than on an x86 PC.  That's because
despite the usual glitches in chips and specs, the vendors are mostly
accustomed to giving that sort of information out to folk implementing
a variety of operating systems.   Whereas on PCs, they basically only
give it out to BIOS vendors, who then generate buggy firmware and
buggy ACPI bytecode to deliver to otherwise happy penguins; naturally
that sort of third or fourth hand stuff works poorly.

- Dave




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
