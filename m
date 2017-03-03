From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/6] cpufreq: schedutil: ensure max frequency while
 running RT/DL tasks
Date: Fri, 3 Mar 2017 14:01:45 +0530
Message-ID: <20170303083145.GA8206@vireshk-i7>
References: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com>
 <1488469507-32463-4-git-send-email-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1488469507-32463-4-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Redpath <chris.redpath@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On 02-03-17, 15:45, Patrick Bellasi wrote:
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> @@ -293,15 +305,29 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>  	if (curr == sg_policy->thread)
>  		goto done;
>  
> +	/*
> +	 * While RT/DL tasks are running we do not want FAIR tasks to
> +	 * overwrite this CPU's flags, still we can update utilization and
> +	 * frequency (if required/possible) to be fair with these tasks.
> +	 */
> +	rt_mode = task_has_dl_policy(curr) ||
> +		  task_has_rt_policy(curr) ||
> +		  (flags & SCHED_CPUFREQ_RT_DL);
> +	if (rt_mode)
> +		sg_cpu->flags |= flags;
> +	else
> +		sg_cpu->flags = flags;

This looks so hacked up :)

Wouldn't it be better to let the scheduler tell us what all kind of tasks it has
in the rq of a CPU and pass a mask of flags? I think it wouldn't be difficult
(or time consuming) for the scheduler to know that, but I am not 100% sure.

IOW, the flags field in cpufreq_update_util() will represent all tasks in the
rq, instead of just the task that is getting enqueued/dequeued..

And obviously we need to get some utilization numbers for the RT and DL tasks
going forward, switching to max isn't going to work for ever :)

-- 
viresh
