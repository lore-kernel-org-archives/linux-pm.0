From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 38/46] sched: scheduler-driven cpu frequency
 selection
Date: Sat, 15 Aug 2015 14:35:31 +0200
Message-ID: <20150815123531.GE10304@worktop.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-39-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:45036 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbbHOTyW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 15 Aug 2015 15:54:22 -0400
Content-Disposition: inline
In-Reply-To: <1436293469-25707-39-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Jul 07, 2015 at 07:24:21PM +0100, Morten Rasmussen wrote:
> diff --git a/kernel/sched/cpufreq_sched.c b/kernel/sched/cpufreq_sched.c
> new file mode 100644
> index 0000000..5020f24
> --- /dev/null
> +++ b/kernel/sched/cpufreq_sched.c
> @@ -0,0 +1,308 @@
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
> +
> +#include "sched.h"
> +
> +#define THROTTLE_NSEC		50000000 /* 50ms default */
> +
> +static DEFINE_PER_CPU(unsigned long, pcpu_capacity);
> +static DEFINE_PER_CPU(struct cpufreq_policy *, pcpu_policy);
> +
> +/**
> + * gov_data - per-policy data internal to the governor
> + * @throttle: next throttling period expiry. Derived from throttle_nsec
> + * @throttle_nsec: throttle period length in nanoseconds
> + * @task: worker thread for dvfs transition that may block/sleep
> + * @irq_work: callback used to wake up worker thread
> + * @freq: new frequency stored in *_sched_update_cpu and used in *_sched_thread
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
> +	struct cpufreq_policy *policy;
> +	unsigned int freq;
> +};
> +
> +static void cpufreq_sched_try_driver_target(struct cpufreq_policy *policy, unsigned int freq)
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
> +	up_write(&policy->rwsem);
> +}

That locking truly is disgusting.. why can't we change that?

> +static int cpufreq_sched_thread(void *data)
> +{

> +
> +	ret = set_cpus_allowed_ptr(gd->task, policy->related_cpus);

That's not sufficient, you really want to have called kthread_bind() on
these threads, otherwise userspace can change affinity on you.

> +
> +	do_exit(0);

I thought kthreads only needed to return...

> +}

> +void cpufreq_sched_set_cap(int cpu, unsigned long capacity)
> +{
> +	unsigned int freq_new, cpu_tmp;
> +	struct cpufreq_policy *policy;
> +	struct gov_data *gd;
> +	unsigned long capacity_max = 0;
> +
> +	/* update per-cpu capacity request */
> +	__this_cpu_write(pcpu_capacity, capacity);
> +
> +	policy = cpufreq_cpu_get(cpu);

So this does a down_read_trylock(&cpufreq_rwsem) and a
read_lock_irqsave(&cpufreq_driver_lock), all while holding scheduler
locks.

> +	if (cpufreq_driver_might_sleep())
> +		irq_work_queue_on(&gd->irq_work, cpu);
> +	else
> +		cpufreq_sched_try_driver_target(policy, freq_new);

This will then do a down_write_trylock(&policy->rwsem)

> +
> +out:
> +	cpufreq_cpu_put(policy);

> +	return;
> +}

That is just insane... surely we can replace all that with a wee bit of
RCU logic.

So something like:

DEFINE_MUTEX(cpufreq_mutex);
struct cpufreq_driver *cpufreq_driver;

struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
{
	struct cpufreq_driver *driver;
	struct cpufreq_policy *policy;

	rcu_read_lock();
	driver = rcu_dereference(cpufreq_driver);
	if (!driver)
		goto err;

	policy = per_cpu_ptr(driver->policy, cpu);
	if (!policy)
		goto err;

	return policy;

err:
	rcu_read_unlock();
	return NULL;
}


void cpufreq_cpu_put(struct cpufreq_policy *policy)
{
	rcu_read_unlock();
}



void cpufreq_set_driver(struct cpufreq_driver *driver)
{
	mutex_lock(&cpufreq_mutex);

	rcu_assign_pointer(cpufreq_driver, NULL);

	/*
	 * Wait for everyone to observe the lack of driver; iow. until
	 * its unused.
	 */
	synchronize_rcu();

	/*
	 * Now that ye olde driver be gone, install a new one.
	 */
	if (driver)
		rcu_assign_pointer(cpufreq_driver, driver);

	mutex_unlock(&cpufreq_mutex);
}


No need for cpufreq_rwsem or cpufreq_driver_lock..


Hmm?
