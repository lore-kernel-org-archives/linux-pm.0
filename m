From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 09:27:17 -0700
Message-ID: <20100804162717.GA24163__29815.1260860779$1280939678$gmane$org@linux.vnet.ibm.com>
References: <alpine.DEB.2.00.1008021627290.29820@asgard.lang.hm>
	<AANLkTi=1kBuyPS_P+eNLcnRu1mJH6BzpzQW_sENZuL1L@mail.gmail.com>
	<alpine.DEB.2.00.1008022121430.6545@asgard.lang.hm>
	<AANLkTikhcYzNp8CPp8cqrV7Ey5CLMWu1sJTNxUtEi2as@mail.gmail.com>
	<alpine.DEB.2.00.1008022203470.6545@asgard.lang.hm>
	<AANLkTinFT5jq4nUhUpzS5S4TVDQGj0S7RtRgxNhsz2UF@mail.gmail.com>
	<alpine.DEB.2.00.1008031611100.6545@asgard.lang.hm>
	<20100804001015.GJ2407@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008031723530.6545@asgard.lang.hm>
	<AANLkTinjH0C0bSK=Y2wKASnbJFsR2BN303xBXkaHbmRC@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinjH0C0bSK=Y2wKASnbJFsR2BN303xBXkaHbmRC@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: david@lang.hm, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, swetland@google.com, linux-kernel <linux-kernel@vger.kernel.org>, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 03, 2010 at 08:39:22PM -0700, Arve Hj=F8nnev=E5g wrote:
> On Tue, Aug 3, 2010 at 5:51 PM,  <david@lang.hm> wrote:
> > On Tue, 3 Aug 2010, Paul E. McKenney wrote:
> >
> >> On Tue, Aug 03, 2010 at 04:19:25PM -0700, david@lang.hm wrote:
> >>>
> >>> On Tue, 3 Aug 2010, Arve Hj?nnev?g wrote:
> >>>
> >>>> 2010/8/2 =A0<david@lang.hm>:
> >>>>>
> >>>>> so what is the fundamental difference between deciding to go into
> >>>>> low-power
> >>>>> idle modes to wake up back up on a given point in the future and
> >>>>> deciding
> >>>>> that you are going to be idle for so long that you may as well susp=
end
> >>>>> until
> >>>>> there is user input?
> >>>>>
> >>>>
> >>>> Low power idle modes are supposed to be transparent. Suspend stops t=
he
> >>>> monotonic clock, ignores ready threads and switches over to a separa=
te
> >>>> set of wakeup events/interrupts. We don't suspend until there is user
> >>>> input, we suspend until there is a wakeup event (user-input, incoming
> >>>> network data/phone-calls, alarms etc..).
> >>>
> >>> s/user input/wakeup event/ and my question still stands.
> >>>
> >>> low power modes are not transparent to the user in all cases (if the
> >>> screen backlight dimms/shuts off a user reading something will
> >>> notice, if the system switches to a lower clock speed it can impact
> >>> user response time, etc) The system is making it's best guess as to
> >>> how to best srve the user by sacraficing some capibilities to save
> >>> power now so that the power can be available later.
> >>>
> >>> as I see it, suspending until a wakeup event (button press, incoming
> >>> call, alarm, etc) is just another datapoint along the same path.
> >>>
> >>> If the system could not wake itself up to respond to user input,
> >>> phone call, alarm, etc and needed the power button pressed to wake
> >>> up (or shut down to the point where the battery could be removed and
> >>> reinstalled a long time later), I would see things moving into a
> >>> different category, but as long as the system has the ability to
> >>> wake itself up later (and is still consuming power) I see the
> >>> suspend as being in the same category as the other low-power modes
> >>> (it's just more expensive to go in and out of)
> >>>
> >>>
> >>> why should the suspend be put into a different category from the
> >>> other low-power states?
> >>
> >> OK, I'll bite...
> >
> > thanks, this is not intended to be a trap.
> >
> >> From an Android perspective, the differences are as follows:
> >>
> >> 1. =A0 =A0 =A0Deep idle states are entered only if there are no runnab=
le tasks.
> >> =A0 =A0 =A0 =A0In contrast, opportunistic suspend can happen even when=
 there
> >> =A0 =A0 =A0 =A0are tasks that are ready, willing, and able to run.
> >
> > Ok, this is a complication to what I'm proposing (and seems a little od=
d,
> > but I can see how it can work), but not neccessarily a major problem. it
> > depends on exactly how the decision is made to go into low power states
> > and/or suspend. If this is done by an application that is able to look =
at
> > either all activity or ignore one cgroup of processes at different time=
s in
> > it's calculations than this would work.
> >
> >> 2. =A0 =A0 =A0There can be a set of input events that do not bring the=
 system
> >> =A0 =A0 =A0 =A0out of suspend, but which would bring the system out of=
 a deep
> >> =A0 =A0 =A0 =A0idle state. =A0For example, I believe that it was state=
d that one
> >> =A0 =A0 =A0 =A0of the Android-based smartphones ignores touchscreen in=
put while
> >> =A0 =A0 =A0 =A0suspended, but pays attention to it while in deep idle =
states.
> >
> > I see this as simply being a matter of what devices are still enabled a=
t the
> > different power savings levels. At one level the touchscreen is still
> > powered, while at another level it isn't, and at yet another level you =
have
> > to hit the power soft-button. This isn't fundamentally different from
> > powering off a USB peripheral that the system decides is idle (and then=
 not
> > seeing input from it until something else wakes the system)
> =

> The touchscreen on android devices is powered down long before we
> suspend, so that is not a good example. There is still a significant
> difference between suspend and idle though. In idle all interrupts
> work, in suspend only interrupts that the driver has called
> enable_irq_wake on will work (on platforms that support it).
> =

> >> 3. =A0 =A0 =A0The system comes out of a deep idle state when a timer
> >> =A0 =A0 =A0 =A0expires. =A0In contrast, timers cannot expire while the
> >> =A0 =A0 =A0 =A0system is suspended. =A0(This one is debatable: some pe=
ople
> >> =A0 =A0 =A0 =A0argue that timers are subject to jitter, and the suspend
> >> =A0 =A0 =A0 =A0case for timers is the same as that for deep idle state=
s,
> >> =A0 =A0 =A0 =A0but with unbounded timer jitter. =A0Others disagree. =
=A0The
> >> =A0 =A0 =A0 =A0resulting discussions have produced much heat, but litt=
le
> >> =A0 =A0 =A0 =A0light. =A0Such is life.)
> >
> > if you have the ability to wake for an alarm, you have the ability to w=
ake
> > for a timer (if from no other method than to set the alarm to when the =
timer
> > tick would go off)
> =

> If you just program the alarm you will wake up see that the monotonic
> clock has not advanced and set the alarm another n seconds into the
> future. Or are proposing that suspend should be changed to keep the
> monotonic clock running? If you are, why? We can enter the same
> hardware states from idle, and modifying suspend to wake up more often
> would increase the average power consumption in suspend, not improve
> it for idle. In other words, if suspend wakes up as often as idle, why
> use suspend?

Hmmm...  The bit about the monotonic clock not advancing could help
explain at least some of the heartburn from the scheduler and real-time
folks.  ;-)

My guess is that this is not a problem for Android workloads, which
probably do not contain aggressive real-time components.  (With the
possible exception of interactions with the cellphone network, which
I believe are handled by a separate core with separate OS.)  However,
pulling this into the Linux kernel would require that interactions with
aggressive real-time workloads be handled, one way or another.

I can see a couple possible resolutions:

1.	Make OPPORTUNISTIC_SUSPEND depend on !PREEMPT_RT, so that
	opportunistic suspend simply doesn't happen on systems that
	support aggressive real-time workloads.

2.	Allow OPPORTUNISTIC_SUSPEND and PREEMPT_RT, but suppress
	opportunistic suspend when there is a user-created real-time
	process.  One way to handle this would be with a variation
	on a tongue-in-cheek suggestion from Peter Zijlstra, namely
	to have every real-time process hold a wakelock.  Note that
	such a wakelock would need to be held even if the real-time
	process in question was not runnable, in order to meet
	possible real-time deadlines when the real-time process was
	awakened.

3.	Your proposal here.  ;-)

Thoughts?

							Thanx, Paul

> >> There may well be others.
> >>
> >> Whether these distinctions are a good thing or a bad thing is one of
> >> the topics of this discussion. =A0But the distinctions themselves are
> >> certainly very real, from what I can see.
> >>
> >> Or am I missing your point?
> >
> > these big distinction that I see as significant seem to be in the decis=
ion
> > of when to go into the different states, and the difference between the
> > states =A0themselves seem to be less significant (and either very close=
 to, or
> > within the variation that already exists for power saving modes)
> >
> > If I'm right bout this, then it would seem to simplify the concept and
> > change it from some really foreign android-only thing into a special ca=
se
> > variation of existing core concepts.
> =

> Suspend is not an android only concept. The android extensions just
> allow us to aggressively use suspend without loosing (or delaying)
> wakeup events. On the hardware that we shipped we can enter the same
> power mode from idle as we do in suspend, but we still use suspend
> primarily because it stops the monotonic clock and all the timers that
> use it. Changing suspend to behave more like an idle mode, which seems
> to be what you are suggesting, would not buy us anything.
> =

> >
> > you have many different power saving modes, the daemon (or kernel code)=
 that
> > is determining which mode to go into would need different logic (includ=
ing,
> > but not limited to the ability to be able to ignore one or more cgroups=
 of
> > processes). different power saving modes have different trade-offs, and=
 some
> > of them power down different peripherals (which is always a platform
> > specific, if not system specific set of trade-offs)
> >
> =

> The hardware specific idle hook can (and does) decide to go into any
> power state from idle that does not disrupt any active devices.
> =

> > This all depends on the ability for the code that decides to switch pow=
er
> > modes (including to trigger suspend) to be able to see things in suffic=
ient
> > detail to be able to do different things depending on the class of prog=
rams.
> > I don't know enough about this code to know if this is the case or not,=
 I
> > really wish that someone familiar with the power saving code could eith=
er
> > confirm that this is possible, or state that it's not possible (or at l=
east,
> > not without major surgery)
> >
> =

> =

> =

> -- =

> Arve Hj=F8nnev=E5g
