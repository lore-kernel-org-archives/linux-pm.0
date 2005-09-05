From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Suspended devices and drivers
Date: Sun, 4 Sep 2005 21:25:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509042055440.6059-100000@netrider.rowland.org>
References: <20050904204641.8D1B2C1BF2@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============59920085884022878=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050904204641.8D1B2C1BF2@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============59920085884022878==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sun, 4 Sep 2005, David Brownell wrote:

> > Date: Sun, 4 Sep 2005 12:13:58 -0400 (EDT)
> > From: Alan Stern <stern@rowland.harvard.edu>
> >
> > Is there any recommendation about what to do when a driver is probed
> > for a suspended device?
> 
> Sure; see below ("common solution").
> 
> 
> >	Probably most drivers don't bother to check
> > the device state; if they encounter errors because the device doesn't
> > respond the way they expect, the probe will simply fail.  (The USB
> > subsystem, for example, doesn't take this into account.)
> 
> Actually the USB HCDs do take that into account.  The "subsystem"
> does as much as it can:  PCI HCDs have utilities to share.  The first
> thing usb_hcd_pci_probe() routine does is call the pci_enable_device(),
> which puts the HC in D0 state (assuming the HC supports PCI PM at all).
> In fact that's much of _why_ that call is made so early ...
> 
> The non-PCI HCDs necessarily work a bit differently, and can't share
> any bus-specific code; there can't be much of a "subsystem" role.

It's true that the HCDs are reasonably capable in this respect.  I was
speaking more of the USB device drivers.  Right now usb_probe_interface
returns -EHOSTUNREACH when an interface on a suspended device is probed.  
It doesn't try to resume the device.  Is this something we should add?


> > A related problem is faced by USB drivers in a boot kernel.  The
> > current design relies on USB devices maintaining their state across a
> > suspend/resume, even suspend to disk.
> 
> I don't know any particular way they'd "rely" on that.  Modulo any
> recent bugs, the transitions from a USB suspend state are either
> (a) resuming, or (b) disconnecting.  You imply (b) won't happen.

> > In fact, maybe it's a mistake to expect USB devices to maintain their
> > state across STD.  After all, devices on the motherboard aren't
> > expected to;
> 
> They're certainly _allowed_ to do so though.  Some are quite expected
> to, like the RTC ... and on many platforms, there'll be some SRAM
> (typically 16+ KB) maintaining state during suspend/resume transitions
> even when DRAM goes unpowered.
> 
> (Of course, powercycling is another story entirely.  And it's very
> easy lately to confuse STD with the powercycling version of swsusp
> snapshot-resume.  Those are quite different.)

You're right, I've been confusing the two.  Okay, let's focus our 
attention on the powercycling version of swsusp.

> >	it's generally accepted that drivers will restore
> > whatever state is necessary as part of their resume procedure.
> 
> If the USB stack has actually suspended that device, that's appropriate.
> 
> If its port has been power cycled for any reason (including even just
> unplug/replug) then it's impossible to resume; so usbcore must then
> disconnect() not resume().  It'll later re-enumerate that port.

While it is impossible to "resume" in the sense used by the USB spec, it
is still possible to get much the same effect by re-enumerating.  That's
pretty much what usb_reset_device does right now (although it doesn't ever
drop the VBUS power).

> > Why shouldn't USB devices behave the same way?
> 
> USB _devices_ don't know STD from Adam.  All they know is whether they're
> still suspended or not ... and the answer is NO unless both (a) VBUS
> connectivity from the root hub has powered the link the whole time, which
> is easy with true STD but not snapshot-resume; and (b) nobody's reset their
> port, e.g. by power cycling the root hub or by some software initiated reset.
> 
> So a true system _suspend_ state should already be doing that.
> Even suspend-to-disk.
> 
> But the poweroff snapshot-resume thing isn't the same thing; USB devices 
> can't maintain suspend states when VBUS power gets dropped.  Those get
> disconnected ... just like happens on _any_ hotpluggable bus segment.

That's my point: The devices can't maintain state, but why should they
when the driver is supposed to maintain it for them?  (Yes, some aspects
of state, like firmware updates, might be _too_ difficult for the
driver to preserve.  Such things should be in the minority, however.)

People expect that following a powercycled swsusp, their memory mappings 
to disks on the motherboard will remain intact.  Why shouldn't mappings to 
hotpluggable disks remain intact as well, provided the disk is still 
plugged in?

Admittedly, that last proviso is a tricky point.  It seems to me that it
ought to be sufficient to make a good-faith attempt at verifying that the
device present on a port after a resume is the same device that was there
before the suspend.  For example, comparing USB descriptors (possibly
including some string descriptors as well).  Sure, you could fool such a
test -- but if you do, you get what you deserve.

My intuition says that users won't care about the technical differences 
between hotpluggable and non-hotpluggable devices, when it comes to the 
behavior of snapshot-poweroff-resume.  They will want things Just To 
Work.

Alan Stern

P.S.: Does anyone know how Windows behaves if a running program has files
open on a floppy disk (or a USB disk) across a Hibernate?  I should try
the experiment...


--===============59920085884022878==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============59920085884022878==--
