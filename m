From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq, intel_pstate.c, Fix rounding errors
Date: Thu, 19 Nov 2015 10:16:39 +0530
Message-ID: <20151119044639.GD3737@ubuntu>
References: <1447862144-7188-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35253 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932541AbbKSEqo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 23:46:44 -0500
Received: by pacej9 with SMTP id ej9so67853972pac.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2015 20:46:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1447862144-7188-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Len Brown <len.brown@intel.com>, Alexandra Yates <alexandra.yates@intel.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 18-11-15, 10:55, Prarit Bhargava wrote:
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 2e31d09..686f024 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1233,6 +1233,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  	struct cpudata *cpu;
>  	int i;
>  #endif
> +	int max_policy_calc;
> +
>  	pr_debug("intel_pstate: %s max %u policy->max %u\n", __func__,
>  		 policy->cpuinfo.max_freq, policy->max);
>  	if (!policy->cpuinfo.max_freq)
> @@ -1249,7 +1251,10 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  	limits = &powersave_limits;
>  	limits->min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
>  	limits->min_policy_pct = clamp_t(int, limits->min_policy_pct, 0 , 100);
> -	limits->max_policy_pct = (policy->max * 100) / policy->cpuinfo.max_freq;
> +
> +	max_policy_calc = (policy->max * 1000) / policy->cpuinfo.max_freq;
> +	limits->max_policy_pct = DIV_ROUND_UP(max_policy_calc, 10);
> +

Nice catch, but why can't we do this instead:

	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100, policy->cpuinfo.max_freq);

>  	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0 , 100);
>  
>  	/* Normalize user input to [min_policy_pct, max_policy_pct] */
> @@ -1269,6 +1274,7 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  				  int_tofp(100));
>  	limits->max_perf = div_fp(int_tofp(limits->max_perf_pct),
>  				  int_tofp(100));
> +	limits->max_perf = round_up(limits->max_perf, 8);

Perhaps you should fix this in a separate patch.

-- 
viresh
