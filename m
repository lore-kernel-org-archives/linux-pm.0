From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 21 Jun 2006 10:04:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Wed, 21 Jun 2006, Alan Stern wrote:
> > =

> >  - we should have _suspend_ support. This is the "real suspend" thing, =
ie =

> >    support for putting the machine to sleep, and it is totally independ=
ent =

> >    of any snapshotting capability what-so-ever.
> =

> This is what you want to happen during STR, right?

Right. Although I can see a S4-kind of suspend being a "suspend" too, just =

not saving memory state. You can certainly see the memory state as being =

"independent" of the actual device suspend activity.

> > 	- save_state (or, as Ben prefers, "prepare_to_suspend", but that's =

> > 	  a naming issue, and having listened to his arguments, I think he =

> > 	  prefers that name because he's confused)
> =

> How about "prepare_to_reinitialize"?  After all, there's no need to save =

> anything or worry about suspending if you aren't going to restart the =

> system later.

Well, naming this op seems to be really hard. In the end, I don't really =

care.

What I want is really to haev modular, independent calls, that tell driver =

writers _exactly_ what is going on, and why they should do so. =


(And, btw, "tell driver writers" is only indirectly about having the =

documentation. Much more important than documentation is just clear and =

unambiguous interfaces. Right now, "suspend()" is _not_ that. It's not =

clear and unambiguous at all, it's a muddy pit-hole of mixing different =

things - you're supposed to do all of "freeze", "save state" and =

"suspend")

To me, "prepare_to_reinitialize" is just very cumbersome, but I really =

don't care about the naming as much as I care about the op doing just =

_one_ thing, and doing it well.

It's the whole UNIX philosophy again. You can have the Windows kind of =

"open()" system call that has 8 arguments, and can do a "open with stat, =

but only on Wednesdays, and only when I said 'Simon Says' before".

Or you can have the UNIX kind of "open()", which is one system call, does =

one thing only, and if you want the "stat()" of the opened file, you do =

that separately.

You do NOT mix operations in one super-duper-operation.

And naming is somewhat secondary (although not totally irrelevant, of =

course - you can certainly confuse people with bad naming even if the =

design is otherwise perfect).

> > 	- suspend()
> =

> Presumably remote wakeup (WOL, whatever) gets enabled as part of the =

> suspend().

That's what I'd expect, yes. Clearly _managing_ that whole thing is a =

totally separate issue, but right now we don't even do that within the =

actual device infrastructure, but on a device-by-device basis (ie ethtool =

for networking and perhaps the RTC tools for timed wakeups?).

In fact, exactly because different devices have so fundamentally different =

notions of what a wakup event is, I think that's the only really workable =

option: have a device-specific setup phase long before, and have =

"suspend()" just then implement whatever that was.

In other words, I don't see how we could even _have_ some "generic =

wake-event setup" at this level.

But I haven't thought about it that much.

> > 	- resume() (and, to clarify my position, let's call it just =

> > 	  "restore_state()" here, although I don't actually think renaming =

> > 	  it is worth-while, but _mentally_ you should think of the =

> > 	  "resume()" function as a state _restore_, not a "resume", =

> > 	  exactly because it's not actually paired with the suspend, but =

> > 	  with the "save_state()" function)
> =

> At what stage do you restore power to the device?

I am ambivalent about this.

In many cases, power _will_ have been enabled earlier (ie the =

suspend-to-disk case will do it), so I _think_ that the answer is that a =

robust driver just cannot depend on what the state of the device was =

before, and that part of "restore_state()" is to also restore the power =

state at the time of the "save_state()".

So we _may_ actually restore power to the device before even calling =

"resume()", and the driver just doesn't know and shouldn't care. The only =

_real_ semantics should be that the power state _after_ the restore_state =

should be the same as it was when save_state was called.

That seems like the only sane thing we can do, considering the different =

ways to reach it. =


> How does the handling differ when you are doing runtime (AKA dynamic AKA =

> selective) suspend/resume?

I think that you should be perfectly able to do a single-device "shut that =

device off" with a simple:

	save_state(dev);
	suspend(dev);
	..
	restore_state(dev);

without having any other suspend going on and without iterating over any =

other devices.

Of course, whoever does this needs to verify that the device itself is =

quiescent (or able to wake up itself and force its own "restore_state()").

I don't see any real issues there, do you?

(That "needs to verify" migth of course be a big issue, but on the other =

hand, I don't think anybody really disagrees about this, do they?)

> > 	unfreeze at least enough to be able to write
> > 	write snapshot to disk
> =

> And somewhere in here you have to enable remote wakeup.

No, that would be part of the next phase:

> > 	.. shutdown ..

(which might be a suspend cycle).

> > 	.. reboot ..
> > 	restore snapshot from disk
> =

> Here you left out two steps.  First, drivers have to get their devices
> back into working condition.  (They might be exactly as shutdown() left
> them, or they might have been reset by the firmware.)  Second, you need to
> unfreeze all the upper layers.
> =

> > 	for_each_dev()
> > 		restore_state()

The "restore_state()" will get the devices back to working condition (by =

definition, or the "save/restore" is clearly buggy). So there's no need to =

unfreeze devices (and that would, in fact, be a bug, since you'd unfreeze =

them into some random state if you hadn't done the restore_state).

But yes, we need to unfreeze the upper layers, since the snapshot got done =

with them frozen.

> My point (which you seem to have forgotten) was that the "enable remote =

> wakeup" step is also common between the two.

I didn't forget anything. You just didn't understand. I said:

> > See? The "..shutdown .." part is whatever you make of it, you _can_, if =

> > you want to, just make it
> > =

> > 	for_each_dev()
> > 		supend()
> > 	shutdown();

Where that "suspend() each device" would do all the same WOL that it does =

when it goes to _real_ suspend.

But the point is, THAT'S ALL INDEPENDENT. It's not necessarily what you do =

at all. It's very possible that you do NOT do this, and that you just shut =

down.

In other words, "save_state(dev)" _may_ be followed by a "suspend(dev)" =

regardless of whether you go to STR or to STD, BUT IT MIGHT NOT.

It's perfectly valid to _not_ call "suspend(dev)" as part of STD too.

That's very much why I had that

	"..shutdown.."

part. Exactly because there are anternative ways of doing shutdown. It =

might be "shut down all devices and power off NOW" (removing all power), =

and it migt be "suspend all devices and go to S4". Both are totally valid.

		Linus
