From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v2 2/2] cpufreq / sched: Pass runqueue pointer to
 cpufreq_update_util()
Date: Mon, 15 Aug 2016 15:16:12 -0700
Message-ID: <20160815221612.GJ14324@graphite.smuckle.net>
References: <6346523.ZooER3FGDH@vostro.rjw.lan>
 <6457758.OIoE6g3rfd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6457758.OIoE6g3rfd@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

LGTM

On Fri, Aug 12, 2016 at 02:06:44AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> All of the callers of cpufreq_update_util() pass rq_clock(rq) to it
> as the time argument and some of them check whether or not cpu_of(rq)
> is equal to smp_processor_id() before calling it, so rework it to
> take a runqueue pointer as the argument and move the rq_clock(rq)
> evaluation into it.
> 
> Additionally, provide a wrapper checking cpu_of(rq) against
> smp_processor_id() for the cpufreq_update_util() callers that
> need it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a new patch based on the [2/2] from v1.
> 
> ---
>  kernel/sched/deadline.c |    3 +--
>  kernel/sched/fair.c     |    4 +---
>  kernel/sched/rt.c       |    3 +--
>  kernel/sched/sched.h    |   15 +++++++++++----
>  4 files changed, 14 insertions(+), 11 deletions(-)
> 
> Index: linux-pm/kernel/sched/deadline.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/deadline.c
> +++ linux-pm/kernel/sched/deadline.c
> @@ -733,8 +733,7 @@ static void update_curr_dl(struct rq *rq
>  	}
>  
>  	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
> -	if (cpu_of(rq) == smp_processor_id())
> -		cpufreq_update_util(rq_clock(rq), SCHED_CPUFREQ_DL);
> +	cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_DL);
>  
>  	schedstat_set(curr->se.statistics.exec_max,
>  		      max(curr->se.statistics.exec_max, delta_exec));
> Index: linux-pm/kernel/sched/fair.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/fair.c
> +++ linux-pm/kernel/sched/fair.c
> @@ -2876,8 +2876,6 @@ static inline void update_tg_load_avg(st
>  static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
>  {
>  	if (&this_rq()->cfs == cfs_rq) {
> -		struct rq *rq = rq_of(cfs_rq);
> -
>  		/*
>  		 * There are a few boundary cases this might miss but it should
>  		 * get called often enough that that should (hopefully) not be
> @@ -2894,7 +2892,7 @@ static inline void cfs_rq_util_change(st
>  		 *
>  		 * See cpu_util().
>  		 */
> -		cpufreq_update_util(rq_clock(rq), 0);
> +		cpufreq_update_util(rq_of(cfs_rq), 0);
>  	}
>  }
>  
> Index: linux-pm/kernel/sched/rt.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/rt.c
> +++ linux-pm/kernel/sched/rt.c
> @@ -958,8 +958,7 @@ static void update_curr_rt(struct rq *rq
>  		return;
>  
>  	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
> -	if (cpu_of(rq) == smp_processor_id())
> -		cpufreq_update_util(rq_clock(rq), SCHED_CPUFREQ_RT);
> +	cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_RT);
>  
>  	schedstat_set(curr->se.statistics.exec_max,
>  		      max(curr->se.statistics.exec_max, delta_exec));
> Index: linux-pm/kernel/sched/sched.h
> ===================================================================
> --- linux-pm.orig/kernel/sched/sched.h
> +++ linux-pm/kernel/sched/sched.h
> @@ -1763,7 +1763,7 @@ DECLARE_PER_CPU(struct update_util_data
>  
>  /**
>   * cpufreq_update_util - Take a note about CPU utilization changes.
> - * @time: Current time.
> + * @rq: Runqueue to carry out the update for.
>   * @flags: Update reason flags.
>   *
>   * This function is called by the scheduler on the CPU whose utilization is
> @@ -1783,16 +1783,23 @@ DECLARE_PER_CPU(struct update_util_data
>   * but that really is a band-aid.  Going forward it should be replaced with
>   * solutions targeted more specifically at RT and DL tasks.
>   */
> -static inline void cpufreq_update_util(u64 time, unsigned int flags)
> +static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
>  {
>  	struct update_util_data *data;
>  
>  	data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
>  	if (data)
> -		data->func(data, time, flags);
> +		data->func(data, rq_clock(rq), flags);
> +}
> +
> +static inline void cpufreq_update_this_cpu(struct rq *rq, unsigned int flags)
> +{
> +	if (cpu_of(rq) == smp_processor_id())
> +		cpufreq_update_util(rq, flags);
>  }
>  #else
> -static inline void cpufreq_update_util(u64 time, unsigned int flags) {}
> +static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
> +static inline void cpufreq_update_this_cpu(struct rq *rq, unsigned int flags) {}
>  #endif /* CONFIG_CPU_FREQ */
>  
>  #ifdef arch_scale_freq_capacity
> 
