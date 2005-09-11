From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Suspended devices and drivers
Date: Sun, 11 Sep 2005 16:06:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509111538350.25522-100000@netrider.rowland.org>
References: <20050911190317.7E580E9E16@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============18684120530456916=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050911190317.7E580E9E16@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
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

--===============18684120530456916==
Content-Type: TEXT/PLAIN; charset=US-ASCII

I suspect this is a losing argument, but I'll carry on a bit more just to 
be perverse...


On Sun, 11 Sep 2005, David Brownell wrote:

> > > If both of those are false, there's no way for usbcore to guarantee that the
> > > same device is connected as was there when you suspended.
> >
> > No way to _guarantee_ it, agreed.  But we can try to do an acceptable job
> > of making sure.
> 
> Most usable definitions of "acceptable" will end up needing to be very
> driver-specific ... or vendor-specific, or system-specific, etc.

I see nothing wrong in that.  And we can have minimal standards that are 
more general, say filesystem-specific.

> Some usb mass storage devices have non-unique serial numbers, for example,
> so there's no way that even usb-storage could always give the right answer.

That's why I said "acceptable job" instead of "perfect job".

> Maybe something interesting could be done with a certificate that "vendor
> XYZ guarantees unique serial numbers" or "vendor ZZZ supports the 'green'
> device authentication protocol".

Maybe.  But I would like to see this available even in situations where 
such certificates do not exist.


> > > If either (a) or eventually (b) above are true, that should "just work".
> >
> > That's the easy part.  It _should_ "just work" even if (a) and (b) aren't 
> > true -- that's the hard part.
> 
> I disagree.  "Should" implies "could work robustly", for which I just gave
> another counter-example.  (Don't forget the filesystem corruption one too.)

One always has to balance robustness against useability.  I think you're
pushing it too far in one direction.  There could, for example, be a
configuration option (or kernel attribute) for "forced removal of
hot-unpluggable devices on poweroff-suspend".  Then people could go either
way, according to their own preferences.

> To me this is a correctness issue.  One that certainly has some user
> interface implications;  UNIX (and hence Linux) is still on a long trek
> to get rid of assumptions that once devices exist, they continue to exist.
> Such bad assumptions have shown up in many user interfaces, and evidently
> even in versions of the SCSI stack.  :(
> 
> But it's just the flip side of hotplugging (hot UNplugging) ... and in the
> same way that userspace needed to learn that devices may appear (and need
> to be set up, used, managed, etc), so must it also learn they may disappear
> at various times.  Including "while suspended".

Nobody is denying that.  But there's a big difference between learning 
that devices _may_ disappear and _forcing_ them to disappear needlessly.


> > It's not just USB, obviously.  What happens (and what _should_ happen) if 
> > you swap parallel-SCSI drives while the power is off?
> 
> It's common for specs (like for your stereo, and ISTR ACPI) to emphasize
> that once you open the case (e.g. to swap SCSI or IDE drives),

Or change external connectors or cables...

>   resume
> behavior is no longer specified (e.g. to behave sanely) ...
> 
> What "should" happen in such cases is as much a function of your own
> knowledge and skills, and the whole-system spec, as of kernel behavior. :)

Isn't that consistent with what I've been saying all along?  If you don't 
change the connections during snapshot-poweroff-resume then the devices 
remain intact; if you do then anything might happen (but usually the 
devices will simply disappear).


> > > The driver is supposed to maintain driver state; but
> > > the device is supposed to maintain device state.
> >
> > Even during shapshot-poweroff-resume?  How is the device supposed to
> > manage that?
> 
> That's something I'd expect its driver to know.  One answer is:
> 
> >	Unless by "device state" you mean non-volatile things, like
> > the contents of flash memory.  Such things present no problem for
> > snapshot-resume.
> 
> But there's also volatile state; consider bus powered static RAM.
> Or that tamper detection ciruit, reset when you opened the case.  :)
> 
> 
> > > Resuming implies _both_ of them have been preserved.
> > ...

In cases where state cannot be preserved, then obviously the device can't 
hope to survive snapshot-poweroff-resume.  But you're distorting matters 
by implying that the driver can not be responsible for maintaining device 
state.  Of course it can; and if the driver and device _together_ maintain 
sufficient state then the device should survive.


> > The tricky part is making sure that the same device is still attached and 
> > it still contains the same medium.  Two different problems, which need to 
> > be handled at two different levels.  Checking for the same device should 
> > be done at the bus level, and checking for the same medium should be done 
> > at the disk-driver level.
> 
> I summarized the USB bus rules -- (a) and (b) -- above.

Those are the rules for _guaranteeing_ that the USB device hasn't changed.  
What about rules for saying that as far as you can tell the device hasn't 
changed?

> Right now the "same medium" checks are done in userspace.  And I recall
> folk arguing about that, and deciding that userspace was the the only
> workable place for them ...

That may be so; I don't know.  The thought occurs that the filesystem 
ought to get involved, at least to the extent of checking a hash of the 
superblock...

> > 	  In each case it's not possible to be 100% 
> > certain, but it is possible to detect the most likely sorts of changes.  
> > I.e., unless the user deliberately tries to fool the system, things should 
> > work correctly.
> 
> Oddly enough, for wired USB (a) *IS* 100% certain (given no hardware bugs).

Yep.  But for other systems, certainty is impossible.

> There's wriggle room in (b) ... we don't check it right now, but it'd make
> sense for that to be manageable from userspace.
> 
> And I couldn't support the assumption of "non-hostile environment" for
> most any general purpose system ... they'll surely get used in places
> where that's an unsafe assumption!

I hardly think that matters.  Anyone who has sufficient physical access to
the computer to disconnect and reconnect peripheral devices is already in
a position to do a lot of damage.  You might just as well go around trying
to protect against hostile actions by root!  :-)

Alan Stern


--===============18684120530456916==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============18684120530456916==--
