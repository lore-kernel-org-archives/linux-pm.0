From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency selection
Date: Thu, 25 Feb 2016 04:55:57 +0100
Message-ID: <8427745.Y8N2bqC3SO@vostro.rjw.lan>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org> <1456190570-4475-4-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51612 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758526AbcBYDyZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2016 22:54:25 -0500
In-Reply-To: <1456190570-4475-4-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>, Juri Lelli <juri.lelli@arm.com>

Hi,

I promised a review and here it goes.

Let me focus on this one as the rest seems to depend on it.

On Monday, February 22, 2016 05:22:43 PM Steve Muckle wrote:
> From: Michael Turquette <mturquette@baylibre.com>
> 
> Scheduler-driven CPU frequency selection hopes to exploit both
> per-task and global information in the scheduler to improve frequency
> selection policy, achieving lower power consumption, improved
> responsiveness/performance, and less reliance on heuristics and
> tunables. For further discussion on the motivation of this integration
> see [0].
> 
> This patch implements a shim layer between the Linux scheduler and the
> cpufreq subsystem. The interface accepts capacity requests from the
> CFS, RT and deadline sched classes. The requests from each sched class
> are summed on each CPU with a margin applied to the CFS and RT
> capacity requests to provide some headroom. Deadline requests are
> expected to be precise enough given their nature to not require
> headroom. The maximum total capacity request for a CPU in a frequency
> domain drives the requested frequency for that domain.
> 
> Policy is determined by both the sched classes and this shim layer.
> 
> Note that this algorithm is event-driven. There is no polling loop to
> check cpu idle time nor any other method which is unsynchronized with
> the scheduler, aside from an optional throttling mechanism.
> 
> Thanks to Juri Lelli <juri.lelli@arm.com> for contributing design ideas,
> code and test results, and to Ricky Liang <jcliang@chromium.org>
> for initialization and static key inc/dec fixes.
> 
> [0] http://article.gmane.org/gmane.linux.kernel/1499836
> 
> [smuckle@linaro.org: various additions and fixes, revised commit text]

Well, the changelog is still a bit terse in my view.  It should at least
describe the design somewhat (mention the static keys and how they are
used etc) end explain why the things are done this way. 

> CC: Ricky Liang <jcliang@chromium.org>
> Signed-off-by: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Steve Muckle <smuckle@linaro.org>
> ---
>  drivers/cpufreq/Kconfig      |  21 ++
>  include/linux/cpufreq.h      |   3 +
>  include/linux/sched.h        |   8 +
>  kernel/sched/Makefile        |   1 +
>  kernel/sched/cpufreq_sched.c | 459 +++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h         |  51 +++++
>  6 files changed, 543 insertions(+)
>  create mode 100644 kernel/sched/cpufreq_sched.c
> 

[cut]

> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 93e1c1c..ce8b895 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -495,6 +495,9 @@ extern struct cpufreq_governor cpufreq_gov_ondemand;
>  #elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE)
>  extern struct cpufreq_governor cpufreq_gov_conservative;
>  #define CPUFREQ_DEFAULT_GOVERNOR	(&cpufreq_gov_conservative)
> +#elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_SCHED)
> +extern struct cpufreq_governor cpufreq_gov_sched;
> +#define CPUFREQ_DEFAULT_GOVERNOR	(&cpufreq_gov_sched)
>  #endif
>  
>  /*********************************************************************
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index a292c4b..27a6cd8 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -937,6 +937,14 @@ enum cpu_idle_type {
>  #define SCHED_CAPACITY_SHIFT	10
>  #define SCHED_CAPACITY_SCALE	(1L << SCHED_CAPACITY_SHIFT)
>  
> +struct sched_capacity_reqs {
> +	unsigned long cfs;
> +	unsigned long rt;
> +	unsigned long dl;
> +
> +	unsigned long total;
> +};

Without a comment explaining what this represents it is quite hard to
decode it.

> +
>  /*
>   * Wake-queues are lists of tasks with a pending wakeup, whose
>   * callers have already marked the task as woken internally,
> diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
> index 6768797..90ed832 100644
> --- a/kernel/sched/Makefile
> +++ b/kernel/sched/Makefile
> @@ -19,3 +19,4 @@ obj-$(CONFIG_SCHED_AUTOGROUP) += auto_group.o
>  obj-$(CONFIG_SCHEDSTATS) += stats.o
>  obj-$(CONFIG_SCHED_DEBUG) += debug.o
>  obj-$(CONFIG_CGROUP_CPUACCT) += cpuacct.o
> +obj-$(CONFIG_CPU_FREQ_GOV_SCHED) += cpufreq_sched.o
> diff --git a/kernel/sched/cpufreq_sched.c b/kernel/sched/cpufreq_sched.c
> new file mode 100644
> index 0000000..a113e4e
> --- /dev/null
> +++ b/kernel/sched/cpufreq_sched.c
> @@ -0,0 +1,459 @@
> +/*

Any chance to add one sentence about what's in the file?

Besides, governors traditionally go to drivers/cpufreq.  Why is this different?

> + *  Copyright (C)  2015 Michael Turquette <mturquette@linaro.org>
> + *  Copyright (C)  2015-2016 Steve Muckle <smuckle@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/cpufreq.h>
> +#include <linux/module.h>
> +#include <linux/kthread.h>
> +#include <linux/percpu.h>
> +#include <linux/irq_work.h>
> +#include <linux/delay.h>
> +#include <linux/string.h>
> +
> +#include "sched.h"
> +
> +struct static_key __read_mostly __sched_freq = STATIC_KEY_INIT_FALSE;

Well, I'm not familiar with static keys and how they work, so you'll need to
explain this part to me.  I'm assuming that there is some magic related to
the value of the key that changes set_*_cpu_capacity() into no-ops when the
key is 0, presumably by modifying kernel code.

So this is clever but tricky and my question here is why it is necessary.

For example, compared to the RCU-based approach I'm using, how much better
this is?  Yes, there is some tiny overhead related to the checking if callbacks
are present and invoking them, but is it really so bad?  Can you actually
measure the different in any realistic workload?

One thing I personally like in the RCU-based approach is its universality.  The
callbacks may be installed by different entities in a uniform way: intel_pstate
can do that, the old governors can do that, my experimental schedutil code can
do that and your code could have done that too in principle.  And this is very
nice, because it is a common underlying mechanism that can be used by everybody
regardless of their particular implementations on the other side.

Why would I want to use something different, then?

> +static bool __read_mostly cpufreq_driver_slow;
> +
> +/*
> + * The number of enabled schedfreq policies is modified during GOV_START/STOP.
> + * It, along with whether the schedfreq static key is enabled, is protected by
> + * the gov_enable_lock.
> + */

Well, it would be good to explain what the role of the number of enabled_policies is
at least briefly.

> +static int enabled_policies;
> +static DEFINE_MUTEX(gov_enable_lock);
> +
> +#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_SCHED
> +static struct cpufreq_governor cpufreq_gov_sched;
> +#endif

I don't think you need the #ifndef any more after recent changes in linux-next.

> +
> +/*
> + * Capacity margin added to CFS and RT capacity requests to provide
> + * some head room if task utilization further increases.
> + */

OK, where does this number come from?

> +unsigned int capacity_margin = 1280;
> +
> +static DEFINE_PER_CPU(struct gov_data *, cpu_gov_data);
> +DEFINE_PER_CPU(struct sched_capacity_reqs, cpu_sched_capacity_reqs);
> +
> +/**
> + * gov_data - per-policy data internal to the governor
> + * @throttle: next throttling period expiry. Derived from throttle_nsec
> + * @throttle_nsec: throttle period length in nanoseconds
> + * @task: worker thread for dvfs transition that may block/sleep
> + * @irq_work: callback used to wake up worker thread
> + * @policy: pointer to cpufreq policy associated with this governor data
> + * @fastpath_lock: prevents multiple CPUs in a frequency domain from racing
> + * with each other in fast path during calculation of domain frequency
> + * @slowpath_lock: mutex used to synchronize with slow path - ensure policy
> + * remains enabled, and eliminate racing between slow and fast path
> + * @enabled: boolean value indicating that the policy is started, protected
> + * by the slowpath_lock
> + * @requested_freq: last frequency requested by the sched governor
> + *
> + * struct gov_data is the per-policy cpufreq_sched-specific data
> + * structure. A per-policy instance of it is created when the
> + * cpufreq_sched governor receives the CPUFREQ_GOV_POLICY_INIT
> + * condition and a pointer to it exists in the gov_data member of
> + * struct cpufreq_policy.
> + */
> +struct gov_data {
> +	ktime_t throttle;
> +	unsigned int throttle_nsec;
> +	struct task_struct *task;
> +	struct irq_work irq_work;
> +	struct cpufreq_policy *policy;
> +	raw_spinlock_t fastpath_lock;
> +	struct mutex slowpath_lock;
> +	unsigned int enabled;
> +	unsigned int requested_freq;
> +};
> +
> +static void cpufreq_sched_try_driver_target(struct cpufreq_policy *policy,
> +					    unsigned int freq)
> +{
> +	struct gov_data *gd = policy->governor_data;
> +
> +	__cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_L);
> +	gd->throttle = ktime_add_ns(ktime_get(), gd->throttle_nsec);
> +}
> +
> +static bool finish_last_request(struct gov_data *gd)
> +{
> +	ktime_t now = ktime_get();
> +
> +	if (ktime_after(now, gd->throttle))
> +		return false;
> +
> +	while (1) {

I would write this as

	do {

> +		int usec_left = ktime_to_ns(ktime_sub(gd->throttle, now));
> +
> +		usec_left /= NSEC_PER_USEC;
> +		usleep_range(usec_left, usec_left + 100);
> +		now = ktime_get();

	} while (ktime_before(now, gd->throttle));

	return true;

But maybe that's just me. :-)

> +		if (ktime_after(now, gd->throttle))
> +			return true;
> +	}
> +}

I'm not a big fan of this throttling mechanism overall, but more about that later.

> +
> +static int cpufreq_sched_thread(void *data)
> +{

Now, what really is the advantage of having those extra threads vs using
workqueues?

I guess the underlying concern is that RT tasks may stall workqueues indefinitely
in theory and then the frequency won't be updated, but there's much more kernel
stuff run from workqueues and if that is starved, you won't get very far anyway.

If you take special measures to prevent frequency change requests from being
stalled by RT tasks, question is why are they so special?  Aren't there any
other kernel activities that also should be protected from that and may be
more important than CPU frequency changes?

Plus if this really is the problem here, then it also affects the other cpufreq
governors, so maybe it should be solved for everybody in some common way?

> +	struct sched_param param;
> +	struct gov_data *gd = (struct gov_data*) data;
> +	struct cpufreq_policy *policy = gd->policy;
> +	unsigned int new_request = 0;
> +	unsigned int last_request = 0;
> +	int ret;
> +
> +	param.sched_priority = 50;
> +	ret = sched_setscheduler_nocheck(gd->task, SCHED_FIFO, &param);
> +	if (ret) {
> +		pr_warn("%s: failed to set SCHED_FIFO\n", __func__);
> +		do_exit(-EINVAL);
> +	} else {
> +		pr_debug("%s: kthread (%d) set to SCHED_FIFO\n",
> +				__func__, gd->task->pid);
> +	}
> +
> +	mutex_lock(&gd->slowpath_lock);
> +
> +	while (true) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		if (kthread_should_stop()) {
> +			set_current_state(TASK_RUNNING);
> +			break;
> +		}
> +		new_request = gd->requested_freq;
> +		if (!gd->enabled || new_request == last_request) {

This generally is a mistake.

You can't assume that if you had requested a CPU to enter a specific P-state,
that state was actually entered.  In the platform-coordinated case the hardware
(or firmware) may choose to ignore your request and you won't be told about
that.

For this reason, you generally need to make the request every time even if it
is identical to the previous one.  Even in the one-CPU-per-policy case there
may be HW coordination you don't know about.

> +			mutex_unlock(&gd->slowpath_lock);
> +			schedule();
> +			mutex_lock(&gd->slowpath_lock);
> +		} else {
> +			set_current_state(TASK_RUNNING);
> +			/*
> +			 * if the frequency thread sleeps while waiting to be
> +			 * unthrottled, start over to check for a newer request
> +			 */
> +			if (finish_last_request(gd))
> +				continue;
> +			last_request = new_request;
> +			cpufreq_sched_try_driver_target(policy, new_request);
> +		}
> +	}
> +
> +	mutex_unlock(&gd->slowpath_lock);
> +
> +	return 0;
> +}
> +
> +static void cpufreq_sched_irq_work(struct irq_work *irq_work)
> +{
> +	struct gov_data *gd;
> +
> +	gd = container_of(irq_work, struct gov_data, irq_work);
> +	if (!gd)
> +		return;
> +
> +	wake_up_process(gd->task);

I'm wondering what would be wrong with writing it as

	if (gd)
		wake_up_process(gd->task);

And can gd turn out to be NULL here in any case?

> +}
> +
> +static void update_fdomain_capacity_request(int cpu)
> +{
> +	unsigned int freq_new, index_new, cpu_tmp;
> +	struct cpufreq_policy *policy;
> +	struct gov_data *gd = per_cpu(cpu_gov_data, cpu);
> +	unsigned long capacity = 0;
> +
> +	if (!gd)
> +		return;
> +

Why is this check necessary?

> +	/* interrupts already disabled here via rq locked */
> +	raw_spin_lock(&gd->fastpath_lock);

Well, if you compare this with the one-CPU-per-policy path in my experimental
schedutil governor code with the "fast switch" patch on top, you'll notice that
it doesn't use any locks and/or atomic ops.  That's very much on purpose and
here's where your whole gain from using static keys practically goes away.

> +
> +	policy = gd->policy;
> +
> +	for_each_cpu(cpu_tmp, policy->cpus) {
> +		struct sched_capacity_reqs *scr;
> +
> +		scr = &per_cpu(cpu_sched_capacity_reqs, cpu_tmp);
> +		capacity = max(capacity, scr->total);
> +	}

You could save a few cycles from this in the case when the policy is not
shared.

> +
> +	freq_new = capacity * policy->max >> SCHED_CAPACITY_SHIFT;

Where does this formula come from?

> +
> +	/*
> +	 * Calling this without locking policy->rwsem means we race
> +	 * against changes with policy->min and policy->max. This should
> +	 * be okay though.
> +	 */
> +	if (cpufreq_frequency_table_target(policy, policy->freq_table,
> +					   freq_new, CPUFREQ_RELATION_L,
> +					   &index_new))
> +		goto out;

__cpufreq_driver_target() will call this again, so isn't calling it here
a bit wasteful?

> +	freq_new = policy->freq_table[index_new].frequency;
> +
> +	if (freq_new == gd->requested_freq)
> +		goto out;
> +

Again, the above generally is a mistake for reasons explained earlier.

> +	gd->requested_freq = freq_new;
> +
> +	if (cpufreq_driver_slow || !mutex_trylock(&gd->slowpath_lock)) {

This really doesn't look good to me.

Why is the mutex needed here in the first place?  cpufreq_sched_stop() should
be able to make sure that this function won't be run again for the policy
without using this lock.

> +		irq_work_queue_on(&gd->irq_work, cpu);

I hope that you are aware of the fact that irq_work_queue_on() explodes
on uniprocessor ARM32 if you run an SMP kernel on it?

And what happens in the !cpufreq_driver_is_slow() case when we don't
initialize the irq_work?

> +	} else if (policy->transition_ongoing ||
> +		   ktime_before(ktime_get(), gd->throttle)) {

If this really runs in the scheduler paths, you don't want to have ktime_get()
here.

> +		mutex_unlock(&gd->slowpath_lock);
> +		irq_work_queue_on(&gd->irq_work, cpu);

Allright.

I think I have figured out how this is arranged, but I may be wrong. :-)

Here's my understanding of it.  If we are throttled, we don't just skip the
request.  Instead, we wake up the gd thread kind of in the hope that the
throttling may end when it actually wakes up.  So in fact we poke at the
gd thread on a regular basis asking it "Are you still throttled?" and that
happens on every call from the scheduler until the throttling is over if
I'm not mistaken.  This means that during throttling every call from the
scheduler generates an irq_work that wakes up the gd thread just to make it
check if it still is throttled and go to sleep again.  Please tell me
that I haven't understood this correctly.

The above aside, I personally think that rate limitting should happen at the source
and not at the worker thread level.  So if you're throttled, you should just
return immediately from this function without generating any more work.  That,
BTW, is what the sampling rate in my code is for.

> +	} else {
> +		cpufreq_sched_try_driver_target(policy, freq_new);

Well, this is supposed to be the fast path AFAICS.

Did you actually look at what __cpufreq_driver_target() does in general?
Including the wait_event() in cpufreq_freq_transition_begin() to mention just
one suspicious thing?  And how much overhead it generates in the most general
case?

No, running *that* from the fast path is not a good idea.  Quite honestly,
you'd need a new driver callback and a new way to run it from the cpufreq core
to implement this in a reasonably efficient way.

> +		mutex_unlock(&gd->slowpath_lock);
> +	}
> +
> +out:
> +	raw_spin_unlock(&gd->fastpath_lock);
> +}
> +
> +void update_cpu_capacity_request(int cpu, bool request)
> +{
> +	unsigned long new_capacity;
> +	struct sched_capacity_reqs *scr;
> +
> +	/* The rq lock serializes access to the CPU's sched_capacity_reqs. */
> +	lockdep_assert_held(&cpu_rq(cpu)->lock);
> +
> +	scr = &per_cpu(cpu_sched_capacity_reqs, cpu);
> +
> +	new_capacity = scr->cfs + scr->rt;
> +	new_capacity = new_capacity * capacity_margin
> +		/ SCHED_CAPACITY_SCALE;
> +	new_capacity += scr->dl;

Can you please explain the formula here?

> +
> +	if (new_capacity == scr->total)
> +		return;
> +

The same mistake as before.

> +	scr->total = new_capacity;
> +	if (request)
> +		update_fdomain_capacity_request(cpu);
> +}
> +
> +static ssize_t show_throttle_nsec(struct cpufreq_policy *policy, char *buf)
> +{
> +	struct gov_data *gd = policy->governor_data;
> +	return sprintf(buf, "%u\n", gd->throttle_nsec);
> +}
> +
> +static ssize_t store_throttle_nsec(struct cpufreq_policy *policy,
> +				   const char *buf, size_t count)
> +{
> +	struct gov_data *gd = policy->governor_data;
> +	unsigned int input;
> +	int ret;
> +
> +	ret = sscanf(buf, "%u", &input);
> +
> +	if (ret != 1)
> +		return -EINVAL;
> +
> +	gd->throttle_nsec = input;
> +	return count;
> +}
> +
> +static struct freq_attr sched_freq_throttle_nsec_attr =
> +	__ATTR(throttle_nsec, 0644, show_throttle_nsec, store_throttle_nsec);
> +
> +static struct attribute *sched_freq_sysfs_attribs[] = {
> +	&sched_freq_throttle_nsec_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute_group sched_freq_sysfs_group = {
> +	.attrs = sched_freq_sysfs_attribs,
> +	.name = "sched_freq",
> +};
> +
> +static int cpufreq_sched_policy_init(struct cpufreq_policy *policy)
> +{
> +	struct gov_data *gd;
> +	int ret;
> +
> +	gd = kzalloc(sizeof(*gd), GFP_KERNEL);
> +	if (!gd)
> +		return -ENOMEM;
> +	policy->governor_data = gd;
> +	gd->policy = policy;
> +	raw_spin_lock_init(&gd->fastpath_lock);
> +	mutex_init(&gd->slowpath_lock);
> +
> +	ret = sysfs_create_group(&policy->kobj, &sched_freq_sysfs_group);
> +	if (ret)
> +		goto err_mem;
> +
> +	/*
> +	 * Set up schedfreq thread for slow path freq transitions if
> +	 * required by the driver.
> +	 */
> +	if (cpufreq_driver_is_slow()) {
> +		cpufreq_driver_slow = true;
> +		gd->task = kthread_create(cpufreq_sched_thread, gd,
> +					  "kschedfreq:%d",
> +					  cpumask_first(policy->related_cpus));
> +		if (IS_ERR_OR_NULL(gd->task)) {
> +			pr_err("%s: failed to create kschedfreq thread\n",
> +			       __func__);
> +			goto err_sysfs;
> +		}
> +		get_task_struct(gd->task);
> +		kthread_bind_mask(gd->task, policy->related_cpus);
> +		wake_up_process(gd->task);
> +		init_irq_work(&gd->irq_work, cpufreq_sched_irq_work);
> +	}
> +	return 0;
> +
> +err_sysfs:
> +	sysfs_remove_group(&policy->kobj, &sched_freq_sysfs_group);
> +err_mem:
> +	policy->governor_data = NULL;
> +	kfree(gd);
> +	return -ENOMEM;
> +}
> +
> +static int cpufreq_sched_policy_exit(struct cpufreq_policy *policy)
> +{
> +	struct gov_data *gd = policy->governor_data;
> +
> +	/* Stop the schedfreq thread associated with this policy. */
> +	if (cpufreq_driver_slow) {
> +		kthread_stop(gd->task);
> +		put_task_struct(gd->task);
> +	}
> +	sysfs_remove_group(&policy->kobj, &sched_freq_sysfs_group);
> +	policy->governor_data = NULL;
> +	kfree(gd);
> +	return 0;
> +}
> +
> +static int cpufreq_sched_start(struct cpufreq_policy *policy)
> +{
> +	struct gov_data *gd = policy->governor_data;
> +	int cpu;
> +
> +	/*
> +	 * The schedfreq static key is managed here so the global schedfreq
> +	 * lock must be taken - a per-policy lock such as policy->rwsem is
> +	 * not sufficient.
> +	 */
> +	mutex_lock(&gov_enable_lock);
> +
> +	gd->enabled = 1;
> +
> +	/*
> +	 * Set up percpu information. Writing the percpu gd pointer will
> +	 * enable the fast path if the static key is already enabled.
> +	 */
> +	for_each_cpu(cpu, policy->cpus) {
> +		memset(&per_cpu(cpu_sched_capacity_reqs, cpu), 0,
> +		       sizeof(struct sched_capacity_reqs));
> +		per_cpu(cpu_gov_data, cpu) = gd;
> +	}
> +
> +	if (enabled_policies == 0)
> +		static_key_slow_inc(&__sched_freq);
> +	enabled_policies++;
> +	mutex_unlock(&gov_enable_lock);
> +
> +	return 0;
> +}
> +
> +static void dummy(void *info) {}
> +
> +static int cpufreq_sched_stop(struct cpufreq_policy *policy)
> +{
> +	struct gov_data *gd = policy->governor_data;
> +	int cpu;
> +
> +	/*
> +	 * The schedfreq static key is managed here so the global schedfreq
> +	 * lock must be taken - a per-policy lock such as policy->rwsem is
> +	 * not sufficient.
> +	 */
> +	mutex_lock(&gov_enable_lock);
> +
> +	/*
> +	 * The governor stop path may or may not hold policy->rwsem. There
> +	 * must be synchronization with the slow path however.
> +	 */
> +	mutex_lock(&gd->slowpath_lock);
> +
> +	/*
> +	 * Stop new entries into the hot path for all CPUs. This will
> +	 * potentially affect other policies which are still running but
> +	 * this is an infrequent operation.
> +	 */
> +	static_key_slow_dec(&__sched_freq);
> +	enabled_policies--;
> +
> +	/*
> +	 * Ensure that all CPUs currently part of this policy are out
> +	 * of the hot path so that if this policy exits we can free gd.
> +	 */
> +	preempt_disable();
> +	smp_call_function_many(policy->cpus, dummy, NULL, true);
> +	preempt_enable();

I'm not sure how this works, can you please tell me?

> +
> +	/*
> +	 * Other CPUs in other policies may still have the schedfreq
> +	 * static key enabled. The percpu gd is used to signal which
> +	 * CPUs are enabled in the sched gov during the hot path.
> +	 */
> +	for_each_cpu(cpu, policy->cpus)
> +		per_cpu(cpu_gov_data, cpu) = NULL;
> +
> +	/* Pause the slow path for this policy. */
> +	gd->enabled = 0;
> +
> +	if (enabled_policies)
> +		static_key_slow_inc(&__sched_freq);
> +	mutex_unlock(&gd->slowpath_lock);
> +	mutex_unlock(&gov_enable_lock);
> +
> +	return 0;
> +}
> +
> +static int cpufreq_sched_setup(struct cpufreq_policy *policy,
> +			       unsigned int event)
> +{
> +	switch (event) {
> +	case CPUFREQ_GOV_POLICY_INIT:
> +		return cpufreq_sched_policy_init(policy);
> +	case CPUFREQ_GOV_POLICY_EXIT:
> +		return cpufreq_sched_policy_exit(policy);
> +	case CPUFREQ_GOV_START:
> +		return cpufreq_sched_start(policy);
> +	case CPUFREQ_GOV_STOP:
> +		return cpufreq_sched_stop(policy);
> +	case CPUFREQ_GOV_LIMITS:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_SCHED
> +static
> +#endif
> +struct cpufreq_governor cpufreq_gov_sched = {
> +	.name			= "sched",
> +	.governor		= cpufreq_sched_setup,
> +	.owner			= THIS_MODULE,
> +};
> +
> +static int __init cpufreq_sched_init(void)
> +{
> +	return cpufreq_register_governor(&cpufreq_gov_sched);
> +}
> +
> +/* Try to make this the default governor */
> +fs_initcall(cpufreq_sched_init);

I have no comments to the rest of the patch.

Thanks,
Rafael

