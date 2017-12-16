From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 4/4] sched/cpufreq_schedutil: use util_est for OPP selection
Date: Sat, 16 Dec 2017 03:35:58 +0100
Message-ID: <1730241.78TPuThRce@aspire.rjw.lan>
References: <20171205171018.9203-1-patrick.bellasi@arm.com> <20171205171018.9203-5-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42936 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756090AbdLPCgo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Dec 2017 21:36:44 -0500
In-Reply-To: <20171205171018.9203-5-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On Tuesday, December 5, 2017 6:10:18 PM CET Patrick Bellasi wrote:
> When schedutil looks at the CPU utilization, the current PELT value for
> that CPU is returned straight away. In certain scenarios this can have
> undesired side effects and delays on frequency selection.
> 
> For example, since the task utilization is decayed at wakeup time, a
> long sleeping big task newly enqueued does not add immediately a
> significant contribution to the target CPU. This introduces some latency
> before schedutil will be able to detect the best frequency required by
> that task.
> 
> Moreover, the PELT signal build-up time is function of the current
> frequency, because of the scale invariant load tracking support. Thus,
> starting from a lower frequency, the utilization build-up time will
> increase even more and further delays the selection of the actual
> frequency which better serves the task requirements.
> 
> In order to reduce these kind of latencies, this patch integrates the
> usage of the CPU's estimated utilization in the sugov_get_util function.
> 
> The estimated utilization of a CPU is defined to be the maximum between
> its PELT's utilization and the sum of the estimated utilization of each
> currently RUNNABLE task on that CPU.
> This allows to properly represent the expected utilization of a CPU which,
> for example, has just got a big task running after a long sleep period,
> and ultimately it allows to select the best frequency to run a task
> right after it wakes up.
> 
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Reviewed-by: Brendan Jackman <brendan.jackman@arm.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Paul Turner <pjt@google.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> 
> ---
> Changes v1->v2:
>  - rebase on top of v4.15-rc2
>  - tested that overhauled PELT code does not affect the util_est
> ---
>  kernel/sched/cpufreq_schedutil.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 2f52ec0f1539..465430d99440 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -183,7 +183,11 @@ static void sugov_get_util(unsigned long *util, unsigned long *max, int cpu)
>  
>  	cfs_max = arch_scale_cpu_capacity(NULL, cpu);
>  
> -	*util = min(rq->cfs.avg.util_avg, cfs_max);
> +	*util = rq->cfs.avg.util_avg;

I would use a local variable here.

That *util everywhere looks a bit dirtyish.

> +	if (sched_feat(UTIL_EST))
> +		*util = max(*util, rq->cfs.util_est_runnable);
> +	*util = min(*util, cfs_max);
> +
>  	*max = cfs_max;
>  }
>  
> 
