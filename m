From: Juri Lelli <Juri.Lelli@arm.com>
Subject: Re: [RFCv6 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Fri, 11 Dec 2015 11:04:43 +0000
Message-ID: <20151211110443.GA6645@e106622-lin>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-4-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60672 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753482AbbLKLEx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 11 Dec 2015 06:04:53 -0500
Content-Disposition: inline
In-Reply-To: <1449641971-20827-4-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>

Hi Steve,

On 08/12/15 22:19, Steve Muckle wrote:
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
> the scheduler, aside from a throttling mechanism to ensure frequency
> changes are not attempted faster than the hardware can accommodate them.
> 
> Thanks to Juri Lelli <juri.lelli@arm.com> for contributing design ideas,
> code and test results, and to Ricky Liang <jcliang@chromium.org>
> for initialization and static key inc/dec fixes.
> 
> [0] http://article.gmane.org/gmane.linux.kernel/1499836
> 
> [smuckle@linaro.org: various additions and fixes, revised commit text]
> 
> CC: Ricky Liang <jcliang@chromium.org>
> Signed-off-by: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Steve Muckle <smuckle@linaro.org>
> ---
>  drivers/cpufreq/Kconfig      |  20 +++
>  include/linux/cpufreq.h      |   3 +
>  include/linux/sched.h        |   8 +
>  kernel/sched/Makefile        |   1 +
>  kernel/sched/cpufreq_sched.c | 364 +++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h         |  51 ++++++
>  6 files changed, 447 insertions(+)
>  create mode 100644 kernel/sched/cpufreq_sched.c
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 659879a..6f2e96c 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -102,6 +102,14 @@ config CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
>  	  Be aware that not all cpufreq drivers support the conservative
>  	  governor. If unsure have a look at the help section of the
>  	  driver. Fallback governor will be the performance governor.
> +
> +config CPU_FREQ_DEFAULT_GOV_SCHED
> +	bool "sched"
> +	select CPU_FREQ_GOV_SCHED
> +	help
> +	  Use the CPUfreq governor 'sched' as default. This scales
> +	  cpu frequency using CPU utilization estimates from the
> +	  scheduler.
>  endchoice
>  
>  config CPU_FREQ_GOV_PERFORMANCE
> @@ -183,6 +191,18 @@ config CPU_FREQ_GOV_CONSERVATIVE
>  
>  	  If in doubt, say N.
>  
> +config CPU_FREQ_GOV_SCHED
> +	bool "'sched' cpufreq governor"
> +	depends on CPU_FREQ

We depend on IRQ_WORK as well, which in turn I think depends on SMP. As
briefly discussed with Peter on IRC, we might want to use
smp_call_function_single_async() instead to break this dependecies
chain (and be able to use this governor on UP as well).

> +	select CPU_FREQ_GOV_COMMON
> +	help
> +	  'sched' - this governor scales cpu frequency from the
> +	  scheduler as a function of cpu capacity utilization. It does
> +	  not evaluate utilization on a periodic basis (as ondemand
> +	  does) but instead is event-driven by the scheduler.
> +
> +	  If in doubt, say N.
> +
>  comment "CPU frequency scaling drivers"
>  
>  config CPUFREQ_DT
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 7f8c63d..7e4bde1 100644
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
> index 3b0de68..d910a31 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -927,6 +927,14 @@ enum cpu_idle_type {
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
> index 0000000..af8b5bc
> --- /dev/null
> +++ b/kernel/sched/cpufreq_sched.c
> @@ -0,0 +1,364 @@
> +/*
> + *  Copyright (C)  2015 Michael Turquette <mturquette@linaro.org>
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
> +#define THROTTLE_NSEC		50000000 /* 50ms default */
> +
> +struct static_key __read_mostly __sched_freq = STATIC_KEY_INIT_FALSE;
> +static bool __read_mostly cpufreq_driver_slow;
> +
> +#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_SCHED
> +static struct cpufreq_governor cpufreq_gov_sched;
> +#endif
> +
> +/*
> + * Capacity margin added to CFS and RT capacity requests to provide
> + * some head room if task utilization further increases.
> + */
> +unsigned int capacity_margin = 1280;
> +
> +static DEFINE_PER_CPU(unsigned long, enabled);
> +DEFINE_PER_CPU(struct sched_capacity_reqs, cpu_sched_capacity_reqs);
> +
> +/**
> + * gov_data - per-policy data internal to the governor
> + * @throttle: next throttling period expiry. Derived from throttle_nsec
> + * @throttle_nsec: throttle period length in nanoseconds
> + * @task: worker thread for dvfs transition that may block/sleep
> + * @irq_work: callback used to wake up worker thread
> + * @requested_freq: last frequency requested by the sched governor
> + *
> + * struct gov_data is the per-policy cpufreq_sched-specific data structure. A
> + * per-policy instance of it is created when the cpufreq_sched governor receives
> + * the CPUFREQ_GOV_START condition and a pointer to it exists in the gov_data
> + * member of struct cpufreq_policy.
> + *
> + * Readers of this data must call down_read(policy->rwsem). Writers must
> + * call down_write(policy->rwsem).
> + */
> +struct gov_data {
> +	ktime_t throttle;
> +	unsigned int throttle_nsec;
> +	struct task_struct *task;
> +	struct irq_work irq_work;
> +	unsigned int requested_freq;
> +};
> +
> +static void cpufreq_sched_try_driver_target(struct cpufreq_policy *policy,
> +					    unsigned int freq)
> +{
> +	struct gov_data *gd = policy->governor_data;
> +
> +	/* avoid race with cpufreq_sched_stop */
> +	if (!down_write_trylock(&policy->rwsem))
> +		return;
> +
> +	__cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_L);
> +
> +	gd->throttle = ktime_add_ns(ktime_get(), gd->throttle_nsec);

As I think you proposed at Connect, we could use post frequency
transition notifiers to implement throttling. Is this something that you
already tried implementing/planning to experiment with?

> +	up_write(&policy->rwsem);
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
> +		int usec_left = ktime_to_ns(ktime_sub(gd->throttle, now));
> +
> +		usec_left /= NSEC_PER_USEC;
> +		usleep_range(usec_left, usec_left + 100);
> +		now = ktime_get();
> +		if (ktime_after(now, gd->throttle))
> +			return true;
> +	}
> +}
> +
> +/*
> + * we pass in struct cpufreq_policy. This is safe because changing out the
> + * policy requires a call to __cpufreq_governor(policy, CPUFREQ_GOV_STOP),
> + * which tears down all of the data structures and __cpufreq_governor(policy,
> + * CPUFREQ_GOV_START) will do a full rebuild, including this kthread with the
> + * new policy pointer
> + */
> +static int cpufreq_sched_thread(void *data)
> +{
> +	struct sched_param param;
> +	struct cpufreq_policy *policy;
> +	struct gov_data *gd;
> +	unsigned int new_request = 0;
> +	unsigned int last_request = 0;
> +	int ret;
> +
> +	policy = (struct cpufreq_policy *) data;
> +	gd = policy->governor_data;
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
> +	do {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		new_request = gd->requested_freq;
> +		if (new_request == last_request) {
> +			schedule();
> +		} else {

Shouldn't we have to do the following here?


@@ -125,9 +125,9 @@ static int cpufreq_sched_thread(void *data)
 	}
 
 	do {
-		set_current_state(TASK_INTERRUPTIBLE);
 		new_request = gd->requested_freq;
 		if (new_request == last_request) {
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule();
 		} else {
 			/*

Otherwise we set task to INTERRUPTIBLE state right after it has been
woken up.

Thanks,

- Juri

> +			/*
> +			 * if the frequency thread sleeps while waiting to be
> +			 * unthrottled, start over to check for a newer request
> +			 */
> +			if (finish_last_request(gd))
> +				continue;
> +			last_request = new_request;
> +			cpufreq_sched_try_driver_target(policy, new_request);
> +		}
> +	} while (!kthread_should_stop());
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
> +}
> +
> +static void update_fdomain_capacity_request(int cpu)
> +{
> +	unsigned int freq_new, index_new, cpu_tmp;
> +	struct cpufreq_policy *policy;
> +	struct gov_data *gd;
> +	unsigned long capacity = 0;
> +
> +	/*
> +	 * Avoid grabbing the policy if possible. A test is still
> +	 * required after locking the CPU's policy to avoid racing
> +	 * with the governor changing.
> +	 */
> +	if (!per_cpu(enabled, cpu))
> +		return;
> +
> +	policy = cpufreq_cpu_get(cpu);
> +	if (IS_ERR_OR_NULL(policy))
> +		return;
> +
> +	if (policy->governor != &cpufreq_gov_sched ||
> +	    !policy->governor_data)
> +		goto out;
> +
> +	gd = policy->governor_data;
> +
> +	/* find max capacity requested by cpus in this policy */
> +	for_each_cpu(cpu_tmp, policy->cpus) {
> +		struct sched_capacity_reqs *scr;
> +
> +		scr = &per_cpu(cpu_sched_capacity_reqs, cpu_tmp);
> +		capacity = max(capacity, scr->total);
> +	}
> +
> +	/* Convert the new maximum capacity request into a cpu frequency */
> +	freq_new = capacity * policy->max >> SCHED_CAPACITY_SHIFT;
> +	if (cpufreq_frequency_table_target(policy, policy->freq_table,
> +					   freq_new, CPUFREQ_RELATION_L,
> +					   &index_new))
> +		goto out;
> +	freq_new = policy->freq_table[index_new].frequency;
> +
> +	if (freq_new == gd->requested_freq)
> +		goto out;
> +
> +	gd->requested_freq = freq_new;
> +
> +	/*
> +	 * Throttling is not yet supported on platforms with fast cpufreq
> +	 * drivers.
> +	 */
> +	if (cpufreq_driver_slow)
> +		irq_work_queue_on(&gd->irq_work, cpu);
> +	else
> +		cpufreq_sched_try_driver_target(policy, freq_new);
> +
> +out:
> +	cpufreq_cpu_put(policy);
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
> +
> +	if (new_capacity == scr->total)
> +		return;
> +
> +	scr->total = new_capacity;
> +	if (request)
> +		update_fdomain_capacity_request(cpu);
> +}
> +
> +static inline void set_sched_freq(void)
> +{
> +	static_key_slow_inc(&__sched_freq);
> +}
> +
> +static inline void clear_sched_freq(void)
> +{
> +	static_key_slow_dec(&__sched_freq);
> +}
> +
> +static int cpufreq_sched_policy_init(struct cpufreq_policy *policy)
> +{
> +	struct gov_data *gd;
> +	int cpu;
> +
> +	for_each_cpu(cpu, policy->cpus)
> +		memset(&per_cpu(cpu_sched_capacity_reqs, cpu), 0,
> +		       sizeof(struct sched_capacity_reqs));
> +
> +	gd = kzalloc(sizeof(*gd), GFP_KERNEL);
> +	if (!gd)
> +		return -ENOMEM;
> +
> +	gd->throttle_nsec = policy->cpuinfo.transition_latency ?
> +			    policy->cpuinfo.transition_latency :
> +			    THROTTLE_NSEC;
> +	pr_debug("%s: throttle threshold = %u [ns]\n",
> +		  __func__, gd->throttle_nsec);
> +
> +	if (cpufreq_driver_is_slow()) {
> +		cpufreq_driver_slow = true;
> +		gd->task = kthread_create(cpufreq_sched_thread, policy,
> +					  "kschedfreq:%d",
> +					  cpumask_first(policy->related_cpus));
> +		if (IS_ERR_OR_NULL(gd->task)) {
> +			pr_err("%s: failed to create kschedfreq thread\n",
> +			       __func__);
> +			goto err;
> +		}
> +		get_task_struct(gd->task);
> +		kthread_bind_mask(gd->task, policy->related_cpus);
> +		wake_up_process(gd->task);
> +		init_irq_work(&gd->irq_work, cpufreq_sched_irq_work);
> +	}
> +
> +	policy->governor_data = gd;
> +	set_sched_freq();
> +
> +	return 0;
> +
> +err:
> +	kfree(gd);
> +	return -ENOMEM;
> +}
> +
> +static int cpufreq_sched_policy_exit(struct cpufreq_policy *policy)
> +{
> +	struct gov_data *gd = policy->governor_data;
> +
> +	clear_sched_freq();
> +	if (cpufreq_driver_slow) {
> +		kthread_stop(gd->task);
> +		put_task_struct(gd->task);
> +	}
> +
> +	policy->governor_data = NULL;
> +
> +	kfree(gd);
> +	return 0;
> +}
> +
> +static int cpufreq_sched_start(struct cpufreq_policy *policy)
> +{
> +	int cpu;
> +
> +	for_each_cpu(cpu, policy->cpus)
> +		per_cpu(enabled, cpu) = 1;
> +
> +	return 0;
> +}
> +
> +static int cpufreq_sched_stop(struct cpufreq_policy *policy)
> +{
> +	int cpu;
> +
> +	for_each_cpu(cpu, policy->cpus)
> +		per_cpu(enabled, cpu) = 0;
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
> +	int cpu;
> +
> +	for_each_cpu(cpu, cpu_possible_mask)
> +		per_cpu(enabled, cpu) = 0;
> +	return cpufreq_register_governor(&cpufreq_gov_sched);
> +}
> +
> +/* Try to make this the default governor */
> +fs_initcall(cpufreq_sched_init);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index a5a6b3e..a88dbec 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1383,6 +1383,57 @@ unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
>  }
>  #endif
>  
> +#ifdef CONFIG_CPU_FREQ_GOV_SCHED
> +extern unsigned int capacity_margin;
> +extern struct static_key __sched_freq;
> +
> +static inline bool sched_freq(void)
> +{
> +	return static_key_false(&__sched_freq);
> +}
> +
> +DECLARE_PER_CPU(struct sched_capacity_reqs, cpu_sched_capacity_reqs);
> +void update_cpu_capacity_request(int cpu, bool request);
> +
> +static inline void set_cfs_cpu_capacity(int cpu, bool request,
> +					unsigned long capacity)
> +{
> +	if (per_cpu(cpu_sched_capacity_reqs, cpu).cfs != capacity) {
> +		per_cpu(cpu_sched_capacity_reqs, cpu).cfs = capacity;
> +		update_cpu_capacity_request(cpu, request);
> +	}
> +}
> +
> +static inline void set_rt_cpu_capacity(int cpu, bool request,
> +				       unsigned long capacity)
> +{
> +	if (per_cpu(cpu_sched_capacity_reqs, cpu).rt != capacity) {
> +		per_cpu(cpu_sched_capacity_reqs, cpu).rt = capacity;
> +		update_cpu_capacity_request(cpu, request);
> +	}
> +}
> +
> +static inline void set_dl_cpu_capacity(int cpu, bool request,
> +				       unsigned long capacity)
> +{
> +	if (per_cpu(cpu_sched_capacity_reqs, cpu).dl != capacity) {
> +		per_cpu(cpu_sched_capacity_reqs, cpu).dl = capacity;
> +		update_cpu_capacity_request(cpu, request);
> +	}
> +}
> +#else
> +static inline bool sched_freq(void) { return false; }
> +static inline void set_cfs_cpu_capacity(int cpu, bool request,
> +					unsigned long capacity)
> +{ }
> +static inline void set_rt_cpu_capacity(int cpu, bool request,
> +				       unsigned long capacity)
> +{ }
> +static inline void set_dl_cpu_capacity(int cpu, bool request,
> +				       unsigned long capacity)
> +{ }
> +#endif
> +
>  static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta)
>  {
>  	rq->rt_avg += rt_delta * arch_scale_freq_capacity(NULL, cpu_of(rq));
> -- 
> 2.4.10
> 
