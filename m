From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Wed, 21 Jun 2006 11:10:06 +1000
Message-ID: <1150852207.12507.30.camel@localhost.localdomain>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606160704.34093.david-b@pacbell.net>
	<Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
	<200606181016.47561.david-b@pacbell.net>
	<Pine.LNX.4.64.0606181040200.5498@g5.osdl.org>
	<1150843494.1901.42.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606201744220.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606201744220.5498@g5.osdl.org>
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

On Tue, 2006-06-20 at 17:49 -0700, Linus Torvalds wrote:

> If the drive queue is quiescent (which isn't even a driver issue), a IDE =

> controller won't touch memory _anyway_. So "freeze" for the IDE driver is =

> 100% a total no-op, apart from perhaps disabling interrupts, "just =

> because". =


But the driver queue isn't quiescent ! Unless you add some new mecanisms
to make sure it is and that all pending asynchronous/tagged/whatever
requests have completed and all data hit the platter before you actually
suspend, which is near to impossible if you keep userland alive (which I
happily do for STR on ppc at least) and still very difficult if you
don't due to various things in the kernel itself that might try to push
things out (think about kmalloc causing swapout, in kernel nfs server,
some IO scheduler deciding to prefetch some stuff after a request that
happened before suspend, etc....)

> Unlike network devices and USB, an IDE controller doesn't do anything on =

> its own anyway. =


Old ones don't, new ones might well do, especially SATA ones with NCQ
like thingies.

> So where do you find that "95% the same" logic? =


The queue blocking and synchronisation logic. That's all there is to it.
The actuall suspend command is a piece of cake once you have that.

> Let's recap: for "freeze"/"unfreeze", there is absolutely zero to do. The =

> disk controller won't be doing any IO on its own anyway.

No but various things in the system will feed the disk queue. I'm
talking about the disk driver. The controller driver has a separate
callback, that thanks to the device tree ordering, is called _after_ the
disk suspend, when indeed all child disks are totally quiescent, and
does nothign much more than putting the chip into D3. That indeed is a
nop on freeze.

> For "suspend"/"resume", you need to put the controller in a sleep state =

> (which, in the case of IDE, means turning it off into D3cold - there is =

> absolutely no reason to even keep it powered), and on resume you need to =

> do a lot of work to wait for the disks etc to actuall come back and =

> re-connect to the disks.

It's unlcear wether the later is not the controller job, it's the disk
driver job I'd say though in the case of IDE, it's actually the
IDE-mid-layer (yuck) job to wait for BUSY to go down on the bus (not a
lot of work though).

> Where's the "95% shared?"
> =

> I tell you where it is: it's in the current _IDIOTIC_ design, which think=
s =

> that the two are the same issue, when they have absolutely _zero_ in =

> common.

I don't know why you mixed resume in the picture. It's the same when
resuming from STR and STD so there is nothing special about it and we
agree. The problem is the suspend process and wether we need:

 - suspend() to have freeze() semantics
 - suspend() to be separate from freeze() and the core call both
(freeze() then suspend())
 - suspend() and freeze() to be completely separate things

Now to make sure we aren't mixing up the semantics here, I'm _NOT_
talking about prepare() and finish() as we discussed earlier. I totally
agree we need these for a lot of scenario, from preloading firmwares in
memory so we can resume, to telling bus drivers to stop adding/removing
devices (that will simplify locking issues with the suspend process
dramatically) etc etc...

My point is that there is this step that is needed for a number of
drivers which consist of making sure they stop actually processing
requests and I call it freeze(). It's tremendously helpful to get a
consistent image when doing STD but it's also very useful for STR to
avoid that something tries to coerce the driver into hitting the
hardware after that hardware has been suspended/powered off.

It's required for block devices to make sure their requrest queue is
properly frozen (with proper ordering vs. barriers and proper wait of
pending tagged commands etc...) since block IO isn't lossy. In fact,
block devices are by far the most complicated problem at this point. The
case of IDE is a nice example of why calling freeze() _then_ suspend()
would be a pain in the ass rather than having one call do both, since
once IDE has stopped it's queue, it can't itself use it to send the
spindown command to the disk, so it would have to do it with
direct-blast-ugly-as-hell PIO to the taskfile. gack... We have a nice
mecanism that works well, why break it ?

Network drivers can just start dropping packets. We agree. So they are
mostly the easy ones, at least for ethernet drivers. It's still
important that xmit() and other downward callbacks are properly
sycnrhonized with suspend() to make sure that nothing tries to touch the
hardware _after_ it's been suspended. So suspend() for a network driver
shall at least call netif_stop_queue(). it needs to do that also to
avoid spurrious timeout callbacks from the network layer.

Now, there are more complex network drivers, like wireless... those ones
often have a whole load of shit to sync with, like work queues doing AP
scrubbing in the background (softmac/80211 stack but it's the same as
the driver in that picture, syncing with those things is driven by the
driver suspend routine). Those thing need to be stopped before the chips
is put down. Guess what ? It's also exactly what freeze() needs to do so
we get a consistent image for STD...

What else ? Sound drivers ? Wow, those are easy. They need pretty much
only to block access from userspace.... heh, provided you don't have
mmap'ed hardware buffer down there... then you have a problem. It is
possible to unmap things behind userspace back (invalidate the PTEs) and
have a subsequent nopage() block until the hardware is back or that sort
of thing, but that mean some infrastructure in alsa we don't have today.
SO there is some synchronisation to be done with driver clients too here
before we put the device down. We might not _need_ it absolutely for a
consistent image with STD, but I'm sure it will make the driver writer
(and the alsa stack) life easier to know that whatever data structures
they have in memeory will be in the exact same state they left it at
freeze/suspend time when they get a resume don't you think ?

I have the feeling that you very much underestimage what drivers have to
do to suspend and resume reliably.

Again, freeze() is essentially "susepnd the driver" while suspend() is
"suspend the device".

The only case where the later does not imply the former is when doing
dynamic power management (suspending a device whne it's not used for
some time for example etc...) which is mostly something local to the
driver. It's something we _have_ been talking about, since it would be
nice when drivers are idle, to be able to suspend the hardware, but also
the bus they sit on, and propagate suspend state dependencies up/down
the tree, but it's a whole different issue and it has its own
complexities.

Ben.
 =
