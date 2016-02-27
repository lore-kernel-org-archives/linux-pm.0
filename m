From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v4 1/2] cpufreq: New governor using utilization data from the scheduler
Date: Sat, 27 Feb 2016 16:24:04 +0100
Message-ID: <2754630.1sRldKdOu8@vostro.rjw.lan>
References: <5059413.77KZsd2lep@vostro.rjw.lan> <1825489.pc33SqXSIB@vostro.rjw.lan> <56D1270F.4010106@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64007 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756340AbcB0PW2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Feb 2016 10:22:28 -0500
In-Reply-To: <56D1270F.4010106@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>

On Friday, February 26, 2016 08:33:19 PM Steve Muckle wrote:
> On 02/25/2016 01:14 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Add a new cpufreq scaling governor, called "schedutil", that uses
> > scheduler-provided CPU utilization information as input for making
> > its decisions.
> > 
> > Doing that is possible after commit fe7034338ba0 (cpufreq: Add
> > mechanism for registering utilization update callbacks) that
> > introduced cpufreq_update_util() called by the scheduler on
> > utilization changes (from CFS) and RT/DL task status updates.
> > In particular, CPU frequency scaling decisions may be based on
> > the the utilization data passed to cpufreq_update_util() by CFS.
> > 
> > The new governor is very simple.  It is almost as simple as it
> > can be and remain reasonably functional.
> > 
> > The frequency selection formula used by it is essentially the same
> > as the one used by the "ondemand" governor, although it doesn't use
> > the additional up_threshold parameter, but instead of computing the
> > load as the "non-idle CPU time" to "total CPU time" ratio, it takes
> > the utilization data provided by CFS as input.  More specifically,
> > it represents "load" as the util/max ratio, where util and max
> > are the utilization and CPU capacity coming from CFS.
> > 
> > All of the computations are carried out in the utilization update
> > handlers provided by the new governor.  One of those handlers is
> > used for cpufreq policies shared between multiple CPUs and the other
> > one is for policies with one CPU only (and therefore it doesn't need
> > to use any extra synchronization means).  The only operation carried
> > out by the new governor's ->gov_dbs_timer callback, sugov_set_freq(),
> > is a __cpufreq_driver_target() call to trigger a frequency update (to
> > a value already computed beforehand in one of the utilization update
> > handlers).  This means that, at least for some cpufreq drivers that
> > can update CPU frequency by doing simple register writes, it should
> > be possible to set the frequency in the utilization update handlers
> > too in which case all of the governor's activity would take place in
> > the scheduler paths invoking cpufreq_update_util() without the need
> > to run anything in process context.
> > 
> > Currently, the governor treats all of the RT and DL tasks as
> > "unknown utilization" and sets the frequency to the allowed
> > maximum when updated from the RT or DL sched classes.  That
> > heavy-handed approach should be replaced with something more
> > specifically targeted at RT and DL tasks.
> > 
> > To some extent it relies on the common governor code in
> > cpufreq_governor.c and it uses that code in a somewhat unusual
> > way (different from what the "ondemand" and "conservative"
> > governors do), so some small and rather unintrusive changes
> > have to be made in that code and the other governors to support it.
> > 
> > However, after making it possible to set the CPU frequency from
> > the utilization update handlers, that new governor's interactions
> > with the common code might be limited to the initialization, cleanup
> > and handling of sysfs attributes (currently only one attribute,
> > sampling_rate, is supported in addition to the standard policy
> > attributes handled by the cpufreq core).
> 
> We'll still need a slow path for platforms that don't support fast
> transitions right?

Right.

> Or is this referring to plans to add an RT thread for slowpath changes
> instead of using the dbs stuff :) .

I did not consider that when I was working on the $subject patch. :-)

> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > There was no v3 of this patch, but patch [2/2] had a v3 in the meantime.
> > 
> > Changes from v2:
> > - Avoid requesting the same frequency that was requested last time for
> >   the given policy.
> > 
> > Changes from v1:
> > - Use policy->min and policy->max as min/max frequency in computations.
> > 
> > ---
> >  drivers/cpufreq/Kconfig                |   15 +
> >  drivers/cpufreq/Makefile               |    1 
> >  drivers/cpufreq/cpufreq_conservative.c |    3 
> >  drivers/cpufreq/cpufreq_governor.c     |   21 +-
> >  drivers/cpufreq/cpufreq_governor.h     |    2 
> >  drivers/cpufreq/cpufreq_ondemand.c     |    3 
> >  drivers/cpufreq/cpufreq_schedutil.c    |  253 +++++++++++++++++++++++++++++++++
> >  7 files changed, 288 insertions(+), 10 deletions(-)
> > 
> > Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
> > +++ linux-pm/drivers/cpufreq/cpufreq_governor.h
> > @@ -164,7 +164,7 @@ struct dbs_governor {
> >  	void (*free)(struct policy_dbs_info *policy_dbs);
> >  	int (*init)(struct dbs_data *dbs_data, bool notify);
> >  	void (*exit)(struct dbs_data *dbs_data, bool notify);
> > -	void (*start)(struct cpufreq_policy *policy);
> > +	bool (*start)(struct cpufreq_policy *policy);
> >  };
> >  
> >  static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy)
> > Index: linux-pm/drivers/cpufreq/cpufreq_schedutil.c
> > ===================================================================
> > --- /dev/null
> > +++ linux-pm/drivers/cpufreq/cpufreq_schedutil.c
> > @@ -0,0 +1,253 @@
> > +/*
> > + * CPUFreq governor based on scheduler-provided CPU utilization data.
> > + *
> > + * Copyright (C) 2016, Intel Corporation
> > + * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/percpu-defs.h>
> > +#include <linux/slab.h>
> > +
> > +#include "cpufreq_governor.h"
> > +
> > +struct sugov_policy {
> > +	struct policy_dbs_info policy_dbs;
> > +	unsigned int next_freq;
> > +	raw_spinlock_t update_lock;  /* For shared policies */
> > +};
> > +
> > +static inline struct sugov_policy *to_sg_policy(struct policy_dbs_info *policy_dbs)
> > +{
> > +	return container_of(policy_dbs, struct sugov_policy, policy_dbs);
> > +}
> > +
> > +struct sugov_cpu {
> > +	struct update_util_data update_util;
> > +	struct policy_dbs_info *policy_dbs;
> > +	/* The fields below are only needed when sharing a policy. */
> > +	unsigned long util;
> > +	unsigned long max;
> > +	u64 last_update;
> > +};
> > +
> > +static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
> > +
> > +/************************ Governor internals ***********************/
> > +
> > +static unsigned int sugov_next_freq(struct policy_dbs_info *policy_dbs,
> > +				    unsigned long util, unsigned long max,
> > +				    u64 last_sample_time)
> > +{
> > +	struct cpufreq_policy *policy = policy_dbs->policy;
> > +	unsigned int min_f = policy->min;
> > +	unsigned int max_f = policy->max;
> > +	unsigned int j;
> > +
> > +	if (util > max || min_f >= max_f)
> > +		return max_f;
> > +
> > +	for_each_cpu(j, policy->cpus) {
> > +		struct sugov_cpu *j_sg_cpu;
> > +		unsigned long j_util, j_max;
> > +
> > +		if (j == smp_processor_id())
> > +			continue;
> > +
> > +		j_sg_cpu = &per_cpu(sugov_cpu, j);
> > +		/*
> > +		 * If the CPU was last updated before the previous sampling
> > +		 * time, we don't take it into account as it probably is idle
> > +		 * now.
> > +		 */
> 
> If the sampling rate is less than the tick, it seems possible a busy CPU
> may not manage to get an update in within the current sampling period.

Right.

sampling_rate is more of a rate limit here, though, because the governor doesn't
really do any sampling (I was talking about that in the intro message at
http://marc.info/?l=linux-pm&m=145609673008122&w=2).

It was easy to re-use the existing show/store for that, so I took the shortcut,
but I'm considering to introduce a new attribute with a more suitable name for
that.  That would help to avoid a couple of unclean things in patch [2/2] as
well if I'm not mistaken.

> What about checking to see if there was an update within the last tick
> period, rather than sample period?

If your rate limit is set below the rate of the updates (scheduling rate more
or less), it simply has no effect.  To me, that case doesn't require any
special care.

> There's also NO_HZ_FULL. I don't know that anyone using NO_HZ_FULL would
> want to use a governor other than performance, but I thought I'd mention
> it just in case.

Yup.  That's broken already with anything different from "performance".

I think we should fix it, but it can be taken care of later.  Plus that's one
of the things that need to be fixed in general rather than for a single
governor.

> > +		if (j_sg_cpu->last_update < last_sample_time)
> > +			continue;
> > +
> > +		j_util = j_sg_cpu->util;
> > +		j_max = j_sg_cpu->max;
> > +		if (j_util > j_max)
> > +			return max_f;
> > +
> > +		if (j_util * max > j_max * util) {
> > +			util = j_util;
> > +			max = j_max;
> > +		}
> > +	}
> > +
> > +	return min_f + util * (max_f - min_f) / max;
> > +}
> > +
> > +static void sugov_update_commit(struct policy_dbs_info *policy_dbs, u64 time,
> > +				unsigned int next_freq)
> > +{
> > +	struct sugov_policy *sg_policy = to_sg_policy(policy_dbs);
> > +
> > +	policy_dbs->last_sample_time = time;
> > +	if (sg_policy->next_freq != next_freq) {
> > +		sg_policy->next_freq = next_freq;
> > +		policy_dbs->work_in_progress = true;
> > +		irq_work_queue(&policy_dbs->irq_work);
> > +	}
> > +}
> > +
> > +static void sugov_update_shared(struct update_util_data *data, u64 time,
> > +				unsigned long util, unsigned long max)
> > +{
> > +	struct sugov_cpu *sg_cpu = container_of(data, struct sugov_cpu, update_util);
> > +	struct policy_dbs_info *policy_dbs = sg_cpu->policy_dbs;
> > +	struct sugov_policy *sg_policy = to_sg_policy(policy_dbs);
> > +	unsigned int next_f;
> > +	u64 delta_ns, lst;
> > +
> > +	raw_spin_lock(&sg_policy->update_lock);
> > +
> > +	sg_cpu->util = util;
> > +	sg_cpu->max = max;
> > +	sg_cpu->last_update = time;
> > +
> > +	if (policy_dbs->work_in_progress)
> > +		goto out;
> > +
> > +	/*
> > +	 * This assumes that dbs_data_handler() will not change sample_delay_ns.
> > +	 */
> > +	lst = policy_dbs->last_sample_time;
> > +	delta_ns = time - lst;
> > +	if ((s64)delta_ns < policy_dbs->sample_delay_ns)
> > +		goto out;
> > +
> > +	next_f = sugov_next_freq(policy_dbs, util, max, lst);
> > +
> > +	sugov_update_commit(policy_dbs, time, next_f);
> > +
> > + out:
> > +	raw_spin_unlock(&sg_policy->update_lock);
> > +}
> > +
> > +static void sugov_update_single(struct update_util_data *data, u64 time,
> > +				unsigned long util, unsigned long max)
> > +{
> > +	struct sugov_cpu *sg_cpu = container_of(data, struct sugov_cpu, update_util);
> > +	struct policy_dbs_info *policy_dbs = sg_cpu->policy_dbs;
> > +	unsigned int min_f, max_f, next_f;
> > +	u64 delta_ns;
> > +
> > +	if (policy_dbs->work_in_progress)
> > +		return;
> > +
> > +	/*
> > +	 * This assumes that dbs_data_handler() will not change sample_delay_ns.
> > +	 */
> > +	delta_ns = time - policy_dbs->last_sample_time;
> > +	if ((s64)delta_ns < policy_dbs->sample_delay_ns)
> > +		return;
> > +
> > +	min_f = policy_dbs->policy->min;
> > +	max_f = policy_dbs->policy->max;
> > +	next_f = util > max || min_f >= max_f ? max_f :
> > +			min_f + util * (max_f - min_f) / max;
> > +
> > +	sugov_update_commit(policy_dbs, time, next_f);
> > +}
> > +
> > +/************************** sysfs interface ************************/
> > +
> > +gov_show_one_common(sampling_rate);
> > +
> > +gov_attr_rw(sampling_rate);
> > +
> > +static struct attribute *sugov_attributes[] = {
> > +	&sampling_rate.attr,
> > +	NULL
> > +};
> > +
> > +/********************** dbs_governor interface *********************/
> > +
> > +static struct policy_dbs_info *sugov_alloc(void)
> > +{
> > +	struct sugov_policy *sg_policy;
> > +
> > +	sg_policy = kzalloc(sizeof(*sg_policy), GFP_KERNEL);
> > +	if (!sg_policy)
> > +		return NULL;
> > +
> > +	raw_spin_lock_init(&sg_policy->update_lock);
> > +	return &sg_policy->policy_dbs;
> > +}
> > +
> > +static void sugov_free(struct policy_dbs_info *policy_dbs)
> > +{
> > +	kfree(to_sg_policy(policy_dbs));
> 
> Is it possible that a CPU could still be in the sugov_update_* path
> above when this runs?

No, it isn't.

> I see that cpufreq_governor_stop will call
> gov_cancel_work which clears the update_util hook, but I don't see
> anything that synchronizes with all CPUs having exited the update path.

gov_cancel_work() calls gov_clear_update_util() which clears the update_util
pointers for all policy CPUs and invokes synchronize_rcu() (or synchronize_sched()
with my latest patch applied: https://patchwork.kernel.org/patch/8443191/).

This guarantees that sugov_update_* won't be running on any of those CPUs
when that has returned.

> > +}
> > +
> > +static bool sugov_start(struct cpufreq_policy *policy)
> > +{
> > +	struct policy_dbs_info *policy_dbs = policy->governor_data;
> > +	struct sugov_policy *sg_policy = to_sg_policy(policy_dbs);
> > +	unsigned int cpu;
> > +
> > +	gov_update_sample_delay(policy_dbs, policy_dbs->dbs_data->sampling_rate);
> > +	policy_dbs->last_sample_time = 0;
> > +	sg_policy->next_freq = UINT_MAX;
> > +
> > +	for_each_cpu(cpu, policy->cpus) {
> > +		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
> > +
> > +		sg_cpu->policy_dbs = policy_dbs;
> > +		if (policy_dbs->is_shared) {
> > +			sg_cpu->util = ULONG_MAX;
> > +			sg_cpu->max = 0;
> > +			sg_cpu->last_update = 0;
> > +			sg_cpu->update_util.func = sugov_update_shared;
> > +		} else {
> > +			sg_cpu->update_util.func = sugov_update_single;
> > +		}
> > +		cpufreq_set_update_util_data(cpu, &sg_cpu->update_util);
> > +	}
> > +	return false;
> > +}
> > +
> > +static unsigned int sugov_set_freq(struct cpufreq_policy *policy)
> > +{
> > +	struct policy_dbs_info *policy_dbs = policy->governor_data;
> > +	struct sugov_policy *sg_policy = to_sg_policy(policy_dbs);
> > +
> > +	__cpufreq_driver_target(policy, sg_policy->next_freq, CPUFREQ_RELATION_C);
> 
> Similar to the concern raised in the acpi changes I think this should be
> CPUFREQ_RELATION_L, otherwise you may not run fast enough to meet demand.

"ondemand" uses CPUFREQ_RELATION_C when powersave_bias is unset and that's why
I used it here.

Like I said in my reply to Peter in that thread, using RELATION_L here is likely
to make us avoid the min frequency almost entirely even if the system is almost
completely idle.  I don't think that would be OK really.

That said my opinion about this particular item isn't really strong.

> > +	return policy_dbs->dbs_data->sampling_rate;
> > +}
> > +
> > +static struct dbs_governor schedutil_gov = {
> > +	.gov = {
> > +		.name = "schedutil",
> > +		.governor = cpufreq_governor_dbs,
> > +		.max_transition_latency	= TRANSITION_LATENCY_LIMIT,
> > +		.owner = THIS_MODULE,
> > +	},
> > +	.kobj_type = { .default_attrs = sugov_attributes },
> > +	.gov_dbs_timer = sugov_set_freq,
> > +	.alloc = sugov_alloc,
> > +	.free = sugov_free,
> > +	.start = sugov_start,
> > +};
> > +
> > +#define CPU_FREQ_GOV_SCHEDUTIL	(&schedutil_gov.gov)
> > +
> > +static int __init sugov_init(void)
> > +{
> > +	return cpufreq_register_governor(CPU_FREQ_GOV_SCHEDUTIL);
> > +}
> > +
> > +static void __exit sugov_exit(void)
> > +{
> > +	cpufreq_unregister_governor(CPU_FREQ_GOV_SCHEDUTIL);
> > +}
> > +
> > +MODULE_AUTHOR("Rafael J. Wysocki <rafael.j.wysocki@intel.com>");
> > +MODULE_DESCRIPTION("Utilization-based CPU frequency selection");
> > +MODULE_LICENSE("GPL");
> > +
> > +module_init(sugov_init);
> > +module_exit(sugov_exit);
> > Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
> > +++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
> > @@ -299,12 +299,13 @@ static void cs_exit(struct dbs_data *dbs
> >  	kfree(dbs_data->tuners);
> >  }
> >  
> > -static void cs_start(struct cpufreq_policy *policy)
> > +static bool cs_start(struct cpufreq_policy *policy)
> >  {
> >  	struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
> >  
> >  	dbs_info->down_skip = 0;
> >  	dbs_info->requested_freq = policy->cur;
> > +	return true;
> >  }
> >  
> >  static struct dbs_governor cs_dbs_gov = {
> > Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
> > +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
> > @@ -472,9 +472,11 @@ static int cpufreq_governor_init(struct
> >  	INIT_LIST_HEAD(&dbs_data->policy_dbs_list);
> >  	mutex_init(&dbs_data->mutex);
> >  
> > -	ret = gov->init(dbs_data, !policy->governor->initialized);
> > -	if (ret)
> > -		goto free_policy_dbs_info;
> > +	if (gov->init) {
> > +		ret = gov->init(dbs_data, !policy->governor->initialized);
> > +		if (ret)
> > +			goto free_policy_dbs_info;
> > +	}
> >  
> >  	/* policy latency is in ns. Convert it to us first */
> >  	latency = policy->cpuinfo.transition_latency / 1000;
> > @@ -510,7 +512,10 @@ static int cpufreq_governor_init(struct
> >  
> >  	if (!have_governor_per_policy())
> >  		gov->gdbs_data = NULL;
> > -	gov->exit(dbs_data, !policy->governor->initialized);
> > +
> > +	if (gov->exit)
> > +		gov->exit(dbs_data, !policy->governor->initialized);
> > +
> >  	kfree(dbs_data);
> >  
> >  free_policy_dbs_info:
> > @@ -544,7 +549,9 @@ static int cpufreq_governor_exit(struct
> >  		if (!have_governor_per_policy())
> >  			gov->gdbs_data = NULL;
> >  
> > -		gov->exit(dbs_data, policy->governor->initialized == 1);
> > +		if (gov->exit)
> > +			gov->exit(dbs_data, policy->governor->initialized == 1);
> > +
> >  		mutex_destroy(&dbs_data->mutex);
> >  		kfree(dbs_data);
> >  	} else {
> > @@ -588,9 +595,9 @@ static int cpufreq_governor_start(struct
> >  			j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
> >  	}
> >  
> > -	gov->start(policy);
> > +	if (gov->start(policy))
> > +		gov_set_update_util(policy_dbs, sampling_rate);
> >  
> > -	gov_set_update_util(policy_dbs, sampling_rate);
> >  	return 0;
> >  }
> >  
> > Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
> > +++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
> > @@ -402,12 +402,13 @@ static void od_exit(struct dbs_data *dbs
> >  	kfree(dbs_data->tuners);
> >  }
> >  
> > -static void od_start(struct cpufreq_policy *policy)
> > +static bool od_start(struct cpufreq_policy *policy)
> >  {
> >  	struct od_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
> >  
> >  	dbs_info->sample_type = OD_NORMAL_SAMPLE;
> >  	ondemand_powersave_bias_init(policy);
> > +	return true;
> >  }
> >  
> >  static struct od_ops od_ops = {
> > Index: linux-pm/drivers/cpufreq/Kconfig
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/Kconfig
> > +++ linux-pm/drivers/cpufreq/Kconfig
> > @@ -184,6 +184,21 @@ config CPU_FREQ_GOV_CONSERVATIVE
> >  
> >  	  If in doubt, say N.
> >  
> > +config CPU_FREQ_GOV_SCHEDUTIL
> > +	tristate "'schedutil' cpufreq policy governor"
> > +	depends on CPU_FREQ
> 
> do you need to select IRQ_WORK here

No, I don't.

It already is selected by CPU_FREQ in linux-next, but it really should be
selected by CPU_FREQ_GOV_COMMON, so let me cut a patch to make that change.

> > +	select CPU_FREQ_GOV_COMMON
> > +	help
> > +	  The frequency selection formula used by this governor is analogous
> > +	  to the one used by 'ondemand', but instead of computing CPU load
> > +	  as the "non-idle CPU time" to "total CPU time" ratio, it uses CPU
> > +	  utilization data provided by the scheduler as input.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called cpufreq_conservative.
> > +
> > +	  If in doubt, say N.
> > +
> >  comment "CPU frequency scaling drivers"
> >  
> >  config CPUFREQ_DT
> > Index: linux-pm/drivers/cpufreq/Makefile
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/Makefile
> > +++ linux-pm/drivers/cpufreq/Makefile
> > @@ -10,6 +10,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_POWERSAVE)	+=
> >  obj-$(CONFIG_CPU_FREQ_GOV_USERSPACE)	+= cpufreq_userspace.o
> >  obj-$(CONFIG_CPU_FREQ_GOV_ONDEMAND)	+= cpufreq_ondemand.o
> >  obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE)	+= cpufreq_conservative.o
> > +obj-$(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)	+= cpufreq_schedutil.o
> >  obj-$(CONFIG_CPU_FREQ_GOV_COMMON)		+= cpufreq_governor.o
> >  
> >  obj-$(CONFIG_CPUFREQ_DT)		+= cpufreq-dt.o
> > 

Thanks for your comments,
Rafael

