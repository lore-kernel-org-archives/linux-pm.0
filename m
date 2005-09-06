From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Suspended devices and drivers
Date: Tue, 6 Sep 2005 11:19:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509061050440.5078-100000@iolanthe.rowland.org>
References: <20050906001328.2B85733730@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============30488903233051134=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050906001328.2B85733730@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
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

--===============30488903233051134==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 5 Sep 2005, David Brownell wrote:

> > Date: Sun, 4 Sep 2005 21:25:35 -0400 (EDT)
> > From: Alan Stern <stern@rowland.harvard.edu>
> >
> > It's true that the HCDs are reasonably capable in this respect.  I was
> > speaking more of the USB device drivers.  Right now usb_probe_interface
> > returns -EHOSTUNREACH when an interface on a suspended device is probed.  
> > It doesn't try to resume the device.  Is this something we should add?
> 
> Probably.  That may need to work down starting at the root hub ... 

It will be part of the RTPM framework I've described earlier.  (BTW, I'm
waiting for your USB suspend/resume-recursion patch before starting to
work on the RTPM stuff...)


> > > If its port has been power cycled for any reason (including even just
> > > unplug/replug) then it's impossible to resume; so usbcore must then
> > > disconnect() not resume().  It'll later re-enumerate that port.
> >
> > While it is impossible to "resume" in the sense used by the USB spec, it
> > is still possible to get much the same effect by re-enumerating.  That's
> > pretty much what usb_reset_device does right now (although it doesn't ever
> > drop the VBUS power).
> 
> The "dropped VBUS connection" link is pretty fundamental though.  The only
> ways you can know the same device is there later are (a) if it's the same
> VBUS power session, or (b) if none of the parent hub ports is removable.
> 
> If both of those are false, there's no way for usbcore to guarantee that the
> same device is connected as was there when you suspended.

No way to _guarantee_ it, agreed.  But we can try to do an acceptable job
of making sure.

It's not just USB, obviously.  What happens (and what _should_ happen) if 
you swap parallel-SCSI drives while the power is off?  Or if you exchange 
floppy disks or CD-ROM discs?

> By the way, (b) surfaces something that might be useful for Linux at
> some point.  For hotpluggable busses, not all segements are necessarily
> hotpluggable.  We waste a certain amount of resources, such as memory
> to store remove() methods, for hardware that's not actually removable.

Do you know of any examples of wasted code?  Even if one instance of a bus
has non-hotpluggable segments, other instances might still be
hotpluggable.  In such cases the remove methods would indeed be necessary,
even if they weren't always used.

If you want to stretch a point, you could say that all the USB disconnect
methods are wasted for users who never unplug their USB devices while the
system is on!  :-)

> Also, the reason IDE drives come back in the "same" state is that they
> all assume the IDE analogue of (b).  That's fair, since re-cabling things
> normally involves opening the case, implying a full reset/reboot.

But it _doesn't_ imply "a full reset/reboot", if by that phrase you mean
omitting to restore a swsusp image.  There's nothing to stop you from
doing swsusp to disk with powerdown, monkeying around with your IDE drives
& cables, and then trying to do a resume from disk.  It won't work,
clearly -- but you certainly can try it anyway.


> > That's my point: The devices can't maintain state, but why should they
> > when the driver is supposed to maintain it for them?  (Yes, some aspects
> > of state, like firmware updates, might be _too_ difficult for the
> > driver to preserve.  Such things should be in the minority, however.)
> 
> The driver is supposed to maintain driver state; but
> the device is supposed to maintain device state.

Even during shapshot-poweroff-resume?  How is the device supposed to
manage that?  Unless by "device state" you mean non-volatile things, like
the contents of flash memory.  Such things present no problem for
snapshot-resume.

> Resuming implies _both_ of them have been preserved.
> 
> The kind of disk snapshot-resume that you're talking about (involving
> users potentially swapping removable media) worries me.  I'd want to
> know that for example the filesystem code would be made to verify that
> the filesystems were in the state they're supposed to be in, otherwise
> the wrong kind of resume could easily trash disks... and right now,
> I don't think those checks are done in the kernel.

Okay, that's a valid issue to be concerned about.

(Actually, I suspect we don't need to worry about things at the filesystem 
level.  If the same device is still attached, and if nobody has altered 
its contents since the snapshot was made (a reasonable assumption), then 
the filesystems will be okay.  As will the contents of raw partitions.)

The tricky part is making sure that the same device is still attached and 
it still contains the same medium.  Two different problems, which need to 
be handled at two different levels.  Checking for the same device should 
be done at the bus level, and checking for the same medium should be done 
at the disk-driver level.  In each case it's not possible to be 100% 
certain, but it is possible to detect the most likely sorts of changes.  
I.e., unless the user deliberately tries to fool the system, things should 
work correctly.


> > People expect that following a powercycled swsusp, their memory mappings 
> > to disks on the motherboard will remain intact.  Why shouldn't mappings to 
> > hotpluggable disks remain intact as well, provided the disk is still 
> > plugged in?
> 
> If either (a) or eventually (b) above are true, that should "just work".

That's the easy part.  It _should_ "just work" even if (a) and (b) aren't 
true -- that's the hard part.

Alan Stern


--===============30488903233051134==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============30488903233051134==--
