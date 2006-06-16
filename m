From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 16 Jun 2006 09:48:14 -0700
Message-ID: <200606160948.15806.david-b@pacbell.net>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606152135.49527.david-b@pacbell.net>
	<Pine.LNX.4.64.0606152207270.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606152207270.5498@g5.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday 15 June 2006 10:23 pm, Linus Torvalds wrote:
> =

> On Thu, 15 Jun 2006, David Brownell wrote:
> > =

> > The main reason a network driver would be interesting from the PM
> > perspective is that it might be able to issue wake-on-LAN events.
> =

> I think we do that separately as a totally user-land "prepare to suspend" =

> functionality, long before we even get to suspend, right now?

Ethtool just sets parameters, like which kinds of network events
will morph into system wakeup events.  And that happens long before
a system starts to enter whatever sleep (or hibernate) state may
be relevant ... not the same thing as what I understand you're
talking about with this "prepare".

The bit that's interesting from the PM perspective is that the driver
suspend method needs to act differently when WOL is enabled.  Maybe
not so differently on PCI, but on various embedded platforms it's the
usual gig:  the "suspend" state isn't actually that different from
the normal "active" state, from the hardware perspective.  (The PHY
clock and function clocks may need to stay on, depending on what
WOL modes were enabled, for example.)


> > > All the rest of the state is stuff that the driver knows to do, and i=
t's =

> > > about _driver_ state, not hardware state.
> > =

> > USB does however rely on hardware state during true sleep states.
> > For example, that hardware state is what makes remote wakeup work.
> =

> But that's state that we already know, no? =


We know what it _was_ but that's not good enough.  Disconnect during
suspend, as one example, needs to act just like disconnect when the
system is live.  USB Host Controllers monitor port change events while
they're suspended.  And for example one of those events is a "remote
wakeup" where the USB peripheral -- like a keyboard, a mouse, or a
LAN controller -- says "hey Linux, pay attention NOW and wake up".

We *must not* restore the old hardware state; it's invalid by the
time of resume in the power-off cases (notably suspend-to-disk).


(Yes, there's a distinct subtext here that updates to the Linux PM
framework really shouldn't continue to overlook wakeup events...)


> > > Are we also in agreement that it's entirely possible that the main sy=
stem =

> > > disk is behind USB, and that it might be a good idea to support suspe=
nd to =

> > > disk off such a thing?
> > =

> > No.  Last time this was discussed, the conclusion was that it was not
> > currently supportable.    The issues are shared with all removable media
> > volumes:  MMC/SD, Firewire disks, IDE cartridges, external SATA, and mo=
re;
> > not just USB.
> > =

> > One of the basic issues is that _resume_ from such media is problematic.
> =

> I agree that it probably won't work now, and that it's certainly one of =

> the worst cases. It's obviously why I chose it.
> =

> You may call it "best" from a PM standpoint, and I'll agree with you from =

> a "discuss the issues" standpoint, but I think I'll still just call it =

> "worst" from a purely complexity standpoint ;^/

So you're a "glass is half-empty" kind of guy ... not what I had thought!  =
:)

I think a fully featured Firewire stack would have almost the same issues,
not that we have one of those.  A big chunk of the complexity comes from
focussing on the host side core, since host controllers need to mediate
access to up to a hundred peripherals each, as well as directly managing the
power supplies for some of them.  Few other busses do either of those.
(Oh, and few other busses make as much use of PCI class drivers to share
the register interfaces.  Quirks and errata are not shared, though.)


> That said, I think it's not unreasonable to want to be able to resume fro=
m =

> a USB disk at least in theory. Even if the rules very much would be that =

> you'd better not move that disk to any other machine, or do other strange =

> things. I think those rules would be _very_ understandable to your averag=
e =

> user, who wouldn't really even expect it to work.

I think you're unlikely to get many of the "please help me recover
from this disaster!" calls from the folk who didn't actually understand
as much as they thought ...

 =

> (Evil thought: It _would_ be pretty cool if you could take your work with =

> you home by moving the resume disk to an identical machine at home ;)

Well, there's all the open files on the other disks to pay attention
too.  Plus the BDI-2000 ... we need to be able to resume those live
debug sessions!  ;)


> > >    There's two things to notice: there's no _information_ in the comm=
and =

> > >    lists.
> > =

> > ... except from buggy device drivers which didn't abort all their pendi=
ng
> > commands when they got told to suspend.  (OK, that's the current model,
> > not quite what you're talking about here, but this is a real-world case
> > that currently gets handled that way.
> =

> Yeah. I also suspect that in practice it would actually work, because the =

> devices would have been quiet, so the fact that we didn't suspend then =

> didn't actually matter.

We've been trying to cope with the problem, but "quiet" doesn't mean
they're inactive on the USB bus.  Remember that with USB, the host
always initiates transfers ... which means that in many cases it will
be polling quite regularly "are we having fun yet".

Thing is, if drivers don't quiesce themselves properly _and_ have the
polling going on, then they _will_ be seeing unexpected failure modes.
Either because usbcore eventually nukes those pending transfers, or
because when the hardware suspends, the device stops NAKing so that
the host will now need to report some hard errors.

(This also mixes in with runtime suspend states ... e.g. the classic
scenario of suspending the USB mouse to get rid of the 100mA VBUS
drain on the battery, not to mention the constant busmastering that
keeps the CPU out of C3 state, relying on remote wakeup to restart
things.  Devices suspended at runtime need to be quiesced for exactly
the same reasons as those suspended because of a system sleep or
hibernate state.)

 =

> > Going that "re-write" route implies the driver init and re-init logic
> > gets handled much more cleanly than it ever has been.  It's a fine noti=
on,
> > but currently not as practical as the save/restore config space approac=
h.
> =

> I do believe that for a lot of drivers, there really is no difference.

In terms of code structure, there's a huge difference ... and it's right
at the heart of those fragile hardware init sequences.  In terms of what
gets saved for e.g. PCI, you're absolutely right; but sorting through all
the workarounds for hardware quirks/errata may be impractical.

- Dave
