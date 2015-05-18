From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH RFC v2 4/4] sched: cpufreq_cfs: pelt-based cpu frequency
 scaling
Date: Mon, 18 May 2015 17:42:14 +0100
Message-ID: <555A1666.30306@arm.com>
References: <1431396795-32439-1-git-send-email-mturquette@linaro.org> <1431396795-32439-5-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:57503 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932336AbbERQmP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 18 May 2015 12:42:15 -0400
In-Reply-To: <1431396795-32439-5-git-send-email-mturquette@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@linaro.org>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@kernel.org" <mingo@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, "riel@redhat.com" <riel@redhat.com>, "efault@gmx.de" <efault@gmx.de>, "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ashwin.chaugule@linaro.org" <ashwin.chaugule@linaro.org>, "alex.shi@linaro.org" <alex.shi@linaro.org>, "abelvesa@gmail.com" <abelvesa@gmail.com>

Hi Mike,

On 12/05/15 03:13, Michael Turquette wrote:
> Scheduler-driven cpu frequency selection is desirable as part of the
> on-going effort to make the scheduler better aware of energy
> consumption.  No piece of the Linux kernel has a better view of the
> factors that affect a cpu frequency selection policy than the
> scheduler[0], and this patch is an attempt to converge on an initial
> solution.
> 
> This patch implements a cpufreq governor that directly accesses
> scheduler statistics, in particular per-runqueue capacity utilization
> data from cfs via cfs.utilization_load_avg.
> 
> Put plainly, this governor selects the lowest cpu frequency that will
> prevent a runqueue from being over-utilized (until we hit the highest
> frequency of course). This is accomplished by requesting a frequency
> that matches the current capacity utilization, plus a margin.
> 
> Unlike the previous posting from 2014[1] this governor implements a
> "follow the utilization" method, where utilization is defined as the
> frequency-invariant product of cfs.utilization_load_avg and
> cpu_capacity_orig.
> 
> This governor is event-driven. There is no polling loop to check cpu
> idle time nor any other method which is unsynchronized with the
> scheduler. The entry points for this policy are in fair.c:
> enqueue_task_fair, dequeue_task_fair and task_tick_fair.
> 
> This policy is implemented using the cpufreq governor interface for two
> main reasons:
> 
> 1) re-using the cpufreq machine drivers without using the governor
> interface is hard.
> 
> 2) using the cpufreq interface allows us to switch between the
> scheduler-driven policy and legacy cpufreq governors such as ondemand at
> run-time. This is very useful for comparative testing and tuning.
> 
> Finally, it is worth mentioning that this approach neglects all
> scheduling classes except for cfs. It is possible to add support for
> deadline and other other classes here, but I also wonder if a
> multi-governor approach would be a more maintainable solution, where the
> cpufreq core aggregates the constraints set by multiple governors.
> Supporting such an approach in the cpufreq core would also allow for
> peripheral devices to place constraint on cpu frequency without having
> to hack such behavior in at the governor level.
> 
> Thanks to Juri Lelli <juri.lelli@arm.com> for contributing design ideas,
> code and test results.
> 
> [0] http://article.gmane.org/gmane.linux.kernel/1499836
> [1] https://lkml.org/lkml/2014/10/22/22
> 
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Michael Turquette <mturquette@linaro.org>
> ---
> Changes in v2:
>         Folded in Abel's patch to fix builds for non-SMP. Thanks!
>         Dropped use of get_cpu_usage. Instead pass in
>         cfs.utilization_load_avg from fair.c
>         Added two additional conditions to quickly bail from _update_cpu
>         Return requested capacity from cpufreq_cfs_update_cpu
>         Handle frequency-table based systems more gooder
>         Internal data structures and the way data is shared with the
>         thread are changed considerably
> 
>         Food for thought: in cpufreq_cfs_update_cpu we could break out
>         all of the code preceeding the call to cpufreq_cpu_get into
>         fair.c. The interface would change from,
> unsigned long cpufreq_cfs_update_cpu(int cpu, unsigned long util);
>         to,
> unsigned long cpufreq_cfs_update_cpu(int cpu, unsigned long cap_target);
>         This would give fair.c more control over the capacity it wants
>         to target, and makes the governor interface a bit more flexible
>         and useful.
> 
>  drivers/cpufreq/Kconfig    |  24 ++++
>  include/linux/cpufreq.h    |   3 +
>  kernel/sched/Makefile      |   1 +
>  kernel/sched/cpufreq_cfs.c | 343 +++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/fair.c        |  14 ++
>  kernel/sched/sched.h       |   8 ++
>  6 files changed, 393 insertions(+)
>  create mode 100644 kernel/sched/cpufreq_cfs.c
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index a171fef..83d51b4 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -102,6 +102,15 @@ config CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
>           Be aware that not all cpufreq drivers support the conservative
>           governor. If unsure have a look at the help section of the
>           driver. Fallback governor will be the performance governor.
> +
> +config CPU_FREQ_DEFAULT_GOV_CFS
> +       bool "cfs"
> +       select CPU_FREQ_GOV_CFS
> +       select CPU_FREQ_GOV_PERFORMANCE
> +       help
> +         Use the CPUfreq governor 'cfs' as default. This scales
> +         cpu frequency from the scheduler as per-entity load tracking
> +         statistics are updated.
>  endchoice
> 
>  config CPU_FREQ_GOV_PERFORMANCE
> @@ -183,6 +192,21 @@ config CPU_FREQ_GOV_CONSERVATIVE
> 
>           If in doubt, say N.
> 
> +config CPU_FREQ_GOV_CFS
> +       tristate "'cfs' cpufreq governor"
> +       depends on CPU_FREQ
> +       select CPU_FREQ_GOV_COMMON
> +       help
> +         'cfs' - this governor scales cpu frequency from the
> +         scheduler as a function of cpu capacity utilization. It does
> +         not evaluate utilization on a periodic basis (as ondemand
> +         does) but instead is invoked from the completely fair
> +         scheduler when updating per-entity load tracking statistics.
> +         Latency to respond to changes in load is improved over polling
> +         governors due to its event-driven design.
> +
> +         If in doubt, say N.
> +
>  comment "CPU frequency scaling drivers"
> 
>  config CPUFREQ_DT
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 2ee4888..62e8152 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -485,6 +485,9 @@ extern struct cpufreq_governor cpufreq_gov_ondemand;
>  #elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE)
>  extern struct cpufreq_governor cpufreq_gov_conservative;
>  #define CPUFREQ_DEFAULT_GOVERNOR       (&cpufreq_gov_conservative)
> +#elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_CAP_GOV)
> +extern struct cpufreq_governor cpufreq_gov_cap_gov;
> +#define CPUFREQ_DEFAULT_GOVERNOR       (&cpufreq_gov_cap_gov)
>  #endif
> 
>  /*********************************************************************
> diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
> index 46be870..466960d 100644
> --- a/kernel/sched/Makefile
> +++ b/kernel/sched/Makefile
> @@ -19,3 +19,4 @@ obj-$(CONFIG_SCHED_AUTOGROUP) += auto_group.o
>  obj-$(CONFIG_SCHEDSTATS) += stats.o
>  obj-$(CONFIG_SCHED_DEBUG) += debug.o
>  obj-$(CONFIG_CGROUP_CPUACCT) += cpuacct.o
> +obj-$(CONFIG_CPU_FREQ_GOV_CFS) += cpufreq_cfs.o
> diff --git a/kernel/sched/cpufreq_cfs.c b/kernel/sched/cpufreq_cfs.c
> new file mode 100644
> index 0000000..bcb63b6
> --- /dev/null
> +++ b/kernel/sched/cpufreq_cfs.c
> @@ -0,0 +1,343 @@
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
> +#define MARGIN_PCT             125 /* taken from imbalance_pct = 125 */

You don't use this anymore, right? But see also my comment below
on this.

> +#define THROTTLE_NSEC          50000000 /* 50ms default */
> +
> +static DEFINE_PER_CPU(unsigned long, pcpu_util);
> +static DEFINE_PER_CPU(struct cpufreq_policy *, pcpu_policy);
> +
> +/**
> + * gov_data - per-policy data internal to the governor
> + * @throttle: next throttling period expiry. Derived from throttle_nsec
> + * @throttle_nsec: throttle period length in nanoseconds
> + * @task: worker thread for dvfs transition that may block/sleep
> + * @irq_work: callback used to wake up worker thread
> + * @freq: new frequency stored in *_cfs_update_cpu and used in *_cfs_thread
> + *
> + * struct gov_data is the per-policy cpufreq_cfs-specific data structure. A
> + * per-policy instance of it is created when the cpufreq_cfs governor receives
> + * the CPUFREQ_GOV_START condition and a pointer to it exists in the gov_data
> + * member of struct cpufreq_policy.
> + *
> + * Readers of this data must call down_read(policy->rwsem). Writers must
> + * call down_write(policy->rwsem).
> + */
> +struct gov_data {
> +       ktime_t throttle;
> +       unsigned int throttle_nsec;
> +       struct task_struct *task;
> +       struct irq_work irq_work;
> +       struct cpufreq_policy *policy;
> +       unsigned int freq;
> +};
> +
> +/*
> + * we pass in struct cpufreq_policy. This is safe because changing out the
> + * policy requires a call to __cpufreq_governor(policy, CPUFREQ_GOV_STOP),
> + * which tears down all of the data structures and __cpufreq_governor(policy,
> + * CPUFREQ_GOV_START) will do a full rebuild, including this kthread with the
> + * new policy pointer
> + */
> +static int cpufreq_cfs_thread(void *data)
> +{
> +       struct sched_param param;
> +       struct cpufreq_policy *policy;
> +       struct gov_data *gd;
> +       int ret;
> +
> +       policy = (struct cpufreq_policy *) data;
> +       if (!policy) {
> +               pr_warn("%s: missing policy\n", __func__);
> +               do_exit(-EINVAL);
> +       }
> +
> +       gd = policy->governor_data;
> +       if (!gd) {
> +               pr_warn("%s: missing governor data\n", __func__);
> +               do_exit(-EINVAL);
> +       }
> +
> +       param.sched_priority = 50;
> +       ret = sched_setscheduler_nocheck(gd->task, SCHED_FIFO, &param);
> +       if (ret) {
> +               pr_warn("%s: failed to set SCHED_FIFO\n", __func__);
> +               do_exit(-EINVAL);
> +       } else {
> +               pr_debug("%s: kthread (%d) set to SCHED_FIFO\n",
> +                               __func__, gd->task->pid);
> +       }
> +
> +       ret = set_cpus_allowed_ptr(gd->task, policy->related_cpus);
> +       if (ret) {
> +               pr_warn("%s: failed to set allowed ptr\n", __func__);
> +               do_exit(-EINVAL);
> +       }
> +
> +       /* main loop of the per-policy kthread */
> +       do {
> +               set_current_state(TASK_INTERRUPTIBLE);
> +               schedule();
> +               if (kthread_should_stop())
> +                       break;
> +
> +               /* avoid race with cpufreq_cfs_stop */
> +               if (!down_write_trylock(&policy->rwsem))
> +                       continue;
> +
> +               ret = __cpufreq_driver_target(policy, gd->freq,
> +                               CPUFREQ_RELATION_L);
> +               if (ret)
> +                       pr_debug("%s: __cpufreq_driver_target returned %d\n",
> +                                       __func__, ret);
> +
> +               gd->throttle = ktime_add_ns(ktime_get(), gd->throttle_nsec);
> +               up_write(&policy->rwsem);
> +       } while (!kthread_should_stop());
> +
> +       do_exit(0);
> +}
> +
> +static void cpufreq_cfs_irq_work(struct irq_work *irq_work)
> +{
> +       struct gov_data *gd;
> +
> +       gd = container_of(irq_work, struct gov_data, irq_work);
> +       if (!gd) {
> +               return;
> +       }
> +
> +       wake_up_process(gd->task);
> +}
> +
> +/**
> + * cpufreq_cfs_update_cpu - interface to scheduler for changing capacity values
> + * @cpu: cpu whose capacity utilization has recently changed
> + *
> + * cpufreq_cfs_update_cpu is an interface exposed to the scheduler so that the
> + * scheduler may inform the governor of updates to capacity utilization and
> + * make changes to cpu frequency. Currently this interface is designed around
> + * PELT values in CFS. It can be expanded to other scheduling classes in the
> + * future if needed.
> + *
> + * cpufreq_cfs_update_cpu raises an IPI. The irq_work handler for that IPI wakes up
> + * the thread that does the actual work, cpufreq_cfs_thread.
> + *
> + * This functions bails out early if either condition is true:
> + * 1) this cpu is not the new maximum utilization for its frequency domain
> + * 2) no change in cpu frequency is necessary to meet the new capacity request
> + *
> + * Returns the newly chosen capacity. Note that this may not reflect reality if
> + * the hardware fails to transition to this new capacity state.
> + */
> +unsigned long cpufreq_cfs_update_cpu(int cpu, unsigned long util)

Is anybody consuming the return value? Did you have in mind some
possible usage of it?

> +{
> +       unsigned long util_new, util_old, util_max, capacity_new;
> +       unsigned int freq_new, freq_tmp, cpu_tmp;
> +       struct cpufreq_policy *policy;
> +       struct gov_data *gd;
> +       struct cpufreq_frequency_table *pos;
> +
> +       /* handle rounding errors */
> +       util_new = util > SCHED_LOAD_SCALE ? SCHED_LOAD_SCALE : util;
> +
> +       /* update per-cpu utilization */
> +       util_old = __this_cpu_read(pcpu_util);
> +       __this_cpu_write(pcpu_util, util_new);
> +
> +       /* avoid locking policy for now; accessing .cpus only */
> +       policy = per_cpu(pcpu_policy, cpu);
> +
> +       /* find max utilization of cpus in this policy */
> +       util_max = 0;
> +       for_each_cpu(cpu_tmp, policy->cpus)
> +               util_max = max(util_max, per_cpu(pcpu_util, cpu_tmp));
> +
> +       /*
> +        * We only change frequency if this cpu's utilization represents a new
> +        * max. If another cpu has increased its utilization beyond the
> +        * previous max then we rely on that cpu to hit this code path and make
> +        * the change. IOW, the cpu with the new max utilization is responsible
> +        * for setting the new capacity/frequency.
> +        *
> +        * If this cpu is not the new maximum then bail, returning the current
> +        * capacity.
> +        */
> +       if (util_max > util_new)
> +               return capacity_of(cpu);

Here and below you probably want to return arch_scale_freq_capacity(NULL, cpu),
as capacity_of() returns the remaining capacity (w.r.t. capacity_orig) for CFS
tasks after RT tasks contribution is removed.

> +
> +       /*
> +        * We are going to request a new capacity, which might result in a new
> +        * cpu frequency. From here on we need to serialize access to the
> +        * policy and the governor private data.
> +        */
> +       policy = cpufreq_cpu_get(cpu);
> +       if (IS_ERR_OR_NULL(policy)) {
> +               return capacity_of(cpu);
> +       }

Shouldn't this be removed now that we have pcpu_policy?
Also the cpufreq_put_cpu() below.

> +
> +       capacity_new = capacity_of(cpu);
> +       if (!policy->governor_data) {
> +               goto out;
> +       }
> +
> +       gd = policy->governor_data;
> +
> +       /* bail early if we are throttled */
> +       if (ktime_before(ktime_get(), gd->throttle)) {
> +               goto out;
> +       }
> +
> +       /*
> +        * Convert the new maximum capacity utilization into a cpu frequency
> +        *
> +        * It is possible to convert capacity utilization directly into a
> +        * frequency, but that implies that we would be 100% utilized. Instead,
> +        * first add a margin (default 25% capacity increase) to the new
> +        * capacity request. This provides some head room if load increases.
> +        */
> +       capacity_new = util_new + (SCHED_CAPACITY_SCALE >> 2);

Here you introduce this 25% margin w.r.t. SCHED_CAPACITY_SCALE.
Shouldn't the margin be related to util_new instead (using MARGIN_PCT
maybe)?

> +       freq_new = capacity_new * policy->max >> SCHED_CAPACITY_SHIFT;
> +
> +       /*
> +        * If a frequency table is available then find the frequency
> +        * corresponding to freq_new.
> +        *
> +        * For cpufreq drivers without a frequency table, use the frequency
> +        * directly computed from capacity_new + 25% margin.
> +        */
> +       if (policy->freq_table) {
> +               freq_tmp = policy->max;
> +               cpufreq_for_each_entry(pos, policy->freq_table) {
> +                       if (pos->frequency >= freq_new &&
> +                                       pos->frequency < freq_tmp)
> +                               freq_tmp = pos->frequency;
> +               }
> +               freq_new = freq_tmp;
> +               capacity_new = (freq_new << SCHED_CAPACITY_SHIFT) / policy->max;
> +       }

Do we really need to do this here? Doesn't __cpufreq_driver_target()
do the same for us?

Best,

- Juri

> +
> +       /* No change in frequency? Bail and return current capacity. */
> +       if (freq_new == policy->cur) {
> +               capacity_new = capacity_of(cpu);
> +               goto out;
> +       }
> +
> +       /* store the new frequency and kick the thread */
> +       gd->freq = freq_new;
> +
> +       /* XXX can we use something like try_to_wake_up_local here instead? */
> +       irq_work_queue_on(&gd->irq_work, cpu);
> +
> +out:
> +       cpufreq_cpu_put(policy);
> +       return capacity_new;
> +}
> +
> +static void cpufreq_cfs_start(struct cpufreq_policy *policy)
> +{
> +       struct gov_data *gd;
> +       int cpu;
> +
> +       /* prepare per-policy private data */
> +       gd = kzalloc(sizeof(*gd), GFP_KERNEL);
> +       if (!gd) {
> +               pr_debug("%s: failed to allocate private data\n", __func__);
> +               return;
> +       }
> +
> +       /* initialize per-cpu data */
> +       for_each_cpu(cpu, policy->cpus) {
> +               per_cpu(pcpu_util, cpu) = 0;
> +               per_cpu(pcpu_policy, cpu) = policy;
> +       }
> +
> +       /*
> +        * Don't ask for freq changes at an higher rate than what
> +        * the driver advertises as transition latency.
> +        */
> +       gd->throttle_nsec = policy->cpuinfo.transition_latency ?
> +                           policy->cpuinfo.transition_latency :
> +                           THROTTLE_NSEC;
> +       pr_debug("%s: throttle threshold = %u [ns]\n",
> +                 __func__, gd->throttle_nsec);
> +
> +       /* init per-policy kthread */
> +       gd->task = kthread_run(cpufreq_cfs_thread, policy, "kcpufreq_cfs_task");
> +       if (IS_ERR_OR_NULL(gd->task))
> +               pr_err("%s: failed to create kcpufreq_cfs_task thread\n", __func__);
> +
> +       init_irq_work(&gd->irq_work, cpufreq_cfs_irq_work);
> +       policy->governor_data = gd;
> +       gd->policy = policy;
> +}
> +
> +static void cpufreq_cfs_stop(struct cpufreq_policy *policy)
> +{
> +       struct gov_data *gd;
> +
> +       gd = policy->governor_data;
> +       kthread_stop(gd->task);
> +
> +       policy->governor_data = NULL;
> +
> +       /* FIXME replace with devm counterparts? */
> +       kfree(gd);
> +}
> +
> +static int cpufreq_cfs_setup(struct cpufreq_policy *policy, unsigned int event)
> +{
> +       switch (event) {
> +               case CPUFREQ_GOV_START:
> +                       /* Start managing the frequency */
> +                       cpufreq_cfs_start(policy);
> +                       return 0;
> +
> +               case CPUFREQ_GOV_STOP:
> +                       cpufreq_cfs_stop(policy);
> +                       return 0;
> +
> +               case CPUFREQ_GOV_LIMITS:        /* unused */
> +               case CPUFREQ_GOV_POLICY_INIT:   /* unused */
> +               case CPUFREQ_GOV_POLICY_EXIT:   /* unused */
> +                       break;
> +       }
> +       return 0;
> +}
> +
> +#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_SCHED_CFS
> +static
> +#endif
> +struct cpufreq_governor cpufreq_cfs = {
> +       .name                   = "cfs",
> +       .governor               = cpufreq_cfs_setup,
> +       .owner                  = THIS_MODULE,
> +};
> +
> +static int __init cpufreq_cfs_init(void)
> +{
> +       return cpufreq_register_governor(&cpufreq_cfs);
> +}
> +
> +static void __exit cpufreq_cfs_exit(void)
> +{
> +       cpufreq_unregister_governor(&cpufreq_cfs);
> +}
> +
> +/* Try to make this the default governor */
> +fs_initcall(cpufreq_cfs_init);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d27ded9..f3c93b9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4257,6 +4257,11 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>                 update_rq_runnable_avg(rq, rq->nr_running);
>                 add_nr_running(rq, 1);
>         }
> +
> +       if(sched_energy_freq())
> +               cpufreq_cfs_update_cpu(cpu_of(rq),
> +                               rq->cfs.utilization_load_avg);
> +
>         hrtick_update(rq);
>  }
> 
> @@ -4318,6 +4323,11 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>                 sub_nr_running(rq, 1);
>                 update_rq_runnable_avg(rq, 1);
>         }
> +
> +       if(sched_energy_freq())
> +               cpufreq_cfs_update_cpu(cpu_of(rq),
> +                               rq->cfs.utilization_load_avg);
> +
>         hrtick_update(rq);
>  }
> 
> @@ -7816,6 +7826,10 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>                 task_tick_numa(rq, curr);
> 
>         update_rq_runnable_avg(rq, 1);
> +
> +       if(sched_energy_freq())
> +               cpufreq_cfs_update_cpu(cpu_of(rq),
> +                               rq->cfs.utilization_load_avg);
>  }
> 
>  /*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 4925bc4..a8585e1 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1401,6 +1401,13 @@ static inline unsigned long capacity_of(int cpu)
>         return cpu_rq(cpu)->cpu_capacity;
>  }
> 
> +#ifdef CONFIG_CPU_FREQ_GOV_CFS
> +unsigned long cpufreq_cfs_update_cpu(int cpu, unsigned long util);
> +#else
> +static inline unsigned long cpufreq_cfs_update_cpu(int cpu, unsigned long util)
> +{ }
> +#endif
> +
>  static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta)
>  {
>         rq->rt_avg += rt_delta * arch_scale_freq_capacity(NULL, cpu_of(rq));
> @@ -1409,6 +1416,7 @@ static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta)
>  #else
>  static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta) { }
>  static inline void sched_avg_update(struct rq *rq) { }
> +static inline void gov_cfs_update_cpu(int cpu) {}
>  #endif
> 
>  extern void start_bandwidth_timer(struct hrtimer *period_timer, ktime_t period);
> --
> 1.9.1
> 

