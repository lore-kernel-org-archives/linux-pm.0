From: David Brownell <david-b@pacbell.net>
Subject: Re: Suspended devices and drivers
Date: Sun, 11 Sep 2005 12:03:17 -0700
Message-ID: <20050911190317.7E580E9E16@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.44L0.0509061050440.5078-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============73771550262098351=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509061050440.5078-100000@iolanthe.rowland.org>
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

--===============73771550262098351==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> > > 	  Right now usb_probe_interface
> > > returns -EHOSTUNREACH when an interface on a suspended device is probed.  
> > > It doesn't try to resume the device.  Is this something we should add?
> > 
> > Probably.  That may need to work down starting at the root hub ... 
>
> It will be part of the RTPM framework I've described earlier.  (BTW, I'm
> waiting for your USB suspend/resume-recursion patch before starting to
> work on the RTPM stuff...)

I've refreshed those patches and split them out into more digestible
chunks, against 2.6 GIT; I'll post at least a few in the next few days,
after retesting.


> > The "dropped VBUS connection" link is pretty fundamental though.  The only
> > ways you can know the same device is there later are (a) if it's the same
> > VBUS power session, or (b) if none of the parent hub ports is removable.
> > 
> > If both of those are false, there's no way for usbcore to guarantee that the
> > same device is connected as was there when you suspended.
>
> No way to _guarantee_ it, agreed.  But we can try to do an acceptable job
> of making sure.

Most usable definitions of "acceptable" will end up needing to be very
driver-specific ... or vendor-specific, or system-specific, etc.

Some usb mass storage devices have non-unique serial numbers, for example,
so there's no way that even usb-storage could always give the right answer.
Maybe something interesting could be done with a certificate that "vendor
XYZ guarantees unique serial numbers" or "vendor ZZZ supports the 'green'
device authentication protocol".


(out of order:)
> > If either (a) or eventually (b) above are true, that should "just work".
>
> That's the easy part.  It _should_ "just work" even if (a) and (b) aren't 
> true -- that's the hard part.

I disagree.  "Should" implies "could work robustly", for which I just gave
another counter-example.  (Don't forget the filesystem corruption one too.)

To me this is a correctness issue.  One that certainly has some user
interface implications;  UNIX (and hence Linux) is still on a long trek
to get rid of assumptions that once devices exist, they continue to exist.
Such bad assumptions have shown up in many user interfaces, and evidently
even in versions of the SCSI stack.  :(

But it's just the flip side of hotplugging (hot UNplugging) ... and in the
same way that userspace needed to learn that devices may appear (and need
to be set up, used, managed, etc), so must it also learn they may disappear
at various times.  Including "while suspended".


> It's not just USB, obviously.  What happens (and what _should_ happen) if 
> you swap parallel-SCSI drives while the power is off?

It's common for specs (like for your stereo, and ISTR ACPI) to emphasize
that once you open the case (e.g. to swap SCSI or IDE drives), resume
behavior is no longer specified (e.g. to behave sanely) ...

What "should" happen in such cases is as much a function of your own
knowledge and skills, and the whole-system spec, as of kernel behavior. :)



> > > That's my point: The devices can't maintain state, but why should they
> > > when the driver is supposed to maintain it for them?  (Yes, some aspects
> > > of state, like firmware updates, might be _too_ difficult for the
> > > driver to preserve.  Such things should be in the minority, however.)
> > 
> > The driver is supposed to maintain driver state; but
> > the device is supposed to maintain device state.
>
> Even during shapshot-poweroff-resume?  How is the device supposed to
> manage that?

That's something I'd expect its driver to know.  One answer is:

>	Unless by "device state" you mean non-volatile things, like
> the contents of flash memory.  Such things present no problem for
> snapshot-resume.

But there's also volatile state; consider bus powered static RAM.
Or that tamper detection ciruit, reset when you opened the case.  :)


> > Resuming implies _both_ of them have been preserved.
> ...


> The tricky part is making sure that the same device is still attached and 
> it still contains the same medium.  Two different problems, which need to 
> be handled at two different levels.  Checking for the same device should 
> be done at the bus level, and checking for the same medium should be done 
> at the disk-driver level.

I summarized the USB bus rules -- (a) and (b) -- above.

At least for wired USB.  Wireless USB would often need to re-authenticate,
implying access to the linux/security/keys store, and thus userspace.
(Wired devices could implement those authentication protocols too...)

Right now the "same medium" checks are done in userspace.  And I recall
folk arguing about that, and deciding that userspace was the the only
workable place for them ...


> 	  In each case it's not possible to be 100% 
> certain, but it is possible to detect the most likely sorts of changes.  
> I.e., unless the user deliberately tries to fool the system, things should 
> work correctly.

Oddly enough, for wired USB (a) *IS* 100% certain (given no hardware bugs).
There's wriggle room in (b) ... we don't check it right now, but it'd make
sense for that to be manageable from userspace.

And I couldn't support the assumption of "non-hostile environment" for
most any general purpose system ... they'll surely get used in places
where that's an unsafe assumption!

- Dave



--===============73771550262098351==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============73771550262098351==--
