From: Alan Stern <stern@rowland.harvard.edu>
Subject: Wakeup-events implementation
Date: Fri, 13 Aug 2010 11:59:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008131122400.12397-100000@netrider.rowland.org>
References: <AANLkTimgJUAW9TU37XE4BqYWf3yCWvg-vgk3E0YLqcm9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimgJUAW9TU37XE4BqYWf3yCWvg-vgk3E0YLqcm9@mail.gmail.com>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Since this area of the discussion has strayed away from the path of =

Paul McKenney's original summary, I'm starting a new email thread and =

drastically cutting the CC list.

On Sun, 8 Aug 2010, Arve Hj=F8nnev=E5g wrote:

> > Maybe. =A0There aren't enough examples coded up yet to be sure. =A0At t=
his
> > point we could easily make the device argument required instead of
> > optional, and we could add a device argument to pm_relax.
> >
> I think that would be a good start. I can create dummy devices for now
> where I don't already have a device.

Rafael and I spent some time discussing all this during LinuxCon.  =

Combining what he thought with my own ideas led us to decide that the =

wakeup information should be stored in a separate structure, not in =

dev_pm_info.  These structures will be allocated dynamically when a =

device is enabled for remote wakeup (and presumably deallocated if a =

device is disabled for remote wakeup).  A pointer to the new structure =

will be stored in dev_pm_info.  We expect that most devices won't need =

a wakeup structure, because most devices aren't wakeup sources.

This new structure (as yet unnamed) will be a lot like your
suspend_blocker structure, but with some differences.  It won't need a =

name, since the device already has a name.  It won't have a timer, if =

we can get away with leaving one out.  But it will optionally contain =

various counters that can be used for statistics reporting and =

debugging.  The API for exporting these fields to userspace has not yet =

been decided upon.

The device argument will become mandatory for pm_stay_awake, pm_relax, =

and pm_wakeup_event, so that the counter fields can be updated =

properly.

> > In the scheme we're talking about, the suspend-blocking interface for
> > uesrspace would be located entirely in the power manager. =A0Hence it
> > could maintain all the necessary statistics, without involving the
> > kernel. =A0During early stages of system startup, before the power
> > manager is running, lower-level services would not be able to block
> > suspend. =A0This wouldn't matter because at those times the system simp=
ly
> > would not ever suspend -- because suspends have to be initiated by the
> > power manager.
> =

> If we do that, a low level process could try to block suspend while
> the power manager is not running. Then the power manager could start
> and decide to suspend not knowing that a low level process wanted to
> block suspend.

There's a simple solution: Put all this in a _new_, low-level power
manager program that can be started very early during boot-up (before
any of the other low-level services that need to block suspend).  Then
all the other programs would communicate their suspend-blocker
requirements to this program instead of to the kernel.

You expressed concern about the new power manager deadlocking.  This
can be avoided by designing the program properly.  It should run in two
threads.  Thread 1 will handle IPC, keeping track of userspace
suspend-blocker requests, their statistics, and so on.  Thread 2 will
manage the PM interface to the kernel, and it will execute the
following simple loop:

	for (;;) {
		read /sys/power/wakeup_count	/* blocking read */
		if (there are any active userspace suspend blockers) {
			wait until they are all deactivated
		} else {
			if (write to /sys/power/wakeup_count succeeds)
				write "mem" to /sys/power/state
		}
	}

I think this will resolve the problem you were worried about.

> >> >> I don't know if they are all kernel-internal but these drivers appe=
ar
> >> >> to use timeouts and active cancellation on the same wakelock:
> >> >> wifi driver, mmc core, alarm driver, evdev (suspend blocker version
> >> >> removes the timeout).
> >
> > Roughly speaking, what do the timings work out to be? =A0That is, how
> > long are the timeouts for these wakelocks, how long does it usually
> > take for one of them to be actively cancelled, and what percentage of
> > them end up timing out?
> >
> The evdev timeout is a few seconds, and never timeout unless user
> space is misbehaving. I don't know how the wifi and mmc wakelocks are
> used. The alarm driver uses a 1 or 2 second timeout to abort suspend
> when an alarm is set to close to program an rtc alarm. I think this
> one is cancelled when the alarm triggers, and the timeout only handles
> the case where the client cancelled the alarm before it trigger, but I
> don't remember for sure.

Evdev turns out to be tricky for a couple of reasons.  One is this
business of combining active cancellation with timeouts (we might end
up needing a special-purpose timer for this).  Another is the way all
input events funnel into a single event queue.

For example, suppose you want the keyboard to be a wakeup device but =

not the mouse.  Once events get into the input queue, there's no way to =

tell where they came from.  Hence mouse motion events would prevent the =

system from suspending, even though they weren't supposed to.

> You cannot easily mix timeouts, cancellations and nesting.
> Wakelocks/suspend blockers allow you to mix timeouts and
> cancellations.

That's true.  And it turns out that we do need to mix cancellations =

with nesting.  For example, it may well happen that pm_request_resume =

gets called several times before the pm workqueue thread gets around to =

resuming the device.  If each of those calls has a corresponding call =

to pm_stay_awake then we would like to cancel all of them with a single =

pm_relax after the driver's runtime_resume callback is finished.

On the other hand, the driver's runtime_resume routine might need to =

carry out some work in a different kernel thread.  It would call =

pm_stay_awake, and we wouldn't want _this_ call to be cancelled until =

the other thread has run.

In the end, the best answer may be to keep a count of pending wakeup
events in the new wakeup structure (as well as a global count of the
number of devices whose pending count is > 0).  Then pm_stay_awake
would increment the count, pm_relax would decrement it, and there could
be a variant of pm_stay_awake that would increment the count only if it
was currently equal to 0.

> The cleanup is a little simpler when you don't nest and there is less
> chance that a missed edge case prevents suspend forever (we had a few
> of those bugs in our userspace code that used nested wakelocks).

Bugs in the kernel can be tracked down and fixed.

> If
> the above is all you do, then you block suspend forever if someone
> closes an non-empty input device.

That sounds like a fixable bug.  :-)

Alan Stern
