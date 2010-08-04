From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 22:43:47 +0200
Message-ID: <201008042243.48180.rjw@sisk.pl>
References: <alpine.DEB.2.00.1008021627290.29820@asgard.lang.hm>
	<AANLkTinjH0C0bSK=Y2wKASnbJFsR2BN303xBXkaHbmRC@mail.gmail.com>
	<20100804162717.GA24163@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100804162717.GA24163@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: paulmck@linux.vnet.ibm.com
Cc: david@lang.hm, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, swetland@google.com, linux-kernel <linux-kernel@vger.kernel.org>, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, August 04, 2010, Paul E. McKenney wrote:
> On Tue, Aug 03, 2010 at 08:39:22PM -0700, Arve Hj=F8nnev=E5g wrote:
> > On Tue, Aug 3, 2010 at 5:51 PM,  <david@lang.hm> wrote:
> > > On Tue, 3 Aug 2010, Paul E. McKenney wrote:
> > >
> > >> On Tue, Aug 03, 2010 at 04:19:25PM -0700, david@lang.hm wrote:
> > >>>
> > >>> On Tue, 3 Aug 2010, Arve Hj?nnev?g wrote:
> > >>>
> > >>>> 2010/8/2  <david@lang.hm>:
> > >>>>>
> > >>>>> so what is the fundamental difference between deciding to go into
> > >>>>> low-power
> > >>>>> idle modes to wake up back up on a given point in the future and
> > >>>>> deciding
> > >>>>> that you are going to be idle for so long that you may as well su=
spend
> > >>>>> until
> > >>>>> there is user input?
> > >>>>>
> > >>>>
> > >>>> Low power idle modes are supposed to be transparent. Suspend stops=
 the
> > >>>> monotonic clock, ignores ready threads and switches over to a sepa=
rate
> > >>>> set of wakeup events/interrupts. We don't suspend until there is u=
ser
> > >>>> input, we suspend until there is a wakeup event (user-input, incom=
ing
> > >>>> network data/phone-calls, alarms etc..).
> > >>>
> > >>> s/user input/wakeup event/ and my question still stands.
> > >>>
> > >>> low power modes are not transparent to the user in all cases (if the
> > >>> screen backlight dimms/shuts off a user reading something will
> > >>> notice, if the system switches to a lower clock speed it can impact
> > >>> user response time, etc) The system is making it's best guess as to
> > >>> how to best srve the user by sacraficing some capibilities to save
> > >>> power now so that the power can be available later.
> > >>>
> > >>> as I see it, suspending until a wakeup event (button press, incoming
> > >>> call, alarm, etc) is just another datapoint along the same path.
> > >>>
> > >>> If the system could not wake itself up to respond to user input,
> > >>> phone call, alarm, etc and needed the power button pressed to wake
> > >>> up (or shut down to the point where the battery could be removed and
> > >>> reinstalled a long time later), I would see things moving into a
> > >>> different category, but as long as the system has the ability to
> > >>> wake itself up later (and is still consuming power) I see the
> > >>> suspend as being in the same category as the other low-power modes
> > >>> (it's just more expensive to go in and out of)
> > >>>
> > >>>
> > >>> why should the suspend be put into a different category from the
> > >>> other low-power states?
> > >>
> > >> OK, I'll bite...
> > >
> > > thanks, this is not intended to be a trap.
> > >
> > >> From an Android perspective, the differences are as follows:
> > >>
> > >> 1.      Deep idle states are entered only if there are no runnable t=
asks.
> > >>        In contrast, opportunistic suspend can happen even when there
> > >>        are tasks that are ready, willing, and able to run.
> > >
> > > Ok, this is a complication to what I'm proposing (and seems a little =
odd,
> > > but I can see how it can work), but not neccessarily a major problem.=
 it
> > > depends on exactly how the decision is made to go into low power stat=
es
> > > and/or suspend. If this is done by an application that is able to loo=
k at
> > > either all activity or ignore one cgroup of processes at different ti=
mes in
> > > it's calculations than this would work.
> > >
> > >> 2.      There can be a set of input events that do not bring the sys=
tem
> > >>        out of suspend, but which would bring the system out of a deep
> > >>        idle state.  For example, I believe that it was stated that o=
ne
> > >>        of the Android-based smartphones ignores touchscreen input wh=
ile
> > >>        suspended, but pays attention to it while in deep idle states.
> > >
> > > I see this as simply being a matter of what devices are still enabled=
 at the
> > > different power savings levels. At one level the touchscreen is still
> > > powered, while at another level it isn't, and at yet another level yo=
u have
> > > to hit the power soft-button. This isn't fundamentally different from
> > > powering off a USB peripheral that the system decides is idle (and th=
en not
> > > seeing input from it until something else wakes the system)
> > =

> > The touchscreen on android devices is powered down long before we
> > suspend, so that is not a good example. There is still a significant
> > difference between suspend and idle though. In idle all interrupts
> > work, in suspend only interrupts that the driver has called
> > enable_irq_wake on will work (on platforms that support it).
> > =

> > >> 3.      The system comes out of a deep idle state when a timer
> > >>        expires.  In contrast, timers cannot expire while the
> > >>        system is suspended.  (This one is debatable: some people
> > >>        argue that timers are subject to jitter, and the suspend
> > >>        case for timers is the same as that for deep idle states,
> > >>        but with unbounded timer jitter.  Others disagree.  The
> > >>        resulting discussions have produced much heat, but little
> > >>        light.  Such is life.)
> > >
> > > if you have the ability to wake for an alarm, you have the ability to=
 wake
> > > for a timer (if from no other method than to set the alarm to when th=
e timer
> > > tick would go off)
> > =

> > If you just program the alarm you will wake up see that the monotonic
> > clock has not advanced and set the alarm another n seconds into the
> > future. Or are proposing that suspend should be changed to keep the
> > monotonic clock running? If you are, why? We can enter the same
> > hardware states from idle, and modifying suspend to wake up more often
> > would increase the average power consumption in suspend, not improve
> > it for idle. In other words, if suspend wakes up as often as idle, why
> > use suspend?
> =

> Hmmm...  The bit about the monotonic clock not advancing could help
> explain at least some of the heartburn from the scheduler and real-time
> folks.  ;-)

I think that indeed is the case, although they haven't expressed that direc=
tly
yet (at least not that I know of :-)).

> My guess is that this is not a problem for Android workloads, which
> probably do not contain aggressive real-time components.  (With the
> possible exception of interactions with the cellphone network, which
> I believe are handled by a separate core with separate OS.)  However,
> pulling this into the Linux kernel would require that interactions with
> aggressive real-time workloads be handled, one way or another.
> =

> I can see a couple possible resolutions:
> =

> 1.	Make OPPORTUNISTIC_SUSPEND depend on !PREEMPT_RT, so that
> 	opportunistic suspend simply doesn't happen on systems that
> 	support aggressive real-time workloads.
>
> 2.	Allow OPPORTUNISTIC_SUSPEND and PREEMPT_RT, but suppress
> 	opportunistic suspend when there is a user-created real-time
> 	process.  One way to handle this would be with a variation
> 	on a tongue-in-cheek suggestion from Peter Zijlstra, namely
> 	to have every real-time process hold a wakelock.  Note that
> 	such a wakelock would need to be held even if the real-time
> 	process in question was not runnable, in order to meet
> 	possible real-time deadlines when the real-time process was
> 	awakened.

I guess the scheduler itself would need to hold that wakelock.

> 3.	Your proposal here.  ;-)
> =

> Thoughts?

The case when there's a real-time process that's not using its time slices
(because it doesn't have anything to do) seems to be hard.  You'd probably
want to suspend in that case, but then meeting the real-time deadlines would
be kind of unrealistic ...

Thanks,
Rafael
