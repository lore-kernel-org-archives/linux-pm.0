From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Thu, 22 Jun 2006 11:01:59 +1000
Message-ID: <1150938119.16303.99.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
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
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


> What I want is really to haev modular, independent calls, that tell drive=
r =

> writers _exactly_ what is going on, and why they should do so. =

> =

> (And, btw, "tell driver writers" is only indirectly about having the =

> documentation. Much more important than documentation is just clear and =

> unambiguous interfaces. Right now, "suspend()" is _not_ that. It's not =

> clear and unambiguous at all, it's a muddy pit-hole of mixing different =

> things - you're supposed to do all of "freeze", "save state" and =

> "suspend")

Well... thing is, the semantics I define for prepare() and the semantics
you define for save_state() are actually different. And I think we need
both.

That is, if you absolutely want this state saving thing split from the
actual suspend (I'm not convinced it will make driver writers life
easier but let's assume it's fine for now), we still need something with
the semantics of nforming drivers that from now on and until _after_
resume (hence my proposed finish() call to be the pending of _that_:

 - GFP_KERNEL allocations might block for ages (using them might
deadlock, though we might want to add a trick to get_free_pages() to
silently turn them into NOIO)

 - userland will stop responding at any point in time in the future (as
soon as the backing store of a given process or swap is put to sleep, or
maybe blocked in an ioctl of a sleeping driver or whatver

 - As a consequences of the above, things like request_firmware cannot
be used until finish() is called, and thus drivers shall pre-load
whatever they may need now (that _could_ be considered as state saving
especially if the driver actually "saves" the firmware from the device
rather than from the disk) but heh

 - As a general sanity measure and because it will jsut make everything
more smooth, bus drivers are required to stop inserting new devices in
the system until finish() (removal might still be allowable, though I'd
rather not, part of the logic here is that by disallowing that, we
simplify locking issues of power tree traversal, and we avoid the
problem of sending hotplug events to a userland that can't quite react
to them).

> To me, "prepare_to_reinitialize" is just very cumbersome, but I really =

> don't care about the naming as much as I care about the op doing just =

> _one_ thing, and doing it well.
> =

> It's the whole UNIX philosophy again. You can have the Windows kind of =

> "open()" system call that has 8 arguments, and can do a "open with stat, =

> but only on Wednesdays, and only when I said 'Simon Says' before".
> =

> Or you can have the UNIX kind of "open()", which is one system call, does =

> one thing only, and if you want the "stat()" of the opened file, you do =

> that separately.

That's fine unless you need some kind of atomicity, and thus you end up
with all the new _at variants, things like O_CREAT flags, etc... still
better than the windows variant I suppose (heh, I don't know it though)
but we can't always split everything in separate bits.

> You do NOT mix operations in one super-duper-operation.
> =

> And naming is somewhat secondary (although not totally irrelevant, of =

> course - you can certainly confuse people with bad naming even if the =

> design is otherwise perfect).
> =

> > > 	- suspend()
> > =

> > Presumably remote wakeup (WOL, whatever) gets enabled as part of the =

> > suspend().
> =

> That's what I'd expect, yes. Clearly _managing_ that whole thing is a =

> totally separate issue, but right now we don't even do that within the =

> actual device infrastructure, but on a device-by-device basis (ie ethtool =

> for networking and perhaps the RTC tools for timed wakeups?).
> =

> In fact, exactly because different devices have so fundamentally differen=
t =

> notions of what a wakup event is, I think that's the only really workable =

> option: have a device-specific setup phase long before, and have =

> "suspend()" just then implement whatever that was.

I agree with the above about remote wakeup.

> In other words, I don't see how we could even _have_ some "generic =

> wake-event setup" at this level.

We might need some platform specific hooks here or there to control
wakeup sources from the drivers, I don't know about PeeCees but I
suspect drivers that aren't normally platform specific might need to do
some ACPI crap to get WOL working, and things like that...

> But I haven't thought about it that much.
> =

> > > 	- resume() (and, to clarify my position, let's call it just =

> > > 	  "restore_state()" here, although I don't actually think renaming =

> > > 	  it is worth-while, but _mentally_ you should think of the =

> > > 	  "resume()" function as a state _restore_, not a "resume", =

> > > 	  exactly because it's not actually paired with the suspend, but =

> > > 	  with the "save_state()" function)
> > =

> > At what stage do you restore power to the device?
> =

> I am ambivalent about this.
> =

> In many cases, power _will_ have been enabled earlier (ie the =

> suspend-to-disk case will do it), so I _think_ that the answer is that a =

> robust driver just cannot depend on what the state of the device was u
> before, and that part of "restore_state()" is to also restore the power =

> state at the time of the "save_state()".

Agreed about restoring power. I'm still not totally convinced by the
separation of state saving and actual suspend but I agreed to keep that
disagreement out of this specific email :)

> So we _may_ actually restore power to the device before even calling =

> "resume()", and the driver just doesn't know and shouldn't care. The only =

> _real_ semantics should be that the power state _after_ the restore_state =

> should be the same as it was when save_state was called.
> =

> That seems like the only sane thing we can do, considering the different =

> ways to reach it. =


Yup.

> > How does the handling differ when you are doing runtime (AKA dynamic AK=
A =

> > selective) suspend/resume?
> =

> I think that you should be perfectly able to do a single-device "shut tha=
t =

> device off" with a simple:
> =

> 	save_state(dev);
> 	suspend(dev);
> 	..
> 	restore_state(dev);
> =

> without having any other suspend going on and without iterating over any =

> other devices.
> =

> Of course, whoever does this needs to verify that the device itself is =

> quiescent (or able to wake up itself and force its own "restore_state()").
> =

> I don't see any real issues there, do you?

Ok, I'm jumping in anyway :) Please read it all the way before
responding as I'm trying also to understand your point of view.

I'm still wondering what happens if some "state" changes (because the
system is live and the driver gets request etc etc etc) between
save_state and suspend (which is the one where the driver stops
processing said requests) and the consequences of restoring a state that
wasn't atomically snapshot at the time of the stopping of the request
processing (that is in suspend).

It makes so much more sense to me to have drivers do, in order:

 - stop processing things so that driver gets idle (or mostly)
 - snapshot hw state
 - suspend

in one ago that is atomic from the outside of the driver. It guarantees
consistency in the "state" (for whatever state means here).

Now part of your argument, if I understand things correctly is that
whatever 'state' have changed between save_state() and suspend() doesn't
matter. That's where I think is the root of our disagreement. But it
essentially boils down to what we call state. I tend to consider it
globally as the sum of device and driver states that affect the
processing of requests.

For example, you "save state", then a request gets in that changes an
operational mode (you changed your MAC filters, or your bus speed, the
AP you are associated to, your encryption keys, whatever), then you get
suspend. When you resume, what should you restore to ? The old MAC
filters / bus speed, encryption key, etc... or the "new" ones ? What
about other drivers above you that may do things that depend on the new
settings if you restore the old ones ?

This is _precisely_ where I have a problem and where I think that there
is need for atomicity between the "stop taking requests" and "save
state". which invariably leads to suspend being atomic with that too
since once you stop taking requests, child drivers can't use you to talk
to their devices.

Ben.
