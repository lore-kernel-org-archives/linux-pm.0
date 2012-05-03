From: Colin Cross <ccross@android.com>
Subject: Re: [PATCHv3 3/5] cpuidle: add support for states that
 affect multiple cpus
Date: Thu, 3 May 2012 16:09:15 -0700
Message-ID: <CAMbhsRQVH=f+2A_JXg3J2NKvC3dxqPk-QUDcbQ3G9Rv426c3AA@mail.gmail.com>
References: <1335816551-27756-1-git-send-email-ccross@android.com>
	<1335816551-27756-4-git-send-email-ccross@android.com>
	<201205040014.05880.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201205040014.05880.rjw@sisk.pl>
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

On Thu, May 3, 2012 at 3:14 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, April 30, 2012, Colin Cross wrote:
<snip>

>> +/**
>> + * DOC: Coupled cpuidle states
>> + *
>> + * On some ARM SMP SoCs (OMAP4460, Tegra 2, and probably more), the
>> + * cpus cannot be independently powered down, either due to
>> + * sequencing restrictions (on Tegra 2, cpu 0 must be the last to
>> + * power down), or due to HW bugs (on OMAP4460, a cpu powering up
>> + * will corrupt the gic state unless the other cpu runs a work
>> + * around). =A0Each cpu has a power state that it can enter without
>> + * coordinating with the other cpu (usually Wait For Interrupt, or
>> + * WFI), and one or more "coupled" power states that affect blocks
>> + * shared between the cpus (L2 cache, interrupt controller, and
>> + * sometimes the whole SoC). =A0Entering a coupled power state must
>> + * be tightly controlled on both cpus.
>> + *
>> + * The easiest solution to implementing coupled cpu power states is
>> + * to hotplug all but one cpu whenever possible, usually using a
>> + * cpufreq governor that looks at cpu load to determine when to
>> + * enable the secondary cpus. =A0This causes problems, as hotplug is an
>> + * expensive operation, so the number of hotplug transitions must be
>> + * minimized, leading to very slow response to loads, often on the
>> + * order of seconds.
>
> I'd drop the above paragraph entirely. =A0It doesn't say much about what'=
s in
> the file and refers to an obviously suboptimal approach.

Sure.


<snip>

>> +/*
>> + * The cpuidle_coupled_poked_mask masked is used to avoid calling
>
> s/masked/mask/ perhaps?

Sure.

<snip>

>> +/**
>> + * cpuidle_coupled_cpus_waiting - check if all cpus in a coupled set ar=
e waiting
>> + * @coupled: the struct coupled that contains the current cpu
>> + *
>> + * Returns true if all cpus coupled to this target state are in the wai=
t loop
>> + */
>> +static inline bool cpuidle_coupled_cpus_waiting(struct cpuidle_coupled =
*coupled)
>> +{
>> + =A0 =A0 int alive;
>> + =A0 =A0 int waiting;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Read alive before reading waiting so a booting cpu is not=
 treated as
>> + =A0 =A0 =A0* idle
>> + =A0 =A0 =A0*/
>
> Well, the comment doesn't really explain much. =A0In particular, why the =
boot CPU
> could be treated as idle if the reads were in a different order.

Hm, I think the race condition is on a cpu going down.  What about:
Read alive before reading waiting.  If waiting is read before alive,
this cpu could see another cpu as waiting just before it goes offline,
between when it the other cpu decrements waiting and when it
decrements alive, which could cause alive =3D=3D waiting when one cpu is
not waiting.

>> + =A0 =A0 alive =3D atomic_read(&coupled->alive_count);
>> + =A0 =A0 smp_rmb();
>> + =A0 =A0 waiting =3D atomic_read(&coupled->waiting_count);
>
> Have you considered using one atomic variable to accommodate both counters
> such that the upper half contains one counter and the lower half contains
> the other?

There are 3 counters (alive, waiting, and ready).  Do you want me to
squish all of them into a single atomic_t, which would limit to 1023
cpus?

>> +
>> + =A0 =A0 return (waiting =3D=3D alive);
>> +}
>> +
>> +/**
>> + * cpuidle_coupled_get_state - determine the deepest idle state
>> + * @dev: struct cpuidle_device for this cpu
>> + * @coupled: the struct coupled that contains the current cpu
>> + *
>> + * Returns the deepest idle state that all coupled cpus can enter
>> + */
>> +static inline int cpuidle_coupled_get_state(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_coupled *coupled)
>> +{
>> + =A0 =A0 int i;
>> + =A0 =A0 int state =3D INT_MAX;
>> +
>> + =A0 =A0 for_each_cpu_mask(i, coupled->coupled_cpus)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (coupled->requested_state[i] !=3D CPUIDLE_C=
OUPLED_DEAD &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 coupled->requested_state[i] < state)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D coupled->requested_s=
tate[i];
>> +
>> + =A0 =A0 BUG_ON(state >=3D dev->state_count || state < 0);
>
> Do you have to crash the kernel here if the assertion doesn't hold? =A0Ma=
ybe
> you could use WARN_ON() and return error code?

If this BUG_ON is hit, there is a race condition somewhere that
allowed a cpu out of idle unexpectedly, and there is no way to recover
without more race conditions.  I don't expect this to ever happen, it
is mostly there to detect race conditions during development.  Should
I drop it completely?

>> +
>> + =A0 =A0 return state;
>> +}
>> +
>> +static void cpuidle_coupled_poked(void *info)
>> +{
>> + =A0 =A0 int cpu =3D (unsigned long)info;
>> + =A0 =A0 cpumask_clear_cpu(cpu, &cpuidle_coupled_poked_mask);
>> +}
>> +
>> +/**
>> + * cpuidle_coupled_poke - wake up a cpu that may be waiting
>> + * @cpu: target cpu
>> + *
>> + * Ensures that the target cpu exits it's waiting idle state (if it is =
in it)
>> + * and will see updates to waiting_count before it re-enters it's waiti=
ng idle
>> + * state.
>> + *
>> + * If cpuidle_coupled_poked_mask is already set for the target cpu, tha=
t cpu
>> + * either has or will soon have a pending IPI that will wake it out of =
idle,
>> + * or it is currently processing the IPI and is not in idle.
>> + */
>> +static void cpuidle_coupled_poke(int cpu)
>> +{
>> + =A0 =A0 struct call_single_data *csd =3D &per_cpu(cpuidle_coupled_poke=
_cb, cpu);
>> +
>> + =A0 =A0 if (!cpumask_test_and_set_cpu(cpu, &cpuidle_coupled_poked_mask=
))
>> + =A0 =A0 =A0 =A0 =A0 =A0 __smp_call_function_single(cpu, csd, 0);
>> +}
>> +
>> +/**
>> + * cpuidle_coupled_poke_others - wake up all other cpus that may be wai=
ting
>> + * @dev: struct cpuidle_device for this cpu
>> + * @coupled: the struct coupled that contains the current cpu
>> + *
>> + * Calls cpuidle_coupled_poke on all other online cpus.
>> + */
>> +static void cpuidle_coupled_poke_others(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_coupled *coupled)
>
> It looks like you could simply pass cpu (not dev) to this function.

OK.

>> +{
>> + =A0 =A0 int cpu;
>> +
>> + =A0 =A0 for_each_cpu_mask(cpu, coupled->coupled_cpus)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cpu !=3D dev->cpu && cpu_online(cpu))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_coupled_poke(cpu);
>> +}
>> +
>> +/**
>> + * cpuidle_coupled_set_waiting - mark this cpu as in the wait loop
>> + * @dev: struct cpuidle_device for this cpu
>> + * @coupled: the struct coupled that contains the current cpu
>> + * @next_state: the index in drv->states of the requested state for thi=
s cpu
>> + *
>> + * Updates the requested idle state for the specified cpuidle device,
>> + * poking all coupled cpus out of idle if necessary to let them see the=
 new
>> + * state.
>> + *
>> + * Provides memory ordering around waiting_count.
>> + */
>> +static void cpuidle_coupled_set_waiting(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_coupled *coupled, int next_stat=
e)
>
> If you passed cpu (instead of dev) to cpuidle_coupled_poke_others(),
> then you could pass cpu (instead of dev) to this function too, it seems.

OK.

>> +{
>> + =A0 =A0 int alive;
>> +
>> + =A0 =A0 BUG_ON(coupled->requested_state[dev->cpu] >=3D 0);
>
> Would be WARN_ON() + do nothing too dangerous here?

If this BUG_ON is hit, then this cpu exited idle without clearing its
waiting state, which could cause another cpu to enter the deeper idle
state while this cpu is still running.  The counters would be out of
sync, so it's not easy to recover.  Again, this is to detect race
conditions during development, but should never happen.  Should I drop
it?

>> +
>> + =A0 =A0 coupled->requested_state[dev->cpu] =3D next_state;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If this is the last cpu to enter the waiting state, poke
>> + =A0 =A0 =A0* all the other cpus out of their waiting state so they can
>> + =A0 =A0 =A0* enter a deeper state. =A0This can race with one of the cp=
us
>> + =A0 =A0 =A0* exiting the waiting state due to an interrupt and
>> + =A0 =A0 =A0* decrementing waiting_count, see comment below.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 alive =3D atomic_read(&coupled->alive_count);
>> + =A0 =A0 if (atomic_inc_return(&coupled->waiting_count) =3D=3D alive)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_coupled_poke_others(dev, coupled);
>> +}
>> +
>> +/**
>> + * cpuidle_coupled_set_not_waiting - mark this cpu as leaving the wait =
loop
>> + * @dev: struct cpuidle_device for this cpu
>> + * @coupled: the struct coupled that contains the current cpu
>> + *
>> + * Removes the requested idle state for the specified cpuidle device.
>> + *
>> + * Provides memory ordering around waiting_count.
>> + */
>> +static void cpuidle_coupled_set_not_waiting(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_coupled *coupled)
>
> It looks like dev doesn't have to be passed here, cpu would be enough.
>
>> +{
>> + =A0 =A0 BUG_ON(coupled->requested_state[dev->cpu] < 0);
>
> Well, like above?
Same as above.

>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Decrementing waiting_count can race with incrementing it =
in
>> + =A0 =A0 =A0* cpuidle_coupled_set_waiting, but that's OK. =A0Worst case=
, some
>> + =A0 =A0 =A0* cpus will increment ready_count and then spin until they
>> + =A0 =A0 =A0* notice that this cpu has cleared it's requested_state.
>> + =A0 =A0 =A0*/
>
> So it looks like having ready_count and waiting_count in one atomic varia=
ble
> can spare us this particular race condition.
As above, there are 3 counters here, alive, ready, and waiting.

>> +
>> + =A0 =A0 smp_mb__before_atomic_dec();
>> + =A0 =A0 atomic_dec(&coupled->waiting_count);
>> + =A0 =A0 smp_mb__after_atomic_dec();
>
> Do you really need both the before and after barriers here? =A0If so, the=
n why?

I believe so, waiting is ordered vs. alive and ready, one barrier is
for each.  Do you want the answers to these questions here or in the
code?  I had comments for every barrier use during development, but it
made it too hard to follow the flow of the code.  I could add a
comment describing the ordering requirements instead, but it's still
hard to translate that to the required barrier locations.

>> +
>> + =A0 =A0 coupled->requested_state[dev->cpu] =3D CPUIDLE_COUPLED_NOT_IDL=
E;
>> +}
>> +
>> +/**
>> + * cpuidle_enter_state_coupled - attempt to enter a state with coupled =
cpus
>> + * @dev: struct cpuidle_device for the current cpu
>> + * @drv: struct cpuidle_driver for the platform
>> + * @next_state: index of the requested state in drv->states
>> + *
>> + * Coordinate with coupled cpus to enter the target state. =A0This is a=
 two
>> + * stage process. =A0In the first stage, the cpus are operating indepen=
dently,
>> + * and may call into cpuidle_enter_state_coupled at completely differen=
t times.
>> + * To save as much power as possible, the first cpus to call this funct=
ion will
>> + * go to an intermediate state (the cpuidle_device's safe state), and w=
ait for
>> + * all the other cpus to call this function. =A0Once all coupled cpus a=
re idle,
>> + * the second stage will start. =A0Each coupled cpu will spin until all=
 cpus have
>> + * guaranteed that they will call the target_state.
>
> It would be good to mention the conditions for calling this function (eg.
> interrupts disabled on the local CPU).

OK.

>> + */
>> +int cpuidle_enter_state_coupled(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_driver *drv, int next_state)
>> +{
>> + =A0 =A0 int entered_state =3D -1;
>> + =A0 =A0 struct cpuidle_coupled *coupled =3D dev->coupled;
>> + =A0 =A0 int alive;
>> +
>> + =A0 =A0 if (!coupled)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 BUG_ON(atomic_read(&coupled->ready_count));
>
> Again, I'd do a WARN_ON() and return error code from here (to avoid crash=
ing
> the kernel).
Same as above, if ready_count is not 0 here then the counters are out
of sync and something is about to go horribly wrong, like cutting
power to a running cpu.

>> + =A0 =A0 cpuidle_coupled_set_waiting(dev, coupled, next_state);
>> +
>> +retry:
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Wait for all coupled cpus to be idle, using the deepest s=
tate
>> + =A0 =A0 =A0* allowed for a single cpu.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 while (!need_resched() && !cpuidle_coupled_cpus_waiting(couple=
d)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 entered_state =3D cpuidle_enter_state(dev, drv,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->safe_state_index);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 local_irq_enable();
>> + =A0 =A0 =A0 =A0 =A0 =A0 while (cpumask_test_cpu(dev->cpu, &cpuidle_cou=
pled_poked_mask))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>
> Hmm. =A0What exactly is this loop supposed to achieve?
This is to ensure that the outstanding wakeups have been processed so
we don't go to idle with an interrupt pending an immediately wake up.

>> + =A0 =A0 =A0 =A0 =A0 =A0 local_irq_disable();
>
> Anyway, you seem to be calling it twice along with this enabling/disablin=
g of
> interrupts. =A0I'd put that into a separate function and explain its role=
 in a
> kerneldoc comment.

I left it here to be obvious that I was enabling interrupts in the
idle path, but I can refactor it out if you prefer.

>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* give a chance to process any remaining pokes */
>> + =A0 =A0 local_irq_enable();
>> + =A0 =A0 while (cpumask_test_cpu(dev->cpu, &cpuidle_coupled_poked_mask))
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> + =A0 =A0 local_irq_disable();
>> +
>> + =A0 =A0 if (need_resched()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_coupled_set_not_waiting(dev, coupled);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* All coupled cpus are probably idle. =A0There is a small c=
hance that
>> + =A0 =A0 =A0* one of the other cpus just became active. =A0Increment a =
counter when
>> + =A0 =A0 =A0* ready, and spin until all coupled cpus have incremented t=
he counter.
>> + =A0 =A0 =A0* Once a cpu has incremented the counter, it cannot abort i=
dle and must
>> + =A0 =A0 =A0* spin until either the count has hit alive_count, or anoth=
er cpu
>> + =A0 =A0 =A0* leaves idle.
>> + =A0 =A0 =A0*/
>> +
>> + =A0 =A0 smp_mb__before_atomic_inc();
>> + =A0 =A0 atomic_inc(&coupled->ready_count);
>> + =A0 =A0 smp_mb__after_atomic_inc();
>
> It seems that at least one of these barriers is unnecessary ...
The first is to ensure ordering between ready_count and waiting count,
the second is for ready_count vs. alive_count and requested_state.

>> + =A0 =A0 /* alive_count can't change while ready_count > 0 */
>> + =A0 =A0 alive =3D atomic_read(&coupled->alive_count);
>> + =A0 =A0 while (atomic_read(&coupled->ready_count) !=3D alive) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Check if any other cpus bailed out of idle.=
 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!cpuidle_coupled_cpus_waiting(coupled)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 atomic_dec(&coupled->ready_cou=
nt);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 smp_mb__after_atomic_dec();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto retry;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* all cpus have acked the coupled state */
>> + =A0 =A0 smp_rmb();
>
> What is the barrier here for?
This protects ready_count vs. requested_state.  It is already
implicitly protected by the atomic_inc_return in set_waiting, but I
thought it would be better to protect it explicitly here.  I think I
added the smp_mb__after_atomic_inc above later, which makes this one
superflous, so I'll drop it.

>> +
>> + =A0 =A0 next_state =3D cpuidle_coupled_get_state(dev, coupled);
>> +
>> + =A0 =A0 entered_state =3D cpuidle_enter_state(dev, drv, next_state);
>> +
>> + =A0 =A0 cpuidle_coupled_set_not_waiting(dev, coupled);
>> + =A0 =A0 atomic_dec(&coupled->ready_count);
>> + =A0 =A0 smp_mb__after_atomic_dec();
>> +
>> +out:
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Normal cpuidle states are expected to return with irqs en=
abled.
>> + =A0 =A0 =A0* That leads to an inefficiency where a cpu receiving an in=
terrupt
>> + =A0 =A0 =A0* that brings it out of idle will process that interrupt be=
fore
>> + =A0 =A0 =A0* exiting the idle enter function and decrementing ready_co=
unt. =A0All
>> + =A0 =A0 =A0* other cpus will need to spin waiting for the cpu that is =
processing
>> + =A0 =A0 =A0* the interrupt. =A0If the driver returns with interrupts d=
isabled,
>> + =A0 =A0 =A0* all other cpus will loop back into the safe idle state in=
stead of
>> + =A0 =A0 =A0* spinning, saving power.
>> + =A0 =A0 =A0*
>> + =A0 =A0 =A0* Calling local_irq_enable here allows coupled states to re=
turn with
>> + =A0 =A0 =A0* interrupts disabled, but won't cause problems for drivers=
 that
>> + =A0 =A0 =A0* exit with interrupts enabled.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 local_irq_enable();
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Wait until all coupled cpus have exited idle. =A0There is=
 no risk that
>> + =A0 =A0 =A0* a cpu exits and re-enters the ready state because this cp=
u has
>> + =A0 =A0 =A0* already decremented its waiting_count.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 while (atomic_read(&coupled->ready_count) !=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> +
>> + =A0 =A0 smp_rmb();
>
> And here?

This was to protect ready_count vs. looping back in and reading
alive_count.  There will be plenty of synchronization calls between
the two with implicit barriers, but I thought it was better to do it
explicitly.

>> +
>> + =A0 =A0 return entered_state;
>> +}
>> +
>> +/**
>> + * cpuidle_coupled_register_device - register a coupled cpuidle device
>> + * @dev: struct cpuidle_device for the current cpu
>> + *
>> + * Called from cpuidle_register_device to handle coupled idle init. =A0=
Finds the
>> + * cpuidle_coupled struct for this set of coupled cpus, or creates one =
if none
>> + * exists yet.
>> + */
>> +int cpuidle_coupled_register_device(struct cpuidle_device *dev)
>> +{
>> + =A0 =A0 int cpu;
>> + =A0 =A0 struct cpuidle_device *other_dev;
>> + =A0 =A0 struct call_single_data *csd;
>> + =A0 =A0 struct cpuidle_coupled *coupled;
>> +
>> + =A0 =A0 if (cpumask_empty(&dev->coupled_cpus))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 for_each_cpu_mask(cpu, dev->coupled_cpus) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 other_dev =3D per_cpu(cpuidle_devices, cpu);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (other_dev && other_dev->coupled) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 coupled =3D other_dev->coupled;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto have_coupled;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* No existing coupled info found, create a new one */
>> + =A0 =A0 coupled =3D kzalloc(sizeof(struct cpuidle_coupled), GFP_KERNEL=
);
>> + =A0 =A0 if (!coupled)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 coupled->coupled_cpus =3D dev->coupled_cpus;
>> + =A0 =A0 for_each_cpu_mask(cpu, coupled->coupled_cpus)
>> + =A0 =A0 =A0 =A0 =A0 =A0 coupled->requested_state[dev->cpu] =3D CPUIDLE=
_COUPLED_DEAD;
>> +
>> +have_coupled:
>> + =A0 =A0 dev->coupled =3D coupled;
>> + =A0 =A0 BUG_ON(!cpumask_equal(&dev->coupled_cpus, &coupled->coupled_cp=
us));
>> +
>> + =A0 =A0 if (cpu_online(dev->cpu)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 coupled->requested_state[dev->cpu] =3D CPUIDLE=
_COUPLED_NOT_IDLE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 atomic_inc(&coupled->alive_count);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 coupled->refcnt++;
>> +
>> + =A0 =A0 csd =3D &per_cpu(cpuidle_coupled_poke_cb, dev->cpu);
>> + =A0 =A0 csd->func =3D cpuidle_coupled_poked;
>> + =A0 =A0 csd->info =3D (void *)(unsigned long)dev->cpu;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/**
>> + * cpuidle_coupled_unregister_device - unregister a coupled cpuidle dev=
ice
>> + * @dev: struct cpuidle_device for the current cpu
>> + *
>> + * Called from cpuidle_unregister_device to tear down coupled idle. =A0=
Removes the
>> + * cpu from the coupled idle set, and frees the cpuidle_coupled_info st=
ruct if
>> + * this was the last cpu in the set.
>> + */
>> +void cpuidle_coupled_unregister_device(struct cpuidle_device *dev)
>> +{
>> + =A0 =A0 struct cpuidle_coupled *coupled =3D dev->coupled;
>> +
>> + =A0 =A0 if (cpumask_empty(&dev->coupled_cpus))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 if (--coupled->refcnt)
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(coupled);
>> + =A0 =A0 dev->coupled =3D NULL;
>> +}
>> +
>> +/**
>> + * cpuidle_coupled_cpu_set_alive - adjust alive_count during hotplug tr=
ansitions
>> + * @cpu: target cpu number
>> + * @alive: whether the target cpu is going up or down
>> + *
>> + * Run on the cpu that is bringing up the target cpu, before the target=
 cpu
>> + * has been booted, or after the target cpu is completely dead.
>> + */
>> +static void cpuidle_coupled_cpu_set_alive(int cpu, bool alive)
>> +{
>> + =A0 =A0 struct cpuidle_device *dev;
>> + =A0 =A0 struct cpuidle_coupled *coupled;
>> +
>> + =A0 =A0 mutex_lock(&cpuidle_lock);
>> +
>> + =A0 =A0 dev =3D per_cpu(cpuidle_devices, cpu);
>> + =A0 =A0 if (!dev->coupled)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 coupled =3D dev->coupled;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* waiting_count must be at least 1 less than alive_count, b=
ecause
>> + =A0 =A0 =A0* this cpu is not waiting. =A0Spin until all cpus have noti=
ced this cpu
>> + =A0 =A0 =A0* is not idle and exited the ready loop before changing ali=
ve_count.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 while (atomic_read(&coupled->ready_count))
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> +
>> + =A0 =A0 if (alive) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 smp_mb__before_atomic_inc();
>> + =A0 =A0 =A0 =A0 =A0 =A0 atomic_inc(&coupled->alive_count);
>> + =A0 =A0 =A0 =A0 =A0 =A0 smp_mb__after_atomic_inc();
>> + =A0 =A0 =A0 =A0 =A0 =A0 coupled->requested_state[dev->cpu] =3D CPUIDLE=
_COUPLED_NOT_IDLE;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 smp_mb__before_atomic_dec();
>> + =A0 =A0 =A0 =A0 =A0 =A0 atomic_dec(&coupled->alive_count);
>> + =A0 =A0 =A0 =A0 =A0 =A0 smp_mb__after_atomic_dec();
>> + =A0 =A0 =A0 =A0 =A0 =A0 coupled->requested_state[dev->cpu] =3D CPUIDLE=
_COUPLED_DEAD;
>
> There's too many SMP barriers above, but I'm not quite sure which of them=
 (if
> any) are really necessary.
The ones before order ready_count vs alive_count, the ones after order
alive_count vs. requested_state and future waiting_count increments.

>> + =A0 =A0 }
>> +
>> +out:
>> + =A0 =A0 mutex_unlock(&cpuidle_lock);
>> +}
>> +
>> +/**
>> + * cpuidle_coupled_cpu_notify - notifier called during hotplug transiti=
ons
>> + * @nb: notifier block
>> + * @action: hotplug transition
>> + * @hcpu: target cpu number
>> + *
>> + * Called when a cpu is brought on or offline using hotplug. =A0Updates=
 the
>> + * coupled cpu set appropriately
>> + */
>> +static int cpuidle_coupled_cpu_notify(struct notifier_block *nb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned long action, void *hcpu)
>> +{
>> + =A0 =A0 int cpu =3D (unsigned long)hcpu;
>> +
>> + =A0 =A0 switch (action & ~CPU_TASKS_FROZEN) {
>> + =A0 =A0 case CPU_DEAD:
>> + =A0 =A0 case CPU_UP_CANCELED:
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_coupled_cpu_set_alive(cpu, false);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case CPU_UP_PREPARE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_coupled_cpu_set_alive(cpu, true);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> + =A0 =A0 return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block cpuidle_coupled_cpu_notifier =3D {
>> + =A0 =A0 .notifier_call =3D cpuidle_coupled_cpu_notify,
>> +};
>> +
>> +static int __init cpuidle_coupled_init(void)
>> +{
>> + =A0 =A0 return register_cpu_notifier(&cpuidle_coupled_cpu_notifier);
>> +}
>> +core_initcall(cpuidle_coupled_init);
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index 4540672..e81cfda 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -171,7 +171,11 @@ int cpuidle_idle_call(void)
>> =A0 =A0 =A0 trace_power_start_rcuidle(POWER_CSTATE, next_state, dev->cpu=
);
>> =A0 =A0 =A0 trace_cpu_idle_rcuidle(next_state, dev->cpu);
>>
>> - =A0 =A0 entered_state =3D cpuidle_enter_state(dev, drv, next_state);
>> + =A0 =A0 if (cpuidle_state_is_coupled(dev, drv, next_state))
>> + =A0 =A0 =A0 =A0 =A0 =A0 entered_state =3D cpuidle_enter_state_coupled(=
dev, drv,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 next_state);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 entered_state =3D cpuidle_enter_state(dev, drv=
, next_state);
>>
>> =A0 =A0 =A0 trace_power_end_rcuidle(dev->cpu);
>> =A0 =A0 =A0 trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
>> @@ -407,9 +411,16 @@ static int __cpuidle_register_device(struct cpuidle=
_device *dev)
>> =A0 =A0 =A0 if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_sysfs;
>>
>> + =A0 =A0 ret =3D cpuidle_coupled_register_device(dev);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_coupled;
>> +
>> =A0 =A0 =A0 dev->registered =3D 1;
>> =A0 =A0 =A0 return 0;
>>
>> +err_coupled:
>> + =A0 =A0 cpuidle_remove_sysfs(cpu_dev);
>> + =A0 =A0 wait_for_completion(&dev->kobj_unregister);
>> =A0err_sysfs:
>> =A0 =A0 =A0 list_del(&dev->device_list);
>> =A0 =A0 =A0 per_cpu(cpuidle_devices, dev->cpu) =3D NULL;
>> @@ -464,6 +475,8 @@ void cpuidle_unregister_device(struct cpuidle_device=
 *dev)
>> =A0 =A0 =A0 wait_for_completion(&dev->kobj_unregister);
>> =A0 =A0 =A0 per_cpu(cpuidle_devices, dev->cpu) =3D NULL;
>>
>> + =A0 =A0 cpuidle_coupled_unregister_device(dev);
>> +
>> =A0 =A0 =A0 cpuidle_resume_and_unlock();
>>
>> =A0 =A0 =A0 module_put(cpuidle_driver->owner);
>> diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
>> index d8a3ccc..76e7f69 100644
>> --- a/drivers/cpuidle/cpuidle.h
>> +++ b/drivers/cpuidle/cpuidle.h
>> @@ -32,4 +32,34 @@ extern int cpuidle_enter_state(struct cpuidle_device =
*dev,
>> =A0extern int cpuidle_add_sysfs(struct device *dev);
>> =A0extern void cpuidle_remove_sysfs(struct device *dev);
>>
>> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>> +bool cpuidle_state_is_coupled(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_driver *drv, int state);
>> +int cpuidle_enter_state_coupled(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_driver *drv, int next_state);
>> +int cpuidle_coupled_register_device(struct cpuidle_device *dev);
>> +void cpuidle_coupled_unregister_device(struct cpuidle_device *dev);
>> +#else
>> +static inline bool cpuidle_state_is_coupled(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_driver *drv, int state)
>> +{
>> + =A0 =A0 return false;
>> +}
>> +
>> +static inline int cpuidle_enter_state_coupled(struct cpuidle_device *de=
v,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_driver *drv, int next_state)
>> +{
>> + =A0 =A0 return -1;
>> +}
>> +
>> +static inline int cpuidle_coupled_register_device(struct cpuidle_device=
 *dev)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static inline void cpuidle_coupled_unregister_device(struct cpuidle_dev=
ice *dev)
>> +{
>> +}
>> +#endif
>> +
>> =A0#endif /* __DRIVER_CPUIDLE_H */
>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>> index 6c26a3d..6038448 100644
>> --- a/include/linux/cpuidle.h
>> +++ b/include/linux/cpuidle.h
>> @@ -57,6 +57,7 @@ struct cpuidle_state {
>>
>> =A0/* Idle State Flags */
>> =A0#define CPUIDLE_FLAG_TIME_VALID =A0 =A0 =A0(0x01) /* is residency tim=
e measurable? */
>> +#define CPUIDLE_FLAG_COUPLED (0x02) /* state applies to multiple cpus */
>>
>> =A0#define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
>>
>> @@ -100,6 +101,12 @@ struct cpuidle_device {
>> =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0device_list;
>> =A0 =A0 =A0 struct kobject =A0 =A0 =A0 =A0 =A0kobj;
>> =A0 =A0 =A0 struct completion =A0 =A0 =A0 kobj_unregister;
>> +
>> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 safe_state_index;
>> + =A0 =A0 cpumask_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 coupled_cpus;
>> + =A0 =A0 struct cpuidle_coupled =A0*coupled;
>> +#endif
>> =A0};
>>
>> =A0DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
>
> Thanks,
> Rafael
