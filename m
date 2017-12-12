From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 1/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Tue, 12 Dec 2017 15:16:26 +0000
Message-ID: <20171212151626.GA8264@e110439-lin>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-2-patrick.bellasi@arm.com>
 <20171207050135.vvhqttazumjg7n7n@vireshk-mac-ubuntu>
 <20171207124510.GP31247@e110439-lin>
 <20171212113727.GO25177@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbdLLPQe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Dec 2017 10:16:34 -0500
Content-Disposition: inline
In-Reply-To: <20171212113727.GO25177@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

Hi Viresh,

On 12-Dec 17:07, Viresh Kumar wrote:
> On 07-12-17, 12:45, Patrick Bellasi wrote:
> > On 07-Dec 10:31, Viresh Kumar wrote:

[...]

> I think its important to fix the basic mechanism of util update than fixing
> corner cases with workarounds. I attempted a simpler approach (at least
> according to me :)). Please share your feedback on it. You can include that as
> part of your series, or I can send it separately if everyone finds it okay.

please go on and post this patch on the list, all other patches from
my series can follow on top, later.

Hereafter inline are some comments on your patch...

> 
> -- 
> viresh
> 
> -------------------------8<-------------------------
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Tue, 12 Dec 2017 15:43:26 +0530
> Subject: [PATCH] sched: Keep track of cpufreq utilization update flags
> 
> Currently the schedutil governor overwrites the sg_cpu->flags field on
> every call to the utilization handler. It was pretty good as the initial
> implementation of utilization handlers, there are several drawbacks
> though.
> 
> The biggest drawback is that the sg_cpu->flags field doesn't always
> represent the correct type of tasks that are enqueued on a CPU's rq. For
> example, if a fair task is enqueued while a RT or DL task is running, we
> will overwrite the flags with value 0 and that may take the CPU to lower
> OPPs unintentionally. There can be other corner cases as well which we
> aren't aware of currently.
> 
> This patch changes the current implementation to keep track of all the
> task types that are currently enqueued to the CPUs rq. There are two
> flags for every scheduling class now, one to set the flag and other one
> to clear it.

nit-pick: that's not completely correct, there is only one CLEAR flag
which is used to clear whatever other flags are passed in.

> The flag is set by the scheduling classes from the existing
> set of calls to cpufreq_update_util(), and the flag is cleared when the
> last task of the scheduling class is dequeued. For now, the util update
> handlers return immediately if they were called to clear the flag.
> 
> We can add more optimizations over this patch separately.
> 
> The last parameter of sugov_set_iowait_boost() is also dropped as the
> function can get it from sg_cpu anyway.

As I comment below, this should be on a different patch IMO.

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

[...]

> @@ -8,9 +8,14 @@
>   * Interface between cpufreq drivers and the scheduler:
>   */
>  
> +#define SCHED_CPUFREQ_CLEAR	(1U << 31)
>  #define SCHED_CPUFREQ_RT	(1U << 0)
> +#define SCHED_CPUFREQ_RT_CLEAR	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_CLEAR)
>  #define SCHED_CPUFREQ_DL	(1U << 1)
> -#define SCHED_CPUFREQ_IOWAIT	(1U << 2)
> +#define SCHED_CPUFREQ_DL_CLEAR	(SCHED_CPUFREQ_DL | SCHED_CPUFREQ_CLEAR)
> +#define SCHED_CPUFREQ_CFS	(1U << 2)
> +#define SCHED_CPUFREQ_CFS_CLEAR	(SCHED_CPUFREQ_CFS | SCHED_CPUFREQ_CLEAR)
> +#define SCHED_CPUFREQ_IOWAIT	(1U << 3)
>  
>  #define SCHED_CPUFREQ_RT_DL	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_DL)

Since you are already changing some flags position, maybe we can have
a better organization by using lower flags for "general bits" and
higher ones for class specific, i.e.

#define SCHED_CPUFREQ_CLEAR	(1U <<  0)
#define SCHED_CPUFREQ_IOWAIT	(1U <<  1)

#define SCHED_CPUFREQ_CFS	(1U <<  8)
#define SCHED_CPUFREQ_RT	(1U <<  9)
#define SCHED_CPUFREQ_DL	(1U << 10)
#define SCHED_CPUFREQ_RT_DL	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_DL)

#define SCHED_CPUFREQ_CFS_CLEAR	(SCHED_CPUFREQ_CFS | SCHED_CPUFREQ_CLEAR)
#define SCHED_CPUFREQ_RT_CLEAR	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_CLEAR)
#define SCHED_CPUFREQ_DL_CLEAR	(SCHED_CPUFREQ_DL | SCHED_CPUFREQ_CLEAR)

>  
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 2f52ec0f1539..7edfdc59ee8f 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -187,10 +187,11 @@ static void sugov_get_util(unsigned long *util, unsigned long *max, int cpu)
>  	*max = cfs_max;
>  }
>  
> -static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
> -				   unsigned int flags)
> +static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time)
>  {
> -	if (flags & SCHED_CPUFREQ_IOWAIT) {
> +	if (sg_cpu->flags & SCHED_CPUFREQ_IOWAIT) {
> +		sg_cpu->flags &= ~SCHED_CPUFREQ_IOWAIT;
> +

This function should still work if we pass in flags as a parameter.
Thus, this looks like an change/optimization of the
sugov_set_iowait_boost API, which maybe should be better moved into a
separate patch on top of this one.

>  		if (sg_cpu->iowait_boost_pending)
>  			return;
>  

[...]

> @@ -655,7 +669,7 @@ static int sugov_start(struct cpufreq_policy *policy)
>  		memset(sg_cpu, 0, sizeof(*sg_cpu));
>  		sg_cpu->cpu = cpu;
>  		sg_cpu->sg_policy = sg_policy;
> -		sg_cpu->flags = SCHED_CPUFREQ_RT;
> +		sg_cpu->flags = 0;

Juri already pointed out this change, why it's needed?
Perhaps a note in the changelog can be useful.

>  		sg_cpu->iowait_boost_max = policy->cpuinfo.max_freq;
>  	}
>  

[...]

-- 
#include <best/regards.h>

Patrick Bellasi
