From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: governor: Ensure sufficiently large sampling intervals
Date: Wed, 31 Jan 2018 10:27:50 +0100
Message-ID: <2630000.4uvCBXZKjv@aspire.rjw.lan>
References: <5c514d244ce5b3f7f94d8675fcd64c58fba09417.1517210263.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:46143 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752825AbeAaJ3Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jan 2018 04:29:25 -0500
In-Reply-To: <5c514d244ce5b3f7f94d8675fcd64c58fba09417.1517210263.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: stable@vger.kernel.org, linux-pm@vger.kernel.org

On Monday, January 29, 2018 8:21:23 AM CET Viresh Kumar wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> [ Upstream commit 56026645e2b6f11ede34a5e6ab69d3eb56f9c8fc ]
> 
> After commit aa7519af450d (cpufreq: Use transition_delay_us for legacy
> governors as well) the sampling_rate field of struct dbs_data may be
> less than the tick period which causes dbs_update() to produce
> incorrect results, so make the code ensure that the value of that
> field will always be sufficiently large.
> 
> Cc: 4.14 <stable@vger.kernel.org> # 4.14
> Fixes: aa7519af450d (cpufreq: Use transition_delay_us for legacy governors as well)
> Reported-by: Andy Tang <andy.tang@nxp.com>
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Tested-by: Andy Tang <andy.tang@nxp.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 58d4f4e1ad6a..ca38229b045a 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -22,6 +22,8 @@
>  
>  #include "cpufreq_governor.h"
>  
> +#define CPUFREQ_DBS_MIN_SAMPLING_INTERVAL	(2 * TICK_NSEC / NSEC_PER_USEC)
> +
>  static DEFINE_PER_CPU(struct cpu_dbs_info, cpu_dbs);
>  
>  static DEFINE_MUTEX(gov_dbs_data_mutex);
> @@ -47,11 +49,15 @@ ssize_t store_sampling_rate(struct gov_attr_set *attr_set, const char *buf,
>  {
>  	struct dbs_data *dbs_data = to_dbs_data(attr_set);
>  	struct policy_dbs_info *policy_dbs;
> +	unsigned int sampling_interval;
>  	int ret;
> -	ret = sscanf(buf, "%u", &dbs_data->sampling_rate);
> -	if (ret != 1)
> +
> +	ret = sscanf(buf, "%u", &sampling_interval);
> +	if (ret != 1 || sampling_interval < CPUFREQ_DBS_MIN_SAMPLING_INTERVAL)
>  		return -EINVAL;
>  
> +	dbs_data->sampling_rate = sampling_interval;
> +
>  	/*
>  	 * We are operating under dbs_data->mutex and so the list and its
>  	 * entries can't be freed concurrently.
> @@ -430,7 +436,14 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto free_policy_dbs_info;
>  
> -	dbs_data->sampling_rate = cpufreq_policy_transition_delay_us(policy);
> +	/*
> +	 * The sampling interval should not be less than the transition latency
> +	 * of the CPU and it also cannot be too small for dbs_update() to work
> +	 * correctly.
> +	 */
> +	dbs_data->sampling_rate = max_t(unsigned int,
> +					CPUFREQ_DBS_MIN_SAMPLING_INTERVAL,
> +					cpufreq_policy_transition_delay_us(policy));
>  
>  	if (!have_governor_per_policy())
>  		gov->gdbs_data = dbs_data;
> 

Right, thanks for pushing this to -stable!
