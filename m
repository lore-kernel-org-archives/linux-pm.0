From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Thu, 22 Jun 2006 13:18:05 +1000
Message-ID: <1150946286.947.50.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
	<1150938119.16303.99.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606211844590.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606211844590.5498@g5.osdl.org>
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


> >  - GFP_KERNEL allocations might block for ages (using them might
> > deadlock, though we might want to add a trick to get_free_pages() to
> > silently turn them into NOIO)
> =

> There's nothing wrong with using GFP_KERNEL at all after "save_state". It =

> doesn't start blocking, it doesn't start acting up, it doesn't do anythin=
g =

> bad at all.

It does. Look at it this way: After all drivers got save_state() called
(or prepare(), whatever  it's named), the core will start calling
suspend() for all drivers in the tree. At this point GFP_KERNEL becomes
blocking (and userland unuseable etc...).

However, from a given random driver point of view (for example your
wireless), it doesn't _know_ when that suspend() loop started. At any
point in time after a driver got called for save_state(), basically, and
before it got it's own suspend(), _other_ drivers (notably the ones
having mapped files or swap on them) might have had their suspend()
already.

So in the situation where it got save_state() already but not suspend()
yet, if it assumes GFP_KERNEL is safe or request_firmware() is useable,
then it might try to do it after the swap device (another device)
already got its suspend() and block... which might put it in a deadlock
situation by the time the actual suspend() arrives (it might hold an
internal semaphore for example, or whatever).

In general, drivers need that prepare() call I described as a way to
know that they can -still- do GFP_KERNEL, talk to userland, etc etc...
from within that prepare() call, but at any time _after_ they return
from it, all those things will stop working because other drivers will
start getting suspended.

> What _is_ a problem, and this has nothing to do with save_state(), is tha=
t =

> if your "suspend()" routine requires more memory, other devices may =

> already have been suspended. That's true _now_, and that's true regardles=
s =

> of save_state. It has absolutely nothing to do with save_state itself.

Nah nah... if a driver needs more memory, it can pre-allocate it in
prepare().. they rarely do tho.

> >  - userland will stop responding at any point in time in the future (as
> > soon as the backing store of a given process or swap is put to sleep, or
> > maybe blocked in an ioctl of a sleeping driver or whatver
> =

> Exact same thing. This has _nothing_ to do with save_state(), and is no =

> different from what we have now, in exactly the same ways.

It has, as per my above explanation. That is, after that first callback
that we want to introduce (save_state, prepare, whatever), all those
things become unsafe because other drivers might have been suspended
already. Which is why I want this prepare() callback. To give a chance
to driver to do all those things (allocate memory if necessary,
synchronize with userland, etc....).

Right now, a lot of wireless drivers will fail on wakeup for example
because they try to request_firmware() in resume(), because their resume
might happen to be called before the one of the main hard disk
where /sbin/hotplug is. (request_firmware() times out).

With my scheme, they can preload that firmware at prepare() time, and
they know from finish() that it's safe again to do all those things at
any time (upon user requests for example).

> And btw, in my suggested setup, you actually _do_ get that notification, =

> ie the "freeze()" thing tells you that if you're doing snapshotting etc, =

> that's the point where processes have also been put to sleep.

I'm talking exclusively about STR at the moment. There is no freeze()
involved and userland stops not because it's been frozen but because it
might have taken a page fault on a suspended device for example.

> In other words, in my suggested setup, you get _more_ information, and =

> there are actually _fewer_ problems. For example, take the GFP_KERNEL =

> thing above: it's perfectly fine to do a blocking allocation during =

> "save_state()", the way it is _not_ fine to do one during suspend().

It is fine yes. It's not fine to do it at any time _after_
save_sate/prepare. That's my point. I think you misuderstood me. I
didn't say all those things are not ok at prepare/save_state, I'm saying
that prepare/save_state has the semantic of informing the driver that
those things are not ok _after_ it returns from that call.
 =

> And again, none of this is new. save_state() doesn't introduce any new =

> problems, and as the example above, it actually makes some problems just =

> go away (if the reason you need memory allocation is for state saving, =

> then you're in luck).

Yes, I want prepare() for that reason, to fix an existing problem. (I
said prepare to highlight the fact that I'm talking about the semantics
I described above, regardless of actual state saving).

> >  - As a consequences of the above, things like request_firmware cannot
> > be used until finish() is called, and thus drivers shall pre-load
> > whatever they may need now (that _could_ be considered as state saving
> > especially if the driver actually "saves" the firmware from the device
> > rather than from the disk) but heh
> =

> I'm certainly ok with a final "finish" round, to tell people that all =

> devices have been through resume(), and user-space is up and running =

> again. No problem. But again, you're trying to fix problems that my =

> suggested thing doesn't even introduce.

I never said your thing was introducing those problems, we are
misunderstanding each other there. I want that prepare() thing and
wanted it for some time now to fix an existing problem :) I still
disagree with the save_state/suspend split for the reason I exposed
later in the email.

> IOW, this has _nothing_ to do with this discussion, and is a totally =

> separate thing.

Sort-of. We have been mixing things too much in this discussion indeed.
It's part of the problem though and a great part of random issues with
today's suspend/resume.

> > I'm still wondering what happens if some "state" changes
> =

> By definition, it cannot.
>
> If it's your software request queue, it's not "state" that gets saved. =

> It's your memory image.

I'm not talking about saving the request queue or anything like that...
look at the examples I gave.

> When the memory image gets restored (whether because it never went away, =

> or because you had a snapshot), part of the "resume()" thing is knowing =

> that you need to make your device state coherent with that memory image.

I was not talking about STD. I'm strictly talking about STR here (and
dynamic PM). I _know_ that with STD, your snapshot mecanism will avoid
part of the problem. I'm STRICTLY saying that for suspend() in the STR
and dynamic PM case, splitting save_state() and suspend() is problematic
for the reasons exposed, that is the state may change.

> You're asking for memory image and device state to be somehow "connected"=
, =

> and I think that's insane, idiotic, and impossible to do. =


I'm not asking for anything special :)

> BY DEFINITION the memory image will change _after_ the "save_state()" has =

> taken place. NOTHING WILL EVER CHANGE THAT. =


Yes. Of course. I'm talking about device state here tho.

> You're asking for an atomic snapshot that is simply _impossible_ without =

> external hardware and software (ie you're asking for the nice kind of =

> atomic snapshot that snapshots both driver state, hardware state, and =

> memory image atomically, but that only happens in simulations, or when yo=
u =

> have a eparate VMM that can do the state save for you).

No. I'm not. I'm asking for something very very simple:

When suspending a device, and later resuming it, you get it back in the
exact state it was when you called suspend. Thus, other devices,
clients, filesytems, whatever sitting on top of yours will get it back
in the expected state. A good example is imagine an encrypted block
storage with keys stored in the controller.

With a split save_state/suspend, you can end up with the scenario where

 1- save state saves the device "state", that includes the keys in the
controller
 2- client above calls you to change the keys
 3- suspend
 4- restore_state

At that point, what keys are you restoring ?

I'm talking about STR here ... Of course, the _OBVIOUS_ answer is, the
new ones. That is, step 3 will _have_ to save those keys (if they aren't
already kept in a memory based driver data structure, if they are, then
it's easy, they just get updated and resume gets them back). That is,
suspend() will have to save some state... =


That is true for any driver that has persistent "state" in the hardware
that influence its mode of operation.

Thus having a split "save_state" and later "suspend" is definitely not a
clear semantic to me and will introduce problems/bugs and driver writers
will get it wrong. What are the chances in the above example that the
driver will save the keys from the HW at suspend() time instead of doing
it only in save_state() ?

Now, I know what you'll answer... it's the responsibility of the user of
that driver to restore the keys it wants on wakeup... hell, go fix
everybody including userland programs (who currently don't even have a
well defined way of being informed of suspend and resume).

I think that is just not realistic. Thus I think that the sane way of
doing that which actually _works_ in real life is to have the state be
saved by the suspend() call.

> And you keep _harping_ on this issue, and I keep telling you it ain't =

> going to happen. I don't know what you want me to say. I've told you =

> several times that hardware state is separate from driver state, and =

> resume just has to reconcile the two.

I've given you a clear example where hardware state has to be saved
after save_state. That's the root of my argument here. That it doesn't
make sense to have a separate save_state, it doesn't work, becasue both
device _and_ hardware state will change before suspend() and resume
won't be able to reconcile them _unless_ the hardware sate is also saved
at suspend().

> It's not even _hard_ to do. You know which parts are your driver state, =

> and you know which parts aren't. I don't even understand why you consider =

> this a problem, but you keep bringing it up, even though I've told you th=
e =

> solution several times.

Then we have a problem defining what a state is.

> Let me give you an example, just to clarify.
> =

> Let's say that you have a USB host controller. It's got two kinds of =

> state: the "driver state", which is basically the in-memory image, and =

> which gets snapshotted separately (or, in the case of STR, just remains), =

> and the "hardware state" which is basically the rest, and which is =

> snapshotted by save_state().

USB is funny because it has shared in-memory state between driver and
controller, and the controller itself doesn't really keep any state in
hardware, so it's in fact the easy example :)

> So let's look at examples of those:
> =

>  - the in-memory command queues.
> =

>    This is NOT something a "save_state()" would try to snapshot. It's =

>    memory. It's driver state. And it changes _after_ the "save_state()" =

>    happens. Ok? =


You mean the urb queue I suppose. Or the actual endpoint and transmit
descriptor lists ? I don't think we can just ditch changes to the
endpoint list but yeah, overall, it's all in the memory image and resume
can just "reconnect" EDs (and cancel all outstanding TDs). But it is
important that the memory image is atomic (that is the ED list is
matching exactly what various driver data structures think it is unless
it can be recreated form those data structures, I don't remember exactly
how we keep track of these in USB). We agree that this doesn't have
anything to do with save_state.

In fact, I'm on purpose limiting that argument to STR so far becasue I
think that's where the main issue is at the moment (STD makes things
easier by freezing everything). USB is not really a problem here.

>  - the BAR pointing to the PCI resources.
> =

>    This is _not_ memory state. It's hardware state. And it's _exactly_ =

>    what you need to be able to restore at resume time. You can do so any =

>    way you want to - you can do it by saving off the BAR values, but you =

>    can also decide not to "save" anything at all, but instead re-create i=
t =

>    from the PCI information in the "struct pci_dev".

Yes, though we don't neccessarily need a special save_state hook for
that... we can save that at any time. In fact, in the STR case, we
probably save that very successfully in suspend() :)

Thing is, save_state happens at any time before the actual suspend with
things still operating in between, thus there is absolutely no saying
how long that state remains valid. In the case of PCI config space, it
could have been saved at driver init time for what matters. If the PCI
config space can change in ways that affect driver operation, then how
do you know it won't change _after_ save_state in a way that is
relevant ? There is nothing like a timing constraint between your save
state and your suspend, thus your save state can happen arbitrarily
early before suspend, thus it becomes irrelevant and could just be
driver init. =


>  - IRQ routing information in the PCI config registers or in the MMIO =

>    region, or whatever.

Yeah, similar to the above.

>    This is _not_ memory state. It's hardware state. And it needs to get =

>    saved off, because the firmware won't reset it (or might not set it to =

>    the same value, even if it does).
> =

>  - The pointer to the "current command" in memory in the MMIO region.
> =

>    This is NOT hardware state. This is _driver_ state, and it doesn't =

>    matter one whit that it's in a hardware register. You do not save this =

>    off, because the current command will quite potentially _change_ in =

>    memory, as a result of you doing other things after the save event. Fo=
r =

>    example, "you" may in this case not just be a random USB host =

>    controller, you may actually be _the_ host controller that controls th=
e =

>    disk connected to the system, and a later "save_state()" by somebody =

>    else may need to page something in.
> =

>    So resume() needs to reset this register to match the memory state. =

>    It's _driver_ state, not hardware state, and as all driver state, it =

>    doesn't get saved off by "save_state()", it gets saved off thanks to =

>    the fact that we have a memory image that stays in memory.
> =

> Was it that least case that confused you? =


No. You picked an example that doesn't have problems so that was easy :)
What about devices where actual funcional state _is_ stored in the
hardware. Encryptions keys are an example. But also things like link
speed or link type, filters, whatever... =


In fact, you can separate state in 3 maybe, if that can clarify things:

 - Static state. The example you gave of PCI things. This is essentially
state that doesn't change over time, thus could well be saved at driver
init. I don't see the need for a separate save_state() callback for that

 - Volatile state. That is your example of command pointer. Can be
reconstructed and doesn't need to be saved.

 - That leaves us with the meat that you have avoided so far in your
examples: dynamic (not volatile) state in the hardware. I gave a few
examples, I'm sure we can find many more. There are several ways of
approaching that: One is to say it can always be reconstructed which
seems to have been your initial approach at the start of this
discussion. That means the driver needs to always keep a running memory
image of what it puts in the hardware. Fine with me. But in that case,
there is no need for a "save_state". Or it could be saved. But in that
case, what happens if clients change that state after it's been saved ?
You end up restoring an obsolete one... UNLESS the saving is atomic with
the blocking of client requests.

See ? Or am I still not clear enough ?

> I thought the difference between "driver state" and "hardware state" was =

> pretty obvious. But maybe it wasn't.

It is in your examples. Not in all real life cases though.

> The whole _point_ of doign that separate "save_state()" thing is to allow =

> this relaxation of things _not_ being atomic.

But if save_state() can happen any time before suspend(), it doesn't get
_linked_ to it by any locking or blocking of requests or anything like
that, then it essentially happens arbitrarily early before suspend(). In
which case it totally loses any meaning sinec it could just be done at
init time. =


> As long as things are atomic, we're royally screwed. It seriously limits =

> what we can do. In the "atomic" world, we by definition must do everythin=
g =

> in one pass, and we can not allow any devices to have any hidden =

> dependencies on each other at all, and we can never try to simplify =

> anything for us.
> =

> In contrast, in _my_ world, the following should work:
> =

>  - call "save_state()" on the disk controller
> =

>  - run dbench, iozone, and play quake for half a day.
> =

>  - call "resume()" on the disk controller with the saved-off state from =

>    half a day earlier.
> =

> and nothing bad happens, becuase the "resume()" event won't resume some =

> old insane DMA pointers - it will resume things like maybe the =

> _timing_control_ (which hopefully hadn't changed).

hopefully ? THAT EXACTLY WHERE THE PROBLEM IS !!! timings may have
changed. link speed may have changed. IDE is an easy example because
they _usually_ don't change, but they _can_ (and changing them needs
interaction between the disk and the controller, thus if the controller
restore the wrong ones the disk is toast). And IDE is just an easy
example. I gave a few others. =


> IOW, what the above might do is that if the user ran "hdparm" to set some =

> state, the "resume()" might undo that, because the saved state was from =

> before the hdparm ran.

Or the IDE layer may have changed the timing due to errors, or a
rotating keys mecanism might have switched to a new set of keys because
the old ones just expired, etc etc... and you just retsored the wrong
one, you are toast.

> See? THAT is "hardware state". If it's something that talks about the =

> command queues, it is by definition not "hardware state", it's "driver =

> state".

Yes, it's hardware state, and it needs to be saved, and it needs to be
restores _EXACTLY_ as it was at the time of suspend(), not some the sate
it was at some arbitary time before suspend when you called that
save_state() thing.

> (And yes, the above is obviously an insane example. It's _not_ what =

> suspend_state and resume() are really meant to do at all. I'm just trying =

> to make a point. The point being that save_state() doesn't save state tha=
t =

> the driver can tell from its own software request queue, which is why it =

> doesn't _need_ to be atomic).

I think you missed the point :)

Ben.
