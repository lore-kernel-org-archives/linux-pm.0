From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Wed, 28 Apr 2010 16:35:43 -0700
Message-ID: <h2wd6200be21004281635x9740a6abl2664a1eef8be061d__27807.791872374$1272497903$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1004281317310.1944-100000@iolanthe.rowland.org>
	<201004282313.50603.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201004282313.50603.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2010/4/28 Rafael J. Wysocki <rjw@sisk.pl>:
> On Wednesday 28 April 2010, Alan Stern wrote:
>> On Tue, 27 Apr 2010, [UTF-8] Arve Hj=C3=B8nnev=C3=A5g wrote:
>>
>> > +For example, in cell phones or other embedded systems, where powering=
 the screen
>> > +is a significant drain on the battery, suspend blockers can be used t=
o allow
>> > +user-space to decide whether a keystroke received while the system is=
 suspended
>> > +should cause the screen to be turned back on or allow the system to g=
o back into
>> > +suspend. Use set_irq_wake or a platform specific api to make sure the=
 keypad
>> > +interrupt wakes up the cpu. Once the keypad driver has resumed, the s=
equence of
>> > +events can look like this:
>> > +
>> > +- The Keypad driver gets an interrupt. It then calls suspend_block on=
 the
>> > + =A0keypad-scan suspend_blocker and starts scanning the keypad matrix.
>> > +- The keypad-scan code detects a key change and reports it to the inp=
ut-event
>> > + =A0driver.
>> > +- The input-event driver sees the key change, enqueues an event, and =
calls
>> > + =A0suspend_block on the input-event-queue suspend_blocker.
>> > +- The keypad-scan code detects that no keys are held and calls suspen=
d_unblock
>> > + =A0on the keypad-scan suspend_blocker.
>> > +- The user-space input-event thread returns from select/poll, calls
>> > + =A0suspend_block on the process-input-events suspend_blocker and the=
n calls read
>> > + =A0on the input-event device.
>> > +- The input-event driver dequeues the key-event and, since the queue =
is now
>> > + =A0empty, it calls suspend_unblock on the input-event-queue suspend_=
blocker.
>> > +- The user-space input-event thread returns from read. If it determin=
es that
>> > + =A0the key should leave the screen off, it calls suspend_unblock on =
the
>> > + =A0process_input_events suspend_blocker and then calls select or pol=
l. The
>> > + =A0system will automatically suspend again, since now no suspend blo=
ckers are
>> > + =A0active.
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Key pressed =A0 Key released
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 |
>> > +keypad-scan =A0 =A0 =A0 =A0 =A0++++++++++++++++++
>> > +input-event-queue =A0 =A0 =A0 =A0+++ =A0 =A0 =A0 =A0 =A0+++
>> > +process-input-events =A0 =A0 =A0 +++ =A0 =A0 =A0 =A0 =A0+++
>>
>> This is better than before, but it still isn't ideal. =A0Here's what I
>> mean:
>>
>> > =A0suspend blockers can be used to allow
>> > +user-space to decide whether a keystroke received while the system is=
 suspended
>> > +should cause the screen to be turned back on or allow the system to g=
o back into
>> > +suspend.
>>
>> That's not right. =A0Handling the screen doesn't need suspend blockers:
>> The program decides what to do and then either turns on the screen or
>> else writes "mem" to /sys/power/state.

That does not work though. Unless every key turns the screen on you
will have a race every time the user presses a key you want to ignore.

>> =A0What suspend blockers add is
>> the ability to resolve races and satisfy multiple constraints when
>> going into suspend -- which has nothing to do with operating the
>> screen.

I'm not sure I agree with this. You cannot reliably turn the screen on
from user space when the user presses a wakeup-key without suspend
blockers.

>>
>> I _think_ what you're trying to get at can be expressed this way:
>>
>> =A0 =A0 =A0 Here's an example showing how a cell phone or other embedded
>> =A0 =A0 =A0 system can handle keystrokes (or other input events) in the
>> =A0 =A0 =A0 presence of suspend blockers. =A0Use set_irq_wake...

OK, but the last version was what you (Alan) suggested last year.

>>
>> =A0 =A0 =A0 ...
>>
>> =A0 =A0 =A0 - The user-space input-event thread returns from read. =A0It
>> =A0 =A0 =A0 carries out whatever activities are appropriate (for example,
>> =A0 =A0 =A0 powering up the display screen, running other programs, and =
so
>> =A0 =A0 =A0 on). =A0When it is finished, it calls suspend_unblock on the
>> =A0 =A0 =A0 process_input_events suspend_blocker and then calls select or
>> =A0 =A0 =A0 poll. =A0The system will automatically suspend again when it=
 is
>> =A0 =A0 =A0 idle and no suspend blockers remain active.
>
> Yeah, that sounds better. =A0Arve, what do you think?
>

Idle is irrelevant and needs to be removed. This new last step is also
no longer a concrete example, but if you really think is it better I
can change it.

>> > +/**
>> > + * suspend_block() - Block suspend
>> > + * @blocker: =A0 =A0 =A0 The suspend blocker to use
>> > + *
>> > + * It is safe to call this function from interrupt context.
>> > + */
>> > +void suspend_block(struct suspend_blocker *blocker)
>> > +{
>> > + =A0 unsigned long irqflags;
>> > +
>> > + =A0 if (WARN_ON(!(blocker->flags & SB_INITIALIZED)))
>> > + =A0 =A0 =A0 =A0 =A0 return;
>> > +
>> > + =A0 spin_lock_irqsave(&list_lock, irqflags);
>> > + =A0 blocker->flags |=3D SB_ACTIVE;
>> > + =A0 list_del(&blocker->link);
>> > +
>> > + =A0 if (debug_mask & DEBUG_SUSPEND_BLOCKER)
>> > + =A0 =A0 =A0 =A0 =A0 pr_info("suspend_block: %s\n", blocker->name);
>> > +
>> > + =A0 list_add(&blocker->link, &active_blockers);
>>
>> Here and in suspend_unblock(), you can use list_move() in place of
>> list_del() followed by list_add().
>

OK.

> Indeed. =A0And the debug statement might be moved out of the critical sec=
tion IMHO.
>

If I move the debug statements out of the critical section you could
end entering suspend while the debug log claims a suspend blocker was
active, but I can move the debug statement to the start of the
critical section.

-- =

Arve Hj=F8nnev=E5g
