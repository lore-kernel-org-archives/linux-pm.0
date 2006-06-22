From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Thu, 22 Jun 2006 10:42:10 +1000
Message-ID: <1150936931.16303.79.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211130350.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606210844460.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606210844460.5498@g5.osdl.org>
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

> So, let me re-iterate my view of how things really _should_ work.
> =

>  - we should have _suspend_ support. This is the "real suspend" thing, ie =

>    support for putting the machine to sleep, and it is totally independen=
t =

>    of any snapshotting capability what-so-ever.

Ok, I've come to agree with that one.

>    The operations for suspend support is literally:
> =

> 	- save_state (or, as Ben prefers, "prepare_to_suspend", but that's =

> 	  a naming issue, and having listened to his arguments, I think he =

> 	  prefers that name because he's confused)

Heh, I don't think so but heh :) Can you define exactly the semantics of
what you consider "save state" to be on a driver level ? I've exposed
what I think they should be (basically making sure everything needed for
both suspend() and resume() is there in memory and ready to go and an
opportunity for drivers to say goodbye to their userland friends). It's
also the perfect place to tell bus drivers to stop discovering new
devices.

> 	- suspend()

Yup.

> 	- resume() (and, to clarify my position, let's call it just =

> 	  "restore_state()" here, although I don't actually think renaming =

> 	  it is worth-while, but _mentally_ you should think of the =

> 	  "resume()" function as a state _restore_, not a "resume", =

> 	  exactly because it's not actually paired with the suspend, but =

> 	  with the "save_state()" function)

Well, that's indeed where I don't quite agree agree :) Regardless of
that disagreement, though, we also need a:
	  - finish()

Which is to be called after everything got resumed and is a chance for
drivers to know that they can talk to userland again, it's back, yeah !
and things like GFP_KERNEL will no longer block, and request_firmware()
is an option again etc...  and for bus drivers to allow new discoveries
and send hotplug events to userland about everything that happened since
prepare().

I really have a hard time seeing how your separate save state and later
suspend works in an environment where we aren't suspending the entire
system but just parts of the device-tree. I keep thinking that saving
the actual device state (if any is to save) has to happen atomically
along with suspend, that it's MUCH simpler that way and that your split
approach will only confuse people and cause gazillion more bugs in
drivers that are already pretty screwed up.

>  - we should have a logically and physically totally independent =

>    "snapshot" support in the device layer, with two operations:
> =

> 	- freeze. Which would normally be a no-op, or a DMA engine =

> 	  (or "receive path") shutdown
> =

> 	- unfreeze. Which would normally be a nop-op, or just resuming the =

> 	  DMA engine or receive path.
> =

> And the thing is, all these operations are really very different =

> operations, and the most important part to realize is that they are fairl=
y =

> INDEPENDENT.

I agree that STD can be handled with those separate operations. I still
think that making sure all "higher layers" stop sending requests down to
drivers that can cause them to do DMA will be hard, but heh :)
(Especially in the case of layered transports where a middle protocol
might do activity with the driver on it's own, independently of what
upper layers do, that sort of thing. I think the network stack will be
the real bitch here but I might just be thinking that because I don't
know it very well above the driver layer). =


> But being independent very much means that you can combine them. So, a =

> normal _real_ suspend would literally be basically this sequence:
> =

> 	for_each_dev()
> 		save_state()
> 	for_each_dev()
> 		suspend();
> 	system suspend()
> 	for_each_dev()
> 		restore_state()

See my objections above.

> note how the normal suspend wouldn't do any freezing at all (at least in =

> theory - in practice it may well want to quiesce the machine, and =

> obviously the driver "suspend()" part will result in it stopping handlign =

> any _requests_). But at least from a conceptual standpoint, there are =

> _zero_ VM games, no frozen processes, no nothing. =


So you said it this time... So for STR, we don't stop processes, we
don't stop "subsystems", we basically do nothing to prevent requests
fromn hitting drivers. That's exactly what happens today at least on
powerpc and that works fine ... provided that drivers correctly block
their processing of requests when suspended. That's all I've been
talking about so far and really I don't see how you can disagree there.
In many case, doing that just boils down to gently asking your subsystem
to stop feeding you (netif_stop_queue or detach, fb_set_suspend, etc...)
and making sure we aren't processing some kind of ioctl atc...

> (Also, _conceptually_ the X handling is all perfectly regular, and is par=
t =

> of the "save_state()" and "restore_state()" loop, but then from a pure =

> implementation standpoint you might make it a separate save/restore aroun=
d =

> the whole thing).

You mean X11 ? Well... the only ways to handle it properly today are
either switching the VC away or having an emulation of /dev/apm_bios (I
do both on powerpc). The later tends to have problems anyway so I
recommend the former, which also has the nice side effect of working
with all sort of other applications that may tap the gfx hardware
without going through X.

> Ok, so what happens in a suspend-to-disk? The basic loop is
> =

> 	for_each_dev()
> 		save_state()
> =

> 	freeze upper layers (shrink VM, user crud, filesystem read-only, =

> 		yadda yadda)
> 	for_each_dev()
> 		freeze()
> 	snapshot
> 	for_each_dev()
> 		unfreeze()
> 	unfreeze at least enough to be able to write
> 	write snapshot to disk
> =

> 	.. shutdown ..
> 	.. reboot ..
> 	restore snapshot from disk
> 	for_each_dev()
> 		restore_state()
> =

> =

> See? The "..shutdown .." part is whatever you make of it, you _can_, if =

> you want to, just make it
> =

> 	for_each_dev()
> 		supend()
> 	shutdown();

It shall probably be suspend with an arguemnt to tell drivers we are
going S4 and not S3... but that's in general the case with shutdown.
shutdown and suspend are very similar on lots of machines (most
handhelds don't have an actual shutdown, drivers are in control of the
power to their device), and if you want things like remote wakeup etc...
you may actually want to put things in D3 state and do a BIOS S4 suspend
rather than shutting down. Or could just be the existind shutdown()
callback with some global thingy telling the few drivers that do care
"we are going S4"... I don't care much at this stage.
 =

> but on other hardware/circumstances it might be a more normal "turn power =

> off" kind of shutdown. All up to you, and TOTALLY INDEPENDENT of the basi=
c =

> operations.
> =

> Also, notice how the only thing hat is _really_ common between the two is =

> not the suspend at all, but the "save_state()" and "restore_state()" =

> loops. THOSE are fundamentally shared, but neither of them actually has =

> really anything at all to do with the suspend itself, with WOL, or =

> anything else.
> =

> (This also clarifies why "save_state()" and "suspend()" are really =

> different operations, and why "prepare_to_suspend()" is actually not a =

> great name - it may not be paired with a suspend at all, if you just shut =

> down the machine: it would be paired with a "shutdown()").

I'll continue spinning it around my head for a while and see if I can
make sense of that split save state that isn't atomic to the acutal
suspend()... =


Ben.
