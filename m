From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v3 3/6] cpufreq: schedutil: update CFS util only if used
Date: Thu, 30 Nov 2017 14:22:34 +0100
Message-ID: <20171130132234.GC9903@localhost.localdomain>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-4-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171130114723.29210-4-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 30/11/17 11:47, Patrick Bellasi wrote:
> Currently the utilization of the FAIR class is collected before locking
> the policy. Although that should not be a big issue for most cases, we
> also don't really know how much latency there can be between the
> utilization reading and its usage.
> 
> Let's get the FAIR utilization right before its usage to be better in
> sync with the current status of a CPU.
> 
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> 
> ---
> Changes from v2:
> - rebased on v4.15-rc1
> 
> Change-Id: I9291a560bcad7db76894e3f0fcdb917511d0479e
> ---
>  kernel/sched/cpufreq_schedutil.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 448f49de5335..40521d59630b 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -351,10 +351,9 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>  	unsigned int next_f;
>  	bool rt_mode;
>  
> -	sugov_get_util(&util, &max, sg_cpu->cpu);
> -
>  	raw_spin_lock(&sg_policy->update_lock);
>  
> +	sugov_get_util(&util, &max, sg_cpu->cpu);
>  	sg_cpu->util = util;
>  	sg_cpu->max = max;

Patch looks good.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

However, not sure $SUBJECT is really in sync with what the patch does?
CFS gets "used" before and after the patch... last paragraph of the
changelog looks more like it. :)

Best,

Juri
