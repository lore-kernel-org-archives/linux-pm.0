From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Thu, 29 Apr 2010 11:41:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004291124580.1697-100000@iolanthe.rowland.org>
References: <h2wd6200be21004281635x9740a6abl2664a1eef8be061d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <h2wd6200be21004281635x9740a6abl2664a1eef8be061d@mail.gmail.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 28 Apr 2010, Arve Hj=F8nnev=E5g wrote:

> >> > =A0suspend blockers can be used to allow
> >> > +user-space to decide whether a keystroke received while the system =
is suspended
> >> > +should cause the screen to be turned back on or allow the system to=
 go back into
> >> > +suspend.
> >>
> >> That's not right. =A0Handling the screen doesn't need suspend blockers:
> >> The program decides what to do and then either turns on the screen or
> >> else writes "mem" to /sys/power/state.
> =

> That does not work though. Unless every key turns the screen on you
> will have a race every time the user presses a key you want to ignore.

Of course.  You are confirming what I wrote immediately below: Suspend
blockers help resolve races.  Note that this race has nothing to do
with the _screen_ in particular -- exactly the same race occurs if you
decide to turn on the audio speaker or some other piece of hardware.

> >> =A0What suspend blockers add is
> >> the ability to resolve races and satisfy multiple constraints when
> >> going into suspend -- which has nothing to do with operating the
> >> screen.
> =

> I'm not sure I agree with this. You cannot reliably turn the screen on
> from user space when the user presses a wakeup-key without suspend
> blockers.

Let's say that it has nothing to do _specifically_ with the screen.  =

_Any_ action you want to take in userspace is difficult to coordinate =

with system suspends if you don't have suspend blockers.

> >>
> >> I _think_ what you're trying to get at can be expressed this way:
> >>
> >> =A0 =A0 =A0 Here's an example showing how a cell phone or other embedd=
ed
> >> =A0 =A0 =A0 system can handle keystrokes (or other input events) in the
> >> =A0 =A0 =A0 presence of suspend blockers. =A0Use set_irq_wake...
> =

> OK, but the last version was what you (Alan) suggested last year.

So at least my mental processes have remained consistent over the span
of a year.  Nice to know I haven't undergone a complete personality =

change...  :-)

> >> =A0 =A0 =A0 ...
> >>
> >> =A0 =A0 =A0 - The user-space input-event thread returns from read. =A0=
It
> >> =A0 =A0 =A0 carries out whatever activities are appropriate (for examp=
le,
> >> =A0 =A0 =A0 powering up the display screen, running other programs, an=
d so
> >> =A0 =A0 =A0 on). =A0When it is finished, it calls suspend_unblock on t=
he
> >> =A0 =A0 =A0 process_input_events suspend_blocker and then calls select=
 or
> >> =A0 =A0 =A0 poll. =A0The system will automatically suspend again when =
it is
> >> =A0 =A0 =A0 idle and no suspend blockers remain active.
> >
> > Yeah, that sounds better. =A0Arve, what do you think?
> >
> =

> Idle is irrelevant and needs to be removed. This new last step is also
> no longer a concrete example, but if you really think is it better I
> can change it.

Perhaps you would prefer to change this completely.  Write up a =

description of what can go wrong when suspend blockers _aren't_ used, =

and show how suspend blockers can prevent the problem from occurring.

But whatever you do, don't make it appear that suspend blockers allow
user programs to make decisions (which is what you wrote before).  They =

don't -- programs can make whatever decisions they want.  Suspend =

blockers merely help them carry out the actions they have decided upon =

in a safe manner.

And don't make it appear that suspend blockers can only be used for
solving screen-related problems.

Alan Stern
