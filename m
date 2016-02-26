From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Thu, 25 Feb 2016 16:34:23 -0800
Message-ID: <56CF9D8F.7010607@linaro.org>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
 <1456190570-4475-4-git-send-email-smuckle@linaro.org>
 <8427745.Y8N2bqC3SO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8427745.Y8N2bqC3SO@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>
List-Id: linux-pm@vger.kernel.org

On 02/24/2016 07:55 PM, Rafael J. Wysocki wrote:
> Hi,
> 
> I promised a review and here it goes.

Thanks Rafael for your detailed review.

> 
> Let me focus on this one as the rest seems to depend on it.
> 
> On Monday, February 22, 2016 05:22:43 PM Steve Muckle wrote:
>> From: Michael Turquette <mturquette@baylibre.com>
>>
>> Scheduler-driven CPU frequency selection hopes to exploit both
>> per-task and global information in the scheduler to improve frequency
>> selection policy, achieving lower power consumption, improved
>> responsiveness/performance, and less reliance on heuristics and
>> tunables. For further discussion on the motivation of this integration
>> see [0].
>>
>> This patch implements a shim layer between the Linux scheduler and the
>> cpufreq subsystem. The interface accepts capacity requests from the
>> CFS, RT and deadline sched classes. The requests from each sched class
>> are summed on each CPU with a margin applied to the CFS and RT
>> capacity requests to provide some headroom. Deadline requests are
>> expected to be precise enough given their nature to not require
>> headroom. The maximum total capacity request for a CPU in a frequency
>> domain drives the requested frequency for that domain.
>>
>> Policy is determined by both the sched classes and this shim layer.
>>
>> Note that this algorithm is event-driven. There is no polling loop to
>> check cpu idle time nor any other method which is unsynchronized with
>> the scheduler, aside from an optional throttling mechanism.
>>
>> Thanks to Juri Lelli <juri.lelli@arm.com> for contributing design ideas,
>> code and test results, and to Ricky Liang <jcliang@chromium.org>
>> for initialization and static key inc/dec fixes.
>>
>> [0] http://article.gmane.org/gmane.linux.kernel/1499836
>>
>> [smuckle@linaro.org: various additions and fixes, revised commit text]
> 
> Well, the changelog is still a bit terse in my view.  It should at least
> describe the design somewhat (mention the static keys and how they are
> used etc) end explain why the things are done this way. 

Sure. Will add more, including the details you mention.

> 
...
>>  /*********************************************************************
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index a292c4b..27a6cd8 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -937,6 +937,14 @@ enum cpu_idle_type {
>>  #define SCHED_CAPACITY_SHIFT	10
>>  #define SCHED_CAPACITY_SCALE	(1L << SCHED_CAPACITY_SHIFT)
>>  
>> +struct sched_capacity_reqs {
>> +	unsigned long cfs;
>> +	unsigned long rt;
>> +	unsigned long dl;
>> +
>> +	unsigned long total;
>> +};
> 
> Without a comment explaining what this represents it is quite hard to
> decode it.

This is the per-CPU representation of capacity requests from each sched
class. The scale of the cfs, rt, and dl capacity numbers are 0 to
SCHED_CAPACITY_SCALE. I'll add a comment here.

> 
>> +
>>  /*
>>   * Wake-queues are lists of tasks with a pending wakeup, whose
>>   * callers have already marked the task as woken internally,
>> diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
>> index 6768797..90ed832 100644
>> --- a/kernel/sched/Makefile
>> +++ b/kernel/sched/Makefile
>> @@ -19,3 +19,4 @@ obj-$(CONFIG_SCHED_AUTOGROUP) += auto_group.o
>>  obj-$(CONFIG_SCHEDSTATS) += stats.o
>>  obj-$(CONFIG_SCHED_DEBUG) += debug.o
>>  obj-$(CONFIG_CGROUP_CPUACCT) += cpuacct.o
>> +obj-$(CONFIG_CPU_FREQ_GOV_SCHED) += cpufreq_sched.o
>> diff --git a/kernel/sched/cpufreq_sched.c b/kernel/sched/cpufreq_sched.c
>> new file mode 100644
>> index 0000000..a113e4e
>> --- /dev/null
>> +++ b/kernel/sched/cpufreq_sched.c
>> @@ -0,0 +1,459 @@
>> +/*
> 
> Any chance to add one sentence about what's in the file?

Sure, will do.

> 
> Besides, governors traditionally go to drivers/cpufreq.  Why is this different?

This predates my involvement but I'm guessing this was done because the
long term vision was for cpufreq to eventually be removed from the
picture. But it may be quite some time before that happens - I think
communicating directly with drivers may be difficult due to the need to
synchronize with thermal or userspace min/max requests etc, plus there's
the fact that we've got a longstanding API exposed to userspace.

I'm happy to move this to drivers/cpufreq.

> 
>> + *  Copyright (C)  2015 Michael Turquette <mturquette@linaro.org>
>> + *  Copyright (C)  2015-2016 Steve Muckle <smuckle@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/cpufreq.h>
>> +#include <linux/module.h>
>> +#include <linux/kthread.h>
>> +#include <linux/percpu.h>
>> +#include <linux/irq_work.h>
>> +#include <linux/delay.h>
>> +#include <linux/string.h>
>> +
>> +#include "sched.h"
>> +
>> +struct static_key __read_mostly __sched_freq = STATIC_KEY_INIT_FALSE;
> 
> Well, I'm not familiar with static keys and how they work, so you'll need to
> explain this part to me.  I'm assuming that there is some magic related to
> the value of the key that changes set_*_cpu_capacity() into no-ops when the
> key is 0, presumably by modifying kernel code.

That's correct.

> 
> So this is clever but tricky and my question here is why it is necessary.
> 
> For example, compared to the RCU-based approach I'm using, how much better
> this is?  Yes, there is some tiny overhead related to the checking if callbacks
> are present and invoking them, but is it really so bad?  Can you actually
> measure the different in any realistic workload?

I have not tried to measure any difference. We erred on the side of
caution to avoid impacting the scheduler hot paths entirely if possible.

> One thing I personally like in the RCU-based approach is its universality.  The
> callbacks may be installed by different entities in a uniform way: intel_pstate
> can do that, the old governors can do that, my experimental schedutil code can
> do that and your code could have done that too in principle.  And this is very
> nice, because it is a common underlying mechanism that can be used by everybody
> regardless of their particular implementations on the other side.
> 
> Why would I want to use something different, then?

I've got nothing against a callback registration mechanism. As you
mentioned in another mail it could itself use static keys, enabling the
static key when a callback is registered and disabling it otherwise to
avoid calling into cpufreq_update_util().

> 
>> +static bool __read_mostly cpufreq_driver_slow;
>> +
>> +/*
>> + * The number of enabled schedfreq policies is modified during GOV_START/STOP.
>> + * It, along with whether the schedfreq static key is enabled, is protected by
>> + * the gov_enable_lock.
>> + */
> 
> Well, it would be good to explain what the role of the number of enabled_policies is
> at least briefly.

It's just that if the number of enabled policies is > 0, the static key
must be enabled so that the callbacks work. I'll clarify that in the
comment here.

> 
>> +static int enabled_policies;
>> +static DEFINE_MUTEX(gov_enable_lock);
>> +
>> +#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_SCHED
>> +static struct cpufreq_governor cpufreq_gov_sched;
>> +#endif
> 
> I don't think you need the #ifndef any more after recent changes in linux-next.

Ah I've been based on tip/sched/core. I should probably move over to
linux-next. Will do so and check this.

> 
>> +
>> +/*
>> + * Capacity margin added to CFS and RT capacity requests to provide
>> + * some head room if task utilization further increases.
>> + */
> 
> OK, where does this number come from?

Someone's posterior :) .

This really should be a tunable IMO, but there's a fairly strong
anti-tunable sentiment, so it's been left hard-coded in an attempt to
provide something that "just works."

At the least I can add a comment saying that the 20% idle headroom
requirement was an off the cuff estimate and that at this time, we don't
have significant data to suggest it's the best number.

> 
...
>> +static bool finish_last_request(struct gov_data *gd)
>> +{
>> +	ktime_t now = ktime_get();
>> +
>> +	if (ktime_after(now, gd->throttle))
>> +		return false;
>> +
>> +	while (1) {
> 
> I would write this as
> 
> 	do {
> 
>> +		int usec_left = ktime_to_ns(ktime_sub(gd->throttle, now));
>> +
>> +		usec_left /= NSEC_PER_USEC;
>> +		usleep_range(usec_left, usec_left + 100);
>> +		now = ktime_get();
> 
> 	} while (ktime_before(now, gd->throttle));
> 
> 	return true;
> 
> But maybe that's just me. :-)

I agree that's cleaner, will change it.

> 
>> +		if (ktime_after(now, gd->throttle))
>> +			return true;
>> +	}
>> +}
> 
> I'm not a big fan of this throttling mechanism overall, but more about that later.
> 
>> +
>> +static int cpufreq_sched_thread(void *data)
>> +{
> 
> Now, what really is the advantage of having those extra threads vs using
> workqueues?
> 
> I guess the underlying concern is that RT tasks may stall workqueues indefinitely
> in theory and then the frequency won't be updated, but there's much more kernel
> stuff run from workqueues and if that is starved, you won't get very far anyway.
> 
> If you take special measures to prevent frequency change requests from being
> stalled by RT tasks, question is why are they so special?  Aren't there any
> other kernel activities that also should be protected from that and may be
> more important than CPU frequency changes?

I think updating the CPU frequency during periods of heavy RT/DL load is
one of the most (if not the most) important things. I can't speak for
other system activities that may get blocked, but there's an opportunity
to protect CPU frequency changes here, and it seems worth taking to me.

> 
> Plus if this really is the problem here, then it also affects the other cpufreq
> governors, so maybe it should be solved for everybody in some common way?

Agreed, I'd think a freq change thread that serves frequency change
requests would be a useful common component. The locking and throttling
(slowpath_lock, finish_last_request()) are somewhat specific to this
implementation, but could probably be done generically and maybe even
used in other governors. If you're okay with it though I'd like to view
that as a slightly longer term effort, as I think it would get unwieldy
trying to do that as part of this initial change.

> 
...
>> +
>> +static void cpufreq_sched_irq_work(struct irq_work *irq_work)
>> +{
>> +	struct gov_data *gd;
>> +
>> +	gd = container_of(irq_work, struct gov_data, irq_work);
>> +	if (!gd)
>> +		return;
>> +
>> +	wake_up_process(gd->task);
> 
> I'm wondering what would be wrong with writing it as
> 
> 	if (gd)
> 		wake_up_process(gd->task);
> 
> And can gd turn out to be NULL here in any case?

In practice I don't think this would ever happen, but there's not
anything that would guarantee the policy can't be stopped and exit while
one of these irq_works is in flight. This would free not only gd but the
the irq_work structure itself.

Rather than check if gd is NULL here I think synchronization is required
to flush an in flight irq_work when the policy is being stopped. I will
add an irq_work_sync in the policy stop path and remove the NULL check.

> 
>> +}
>> +
>> +static void update_fdomain_capacity_request(int cpu)
>> +{
>> +	unsigned int freq_new, index_new, cpu_tmp;
>> +	struct cpufreq_policy *policy;
>> +	struct gov_data *gd = per_cpu(cpu_gov_data, cpu);
>> +	unsigned long capacity = 0;
>> +
>> +	if (!gd)
>> +		return;
>> +
> 
> Why is this check necessary?

As soon as one policy in the system uses scheduler-guided frequency the
static key will be enabled and all CPUs will be calling into the
scheduler hooks and can potentially come through this path. But some
CPUs may not be part of a scheduler-guided frequency policy. Those CPUs
will have a NULL gov_data pointer.

That being said, I think this test should be moved up into
update_cpu_capacity_request() to avoid that computation when it is not
required. Better still would be bailing when required in the
set_*_cpu_capacity() macros in kernel/sched/sched.h. I'll see if I can
do that instead.

> 
>> +	/* interrupts already disabled here via rq locked */
>> +	raw_spin_lock(&gd->fastpath_lock);
> 
> Well, if you compare this with the one-CPU-per-policy path in my experimental
> schedutil governor code with the "fast switch" patch on top, you'll notice that
> it doesn't use any locks and/or atomic ops.  That's very much on purpose and
> here's where your whole gain from using static keys practically goes away.

Sure, I like the idea of special fast callbacks for the simple case of
UP frequency domains and will add it to the list of things to do here.

The static key is really a separate issue IMO as it's about minimizing
the impact of this feature on scheduler hot paths when schedfreq is not
enabled.

> 
>> +
>> +	policy = gd->policy;
>> +
>> +	for_each_cpu(cpu_tmp, policy->cpus) {
>> +		struct sched_capacity_reqs *scr;
>> +
>> +		scr = &per_cpu(cpu_sched_capacity_reqs, cpu_tmp);
>> +		capacity = max(capacity, scr->total);
>> +	}
> 
> You could save a few cycles from this in the case when the policy is not
> shared.

Agreed. Will look at making special UP paths.

> 
>> +
>> +	freq_new = capacity * policy->max >> SCHED_CAPACITY_SHIFT;
> 
> Where does this formula come from?

Capacity here is 0 to SCHED_CAPACITY_SCALE, so this is translating the
capacity request to a frequency request via
(capacity/SCHED_CAPACITY_SCALE) * policy->max. I'll add a comment to
this effect.

The race with policy->max potentially changing also deserves a comment.
If policy->max changes say just before we read it here to do this
translation, the scheduler PELT numbers will still largely be based on
the old policy->max value, because they are an exponential moving
average and will take time to re-adjust. So at least for now I'm
ignoring this race as I don't think it's really meaningful to attempt
any synchronization.

> 
>> +
>> +	/*
>> +	 * Calling this without locking policy->rwsem means we race
>> +	 * against changes with policy->min and policy->max. This should
>> +	 * be okay though.
>> +	 */
>> +	if (cpufreq_frequency_table_target(policy, policy->freq_table,
>> +					   freq_new, CPUFREQ_RELATION_L,
>> +					   &index_new))
>> +		goto out;
> 
> __cpufreq_driver_target() will call this again, so isn't calling it here
> a bit wasteful?

I wanted to avoid waking up the frequency change thread (an expensive
operation) whenever possible, or even making an unnecessary fastpath
frequency request, so translating the raw frequency request to a
supported target frequency allows us to bail if the actual requested
target frequency will end up being the same as the current one. I
thought this was more valuable than the extra table lookup here.

Actually, I could make this better by storing the next lower frequency
than the current frequency as well as the current frequency - this would
allow me to do a much simpler test to see if we'd end up requesting the
same frequency or something different.

> 
>> +	freq_new = policy->freq_table[index_new].frequency;
>> +
>> +	if (freq_new == gd->requested_freq)
>> +		goto out;
>> +
> 
> Again, the above generally is a mistake for reasons explained earlier.

(skipping per the other email)

> 
>> +	gd->requested_freq = freq_new;
>> +
>> +	if (cpufreq_driver_slow || !mutex_trylock(&gd->slowpath_lock)) {
> 
> This really doesn't look good to me.
> 
> Why is the mutex needed here in the first place?  cpufreq_sched_stop() should
> be able to make sure that this function won't be run again for the policy
> without using this lock.

The acquisition of the slowpath_lock here isn't for synchronizing with
the policy being stopped - that's handled differently via the smp call
in the stop routine.

Rather it may be the case that schedfreq runs both in the fast and slow
path on a target (maybe because of throttling, or because a previously
started asynchronous transition isn't done yet). If that is so, then
when the slow path is active, I do not want to attempt a transition in
the fast path.

> 
>> +		irq_work_queue_on(&gd->irq_work, cpu);
> 
> I hope that you are aware of the fact that irq_work_queue_on() explodes
> on uniprocessor ARM32 if you run an SMP kernel on it?

No, I wasn't. Fortunately I think switching it to irq_work_queue() to
run the irq_work on the same CPU as the fast path should be fine
(assuming there's no similar landmine there).

> 
> And what happens in the !cpufreq_driver_is_slow() case when we don't
> initialize the irq_work?

That's a bug, the irq_work should always be initialized. Will fix.

> 
>> +	} else if (policy->transition_ongoing ||
>> +		   ktime_before(ktime_get(), gd->throttle)) {
> 
> If this really runs in the scheduler paths, you don't want to have ktime_get()
> here.

I'll switch this to be sched_clock() based.

> 
>> +		mutex_unlock(&gd->slowpath_lock);
>> +		irq_work_queue_on(&gd->irq_work, cpu);
> 
> Allright.
> 
> I think I have figured out how this is arranged, but I may be wrong. :-)
> 
> Here's my understanding of it.  If we are throttled, we don't just skip the
> request.  Instead, we wake up the gd thread kind of in the hope that the
> throttling may end when it actually wakes up.  So in fact we poke at the
> gd thread on a regular basis asking it "Are you still throttled?" and that
> happens on every call from the scheduler until the throttling is over if
> I'm not mistaken.  This means that during throttling every call from the
> scheduler generates an irq_work that wakes up the gd thread just to make it
> check if it still is throttled and go to sleep again.  Please tell me
> that I haven't understood this correctly.

Sorry, yes this should be doing something much more intelligent such as
checking to see if the freq thread is already due to wake up at some
point, and setting a timer for it if not.

> 
> The above aside, I personally think that rate limitting should happen at the source
> and not at the worker thread level.  So if you're throttled, you should just
> return immediately from this function without generating any more work.  That,
> BTW, is what the sampling rate in my code is for.

I will work on modifying the throttling here to be more sane.

> 
>> +	} else {
>> +		cpufreq_sched_try_driver_target(policy, freq_new);
> 
> Well, this is supposed to be the fast path AFAICS.
> 
> Did you actually look at what __cpufreq_driver_target() does in general?
> Including the wait_event() in cpufreq_freq_transition_begin() to mention just
> one suspicious thing?  And how much overhead it generates in the most general
> case?
> 
> No, running *that* from the fast path is not a good idea.  Quite honestly,
> you'd need a new driver callback and a new way to run it from the cpufreq core
> to implement this in a reasonably efficient way.

Yes I'm aware of the wait_event(). I've attempted to work around it by
ensuring schedfreq does not issue a __cpufreq_driver_target attempt
while a transition is in flight (transition_ongoing), and ensuring the
slow and fast paths can't race. I'm not sure yet whether this is enough
if something like thermal or userspace changes min/max, whether that can
independently start a transition that may cause a fast path request here
to block. This governor does not use the dbs stuff.

While it's not exactly lean, I didn't see anything else in
__cpufreq_driver_target() that looked really terrible.

I've nothing against a new fast switch driver interface. It may be nice
to support unmodified drivers in the fast path as well, if it can be
made to work, even though it may not be optimal.

> 
>> +		mutex_unlock(&gd->slowpath_lock);
>> +	}
>> +
>> +out:
>> +	raw_spin_unlock(&gd->fastpath_lock);
>> +}
>> +
>> +void update_cpu_capacity_request(int cpu, bool request)
>> +{
>> +	unsigned long new_capacity;
>> +	struct sched_capacity_reqs *scr;
>> +
>> +	/* The rq lock serializes access to the CPU's sched_capacity_reqs. */
>> +	lockdep_assert_held(&cpu_rq(cpu)->lock);
>> +
>> +	scr = &per_cpu(cpu_sched_capacity_reqs, cpu);
>> +
>> +	new_capacity = scr->cfs + scr->rt;
>> +	new_capacity = new_capacity * capacity_margin
>> +		/ SCHED_CAPACITY_SCALE;
>> +	new_capacity += scr->dl;
> 
> Can you please explain the formula here?

The deadline class is expected to provide precise enough capacity
requirements (since tasks admitted to it have CPU bandwidth parameters)
such that it does not require additional CPU headroom.

So we're applying the CPU headroom to the CFS and RT capacity requests
only, then adding the DL request.

I'll add a comment here.

> 
>> +
>> +	if (new_capacity == scr->total)
>> +		return;
>> +
> 
> The same mistake as before.

(assuming this is part of the same comment in the other email)

> 
...
>> +static int cpufreq_sched_stop(struct cpufreq_policy *policy)
>> +{
>> +	struct gov_data *gd = policy->governor_data;
>> +	int cpu;
>> +
>> +	/*
>> +	 * The schedfreq static key is managed here so the global schedfreq
>> +	 * lock must be taken - a per-policy lock such as policy->rwsem is
>> +	 * not sufficient.
>> +	 */
>> +	mutex_lock(&gov_enable_lock);
>> +
>> +	/*
>> +	 * The governor stop path may or may not hold policy->rwsem. There
>> +	 * must be synchronization with the slow path however.
>> +	 */
>> +	mutex_lock(&gd->slowpath_lock);
>> +
>> +	/*
>> +	 * Stop new entries into the hot path for all CPUs. This will
>> +	 * potentially affect other policies which are still running but
>> +	 * this is an infrequent operation.
>> +	 */
>> +	static_key_slow_dec(&__sched_freq);
>> +	enabled_policies--;
>> +
>> +	/*
>> +	 * Ensure that all CPUs currently part of this policy are out
>> +	 * of the hot path so that if this policy exits we can free gd.
>> +	 */
>> +	preempt_disable();
>> +	smp_call_function_many(policy->cpus, dummy, NULL, true);
>> +	preempt_enable();
> 
> I'm not sure how this works, can you please tell me?

Peter correctly interpreted my intentions.

The RCU possibility also crossed my mind. They both seemed like a bit of
a hack to me - this wouldn't really be doing any RCU per se, rather
relying on its implementation. I'll switch to RCU since that seems to be
preferred though. It's certainly cleaner to write.

> 
...
> 
> I have no comments to the rest of the patch.

Thanks again for the review.

thanks,
Steve
