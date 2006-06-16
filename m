From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 21:35:48 -0700
Message-ID: <200606152135.49527.david-b@pacbell.net>
References: <20060614103404.GC28536@elf.ucw.cz>
	<1150420919.7725.75.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606151840270.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606151840270.5498@g5.osdl.org>
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

On Thursday 15 June 2006 7:29 pm, Linus Torvalds wrote:
> =

> On Fri, 16 Jun 2006, Benjamin Herrenschmidt wrote:
> > =

> > Network drivers rarely need to save anything :) Most of their state is
> > in the netdev structure (MAC address, multicast filters, etc...) thus
> > it's in many case fairly easy to just restore the whole driver from that
> > without needing a specific state saving phase.

The main reason a network driver would be interesting from the PM
perspective is that it might be able to issue wake-on-LAN events.

Unless the event is receipt of a packet that must then be delivered
to Linux (without retransmit) the network driver can use that simple
"reinit everything" approach.


> Ok, take a deep breath, and think that thought through.

It's actually fairly typical of device drivers ... except those
which rely on hardware state during system sleep states (like STR
and "standby"), and/or issue wakeup events.


> It turns out that _no_ drivers really need to save anything at all, excep=
t =

> the fundamental state that we cannot regenerate directly.
> =

> Think about it.
> =

> All the rest of the state is stuff that the driver knows to do, and it's =

> about _driver_ state, not hardware state.

USB does however rely on hardware state during true sleep states.
For example, that hardware state is what makes remote wakeup work.


> So let's just look at one really bad situation, which is USB. First off, =

> are we all in argeement that USB is important, and not likely to go away? =


Yes.


> Are we also in agreement that it's entirely possible that the main system =

> disk is behind USB, and that it might be a good idea to support suspend t=
o =

> disk off such a thing?

No.  Last time this was discussed, the conclusion was that it was not
currently supportable.    The issues are shared with all removable media
volumes:  MMC/SD, Firewire disks, IDE cartridges, external SATA, and more;
not just USB.

One of the basic issues is that _resume_ from such media is problematic.
Trivial scenarios lead to media corruption for all mounted filesystems
sitting on that volume.  (Suspend, use that usb key on some other system,
resume ... voila, "open" files may be completely gone, resources will have
been reallocated to other files, and so on.)


> So think about that. You're saying that is "impossible" to do, as is =

> apparently Pavel, because USB - in order to work - needs to have all its =

> DMA lists active.
> =

> I'm saying it's not impossible at all, and in fact, if you just shift you=
r =

> perceptions a bit, it turns out to fall right out of the whole "save the =

> state first, but don't shut down" approach.

Your comments here make sense if I view them as limited to a swap
partition on USB media, with no filesystems active.  Or even things
like a USB mouse or keyboard ... in general, things where there is
no state that could be corrupted while the system is powered off
and its USB devices are borrowed for use on other systems.


> I'll tell you the _simple_ solution first, just because the simple =

> solution actually explains what it is all about. It's not the perfect =

> solution, but once you actually understand the simple solution, it's also =

> very obvious how to get to better solutions - they're not fundamentally =

> different.
> =

> So the problem is, that we want to save the system image, but in order to =

> save it, USB has to be active, which means that the image we save is =

> "corrupt". The solution is to _let_ it be corrupt, and revel in the fact =

> that we don't need it to be some magic "snapshot in time".
> =

> What we do is:
> =

>  - we realize that all the USB command lists in memory are all totally =

>    uninteresting, BECAUSE WE GENERATED THEM OURSELVES. We say: "we will =

>    throw away all the command list on resume, instead of trying to =

>    continue using them".
> =

>    There's two things to notice: there's no _information_ in the command =

>    lists.

... except from buggy device drivers which didn't abort all their pending
commands when they got told to suspend.  (OK, that's the current model,
not quite what you're talking about here, but this is a real-world case
that currently gets handled that way.  Nobody aborts the pending messages,
and ISTR there's been no discussion yet about doing that.  We did something
analagous for disconnect processong though, and now _could_ do it here.)


>    We cannot have a USB event "active" over the reboot anyway,  =

>    we'll need to re-connect all devices regardless, so any old command =

>    lists by definition don't actually _matter_.

This is specific to the "system power off" hibernation, and is a direct
consequence of powering off the controller, so it gets reset on power-up.

For suspend-to-RAM there's normally no reset, and there's no fundamental
reason the hardware wouldn't be able to just resume processing the lists.
Some chips do it just fine.  Some don't; you could think of the difference
as being that some chips issue the optional light reset coming from PCI_D3h=
ot.
(So if PCI_D2 or PCI_D1 were used instead of PCI_D3hot, no reset...)


>    The other thing to notice is that none of this is "hardware state". So =

>    when we do the "save_state()" thing, that does _not_ imply saving off =

>    the USB command lists. Not at all. It means saving off things like the =

>    USB controller setup, things like where in PCI space its registers got =

>    mapped when we booted and did the original device discovery.
>
>    We may choose to do that by just saving-and-restoring the actual PCI =

>    config space (which is easy, and you can use a generic helper for that=
, =

>    so that's probably the way to go), or we could just decide that we =

>    don't want to do even that, because we can just re-write the =

>    information using the device resources,

Going that "re-write" route implies the driver init and re-init logic
gets handled much more cleanly than it ever has been.  It's a fine notion,
but currently not as practical as the save/restore config space approach.


>    which we already save off (and  =

>    which, unlike things like the URB lists themselves, are _not_ =

>    changeable, so there's no problem with saving them off)
> =

> See? If you take this approach, you do actually end up saving off memory =

> that may be changing as you save it (imagine, for example, writing to dis=
k =

> the very memory that contains the URB that does the writing itself, and =

> that will change from "ready" to "completed" after the write), AND IT =

> DOESN'T MATTER. Because, on resume, you don't actually use it, you =

> re-create it all.

And USB drivers know that they need to recreate it by using the very same
mechanism they already use to handle especially aggressive STR implementions
(where hardware uses PCI_D3cold not PCI_D3hot for the host controller).
This is not a special case; resume() sees the hardware was reset, and
does its usual thing.

 =

> Btw, most devices don't even _have_ this issue. Most devices don't _have_ =

> memory that ends up changing, or if they have, they're not actually going =

> to be part of the write-out, so when they resume, they don't need to worr=
y =

> about their memory being part of what got changed/freed.

Most _drivers_ are painfully simple compared to USB controller drivers.

 =

> Basically, devices that don't hold on to pointers to data areas in memory =

> will never see this issue. USB, in many ways, is the worst possible case =


It's the "best" one I've seen so far in terms of illustrating coverage gaps
for the Linux-PM framework.  I suppose from some points of view that makes
it the "worst" by some other metric ... ;)


> (a lot of other devices will obviously similarly do command structures in =

> memory, but a lot of _those_ do it purely to statically allocated memory, =

> so they can just clear the thing on resume, and start again).
> =

> See? Suddenly, by accepting the fact that you don't have to get an "atomi=
c =

> snapshot", you are freed to do things much more easily.

Plus, the guts of what you described are already how the USB controller
drivers _have_ to work.  Just to handle the D3cold board options for STR.

- Dave
