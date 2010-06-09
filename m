From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suspend blockers & Android integration
Date: Wed, 9 Jun 2010 11:29:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006091031030.1728-100000__46297.409447334$1276097481$gmane$org@iolanthe.rowland.org>
References: <AANLkTilALyvthzh8rMiDFFP_QTz_o5hxdE8tArMUonpP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTilALyvthzh8rMiDFFP_QTz_o5hxdE8tArMUonpP@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 8 Jun 2010, Arve Hj=F8nnev=E5g wrote:

> >> Wakeup event occurs, and the driver:
> >> - report wakeup event type A
> >> - queue event for delivery to user-space
> >
> > That's not really two distinct steps. =A0Queuing the event for delivery
> > to userspace involves waking up any tasks that are waiting to read the
> > device file; that action (calling wake_up_all() or whatever the driver
> > does) is how the event gets reported.
> >
> =

> If you want to ensure that more than one process see the event it has
> to be two steps, but it does not affect the race I was trying to
> describe.

Are you sure about that?  If two processes call poll() for the same
file descriptor, don't both calls return when data becomes available?  =

But agreed, it doesn't matter -- especially since I only need one =

process (the power manager) to see the event.

> >> User space wakes up:
> >> - Calls api to block task freezing for event type A
> >
> > Again, that's a confusing way of putting it. =A0The API you're referring
> > to is simply the function that activates a suspend blocker. =A0It does
> > prevent task freezing, but you shouldn't say it prevents freezing for
> > event type A. =A0More like the other way around: In addition to
> > preventing freezing, the function tells the power manager that event
> > type A should no longer be considered active. =A0Thus, in a sense it
> > _stops_ event type A from preventing freezing.
> >
> >> Another wakeup event occurs, and the driver:
> >> - report wakeup event type A

I think this is where you misunderstood.  There is no "report wakeup
event" as such.  All that happens is that data becomes available to be
read from the input device file.  However the power manager process
isn't polling the device file at this point (because a suspend blocker
is active), so it doesn't realize that the source has become active
again.

> >> - queue event for delivery to user-space
> >
> > Same as above.
> >
> >> User space continues:
> >> - Read events
> =

> Sorry, I missed the unblock task freezing step here.
> =

> >> - Wait for more events
> >>
> >> Result: Task are not frozen again.
> >
> > Because the suspend blocker was never deactivated. =A0The same thing
> > happens with wakelocks: If a task activates a wakelock and never
> > deactivates it, the system won't go into opportunistic suspend again.
> =

> Yes, but with the sequence of events above task will not be frozen
> again even if the wake-lock/suspend-blocker/task-freezing-preventer is
> released.

Yes they will.  When the suspend blocker is deactivated, the power =

manager process will realize that there are no active suspend blockers =

and it will think there are no active sources.  Thus it will freeze =

processes as usual.

> > Here's how my scheme is meant to work:
> >
> > =A0 =A0 =A0 =A0Wakeup event for input device A occurs.
> >
> > =A0 =A0 =A0 =A0A's driver adds an entry to the input device queue and
> > =A0 =A0 =A0 =A0(if the queue was empty) does wake_up_all() on the device
> > =A0 =A0 =A0 =A0file's wait_queue.
> >
> > =A0 =A0 =A0 =A0The PM process returns from poll() and sees that device
> > =A0 =A0 =A0 =A0file A is now readable, so it adds A to its list of acti=
ve
> > =A0 =A0 =A0 =A0sources and unfreezes userspace.
> >
> > =A0 =A0 =A0 =A0Some other process sees that device file A is now readab=
le,
> > =A0 =A0 =A0 =A0so it activates a suspend blocker and reads events from =
A.
> >
> > =A0 =A0 =A0 =A0When the PM process receives the request to activate the
> > =A0 =A0 =A0 =A0suspend blocker, it removes A from its list of active
> > =A0 =A0 =A0 =A0sources. =A0But it doesn't freeze userspace yet, because=
 now
> > =A0 =A0 =A0 =A0a suspend blocker is active.
> =

> If another event happens at this point don't you put A back on the
> list? If so, it never gets removed.

No, you don't put A back on the list.  Sources get put on the list only
when the information returned by poll() indicates they have data
available.  The power manager doesn't poll while suspend blockers are =

active.

> > =A0 =A0 =A0 =A0The other process consumes events from A and does other
> > =A0 =A0 =A0 =A0stuff. =A0Maybe more input data arrives while this is ha=
ppening
> > =A0 =A0 =A0 =A0and the process reads it. =A0Eventually the process deci=
des to
> > =A0 =A0 =A0 =A0deactivate the suspend blocker, perhaps when no more data
> > =A0 =A0 =A0 =A0is available from the device file, perhaps not.
> >
> > =A0 =A0 =A0 =A0When the PM process receives the request to deactivate t=
he
> > =A0 =A0 =A0 =A0suspend blocker, it sees that now there are no active
> > =A0 =A0 =A0 =A0sources and no active suspend blockers. =A0Therefore it
> > =A0 =A0 =A0 =A0freezes userspace and does a big poll() on all possible
> > =A0 =A0 =A0 =A0sources. =A0(If there are still events on the input devi=
ce
> > =A0 =A0 =A0 =A0queue, the poll() returns immediately.)
> >
> > =A0 =A0 =A0 =A0Rinse and repeat.
> >
> > I don't see any dangerous races there. =A0The scheme can be made a litt=
le
> > more efficient by having the PM process do another poll() (with 0
> > timeout) just before freezing userspace; if the result indicates that a
> > source is active then the freezing and unfreezing can be skipped.

> > There is no race. =A0The driver reports an event has occurred by making
> > the data available to be read from the device file, and the event is
> > processed by reading it from the device file (or at least, that's the
> > first step in processing the event).
> >
> =

> If the driver making data available to be read triggers a wakeup event
> in the power manager process

It doesn't.  Only return from a poll() causes the power manager process =

to think a wakeup event has occurred.

> that has to be cleared by the process
> reading the events, then you have a race. Since the power manager is
> selecting/polling on the same file descriptor, I don't see what you
> gain from linking the wakeup events to suspend blockers.

What I gain is the ability to know when an in-kernel wakelock _could_ =

have been released, without actually implementing in-kernel wakelocks.

With real in-kernel wakelocks, the wakelock is released when the input =

queue becomes empty.  There's no way for the power manager process to =

know exactly when that happens without modifying the kernel.  However =

we can use the activation of the corresponding userspace suspend =

blocker as a proxy.  It's nearly as good, and it gets the job done.

If you prefer, an interface could be added whereby a user process tells =

the power manager explicitly that it's going to read data from an =

input device, instead of relying on implicit notification through =

suspend blocker activation.  I don't know whether this would be simpler =

or more complex; it depends on the design of your userspace.

> If you break
> this link it think can work, but it does require us to modify all code
> that reads wakeup events from the kernel to register the file
> descriptors they get events from.

Yes.  I don't know how your user code is structured; if there is a
fixed correspondence between file descriptors and suspend blockers (the
same wakeup events are always handled by the same suspend blockers)
then this will be a simple change -- the file descriptor can be =

registered when the suspend blocker is created.

If the correspondence is more dynamic (different suspend blockers used =

for the same wakeup device at different times, or multiple wakeup =

devices handled by one suspend blocker) then the required changes will =

be more complicated.  Not tremendously more.

> It would also require adding
> poll/select support to android alarm driver,

Yes.  Is this a platform-specific driver?  (I assume so, since you =

called it the "android alarm driver".)  Then poll/select support can be =

added without provoking a lot of objections from legions of kernel =

developers.

> and any driver that
> currently uses a wakelock with a timeout would need to notify the user
> space power manager instead.

Hmm.  This is symptomatic of a deficiency in the original wakelock =

implementation -- those timeouts always were arbitrary.

The power manager would indeed have to know about wakeup devices that =

don't need to _keep_ the system awake.  Here's one way to cope: During =

those times when no suspend blockers are active but the PM process =

thinks a wakeup source is active, the PM process could poll every few =

seconds to update its list of active sources.  At those points it could =

remove wakeup sources that have timed out.


Obviously this proposal would complicate your userspace.  Not
enormously, since most of the work is confined to the power manager,
but somewhat.  That's the price to be paid for leaving the kernel
essentially untouched.  Consider the amount of resistance your
wakelock/suspend-blocker patches have already received; you'll have to
decide which approach will work out better in the end.

Alan Stern
