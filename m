From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Thu, 29 Apr 2010 16:39:29 -0700
Message-ID: <p2qd6200be21004291639qd65002a8l4cfbf635962615ba@mail.gmail.com>
References: <h2wd6200be21004281635x9740a6abl2664a1eef8be061d@mail.gmail.com>
	<Pine.LNX.4.44L0.1004291124580.1697-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1004291124580.1697-100000@iolanthe.rowland.org>
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
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2010/4/29 Alan Stern <stern@rowland.harvard.edu>:
> On Wed, 28 Apr 2010, Arve Hj=F8nnev=E5g wrote:
>
>> >> > =A0suspend blockers can be used to allow
>> >> > +user-space to decide whether a keystroke received while the system=
 is suspended
>> >> > +should cause the screen to be turned back on or allow the system t=
o go back into
>> >> > +suspend.
>> >>
>> >> That's not right. =A0Handling the screen doesn't need suspend blocker=
s:
>> >> The program decides what to do and then either turns on the screen or
>> >> else writes "mem" to /sys/power/state.
>>
>> That does not work though. Unless every key turns the screen on you
>> will have a race every time the user presses a key you want to ignore.
>
> Of course. =A0You are confirming what I wrote immediately below: Suspend
Yet you offered it as an example of why "Handling the screen doesn't
need suspend blockers".

> blockers help resolve races. =A0Note that this race has nothing to do
> with the _screen_ in particular -- exactly the same race occurs if you
> decide to turn on the audio speaker or some other piece of hardware.
>
I agree with this, but that does not mean that describing how you can
handle the screen with suspend blockers is a bad example.

>> >> =A0What suspend blockers add is
>> >> the ability to resolve races and satisfy multiple constraints when
>> >> going into suspend -- which has nothing to do with operating the
>> >> screen.
>>
>> I'm not sure I agree with this. You cannot reliably turn the screen on
>> from user space when the user presses a wakeup-key without suspend
>> blockers.
>
> Let's say that it has nothing to do _specifically_ with the screen.
> _Any_ action you want to take in userspace is difficult to coordinate
> with system suspends if you don't have suspend blockers.
>
>> >>
>> >> I _think_ what you're trying to get at can be expressed this way:
>> >>
>> >> =A0 =A0 =A0 Here's an example showing how a cell phone or other embed=
ded
>> >> =A0 =A0 =A0 system can handle keystrokes (or other input events) in t=
he
>> >> =A0 =A0 =A0 presence of suspend blockers. =A0Use set_irq_wake...
>>
>> OK, but the last version was what you (Alan) suggested last year.
>
> So at least my mental processes have remained consistent over the span
> of a year. =A0Nice to know I haven't undergone a complete personality
> change... =A0:-)
>
>> >> =A0 =A0 =A0 ...
>> >>
>> >> =A0 =A0 =A0 - The user-space input-event thread returns from read. =
=A0It
>> >> =A0 =A0 =A0 carries out whatever activities are appropriate (for exam=
ple,
>> >> =A0 =A0 =A0 powering up the display screen, running other programs, a=
nd so
>> >> =A0 =A0 =A0 on). =A0When it is finished, it calls suspend_unblock on =
the
>> >> =A0 =A0 =A0 process_input_events suspend_blocker and then calls selec=
t or
>> >> =A0 =A0 =A0 poll. =A0The system will automatically suspend again when=
 it is
>> >> =A0 =A0 =A0 idle and no suspend blockers remain active.
>> >
>> > Yeah, that sounds better. =A0Arve, what do you think?
>> >
>>
>> Idle is irrelevant and needs to be removed. This new last step is also
>> no longer a concrete example, but if you really think is it better I
>> can change it.
>
> Perhaps you would prefer to change this completely. =A0Write up a
> description of what can go wrong when suspend blockers _aren't_ used,
> and show how suspend blockers can prevent the problem from occurring.
>
> But whatever you do, don't make it appear that suspend blockers allow
> user programs to make decisions (which is what you wrote before). =A0They
> don't -- programs can make whatever decisions they want. =A0Suspend
> blockers merely help them carry out the actions they have decided upon
> in a safe manner.

I think suspend blockers do allow user programs to make decisions.
Without suspend blockers some decisions can only be safely be made in
the kernel/drivers.

>
> And don't make it appear that suspend blockers can only be used for
> solving screen-related problems.

How about:

- The user-space input-event thread returns from read. If it
determines that the key should be ignored, it calls suspend_unblock on
the process_input_events suspend_blocker and then calls select or
poll. The system will automatically suspend again, since now no
suspend blockers are active.

If the key that was pressed instead should preform a simple action
(for example, adjusting the volume), this action can be performed
right before calling suspend_unblock on the process_input_events
suspend_blocker. However, if the key triggers a longer-running action,
that action needs its own suspend_blocker and suspend_block must be
called on that suspend blocker before calling suspend_unblock on the
process_input_events suspend_blocker.

-- =

Arve Hj=F8nnev=E5g
