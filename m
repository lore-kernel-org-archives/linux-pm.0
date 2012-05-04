From: Colin Cross <ccross@android.com>
Subject: Re: [PATCHv3 3/5] cpuidle: add support for states that
 affect multiple cpus
Date: Fri, 4 May 2012 11:56:42 -0700
Message-ID: <CAMbhsRRSGypR-N23vXbHSKLc_TPo6PTjQ2-PFicknCqX8tYq9Q@mail.gmail.com>
References: <1335816551-27756-1-git-send-email-ccross@android.com>
	<201205040014.05880.rjw@sisk.pl>
	<CAMbhsRQVH=f+2A_JXg3J2NKvC3dxqPk-QUDcbQ3G9Rv426c3AA@mail.gmail.com>
	<201205041351.25282.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201205041351.25282.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, May 4, 2012 at 4:51 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, May 04, 2012, Colin Cross wrote:
>> On Thu, May 3, 2012 at 3:14 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> [...]
>>
>> >> +/**
>> >> + * cpuidle_coupled_cpus_waiting - check if all cpus in a coupled set=
 are waiting
>> >> + * @coupled: the struct coupled that contains the current cpu
>> >> + *
>> >> + * Returns true if all cpus coupled to this target state are in the =
wait loop
>> >> + */
>> >> +static inline bool cpuidle_coupled_cpus_waiting(struct cpuidle_coupl=
ed *coupled)
>> >> +{
>> >> + =A0 =A0 int alive;
>> >> + =A0 =A0 int waiting;
>> >> +
>> >> + =A0 =A0 /*
>> >> + =A0 =A0 =A0* Read alive before reading waiting so a booting cpu is =
not treated as
>> >> + =A0 =A0 =A0* idle
>> >> + =A0 =A0 =A0*/
>> >
>> > Well, the comment doesn't really explain much. =A0In particular, why t=
he boot CPU
>> > could be treated as idle if the reads were in a different order.
>>
>> Hm, I think the race condition is on a cpu going down. =A0What about:
>> Read alive before reading waiting. =A0If waiting is read before alive,
>> this cpu could see another cpu as waiting just before it goes offline,
>> between when it the other cpu decrements waiting and when it
>> decrements alive, which could cause alive =3D=3D waiting when one cpu is
>> not waiting.
>
> Reading them in this particular order doesn't stop the race, though. =A0I=
 mean,
> if the hotplug happens just right after you've read alive_count, you stil=
l have
> a wrong value. =A0waiting_count is set independently, it seems, so there'=
s no
> ordering between the two on the "store" side and the "load" side ordering
> doesn't matter.

As commented in the hotplug path, hotplug relies on the fact that one
of the cpus in the cluster is involved in the hotplug of the cpu that
is changing (this may not be true for multiple clusters, but it is
easy to fix by IPI-ing to a cpu that is in the same cluster when that
happens).  That means that waiting count is always guaranteed to be at
least 1 less than alive count when alive count changes.  All this read
ordering needs to do is make sure that this cpu doesn't see
waiting_count =3D=3D alive_count by reading them in the wrong order.

> I would just make the CPU hotplug notifier routine block until
> cpuidle_enter_state_coupled() is done and the latter return immediately
> if the CPU hotplug notifier routine is in progress, perhaps falling back
> to the safe state. =A0Or I would make the CPU hotplug notifier routine
> disable the "coupled cpuidle" entirely on DOWN_PREPARE and UP_PREPARE
> and only re-enable it after the hotplug has been completed.

I'll take a look at disabling coupled idle completely during hotplug.

>> >> + =A0 =A0 alive =3D atomic_read(&coupled->alive_count);
>> >> + =A0 =A0 smp_rmb();
>> >> + =A0 =A0 waiting =3D atomic_read(&coupled->waiting_count);
>> >
>> > Have you considered using one atomic variable to accommodate both coun=
ters
>> > such that the upper half contains one counter and the lower half conta=
ins
>> > the other?
>>
>> There are 3 counters (alive, waiting, and ready). =A0Do you want me to
>> squish all of them into a single atomic_t, which would limit to 1023
>> cpus?
>
> No. =A0I'd make sure that cpuidle_enter_state_coupled() did't race with C=
PU
> hotplug, so as to make alive_count stable from its standpoint, and I'd
> put the two remaining counters into one atomic_t variable.

I'll take a look at using a single atomic_t.  My initial worry was
that the increased contention on the shared variable would cause more
cmpxchg retries, but since waiting_count and ready_count are designed
to be modified in sequential phases that shouldn't be an issue.

>> >> +
>> >> + =A0 =A0 return (waiting =3D=3D alive);
>> >> +}
>> >> +
>> >> +/**
>> >> + * cpuidle_coupled_get_state - determine the deepest idle state
>> >> + * @dev: struct cpuidle_device for this cpu
>> >> + * @coupled: the struct coupled that contains the current cpu
>> >> + *
>> >> + * Returns the deepest idle state that all coupled cpus can enter
>> >> + */
>> >> +static inline int cpuidle_coupled_get_state(struct cpuidle_device *d=
ev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_coupled *coupled)
>> >> +{
>> >> + =A0 =A0 int i;
>> >> + =A0 =A0 int state =3D INT_MAX;
>> >> +
>> >> + =A0 =A0 for_each_cpu_mask(i, coupled->coupled_cpus)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (coupled->requested_state[i] !=3D CPUIDL=
E_COUPLED_DEAD &&
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 coupled->requested_state[i] < state)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D coupled->requeste=
d_state[i];
>> >> +
>> >> + =A0 =A0 BUG_ON(state >=3D dev->state_count || state < 0);
>> >
>> > Do you have to crash the kernel here if the assertion doesn't hold? =
=A0Maybe
>> > you could use WARN_ON() and return error code?
>>
>> If this BUG_ON is hit, there is a race condition somewhere that
>> allowed a cpu out of idle unexpectedly, and there is no way to recover
>> without more race conditions. =A0I don't expect this to ever happen, it
>> is mostly there to detect race conditions during development. =A0Should
>> I drop it completely?
>
> I would just drop it, then, in the final respin of the patch.
>
> [...]
>> >> +{
>> >> + =A0 =A0 int alive;
>> >> +
>> >> + =A0 =A0 BUG_ON(coupled->requested_state[dev->cpu] >=3D 0);
>> >
>> > Would be WARN_ON() + do nothing too dangerous here?
>>
>> If this BUG_ON is hit, then this cpu exited idle without clearing its
>> waiting state, which could cause another cpu to enter the deeper idle
>> state while this cpu is still running. =A0The counters would be out of
>> sync, so it's not easy to recover. =A0Again, this is to detect race
>> conditions during development, but should never happen. =A0Should I drop
>> it?
>
> Just like above.
>
>> >> +
>> >> + =A0 =A0 coupled->requested_state[dev->cpu] =3D next_state;
>> >> +
>> >> + =A0 =A0 /*
>> >> + =A0 =A0 =A0* If this is the last cpu to enter the waiting state, po=
ke
>> >> + =A0 =A0 =A0* all the other cpus out of their waiting state so they =
can
>> >> + =A0 =A0 =A0* enter a deeper state. =A0This can race with one of the=
 cpus
>> >> + =A0 =A0 =A0* exiting the waiting state due to an interrupt and
>> >> + =A0 =A0 =A0* decrementing waiting_count, see comment below.
>> >> + =A0 =A0 =A0*/
>> >> + =A0 =A0 alive =3D atomic_read(&coupled->alive_count);
>> >> + =A0 =A0 if (atomic_inc_return(&coupled->waiting_count) =3D=3D alive)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_coupled_poke_others(dev, coupled);
>> >> +}
>> >> +
>> >> +/**
>> >> + * cpuidle_coupled_set_not_waiting - mark this cpu as leaving the wa=
it loop
>> >> + * @dev: struct cpuidle_device for this cpu
>> >> + * @coupled: the struct coupled that contains the current cpu
>> >> + *
>> >> + * Removes the requested idle state for the specified cpuidle device.
>> >> + *
>> >> + * Provides memory ordering around waiting_count.
>> >> + */
>> >> +static void cpuidle_coupled_set_not_waiting(struct cpuidle_device *d=
ev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_coupled *coupled)
>> >
>> > It looks like dev doesn't have to be passed here, cpu would be enough.
>> >
>> >> +{
>> >> + =A0 =A0 BUG_ON(coupled->requested_state[dev->cpu] < 0);
>> >
>> > Well, like above?
>> Same as above.
>
> Ditto. :-)
>
>> >> +
>> >> + =A0 =A0 /*
>> >> + =A0 =A0 =A0* Decrementing waiting_count can race with incrementing =
it in
>> >> + =A0 =A0 =A0* cpuidle_coupled_set_waiting, but that's OK. =A0Worst c=
ase, some
>> >> + =A0 =A0 =A0* cpus will increment ready_count and then spin until th=
ey
>> >> + =A0 =A0 =A0* notice that this cpu has cleared it's requested_state.
>> >> + =A0 =A0 =A0*/
>> >
>> > So it looks like having ready_count and waiting_count in one atomic va=
riable
>> > can spare us this particular race condition.
>> As above, there are 3 counters here, alive, ready, and waiting.
>
> Please refer to my comment about that above.
>
>> >> +
>> >> + =A0 =A0 smp_mb__before_atomic_dec();
>> >> + =A0 =A0 atomic_dec(&coupled->waiting_count);
>> >> + =A0 =A0 smp_mb__after_atomic_dec();
>> >
>> > Do you really need both the before and after barriers here? =A0If so, =
then why?
>>
>> I believe so, waiting is ordered vs. alive and ready, one barrier is
>> for each. =A0Do you want the answers to these questions here or in the
>> code? =A0I had comments for every barrier use during development, but it
>> made it too hard to follow the flow of the code. =A0I could add a
>> comment describing the ordering requirements instead, but it's still
>> hard to translate that to the required barrier locations.
>
> Well, the barriers should be commented in the code, for the sake of people
> reading it and wanting to learn from it if nothing else.
>
> Wherever we put an SMP barrier directly like this, there should be a good
> reason for that and it should be documented.
>
> [...]
>> >> + */
>> >> +int cpuidle_enter_state_coupled(struct cpuidle_device *dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_driver *drv, int next_state)
>> >> +{
>> >> + =A0 =A0 int entered_state =3D -1;
>> >> + =A0 =A0 struct cpuidle_coupled *coupled =3D dev->coupled;
>> >> + =A0 =A0 int alive;
>> >> +
>> >> + =A0 =A0 if (!coupled)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> >> +
>> >> + =A0 =A0 BUG_ON(atomic_read(&coupled->ready_count));
>> >
>> > Again, I'd do a WARN_ON() and return error code from here (to avoid cr=
ashing
>> > the kernel).
>> Same as above, if ready_count is not 0 here then the counters are out
>> of sync and something is about to go horribly wrong, like cutting
>> power to a running cpu.
>
> OK
>
>> >> + =A0 =A0 cpuidle_coupled_set_waiting(dev, coupled, next_state);
>> >> +
>> >> +retry:
>> >> + =A0 =A0 /*
>> >> + =A0 =A0 =A0* Wait for all coupled cpus to be idle, using the deepes=
t state
>> >> + =A0 =A0 =A0* allowed for a single cpu.
>> >> + =A0 =A0 =A0*/
>> >> + =A0 =A0 while (!need_resched() && !cpuidle_coupled_cpus_waiting(cou=
pled)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 entered_state =3D cpuidle_enter_state(dev, =
drv,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->safe_state_index);
>> >> +
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 local_irq_enable();
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 while (cpumask_test_cpu(dev->cpu, &cpuidle_=
coupled_poked_mask))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> >
>> > Hmm. =A0What exactly is this loop supposed to achieve?
>> This is to ensure that the outstanding wakeups have been processed so
>> we don't go to idle with an interrupt pending an immediately wake up.
>
> I see. =A0Is it actually safe to reenable interrupts at this point, thoug=
h?

I think so.  The normal idle loop will enable interrupts in a similar
fashion to what happens here.  There are two things to worry about: a
processed interrupt causing work to be scheduled that should bring
this cpu out of idle, or changing the next timer which would
invalidate the current requested state.  The first is handled by
checking need_resched() after interrupts are disabled again, the
second is currently unhandled but does not affect correct operation,
it just races into a less-than-optimal idle state.

>> >> + =A0 =A0 =A0 =A0 =A0 =A0 local_irq_disable();
>> >
>> > Anyway, you seem to be calling it twice along with this enabling/disab=
ling of
>> > interrupts. =A0I'd put that into a separate function and explain its r=
ole in a
>> > kerneldoc comment.
>>
>> I left it here to be obvious that I was enabling interrupts in the
>> idle path, but I can refactor it out if you prefer.
>
> Well, you can call the function to make it obvious. :-)
>
> Anyway, I think that code duplication is a worse thing than a reasonable
> amount of non-obviousness, so to speak.
>
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 /* give a chance to process any remaining pokes */
>> >> + =A0 =A0 local_irq_enable();
>> >> + =A0 =A0 while (cpumask_test_cpu(dev->cpu, &cpuidle_coupled_poked_ma=
sk))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> >> + =A0 =A0 local_irq_disable();
>> >> +
>> >> + =A0 =A0 if (need_resched()) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_coupled_set_not_waiting(dev, couple=
d);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 /*
>> >> + =A0 =A0 =A0* All coupled cpus are probably idle. =A0There is a smal=
l chance that
>> >> + =A0 =A0 =A0* one of the other cpus just became active. =A0Increment=
 a counter when
>> >> + =A0 =A0 =A0* ready, and spin until all coupled cpus have incremente=
d the counter.
>> >> + =A0 =A0 =A0* Once a cpu has incremented the counter, it cannot abor=
t idle and must
>> >> + =A0 =A0 =A0* spin until either the count has hit alive_count, or an=
other cpu
>> >> + =A0 =A0 =A0* leaves idle.
>> >> + =A0 =A0 =A0*/
>> >> +
>> >> + =A0 =A0 smp_mb__before_atomic_inc();
>> >> + =A0 =A0 atomic_inc(&coupled->ready_count);
>> >> + =A0 =A0 smp_mb__after_atomic_inc();
>> >
>> > It seems that at least one of these barriers is unnecessary ...
>> The first is to ensure ordering between ready_count and waiting count,
>
> Are you afraid that the test against waiting_count from
> cpuidle_coupled_cpus_waiting() may get reordered after the incrementation
> of ready_count or is it something else?

Yes, ready_count must not be incremented before waiting_count =3D=3D alive_=
count.

>> the second is for ready_count vs. alive_count and requested_state.
>
> This one I can understand, but ...
>
>> >> + =A0 =A0 /* alive_count can't change while ready_count > 0 */
>> >> + =A0 =A0 alive =3D atomic_read(&coupled->alive_count);
>
> What happens if CPU hotplug happens right here?

According to the comment above that line that can't happen -
alive_count can't change while ready_count > 0, because that implies
that all cpus are waiting and none can be in the hotplug path where
alive_count is changed.  Looking at it again that is not entirely
true, alive_count could change on systems with >2 cpus, but I think it
can't cause an issue because alive_count would be 2 greater than
waiting_count before alive_count was changed.  Either way, it will be
fixed by disabling coupled idle during hotplug.

>> >> + =A0 =A0 while (atomic_read(&coupled->ready_count) !=3D alive) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* Check if any other cpus bailed out of id=
le. */
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (!cpuidle_coupled_cpus_waiting(coupled))=
 {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 atomic_dec(&coupled->ready_=
count);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 smp_mb__after_atomic_dec();
>
> And the barrier here? =A0Even if the old value of ready_count leaks into
> the while () loop after retry, that doesn't seem to matter.

All of these will be academic if ready_count and waiting_count share
an atomic_t.
waiting_count must not be decremented by exiting the while loop after
the retry label until ready_count is decremented here, but that is
also protected by the barrier in set_not_waiting.  One of them could
be dropped.

>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto retry;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 /* all cpus have acked the coupled state */
>> >> + =A0 =A0 smp_rmb();
>> >
>> > What is the barrier here for?
>> This protects ready_count vs. requested_state. =A0It is already
>> implicitly protected by the atomic_inc_return in set_waiting, but I
>> thought it would be better to protect it explicitly here. =A0I think I
>> added the smp_mb__after_atomic_inc above later, which makes this one
>> superflous, so I'll drop it.
>
> OK
>
>> >> +
>> >> + =A0 =A0 next_state =3D cpuidle_coupled_get_state(dev, coupled);
>> >> +
>> >> + =A0 =A0 entered_state =3D cpuidle_enter_state(dev, drv, next_state);
>> >> +
>> >> + =A0 =A0 cpuidle_coupled_set_not_waiting(dev, coupled);
>> >> + =A0 =A0 atomic_dec(&coupled->ready_count);
>> >> + =A0 =A0 smp_mb__after_atomic_dec();
>> >> +
>> >> +out:
>> >> + =A0 =A0 /*
>> >> + =A0 =A0 =A0* Normal cpuidle states are expected to return with irqs=
 enabled.
>> >> + =A0 =A0 =A0* That leads to an inefficiency where a cpu receiving an=
 interrupt
>> >> + =A0 =A0 =A0* that brings it out of idle will process that interrupt=
 before
>> >> + =A0 =A0 =A0* exiting the idle enter function and decrementing ready=
_count. =A0All
>> >> + =A0 =A0 =A0* other cpus will need to spin waiting for the cpu that =
is processing
>> >> + =A0 =A0 =A0* the interrupt. =A0If the driver returns with interrupt=
s disabled,
>> >> + =A0 =A0 =A0* all other cpus will loop back into the safe idle state=
 instead of
>> >> + =A0 =A0 =A0* spinning, saving power.
>> >> + =A0 =A0 =A0*
>> >> + =A0 =A0 =A0* Calling local_irq_enable here allows coupled states to=
 return with
>> >> + =A0 =A0 =A0* interrupts disabled, but won't cause problems for driv=
ers that
>> >> + =A0 =A0 =A0* exit with interrupts enabled.
>> >> + =A0 =A0 =A0*/
>> >> + =A0 =A0 local_irq_enable();
>> >> +
>> >> + =A0 =A0 /*
>> >> + =A0 =A0 =A0* Wait until all coupled cpus have exited idle. =A0There=
 is no risk that
>> >> + =A0 =A0 =A0* a cpu exits and re-enters the ready state because this=
 cpu has
>> >> + =A0 =A0 =A0* already decremented its waiting_count.
>> >> + =A0 =A0 =A0*/
>> >> + =A0 =A0 while (atomic_read(&coupled->ready_count) !=3D 0)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> >> +
>> >> + =A0 =A0 smp_rmb();
>> >
>> > And here?
>>
>> This was to protect ready_count vs. looping back in and reading
>> alive_count.
>
> Well, I'm lost. :-)
>
> You've not modified anything after the previous smp_mb__after_atomic_dec(=
),
> so what exactly is the reordering this is supposed to work against?
>
> And while we're at it, I'm not quite sure what the things that the previo=
us
> smp_mb__after_atomic_dec() separates from each other are.

Instead of justifying all of these, let me try the combined atomic_t
trick and justify the (many fewer) remaining barriers.

>> There will be plenty of synchronization calls between
>> the two with implicit barriers, but I thought it was better to do it
>> explicitly.
>
> [...]
>> >> +static void cpuidle_coupled_cpu_set_alive(int cpu, bool alive)
>> >> +{
>> >> + =A0 =A0 struct cpuidle_device *dev;
>> >> + =A0 =A0 struct cpuidle_coupled *coupled;
>> >> +
>> >> + =A0 =A0 mutex_lock(&cpuidle_lock);
>> >> +
>> >> + =A0 =A0 dev =3D per_cpu(cpuidle_devices, cpu);
>> >> + =A0 =A0 if (!dev->coupled)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> +
>> >> + =A0 =A0 coupled =3D dev->coupled;
>> >> +
>> >> + =A0 =A0 /*
>> >> + =A0 =A0 =A0* waiting_count must be at least 1 less than alive_count=
, because
>> >> + =A0 =A0 =A0* this cpu is not waiting. =A0Spin until all cpus have n=
oticed this cpu
>> >> + =A0 =A0 =A0* is not idle and exited the ready loop before changing =
alive_count.
>> >> + =A0 =A0 =A0*/
>> >> + =A0 =A0 while (atomic_read(&coupled->ready_count))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> >> +
>> >> + =A0 =A0 if (alive) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 smp_mb__before_atomic_inc();
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 atomic_inc(&coupled->alive_count);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 smp_mb__after_atomic_inc();
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 coupled->requested_state[dev->cpu] =3D CPUI=
DLE_COUPLED_NOT_IDLE;
>> >> + =A0 =A0 } else {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 smp_mb__before_atomic_dec();
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 atomic_dec(&coupled->alive_count);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 smp_mb__after_atomic_dec();
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 coupled->requested_state[dev->cpu] =3D CPUI=
DLE_COUPLED_DEAD;
>> >
>> > There's too many SMP barriers above, but I'm not quite sure which of t=
hem (if
>> > any) are really necessary.
>> The ones before order ready_count vs alive_count, the ones after order
>> alive_count vs. requested_state and future waiting_count increments.
>
> Well, so what are the matching barriers for these?
>
> Rafael
