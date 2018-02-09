From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: schedutil: rate limits for SCHED_DEADLINE
Date: Fri, 9 Feb 2018 09:21:43 +0530
Message-ID: <20180209035143.GX28462@vireshk-i7>
References: <1518109302-8239-1-git-send-email-claudio@evidence.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:32906 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752214AbeBIDvs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Feb 2018 22:51:48 -0500
Received: by mail-pl0-f68.google.com with SMTP id t4so911804plo.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Feb 2018 19:51:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1518109302-8239-1-git-send-email-claudio@evidence.eu.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 08-02-18, 18:01, Claudio Scordino wrote:
> When the SCHED_DEADLINE scheduling class increases the CPU utilization,
> we should not wait for the rate limit, otherwise we may miss some deadline.
> 
> Tests using rt-app on Exynos5422 have shown reductions of about 10% of deadline
> misses for tasks with low RT periods.
> 
> The patch applies on top of the one recently proposed by Peter to drop the
> SCHED_CPUFREQ_* flags.
> 
> Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
> CC: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
> CC: Patrick Bellasi <patrick.bellasi@arm.com>
> CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
> CC: Morten Rasmussen <morten.rasmussen@arm.com>
> CC: Juri Lelli <juri.lelli@redhat.com>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> CC: Vincent Guittot <vincent.guittot@linaro.org>
> CC: Todd Kjos <tkjos@android.com>
> CC: Joel Fernandes <joelaf@google.com>
> CC: linux-pm@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  kernel/sched/cpufreq_schedutil.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

So the previous commit was surely incorrect as it relied on comparing
frequencies instead of dl-util, and freq requirements could have even
changed due to CFS.

> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index b0bd77d..d8dcba2 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -74,7 +74,10 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
>  
>  /************************ Governor internals ***********************/
>  
> -static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> +static bool sugov_should_update_freq(struct sugov_policy *sg_policy,
> +				     u64 time,
> +				     struct sugov_cpu *sg_cpu_old,
> +				     struct sugov_cpu *sg_cpu_new)
>  {
>  	s64 delta_ns;
>  
> @@ -111,6 +114,10 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>  		return true;
>  	}
>  
> +	/* Ignore rate limit when DL increased utilization. */
> +	if (sg_cpu_new->util_dl > sg_cpu_old->util_dl)
> +		return true;
> +

Changing the frequency has a penalty, specially in the ARM world (and
that's where you are testing your stuff). I am worried that we will
have (corner) cases where we will waste a lot of time changing the
frequencies. For example (I may be wrong here), what if 10 small DL
tasks are queued one after the other? The util will keep on changing
and so will the frequency ? There may be more similar cases ?

Is it possible to (somehow) check here if the DL tasks will miss
deadline if we continue to run at current frequency? And only ignore
rate-limit if that is the case ?

>  	delta_ns = time - sg_policy->last_freq_update_time;
>  	return delta_ns >= sg_policy->freq_update_delay_ns;
>  }
> @@ -271,6 +278,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  				unsigned int flags)
>  {
>  	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
> +	struct sugov_cpu sg_cpu_old = *sg_cpu;

Not really a big deal, but this structure is 80 bytes on ARM64, why
copy everything when what we need is just 8 bytes ?

-- 
viresh
