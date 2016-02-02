From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH 5/5] cpufreq: Get rid of ->governor_enabled and its lock
Date: Tue, 2 Feb 2016 16:49:37 +0000
Message-ID: <20160202164937.GK3947@e106622-lin>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
 <48d24fd180e1fdf1c06a6992748c6365be43e937.1454410226.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56931 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754377AbcBBQs6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Feb 2016 11:48:58 -0500
Content-Disposition: inline
In-Reply-To: <48d24fd180e1fdf1c06a6992748c6365be43e937.1454410226.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org

Hi Viresh,

On 02/02/16 16:27, Viresh Kumar wrote:
> Invalid state-transitions is verified by governor core now and there is
> no need to replicate that in cpufreq core. Also we don't drop
> policy->rwsem anymore, which makes rest of the races go away.

There are still paths where we call __cpufreq_governor() without holding
policy->rwsem, but those should be fixed with my cleanups (that I intend
to refresh and post soon). So, I'm not sure we can safely remove this
yet.

> 
> Simplify code a bit now.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 24 ------------------------
>  include/linux/cpufreq.h   |  1 -
>  2 files changed, 25 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 5f7e24567e0e..052ad1b9372c 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -102,7 +102,6 @@ static LIST_HEAD(cpufreq_governor_list);
>  static struct cpufreq_driver *cpufreq_driver;
>  static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
>  static DEFINE_RWLOCK(cpufreq_driver_lock);
> -DEFINE_MUTEX(cpufreq_governor_lock);
>  
>  /* Flag to suspend/resume CPUFreq governors */
>  static bool cpufreq_suspended;
> @@ -1963,21 +1962,6 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
>  
>  	pr_debug("%s: for CPU %u, event %u\n", __func__, policy->cpu, event);
>  
> -	mutex_lock(&cpufreq_governor_lock);
> -	if ((policy->governor_enabled && event == CPUFREQ_GOV_START)
> -	    || (!policy->governor_enabled
> -	    && (event == CPUFREQ_GOV_LIMITS || event == CPUFREQ_GOV_STOP))) {
> -		mutex_unlock(&cpufreq_governor_lock);
> -		return -EBUSY;
> -	}
> -
> -	if (event == CPUFREQ_GOV_STOP)
> -		policy->governor_enabled = false;
> -	else if (event == CPUFREQ_GOV_START)
> -		policy->governor_enabled = true;
> -
> -	mutex_unlock(&cpufreq_governor_lock);
> -
>  	ret = policy->governor->governor(policy, event);

So, __cpufreq_governor() becomes effectively a wrapper around
->governor() calls and governors are left responsible for implementing
the state machine with appropriate checks.

I'm wondering if this approach is completely sane, but what we end up
with your changes should work (and we kill a lock! :)).

Maybe we add a comment somewhere stating exactly how things are meant to
work?

Thanks,

- Juri
