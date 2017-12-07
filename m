From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Thu, 7 Dec 2017 10:31:35 +0530
Message-ID: <20171207050135.vvhqttazumjg7n7n@vireshk-mac-ubuntu>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-2-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171130114723.29210-2-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 30-11-17, 11:47, Patrick Bellasi wrote:
> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> index d1ad3d825561..bb5f778db023 100644
> --- a/include/linux/sched/cpufreq.h
> +++ b/include/linux/sched/cpufreq.h
> @@ -11,6 +11,7 @@
>  #define SCHED_CPUFREQ_RT	(1U << 0)
>  #define SCHED_CPUFREQ_DL	(1U << 1)
>  #define SCHED_CPUFREQ_IOWAIT	(1U << 2)
> +#define SCHED_CPUFREQ_IDLE	(1U << 3)
>  
>  #define SCHED_CPUFREQ_RT_DL	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_DL)
>  
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 2f52ec0f1539..67339ccb5595 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -347,6 +347,12 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>  
>  	sg_cpu->util = util;
>  	sg_cpu->max = max;
> +
> +	/* CPU is entering IDLE, reset flags without triggering an update */
> +	if (unlikely(flags & SCHED_CPUFREQ_IDLE)) {
> +		sg_cpu->flags = 0;
> +		goto done;
> +	}
>  	sg_cpu->flags = flags;
>  
>  	sugov_set_iowait_boost(sg_cpu, time, flags);
> @@ -361,6 +367,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>  		sugov_update_commit(sg_policy, time, next_f);
>  	}
>  
> +done:
>  	raw_spin_unlock(&sg_policy->update_lock);
>  }
>  
> diff --git a/kernel/sched/idle_task.c b/kernel/sched/idle_task.c
> index d518664cce4f..6e8ae2aa7a13 100644
> --- a/kernel/sched/idle_task.c
> +++ b/kernel/sched/idle_task.c
> @@ -30,6 +30,10 @@ pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>  	put_prev_task(rq, prev);
>  	update_idle_core(rq);
>  	schedstat_inc(rq->sched_goidle);
> +
> +	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
> +	cpufreq_update_util(rq, SCHED_CPUFREQ_IDLE);

We posted some comments on V2 for this particular patch suggesting
some improvements. The patch hasn't changed at all and you haven't
replied to few of those suggestions as well. Any particular reason for
that?

For example:
- I suggested to get rid of the conditional expression in
  cpufreq_schedutil.c file that you have added.
- And Joel suggested to clear the RT/DL flags from dequeue path to
  avoid adding SCHED_CPUFREQ_IDLE flag.

-- 
viresh
