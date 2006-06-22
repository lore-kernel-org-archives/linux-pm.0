From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 21 Jun 2006 19:22:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606211844590.5498@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
	<1150938119.16303.99.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150938119.16303.99.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Thu, 22 Jun 2006, Benjamin Herrenschmidt wrote:
>
> That is, if you absolutely want this state saving thing split from the
> actual suspend (I'm not convinced it will make driver writers life
> easier but let's assume it's fine for now), we still need something with
> the semantics of nforming drivers that from now on and until _after_
> resume (hence my proposed finish() call to be the pending of _that_:

None of the things you list have anything to do with splitting up =

save_state() and the current suspend().

All of them are issues with the _current_ situation. For example:

>  - GFP_KERNEL allocations might block for ages (using them might
> deadlock, though we might want to add a trick to get_free_pages() to
> silently turn them into NOIO)

There's nothing wrong with using GFP_KERNEL at all after "save_state". It =

doesn't start blocking, it doesn't start acting up, it doesn't do anything =

bad at all.

What _is_ a problem, and this has nothing to do with save_state(), is that =

if your "suspend()" routine requires more memory, other devices may =

already have been suspended. That's true _now_, and that's true regardless =

of save_state. It has absolutely nothing to do with save_state itself.

>  - userland will stop responding at any point in time in the future (as
> soon as the backing store of a given process or swap is put to sleep, or
> maybe blocked in an ioctl of a sleeping driver or whatver

Exact same thing. This has _nothing_ to do with save_state(), and is no =

different from what we have now, in exactly the same ways.

And btw, in my suggested setup, you actually _do_ get that notification, =

ie the "freeze()" thing tells you that if you're doing snapshotting etc, =

that's the point where processes have also been put to sleep.

In other words, in my suggested setup, you get _more_ information, and =

there are actually _fewer_ problems. For example, take the GFP_KERNEL =

thing above: it's perfectly fine to do a blocking allocation during =

"save_state()", the way it is _not_ fine to do one during suspend().

And again, none of this is new. save_state() doesn't introduce any new =

problems, and as the example above, it actually makes some problems just =

go away (if the reason you need memory allocation is for state saving, =

then you're in luck).

>  - As a consequences of the above, things like request_firmware cannot
> be used until finish() is called, and thus drivers shall pre-load
> whatever they may need now (that _could_ be considered as state saving
> especially if the driver actually "saves" the firmware from the device
> rather than from the disk) but heh

I'm certainly ok with a final "finish" round, to tell people that all =

devices have been through resume(), and user-space is up and running =

again. No problem. But again, you're trying to fix problems that my =

suggested thing doesn't even introduce.

IOW, this has _nothing_ to do with this discussion, and is a totally =

separate thing.

> I'm still wondering what happens if some "state" changes

By definition, it cannot.

If it's your software request queue, it's not "state" that gets saved. =

It's your memory image.

When the memory image gets restored (whether because it never went away, =

or because you had a snapshot), part of the "resume()" thing is knowing =

that you need to make your device state coherent with that memory image.

You're asking for memory image and device state to be somehow "connected", =

and I think that's insane, idiotic, and impossible to do. =


BY DEFINITION the memory image will change _after_ the "save_state()" has =

taken place. NOTHING WILL EVER CHANGE THAT. =


You're asking for an atomic snapshot that is simply _impossible_ without =

external hardware and software (ie you're asking for the nice kind of =

atomic snapshot that snapshots both driver state, hardware state, and =

memory image atomically, but that only happens in simulations, or when you =

have a eparate VMM that can do the state save for you).

And you keep _harping_ on this issue, and I keep telling you it ain't =

going to happen. I don't know what you want me to say. I've told you =

several times that hardware state is separate from driver state, and =

resume just has to reconcile the two.

It's not even _hard_ to do. You know which parts are your driver state, =

and you know which parts aren't. I don't even understand why you consider =

this a problem, but you keep bringing it up, even though I've told you the =

solution several times.

Let me give you an example, just to clarify.

Let's say that you have a USB host controller. It's got two kinds of =

state: the "driver state", which is basically the in-memory image, and =

which gets snapshotted separately (or, in the case of STR, just remains), =

and the "hardware state" which is basically the rest, and which is =

snapshotted by save_state().

So let's look at examples of those:

 - the in-memory command queues.

   This is NOT something a "save_state()" would try to snapshot. It's =

   memory. It's driver state. And it changes _after_ the "save_state()" =

   happens. Ok? =


 - the BAR pointing to the PCI resources.

   This is _not_ memory state. It's hardware state. And it's _exactly_ =

   what you need to be able to restore at resume time. You can do so any =

   way you want to - you can do it by saving off the BAR values, but you =

   can also decide not to "save" anything at all, but instead re-create it =

   from the PCI information in the "struct pci_dev".

 - IRQ routing information in the PCI config registers or in the MMIO =

   region, or whatever.

   This is _not_ memory state. It's hardware state. And it needs to get =

   saved off, because the firmware won't reset it (or might not set it to =

   the same value, even if it does).

 - The pointer to the "current command" in memory in the MMIO region.

   This is NOT hardware state. This is _driver_ state, and it doesn't =

   matter one whit that it's in a hardware register. You do not save this =

   off, because the current command will quite potentially _change_ in =

   memory, as a result of you doing other things after the save event. For =

   example, "you" may in this case not just be a random USB host =

   controller, you may actually be _the_ host controller that controls the =

   disk connected to the system, and a later "save_state()" by somebody =

   else may need to page something in.

   So resume() needs to reset this register to match the memory state. =

   It's _driver_ state, not hardware state, and as all driver state, it =

   doesn't get saved off by "save_state()", it gets saved off thanks to =

   the fact that we have a memory image that stays in memory.

Was it that least case that confused you? =


I thought the difference between "driver state" and "hardware state" was =

pretty obvious. But maybe it wasn't.

The whole _point_ of doign that separate "save_state()" thing is to allow =

this relaxation of things _not_ being atomic.

As long as things are atomic, we're royally screwed. It seriously limits =

what we can do. In the "atomic" world, we by definition must do everything =

in one pass, and we can not allow any devices to have any hidden =

dependencies on each other at all, and we can never try to simplify =

anything for us.

In contrast, in _my_ world, the following should work:

 - call "save_state()" on the disk controller

 - run dbench, iozone, and play quake for half a day.

 - call "resume()" on the disk controller with the saved-off state from =

   half a day earlier.

and nothing bad happens, becuase the "resume()" event won't resume some =

old insane DMA pointers - it will resume things like maybe the =

_timing_control_ (which hopefully hadn't changed).

IOW, what the above might do is that if the user ran "hdparm" to set some =

state, the "resume()" might undo that, because the saved state was from =

before the hdparm ran.

See? THAT is "hardware state". If it's something that talks about the =

command queues, it is by definition not "hardware state", it's "driver =

state".

(And yes, the above is obviously an insane example. It's _not_ what =

suspend_state and resume() are really meant to do at all. I'm just trying =

to make a point. The point being that save_state() doesn't save state that =

the driver can tell from its own software request queue, which is why it =

doesn't _need_ to be atomic).

			Linus
