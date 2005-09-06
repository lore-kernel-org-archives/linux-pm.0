From: David Brownell <david-b@pacbell.net>
Subject: Re: Suspended devices and drivers
Date: Mon, 05 Sep 2005 17:13:28 -0700
Message-ID: <20050906001328.2B85733730@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.44L0.0509042055440.6059-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============60205051477270111=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509042055440.6059-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: stern@rowland.harvard.edu
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============60205051477270111==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> Date: Sun, 4 Sep 2005 21:25:35 -0400 (EDT)
> From: Alan Stern <stern@rowland.harvard.edu>
>
> It's true that the HCDs are reasonably capable in this respect.  I was
> speaking more of the USB device drivers.  Right now usb_probe_interface
> returns -EHOSTUNREACH when an interface on a suspended device is probed.  
> It doesn't try to resume the device.  Is this something we should add?

Probably.  That may need to work down starting at the root hub ... 


> > >	it's generally accepted that drivers will restore
> > > whatever state is necessary as part of their resume procedure.
> > 
> > If the USB stack has actually suspended that device, that's appropriate.
> > 
> > If its port has been power cycled for any reason (including even just
> > unplug/replug) then it's impossible to resume; so usbcore must then
> > disconnect() not resume().  It'll later re-enumerate that port.
>
> While it is impossible to "resume" in the sense used by the USB spec, it
> is still possible to get much the same effect by re-enumerating.  That's
> pretty much what usb_reset_device does right now (although it doesn't ever
> drop the VBUS power).

The "dropped VBUS connection" link is pretty fundamental though.  The only
ways you can know the same device is there later are (a) if it's the same
VBUS power session, or (b) if none of the parent hub ports is removable.

If both of those are false, there's no way for usbcore to guarantee that the
same device is connected as was there when you suspended.

By the way, (b) surfaces something that might be useful for Linux at
some point.  For hotpluggable busses, not all segements are necessarily
hotpluggable.  We waste a certain amount of resources, such as memory
to store remove() methods, for hardware that's not actually removable.
Also, the reason IDE drives come back in the "same" state is that they
all assume the IDE analogue of (b).  That's fair, since re-cabling things
normally involves opening the case, implying a full reset/reboot.


> > But the poweroff snapshot-resume thing isn't the same thing; USB devices 
> > can't maintain suspend states when VBUS power gets dropped.  Those get
> > disconnected ... just like happens on _any_ hotpluggable bus segment.
>
> That's my point: The devices can't maintain state, but why should they
> when the driver is supposed to maintain it for them?  (Yes, some aspects
> of state, like firmware updates, might be _too_ difficult for the
> driver to preserve.  Such things should be in the minority, however.)

The driver is supposed to maintain driver state; but
the device is supposed to maintain device state.

Resuming implies _both_ of them have been preserved.

The kind of disk snapshot-resume that you're talking about (involving
users potentially swapping removable media) worries me.  I'd want to
know that for example the filesystem code would be made to verify that
the filesystems were in the state they're supposed to be in, otherwise
the wrong kind of resume could easily trash disks... and right now,
I don't think those checks are done in the kernel.


> People expect that following a powercycled swsusp, their memory mappings 
> to disks on the motherboard will remain intact.  Why shouldn't mappings to 
> hotpluggable disks remain intact as well, provided the disk is still 
> plugged in?

If either (a) or eventually (b) above are true, that should "just work".

- Dave



--===============60205051477270111==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============60205051477270111==--
