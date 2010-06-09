From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Wed, 9 Jun 2010 16:42:54 -0700
Message-ID: <AANLkTil2JhBgJ27qcTARVj2wVgEltxZKPOc9Ddu4c8yY__37183.9882726364$1276127124$gmane$org@mail.gmail.com>
References: <AANLkTilALyvthzh8rMiDFFP_QTz_o5hxdE8tArMUonpP@mail.gmail.com>
	<Pine.LNX.4.44L0.1006091031030.1728-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006091031030.1728-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

2010/6/9 Alan Stern <stern@rowland.harvard.edu>:
> On Tue, 8 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>
>> >> Wakeup event occurs, and the driver:
>> >> - report wakeup event type A
>> >> - queue event for delivery to user-space
>> >
>> > That's not really two distinct steps. =A0Queuing the event for delivery
>> > to userspace involves waking up any tasks that are waiting to read the
>> > device file; that action (calling wake_up_all() or whatever the driver
>> > does) is how the event gets reported.
>> >
>>
>> If you want to ensure that more than one process see the event it has
>> to be two steps, but it does not affect the race I was trying to
>> describe.
>
> Are you sure about that? =A0If two processes call poll() for the same
> file descriptor, don't both calls return when data becomes available?

Yes if they are both already in the poll call they both return, but if
one process reads the data while the second process is not in the poll
call the second process will not see anything.

> But agreed, it doesn't matter -- especially since I only need one
> process (the power manager) to see the event.

The power may not see the event, the process that reads the event will
always see it. If the power manager is not in the poll call when the
event happens, the process that reads the event can read the event
before the power manager calls poll.

>
>> >> User space wakes up:
>> >> - Calls api to block task freezing for event type A
>> >
>> > Again, that's a confusing way of putting it. =A0The API you're referri=
ng
>> > to is simply the function that activates a suspend blocker. =A0It does
>> > prevent task freezing, but you shouldn't say it prevents freezing for
>> > event type A. =A0More like the other way around: In addition to
>> > preventing freezing, the function tells the power manager that event
>> > type A should no longer be considered active. =A0Thus, in a sense it
>> > _stops_ event type A from preventing freezing.
>> >
>> >> Another wakeup event occurs, and the driver:
>> >> - report wakeup event type A
>
> I think this is where you misunderstood. =A0There is no "report wakeup
> event" as such. =A0All that happens is that data becomes available to be
> read from the input device file. =A0However the power manager process
> isn't polling the device file at this point (because a suspend blocker
> is active), so it doesn't realize that the source has become active
> again.
>

Yes this is not what I though you were suggesting. I thought you were
trying to make sure the power manager sees all wakeup events. If you
are only listening for wakeup events while no suspend blockers are
active, why latch them?

>> >> - queue event for delivery to user-space
>> >
>> > Same as above.
>> >
>> >> User space continues:
>> >> - Read events
>>
>> Sorry, I missed the unblock task freezing step here.
>>
>> >> - Wait for more events
>> >>
>> >> Result: Task are not frozen again.
>> >
>> > Because the suspend blocker was never deactivated. =A0The same thing
>> > happens with wakelocks: If a task activates a wakelock and never
>> > deactivates it, the system won't go into opportunistic suspend again.
>>
>> Yes, but with the sequence of events above task will not be frozen
>> again even if the wake-lock/suspend-blocker/task-freezing-preventer is
>> released.
>
> Yes they will. =A0When the suspend blocker is deactivated, the power
> manager process will realize that there are no active suspend blockers
> and it will think there are no active sources. =A0Thus it will freeze
> processes as usual.
>
>> > Here's how my scheme is meant to work:
>> >
>> > =A0 =A0 =A0 =A0Wakeup event for input device A occurs.
>> >
>> > =A0 =A0 =A0 =A0A's driver adds an entry to the input device queue and
>> > =A0 =A0 =A0 =A0(if the queue was empty) does wake_up_all() on the devi=
ce
>> > =A0 =A0 =A0 =A0file's wait_queue.
>> >
>> > =A0 =A0 =A0 =A0The PM process returns from poll() and sees that device
>> > =A0 =A0 =A0 =A0file A is now readable, so it adds A to its list of act=
ive
>> > =A0 =A0 =A0 =A0sources and unfreezes userspace.
>> >
>> > =A0 =A0 =A0 =A0Some other process sees that device file A is now reada=
ble,
>> > =A0 =A0 =A0 =A0so it activates a suspend blocker and reads events from=
 A.
>> >
>> > =A0 =A0 =A0 =A0When the PM process receives the request to activate the
>> > =A0 =A0 =A0 =A0suspend blocker, it removes A from its list of active
>> > =A0 =A0 =A0 =A0sources. =A0But it doesn't freeze userspace yet, becaus=
e now
>> > =A0 =A0 =A0 =A0a suspend blocker is active.
>>
>> If another event happens at this point don't you put A back on the
>> list? If so, it never gets removed.
>
> No, you don't put A back on the list. =A0Sources get put on the list only
> when the information returned by poll() indicates they have data
> available. =A0The power manager doesn't poll while suspend blockers are
> active.
>
>> > =A0 =A0 =A0 =A0The other process consumes events from A and does other
>> > =A0 =A0 =A0 =A0stuff. =A0Maybe more input data arrives while this is h=
appening
>> > =A0 =A0 =A0 =A0and the process reads it. =A0Eventually the process dec=
ides to
>> > =A0 =A0 =A0 =A0deactivate the suspend blocker, perhaps when no more da=
ta
>> > =A0 =A0 =A0 =A0is available from the device file, perhaps not.
>> >
>> > =A0 =A0 =A0 =A0When the PM process receives the request to deactivate =
the
>> > =A0 =A0 =A0 =A0suspend blocker, it sees that now there are no active
>> > =A0 =A0 =A0 =A0sources and no active suspend blockers. =A0Therefore it
>> > =A0 =A0 =A0 =A0freezes userspace and does a big poll() on all possible
>> > =A0 =A0 =A0 =A0sources. =A0(If there are still events on the input dev=
ice
>> > =A0 =A0 =A0 =A0queue, the poll() returns immediately.)
>> >
>> > =A0 =A0 =A0 =A0Rinse and repeat.
>> >
>> > I don't see any dangerous races there. =A0The scheme can be made a lit=
tle
>> > more efficient by having the PM process do another poll() (with 0
>> > timeout) just before freezing userspace; if the result indicates that a
>> > source is active then the freezing and unfreezing can be skipped.
>
>> > There is no race. =A0The driver reports an event has occurred by making
>> > the data available to be read from the device file, and the event is
>> > processed by reading it from the device file (or at least, that's the
>> > first step in processing the event).
>> >
>>
>> If the driver making data available to be read triggers a wakeup event
>> in the power manager process
>
> It doesn't. =A0Only return from a poll() causes the power manager process
> to think a wakeup event has occurred.
>
>> that has to be cleared by the process
>> reading the events, then you have a race. Since the power manager is
>> selecting/polling on the same file descriptor, I don't see what you
>> gain from linking the wakeup events to suspend blockers.
>
> What I gain is the ability to know when an in-kernel wakelock _could_
> have been released, without actually implementing in-kernel wakelocks.
>
> With real in-kernel wakelocks, the wakelock is released when the input
> queue becomes empty. =A0There's no way for the power manager process to
> know exactly when that happens without modifying the kernel. =A0However
> we can use the activation of the corresponding userspace suspend
> blocker as a proxy. =A0It's nearly as good, and it gets the job done.
>

If you only poll the fd after the last user-space suspend blocker is
released, why do you care when the kernel wakelock could have been
released? It seem the only thing it saves you is an extra poll call
when two wakeup events happen at the same time and one of them is
fully processed and unblocks suspend before the other event handler
blocks suspend. It seems strange to remove your wakeup event from the
list when a specific suspend blocker is acquired when any suspend
blocker will prevent that wakeup event from being added to the list in
the first place.

> If you prefer, an interface could be added whereby a user process tells
> the power manager explicitly that it's going to read data from an
> input device, instead of relying on implicit notification through
> suspend blocker activation. =A0I don't know whether this would be simpler
> or more complex; it depends on the design of your userspace.
>

I don't think there is a need to tie the fds to anything else. If you
poll the fds on the last suspend unblock call, you should get the same
behaviour.

>> If you break
>> this link it think can work, but it does require us to modify all code
>> that reads wakeup events from the kernel to register the file
>> descriptors they get events from.
>
> Yes. =A0I don't know how your user code is structured; if there is a
> fixed correspondence between file descriptors and suspend blockers (the
> same wakeup events are always handled by the same suspend blockers)
> then this will be a simple change -- the file descriptor can be
> registered when the suspend blocker is created.
>
> If the correspondence is more dynamic (different suspend blockers used
> for the same wakeup device at different times, or multiple wakeup
> devices handled by one suspend blocker) then the required changes will
> be more complicated. =A0Not tremendously more.

All input events that can wake the system are handled by one
user-space suspend blocker. Input devices come and go so we would need
to add and remove the fds dynamically.

>
>> It would also require adding
>> poll/select support to android alarm driver,
>
> Yes. =A0Is this a platform-specific driver? =A0(I assume so, since you
> called it the "android alarm driver".) =A0Then poll/select support can be
> added without provoking a lot of objections from legions of kernel
> developers.
>

It is not platform specific, but it is not currently in the mainline
kernel so I would not expect any objections to a change that adding
poll/select support.

>> and any driver that
>> currently uses a wakelock with a timeout would need to notify the user
>> space power manager instead.
>
> Hmm. =A0This is symptomatic of a deficiency in the original wakelock
> implementation -- those timeouts always were arbitrary.
>
> The power manager would indeed have to know about wakeup devices that
> don't need to _keep_ the system awake. =A0Here's one way to cope: During
> those times when no suspend blockers are active but the PM process
> thinks a wakeup source is active, the PM process could poll every few
> seconds to update its list of active sources. =A0At those points it could
> remove wakeup sources that have timed out.
>

For that to work the wakeup events would have to be reported to the
power manager in a reliable way in the first place. Passing the file
descriptor that the app uses to the power manager does not work for
this, since the app could read the event while the power manager was
not in the poll call and the power manager would never see it. Also,
existing apps don't pass their file descriptors to the power manager,
so it has the get the event from somewhere else.

>
> Obviously this proposal would complicate your userspace. =A0Not
> enormously, since most of the work is confined to the power manager,

No, the main problem it that it is not confined to the power manager.
The power manager does not have a list of file descriptors to monitor,
so we have to modify all code that handles wakeup events. This
includes vendor supplied code that we don't have the source for, but,
on some platforms at least, this code relies on kernel wakelocks with
a timeout and could at first be handled the same way we would have to
handle existing apps reading from a socket.

> but somewhat. =A0That's the price to be paid for leaving the kernel
> essentially untouched. =A0Consider the amount of resistance your
> wakelock/suspend-blocker patches have already received; you'll have to
> decide which approach will work out better in the end.
>

The suspend blocker approach is more generally useful since it
supports hardware where suspend is needed. Why this argument is being
ignored is very puzzling.

Your solution is not immediately useful since depends on removing all
periodic kernel timers and adding support to stopping the monotonic
clock for set of processes that are frozen.

Your solution forces the user space interface to be more complicated,
and it creates a new user space power manager that has to start before
any process that handle wakeup events.

-- =

Arve Hj=F8nnev=E5g
