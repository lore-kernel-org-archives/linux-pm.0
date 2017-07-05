From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Wed, 5 Jul 2017 10:20:12 +0530
Message-ID: <20170705045012.GM3532@vireshk-i7>
References: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com>
 <1499189651-18797-3-git-send-email-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:32997 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbdGEEuR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jul 2017 00:50:17 -0400
Received: by mail-pf0-f173.google.com with SMTP id e7so123595435pfk.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Jul 2017 21:50:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1499189651-18797-3-git-send-email-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Andres Oportus <andresoportus@google.com>, Todd Kjos <tkjos@android.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

On 04-07-17, 18:34, Patrick Bellasi wrote:
> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> index d2be2cc..36ac8d2 100644
> --- a/include/linux/sched/cpufreq.h
> +++ b/include/linux/sched/cpufreq.h
> @@ -10,6 +10,7 @@
>  #define SCHED_CPUFREQ_RT	(1U << 0)
>  #define SCHED_CPUFREQ_DL	(1U << 1)
>  #define SCHED_CPUFREQ_IOWAIT	(1U << 2)
> +#define SCHED_CPUFREQ_IDLE	(1U << 3)
>  
>  #define SCHED_CPUFREQ_RT_DL	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_DL)
>  
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index eaba6d6..004ae18 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -304,6 +304,12 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>  
>  	sg_cpu->util = util;
>  	sg_cpu->max = max;
> +
> +	/* CPU is entering IDLE, reset flags without triggering an update */
> +	if (unlikely(flags & SCHED_CPUFREQ_IDLE)) {
> +		sg_cpu->flags = 0;
> +		goto done;
> +	}

Why is it important to have the above diff at all ? For example we aren't doing
similar stuff in sugov_update_single() and that will go on and try to change the
frequency if rate_limit_us time is over since last update.

And also why is it important to write 0 to sg_cpu->flags ? What wouldn't work if
we set sg_cpu->flags to SCHED_CPUFREQ_IDLE in this case ? i.e. Just the below
statement should be good for us.

>  	sg_cpu->flags = flags;
>  
>  	sugov_set_iowait_boost(sg_cpu, time, flags);
> @@ -318,6 +324,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>  		sugov_update_commit(sg_policy, time, next_f);
>  	}
>  
> +done:
>  	raw_spin_unlock(&sg_policy->update_lock);
>  }
>  
> diff --git a/kernel/sched/idle_task.c b/kernel/sched/idle_task.c
> index 0c00172..a844c91 100644
> --- a/kernel/sched/idle_task.c
> +++ b/kernel/sched/idle_task.c
> @@ -29,6 +29,10 @@ pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>  	put_prev_task(rq, prev);
>  	update_idle_core(rq);
>  	schedstat_inc(rq->sched_goidle);
> +
> +	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
> +	cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_IDLE);
> +

This looks correct.

Can we completely avoid the utilization contribution of the CPUs which have gone
idle? Right now we avoid them with help of (delta_ns > TICK_NSEC). Can we
instead check this SCHED_CPUFREQ_IDLE flag ?

-- 
viresh
