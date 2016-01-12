From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 17/19] cpufreq: stop checking for cpufreq_driver
 being present in cpufreq_cpu_get
Date: Tue, 12 Jan 2016 16:47:29 +0530
Message-ID: <20160112111729.GI1084@ubuntu>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-18-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36123 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbcALLRd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 06:17:33 -0500
Received: by mail-pa0-f48.google.com with SMTP id yy13so245758454pab.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 03:17:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1452533760-13787-18-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 11-01-16, 17:35, Juri Lelli wrote:
> After cpufreq_driver_lock() is acquired in cpufreq_cpu_get() we are sure
> we can't race with cpufreq_policy_free() (which is in the path that ends
> up removing cpufreq_driver). We can thus safely remove check for
> cpufreq_driver being present (which is a leftover from commit
> 6eed9404ab3c ("cpufreq: Use rwsem for protecting critical sections")).
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 797bfae..6c9bef7 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -282,15 +282,15 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
>  	if (WARN_ON(cpu >= nr_cpu_ids))
>  		return NULL;
>  
> -	/* get the cpufreq driver */
>  	read_lock_irqsave(&cpufreq_driver_lock, flags);
>  
> -	if (cpufreq_driver) {
> -		/* get the CPU */
> -		policy = cpufreq_cpu_get_raw(cpu);
> -		if (policy)
> -			kobject_get(&policy->kobj);
> -	}
> +	/*
> +	 * If we get a policy, cpufreq_policy_free() didn't
> +	 * yet run.
> +	 */
> +	policy = cpufreq_cpu_get_raw(cpu);
> +	if (policy)
> +		kobject_get(&policy->kobj);
>  
>  	read_unlock_irqrestore(&cpufreq_driver_lock, flags);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
