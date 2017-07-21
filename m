From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V3 1/3] sched: cpufreq: Allow remote cpufreq callbacks
Date: Fri, 21 Jul 2017 15:03:49 +0200
Message-ID: <20170721130349.mv7soic62jdnirq5@hirez.programming.kicks-ass.net>
References: <cover.1499927699.git.viresh.kumar@linaro.org>
 <0f950529a63fb95e87944644c4854be4fcfaea38.1499927699.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:32818 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbdGUNEF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2017 09:04:05 -0400
Content-Disposition: inline
In-Reply-To: <0f950529a63fb95e87944644c4854be4fcfaea38.1499927699.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, linux-kernel@vger.kernel.org

On Thu, Jul 13, 2017 at 12:14:37PM +0530, Viresh Kumar wrote:
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 47e24b5384b3..606b1a37a1af 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -275,6 +275,10 @@ static void dbs_update_util_handler(struct update_util_data *data, u64 time,
>  	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
>  	u64 delta_ns, lst;
>  
> +	/* Don't allow remote callbacks */
> +	if (smp_processor_id() != data->cpu)
> +		return;
> +

The alternative is using some of that policy_dbs->policy->*cpus crud I
suppose, because:

>  	/*
>  	 * The work may not be allowed to be queued up right now.
>  	 * Possible reasons:
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index b7fb8b7c980d..4bee2f4cbc28 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1732,6 +1732,10 @@ static void intel_pstate_update_util_pid(struct update_util_data *data,
>  	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
>  	u64 delta_ns = time - cpu->sample.time;
>  
> +	/* Don't allow remote callbacks */
> +	if (smp_processor_id() != data->cpu)
> +		return;
> +
>  	if ((s64)delta_ns < pid_params.sample_rate_ns)
>  		return;
>  
> @@ -1749,6 +1753,10 @@ static void intel_pstate_update_util(struct update_util_data *data, u64 time,
>  	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
>  	u64 delta_ns;
>  
> +	/* Don't allow remote callbacks */
> +	if (smp_processor_id() != data->cpu)
> +		return;
> +
>  	if (flags & SCHED_CPUFREQ_IOWAIT) {
>  		cpu->iowait_boost = int_tofp(1);
>  	} else if (cpu->iowait_boost) {


For these we can already use cpu->cpu, which would make:

> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> index d2be2ccbb372..8256a8f35f22 100644
> --- a/include/linux/sched/cpufreq.h
> +++ b/include/linux/sched/cpufreq.h
> @@ -16,6 +16,7 @@
>  #ifdef CONFIG_CPU_FREQ
>  struct update_util_data {
>         void (*func)(struct update_util_data *data, u64 time, unsigned int flags);
> +       unsigned int cpu;
>  };
>  
>  void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
> diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
> index dbc51442ecbc..ee4c596b71b4 100644
> --- a/kernel/sched/cpufreq.c
> +++ b/kernel/sched/cpufreq.c
> @@ -42,6 +42,7 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
>  		return;
>  
>  	data->func = func;
> +	data->cpu = cpu;
>  	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_add_update_util_hook);

redundant.

> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 29a397067ffa..ed9c589e5386 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -218,6 +218,10 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  	unsigned int next_f;
>  	bool busy;
>  
> +	/* Remote callbacks aren't allowed for policies which aren't shared */
> +	if (smp_processor_id() != hook->cpu)
> +		return;
> +
>  	sugov_set_iowait_boost(sg_cpu, time, flags);
>  	sg_cpu->last_update = time;
>  
> @@ -290,6 +294,10 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>  	unsigned long util, max;
>  	unsigned int next_f;
>  
> +	/* Don't allow remote callbacks */
> +	if (smp_processor_id() != hook->cpu)
> +		return;
> +
>  	sugov_get_util(&util, &max);
>  
>  	raw_spin_lock(&sg_policy->update_lock);


Given the whole rq->lock thing, I suspect we could actually not do these
two. That would then continue to process the iowait and other accounting
stuff, but stall the moment we call into the actual driver, which will
then drop the request on the floor as per the first few hunks.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index a84299f44b5d..7fcfaee39d19 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1136,7 +1136,7 @@ static void update_curr_dl(struct rq *rq)
>  	}
>  
>  	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
> -	cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_DL);
> +	cpufreq_update_util(rq, SCHED_CPUFREQ_DL);
>  
>  	schedstat_set(curr->se.statistics.exec_max,
>  		      max(curr->se.statistics.exec_max, delta_exec));
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c95880e216f6..d378d02fdfcb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3278,7 +3278,9 @@ static inline void set_tg_cfs_propagate(struct cfs_rq *cfs_rq) {}
>  
>  static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
>  {
> -	if (&this_rq()->cfs == cfs_rq) {
> +	struct rq *rq = rq_of(cfs_rq);
> +
> +	if (&rq->cfs == cfs_rq) {
>  		/*
>  		 * There are a few boundary cases this might miss but it should
>  		 * get called often enough that that should (hopefully) not be
> @@ -3295,7 +3297,7 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
>  		 *
>  		 * See cpu_util().
>  		 */
> -		cpufreq_update_util(rq_of(cfs_rq), 0);
> +		cpufreq_update_util(rq, 0);
>  	}
>  }
>  
> @@ -4875,7 +4877,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	 * passed.
>  	 */
>  	if (p->in_iowait)
> -		cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_IOWAIT);
> +		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
>  
>  	for_each_sched_entity(se) {
>  		if (se->on_rq)
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 45caf937ef90..0af5ca9e3e3f 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -970,7 +970,7 @@ static void update_curr_rt(struct rq *rq)
>  		return;
>  
>  	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
> -	cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_RT);
> +	cpufreq_update_util(rq, SCHED_CPUFREQ_RT);
>  
>  	schedstat_set(curr->se.statistics.exec_max,
>  		      max(curr->se.statistics.exec_max, delta_exec));
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index eeef1a3086d1..aa9d5b87b4f8 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2070,19 +2070,13 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
>  {
>  	struct update_util_data *data;
>  
> -	data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
> +	data = rcu_dereference_sched(*per_cpu_ptr(&cpufreq_update_util_data,
> +						  cpu_of(rq)));
>  	if (data)
>  		data->func(data, rq_clock(rq), flags);
>  }
> -
> -static inline void cpufreq_update_this_cpu(struct rq *rq, unsigned int flags)
> -{
> -	if (cpu_of(rq) == smp_processor_id())
> -		cpufreq_update_util(rq, flags);
> -}
>  #else
>  static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
> -static inline void cpufreq_update_this_cpu(struct rq *rq, unsigned int flags) {}
>  #endif /* CONFIG_CPU_FREQ */

This seems ok. Except of course you'll have conflicts with Juri's patch
set, but that should be trivial to sort out.
