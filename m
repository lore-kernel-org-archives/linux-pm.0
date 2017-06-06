From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Tue, 6 Jun 2017 14:56:51 +0530
Message-ID: <20170606092651.GC5103@vireshk-i7>
References: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com>
 <1488469507-32463-2-git-send-email-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34343 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbdFFJ04 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jun 2017 05:26:56 -0400
Received: by mail-pf0-f173.google.com with SMTP id 9so95762902pfj.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Jun 2017 02:26:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1488469507-32463-2-git-send-email-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Redpath <chris.redpath@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On 02-03-17, 15:45, Patrick Bellasi wrote:
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index e2ed46d..739b29d 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -3653,6 +3653,7 @@ static inline unsigned long rlimit_max(unsigned int limit)
>  #define SCHED_CPUFREQ_RT	(1U << 0)
>  #define SCHED_CPUFREQ_DL	(1U << 1)
>  #define SCHED_CPUFREQ_IOWAIT	(1U << 2)
> +#define SCHED_CPUFREQ_IDLE	(1U << 3)
>  
>  #define SCHED_CPUFREQ_RT_DL	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_DL)
>  
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index fd46593..084a98b 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -281,6 +281,12 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>  
>  	raw_spin_lock(&sg_policy->update_lock);
>  
> +	/* CPU is entering IDLE, reset flags without triggering an update */
> +	if (flags & SCHED_CPUFREQ_IDLE) {
> +		sg_cpu->flags = 0;
> +		goto done;
> +	}
> +
>  	sg_cpu->util = util;
>  	sg_cpu->max = max;
>  	sg_cpu->flags = flags;
> @@ -293,6 +299,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
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
>  	return rq->idle;
>  }

I was discussing about almost the same problem with Vincent today and we were
convinced to write exactly the same patch to solve that. And then I saw this old
thread again :)

Why did this thread die completely ?

Can we at least get the patches which don't have any objections merged
separately first ?

-- 
viresh
