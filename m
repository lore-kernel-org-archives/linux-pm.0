From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: Wakeup-events implementation
Date: Fri, 13 Aug 2010 21:59:26 -0700
Message-ID: <AANLkTin43EBo-v0dxGitqtCCU1K8W+mRzwG+oE94orXi@mail.gmail.com>
References: <AANLkTimgJUAW9TU37XE4BqYWf3yCWvg-vgk3E0YLqcm9@mail.gmail.com>
	<Pine.LNX.4.44L0.1008131122400.12397-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1008131122400.12397-100000@netrider.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2010/8/13 Alan Stern <stern@rowland.harvard.edu>:
> Since this area of the discussion has strayed away from the path of
> Paul McKenney's original summary, I'm starting a new email thread and
> drastically cutting the CC list.
>
> On Sun, 8 Aug 2010, Arve Hj=F8nnev=E5g wrote:
>
>> > Maybe. =A0There aren't enough examples coded up yet to be sure. =A0At =
this
>> > point we could easily make the device argument required instead of
>> > optional, and we could add a device argument to pm_relax.
>> >
>> I think that would be a good start. I can create dummy devices for now
>> where I don't already have a device.
>
> Rafael and I spent some time discussing all this during LinuxCon.
> Combining what he thought with my own ideas led us to decide that the
> wakeup information should be stored in a separate structure, not in
> dev_pm_info. =A0These structures will be allocated dynamically when a
> device is enabled for remote wakeup (and presumably deallocated if a
> device is disabled for remote wakeup). =A0A pointer to the new structure
> will be stored in dev_pm_info. =A0We expect that most devices won't need
> a wakeup structure, because most devices aren't wakeup sources.
>
> This new structure (as yet unnamed) will be a lot like your
> suspend_blocker structure, but with some differences. =A0It won't need a
> name, since the device already has a name.

A name is still useful if we allocate multiple handles per device (see
below for why one handle per device is not enough).

>=A0It won't have a timer, if
> we can get away with leaving one out.

The suspend_blocker structure does not have a timer, it has a timeout.
This was intentional, since it avoids unnecessary timers from firing
but it also means it takes a lot less space than the stats. We do need
the timeout in the structure to support some of our drivers since they
mix wake_lock_timeout and wake_unlock.

>=A0But it will optionally contain
> various counters that can be used for statistics reporting and
> debugging. =A0The API for exporting these fields to userspace has not yet
> been decided upon.
>
> The device argument will become mandatory for pm_stay_awake, pm_relax,
> and pm_wakeup_event, so that the counter fields can be updated
> properly.
>
I think this is a step in the right direction, but it is not enough to
support mixing timeouts and pm_relax in all the drivers.

>> > In the scheme we're talking about, the suspend-blocking interface for
>> > uesrspace would be located entirely in the power manager. =A0Hence it
>> > could maintain all the necessary statistics, without involving the
>> > kernel. =A0During early stages of system startup, before the power
>> > manager is running, lower-level services would not be able to block
>> > suspend. =A0This wouldn't matter because at those times the system sim=
ply
>> > would not ever suspend -- because suspends have to be initiated by the
>> > power manager.
>>
>> If we do that, a low level process could try to block suspend while
>> the power manager is not running. Then the power manager could start
>> and decide to suspend not knowing that a low level process wanted to
>> block suspend.
>
> There's a simple solution: Put all this in a _new_, low-level power
> manager program that can be started very early during boot-up (before
> any of the other low-level services that need to block suspend). =A0Then
> all the other programs would communicate their suspend-blocker
> requirements to this program instead of to the kernel.
>

Maintaining an out of mainline driver to export allow user space to
block suspend seems like a more appealing solution than adding another
process for everyone to depend on. Having a user space interface to
block suspend in the mainline kernel would still be valuable, though.
Like I mentioned in another message, this would allow some low level
services, like the user-space battery monitor some devices have, to
not be android specific.

> You expressed concern about the new power manager deadlocking. =A0This
> can be avoided by designing the program properly. =A0It should run in two
> threads. =A0Thread 1 will handle IPC, keeping track of userspace
> suspend-blocker requests, their statistics, and so on. =A0Thread 2 will
> manage the PM interface to the kernel, and it will execute the
> following simple loop:
>
> =A0 =A0 =A0 =A0for (;;) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0read /sys/power/wakeup_count =A0 =A0/* blo=
cking read */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (there are any active userspace suspend=
 blockers) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wait until they are all de=
activated
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (write to /sys/power/wa=
keup_count succeeds)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write "mem=
" to /sys/power/state
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> I think this will resolve the problem you were worried about.
>

I know how to avoid the deadlock. My point was that adding the code in
the drivers to support the overlapping wakelock model of handling
wakeup events, means that a single threaded power manager that did not
deadlock before now could deadlock.

>> >> >> I don't know if they are all kernel-internal but these drivers app=
ear
>> >> >> to use timeouts and active cancellation on the same wakelock:
>> >> >> wifi driver, mmc core, alarm driver, evdev (suspend blocker version
>> >> >> removes the timeout).
>> >
>> > Roughly speaking, what do the timings work out to be? =A0That is, how
>> > long are the timeouts for these wakelocks, how long does it usually
>> > take for one of them to be actively cancelled, and what percentage of
>> > them end up timing out?
>> >
>> The evdev timeout is a few seconds, and never timeout unless user
>> space is misbehaving. I don't know how the wifi and mmc wakelocks are
>> used. The alarm driver uses a 1 or 2 second timeout to abort suspend
>> when an alarm is set to close to program an rtc alarm. I think this
>> one is cancelled when the alarm triggers, and the timeout only handles
>> the case where the client cancelled the alarm before it trigger, but I
>> don't remember for sure.
>
> Evdev turns out to be tricky for a couple of reasons. =A0One is this
> business of combining active cancellation with timeouts (we might end
> up needing a special-purpose timer for this). =A0Another is the way all
> input events funnel into a single event queue.
>

Input events do not funnel to a single event queue in the kernel (at
least not with the interface I have used). There are separate queues
for each client of every device.

> For example, suppose you want the keyboard to be a wakeup device but
> not the mouse. =A0Once events get into the input queue, there's no way to
> tell where they came from. =A0Hence mouse motion events would prevent the
> system from suspending, even though they weren't supposed to.
>
>> You cannot easily mix timeouts, cancellations and nesting.
>> Wakelocks/suspend blockers allow you to mix timeouts and
>> cancellations.
>
> That's true. =A0And it turns out that we do need to mix cancellations
> with nesting. =A0For example, it may well happen that pm_request_resume
> gets called several times before the pm workqueue thread gets around to
> resuming the device. =A0If each of those calls has a corresponding call
> to pm_stay_awake then we would like to cancel all of them with a single
> pm_relax after the driver's runtime_resume callback is finished.
>
> On the other hand, the driver's runtime_resume routine might need to
> carry out some work in a different kernel thread. =A0It would call
> pm_stay_awake, and we wouldn't want _this_ call to be cancelled until
> the other thread has run.
>
> In the end, the best answer may be to keep a count of pending wakeup
> events in the new wakeup structure (as well as a global count of the
> number of devices whose pending count is > 0). =A0Then pm_stay_awake
> would increment the count, pm_relax would decrement it, and there could
> be a variant of pm_stay_awake that would increment the count only if it
> was currently equal to 0.
>

If I correctly understand what you are suggesting, that does not work.
If two subsystems use the same device an one of them expects the
pm_stay_awake call to be nested and the other one does not, then the
subsystem that uses the non-nested api is not preventing suspend if
the other subsystem was preventing suspend when it called
pm_stay_awake_if_not_zero (the non-nested pm_relax variant would cause
similar problems). Also, to support all our existing drivers we need
multiple handles per device. For each input device we have a wakelock
with a timeout per client. We only allow suspend when all the clients
have emptied their queue or had their wakelock timeout.

>> The cleanup is a little simpler when you don't nest and there is less
>> chance that a missed edge case prevents suspend forever (we had a few
>> of those bugs in our userspace code that used nested wakelocks).
>
> Bugs in the kernel can be tracked down and fixed.
>

Yes, bugs can be fixed, but not all bugs are discovered quickly and
products ship before some bugs are fixed. For instance, when applying
our patch that holds a wakelock when the input queue is not empty to
this weeks kernel, I noticed that someone had fixed a bug where a
queue overflow could leave the queue empty. If you hit this bug with
the wakelock with timeout implementation that we currently use, then
it would cause suspend to be blocked for 5 seconds (less if another
event occurred or the file descriptor was closed). With the patch that
uses a suspend blocker without a timeout, it would block suspend until
another event from the same device occurred or user space closes the
device. With a nesting api like the current pm_stay_awake/pm_relax, it
will prevent suspend forever (unless another driver has the opposite
bug).

Do we need the nested api for something? We need a non-nested api to
mix timeouts and pm_relax, and unless we need the nested variants, it
is easier to just make all the calls non-nesting.

>> If
>> the above is all you do, then you block suspend forever if someone
>> closes an non-empty input device.
>
> That sounds like a fixable bug. =A0:-)
>
> Alan Stern
>
>



-- =

Arve Hj=F8nnev=E5g
