From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 21 Jun 2006 14:17:57 -0700
Message-ID: <200606211417.57633.david-b@pacbell.net>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606182054.36975.david-b@pacbell.net>
	<Pine.LNX.4.64.0606201453160.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606201453160.5498@g5.osdl.org>
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

On Tuesday 20 June 2006 3:06 pm, Linus Torvalds wrote:
> =

> The fact is, "shut down" and "freeze for a moment" are just fundamentally =

> different ops. Not just to disks. =


Not in common usage; "shut down" means _exactly_ a freeze.  As in "shut
down the production line".  "Stop" might be a better word.  But also I
suspect you intended to write "suspend", which is indeed a bit different
(it's a superset of freeze/stop).

One of the vocabulary issues is that we have a hard time talking about
low power modes that retain limited functionality.  For example, systems
may have runtime states that don't provide certain functionality, and so
may individual controllers.  Not exactly suspended, and not necessarily
frozen/stopped either...


> Think just about any USB device. suspend might try to keep power active =

> (hey, if you want the keyboard to wake thigns up, it had better),

In the USB context "suspend" means something extremely specific:  the
device's upstream port has stopped sending SOF packets for at least 3msec,
so that the device enters a specific low power mode (possibly with remote
wakeup enabled).  And VBUS power **IS** provided, but the peripheral's
power budget is now measured in microAmps not milliAmps.

Note that all suspended USB devices are by definition frozen/stopped,
since there may be no I/O interactions with it until it's not suspended.


> 		 but if =

> you have a USB camera, a "freeze" is potentially totally different from a =

> "suspend". A "freeze" would do absolutely nothing (it's a USB host =

> controller issue),

That's one potential implementation strategy ("it's an HCD issue"), but
not the only one.  It'be nonsense to require that USB peripheral drivers
not understand the "stop/freeze" semantics, especially since they're the
once managing the parts of the I/O queue going to any given ste of
peripheral endpoints.


> while a suspend might actually shut the dang thing  =

> down.

Nope; "suspend" may never shut the thing down, it's still powered.


> Yeah, for suspend-to-disk and a camera, maybe you don't care. But my poin=
t =

> is, that disks are NOT special. The only thing that makes them special =

> at all in your world-view has nothing to do with the device itself, or th=
e =

> action itself, but simply that you realize that "suspend-to-disk" will =

> need to wake it up afterwards.

Don't attribute Pavel's approach to me, please!!

And as Ben observed separately, that STD support (with "freeze" and
associated confusions) was added late, which may explain part of why
it doesn't play as well with the rest of the system as would be good.


> But for all you know, the suspend-to-disk will need the random USB device =

> too - security signatures from USB keycard readers etc to enable disk =

> access aren't actually all that sci-fi (and some day it may even be the =

> camera that validates you).

Heh.  Wireless USB peripherals do indeed need to authenticate themselves
to the host (and vice versa).  Now you have me wondering about truly
perverse things like suspending to a disk that's connected over WUSB.  ;)


> > Most pieces of hardware are pretty easy to stick into low power states.
> > What's hard is getting everything quiesced, and ready to be suspended.
> > (Which is the guts of what a freeze does.)
> =

> That's not even true. A lot of hardware needs _lots_ of care to come back =

> from a real low-power event. Like reloading firmware etc.

I was talking about suspend paths, not resume paths.  Agreed that resume
paths get tricky.

- Dave
