From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Tue, 8 Jun 2010 18:48:32 -0700
Message-ID: <AANLkTilALyvthzh8rMiDFFP_QTz_o5hxdE8tArMUonpP__13972.1692693003$1276048262$gmane$org@mail.gmail.com>
References: <AANLkTimcDzHBmgqPkCHB6pW2RZivFhmb_zk68T0I3NJY@mail.gmail.com>
	<Pine.LNX.4.44L0.1006080947050.1625-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006080947050.1625-100000@iolanthe.rowland.org>
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

2010/6/8 Alan Stern <stern@rowland.harvard.edu>:
> On Mon, 7 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>
>> The patch that modifies evdev (posted in this patchset) uses an ioctl
>> to enable the suspend blocker. Not all input devices are used for
>> wakeup events and those don't need to block suspend.
>
> But you do have a 1-1 correspondence, right? =A0That is, the input
> devices that are used for wakeup events are exactly the ones that block
> suspend?
>

Yes.

>
>> If you read an event that occurred after you blocked the task
>> freezing, then tasks will never get frozen again (until more events
>> occur). I think my original description was less confusing, but it
>> seems you got completely distracted by my use of block and unblock
>> suspend when referring to the user space api.
>
> I still find your wording a little confusing. =A0Task freezing can be
> prevented (a more accurate term than "blocked") by two kinds of things:
> a suspend blocker or an "active" wakeup source. =A0I'm not sure which
> kind you mean here.

I mean prevented by a user space suspend blocker.

>
>> It has an indirect connection. You report a wakeup event when it
>> occurs, but clear it when user space calls an api before reading the
>> event. So:
>
> Yes, that's right.
>
>> Wakeup event occurs, and the driver:
>> - report wakeup event type A
>> - queue event for delivery to user-space
>
> That's not really two distinct steps. =A0Queuing the event for delivery
> to userspace involves waking up any tasks that are waiting to read the
> device file; that action (calling wake_up_all() or whatever the driver
> does) is how the event gets reported.
>

If you want to ensure that more than one process see the event it has
to be two steps, but it does not affect the race I was trying to
describe.

>> User space wakes up:
>> - Calls api to block task freezing for event type A
>
> Again, that's a confusing way of putting it. =A0The API you're referring
> to is simply the function that activates a suspend blocker. =A0It does
> prevent task freezing, but you shouldn't say it prevents freezing for
> event type A. =A0More like the other way around: In addition to
> preventing freezing, the function tells the power manager that event
> type A should no longer be considered active. =A0Thus, in a sense it
> _stops_ event type A from preventing freezing.
>
>> Another wakeup event occurs, and the driver:
>> - report wakeup event type A
>> - queue event for delivery to user-space
>
> Same as above.
>
>> User space continues:
>> - Read events

Sorry, I missed the unblock task freezing step here.

>> - Wait for more events
>>
>> Result: Task are not frozen again.
>
> Because the suspend blocker was never deactivated. =A0The same thing
> happens with wakelocks: If a task activates a wakelock and never
> deactivates it, the system won't go into opportunistic suspend again.

Yes, but with the sequence of events above task will not be frozen
again even if the wake-lock/suspend-blocker/task-freezing-preventer is
released.

>
> Here's how my scheme is meant to work:
>
> =A0 =A0 =A0 =A0Wakeup event for input device A occurs.
>
> =A0 =A0 =A0 =A0A's driver adds an entry to the input device queue and
> =A0 =A0 =A0 =A0(if the queue was empty) does wake_up_all() on the device
> =A0 =A0 =A0 =A0file's wait_queue.
>
> =A0 =A0 =A0 =A0The PM process returns from poll() and sees that device
> =A0 =A0 =A0 =A0file A is now readable, so it adds A to its list of active
> =A0 =A0 =A0 =A0sources and unfreezes userspace.
>
> =A0 =A0 =A0 =A0Some other process sees that device file A is now readable,
> =A0 =A0 =A0 =A0so it activates a suspend blocker and reads events from A.
>
> =A0 =A0 =A0 =A0When the PM process receives the request to activate the
> =A0 =A0 =A0 =A0suspend blocker, it removes A from its list of active
> =A0 =A0 =A0 =A0sources. =A0But it doesn't freeze userspace yet, because n=
ow
> =A0 =A0 =A0 =A0a suspend blocker is active.

If another event happens at this point don't you put A back on the
list? If so, it never gets removed.

>
> =A0 =A0 =A0 =A0The other process consumes events from A and does other
> =A0 =A0 =A0 =A0stuff. =A0Maybe more input data arrives while this is happ=
ening
> =A0 =A0 =A0 =A0and the process reads it. =A0Eventually the process decide=
s to
> =A0 =A0 =A0 =A0deactivate the suspend blocker, perhaps when no more data
> =A0 =A0 =A0 =A0is available from the device file, perhaps not.
>
> =A0 =A0 =A0 =A0When the PM process receives the request to deactivate the
> =A0 =A0 =A0 =A0suspend blocker, it sees that now there are no active
> =A0 =A0 =A0 =A0sources and no active suspend blockers. =A0Therefore it
> =A0 =A0 =A0 =A0freezes userspace and does a big poll() on all possible
> =A0 =A0 =A0 =A0sources. =A0(If there are still events on the input device
> =A0 =A0 =A0 =A0queue, the poll() returns immediately.)
>
> =A0 =A0 =A0 =A0Rinse and repeat.
>
> I don't see any dangerous races there. =A0The scheme can be made a little
> more efficient by having the PM process do another poll() (with 0
> timeout) just before freezing userspace; if the result indicates that a
> source is active then the freezing and unfreezing can be skipped.
>
> The big assumption here is that a user process never consumes wakeup
> events without first activating a suspend blocker. =A0This seems like a
> reasonable assumption, but we can work around it if necessary.
>
>> >> It seems you would need a way to pass the wakeup source id to use from
>> >> user space to the driver and for this to work
>> >
>> > No, nothing needs to be passed from userspace to the kernel. =A0However
>> > the source ID (or a set of source IDs) does need to be passed to the
>> > power manager process, probably when the suspend blocker is created.
>> >
>>
>> Then the source id need to be passed from the kernel to user-space.
>
> A source ID is a file descriptor. =A0File descriptors are passed from the
> kernel to userspace whenever a file is opened; I can't deny it. =A0And
> they are passed back to the kernel as part of the read() and poll()
> system calls. =A0Is that what you mean?
>
>> No, that is not the unclear part. What is unclear to me is where the
>> source IDs come from. Are they static and hardcoded in the driver and
>> user-space, or are they passed between the driver and user-space
>> client?
>
> They are not static; they are file descriptors. =A0I guess this should
> have been made more clear originally, but this is still pretty new to
> me too.
>
>> I don't understand how you are planning to ensure that the driver and
>> user-space code that consumes the real event use the same source id.
>
> How can it be otherwise? =A0The userspace code consumes the event by
> reading from the device file. =A0In order to do so, it has to use the
> same file descriptor it received when it opened the device file
> originally.
>
>> The biggest problem I have with it though is that you have created a
>> new race condition between reporting that a wakeup event has occurred
>> and processing of the real event.
>
> There is no race. =A0The driver reports an event has occurred by making
> the data available to be read from the device file, and the event is
> processed by reading it from the device file (or at least, that's the
> first step in processing the event).
>

If the driver making data available to be read triggers a wakeup event
in the power manager process that has to be cleared by the process
reading the events, then you have a race. Since the power manager is
selecting/polling on the same file descriptor, I don't see what you
gain from linking the wakeup events to suspend blockers. If you break
this link it think can work, but it does require us to modify all code
that reads wakeup events from the kernel to register the file
descriptors they get events from. It would also require adding
poll/select support to android alarm driver, and any driver that
currently uses a wakelock with a timeout would need to notify the user
space power manager instead.

>
> There's one other thing worth mentioning. =A0All along I've been talking
> about a power manager process that coordinates all these activities.
> In theory there's no reason that process couldn't be implemented as a
> kernel thread. =A0This would improve efficiency by reducing the number of
> context switches, and it would change IPC calls into plain system
> calls.
>
> If you did implement it that way, it could be done as a standalone
> kernel module, totally noninvasive. =A0It would not need to be part of
> the vanilla kernel and nobody would object to it.
>
> Alan Stern
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



-- =

Arve Hj=F8nnev=E5g
