From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: powernv: Adding fast_switch for schedutil
Date: Fri, 4 Nov 2016 12:03:22 +0530
Message-ID: <20161104063322.GA3414@vireshk-i7>
References: <1478237255-4258-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36106 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933798AbcKDGdc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Nov 2016 02:33:32 -0400
Received: by mail-pf0-f169.google.com with SMTP id 189so46091754pfz.3
        for <linux-pm@vger.kernel.org>; Thu, 03 Nov 2016 23:33:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1478237255-4258-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 04-11-16, 10:57, Akshay Adiga wrote:
> Adding fast_switch which does light weight operation to
> set the desired pstate.
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index d3ffde8..09a0496 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -752,9 +752,12 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	spin_lock_init(&gpstates->gpstate_lock);
>  	ret = cpufreq_table_validate_and_show(policy, powernv_freqs);
>  
> -	if (ret < 0)
> +	if (ret < 0) {
>  		kfree(policy->driver_data);
> +		return ret;
> +	}
>  
> +	policy->fast_switch_possible = true;
>  	return ret;
>  }
>  
> @@ -897,6 +900,22 @@ static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
>  	del_timer_sync(&gpstates->timer);
>  }
>  
> +static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,
> +					unsigned int target_freq)
> +{
> +	int index;
> +	struct powernv_smp_call_data freq_data;
> +
> +	index = cpufreq_table_find_index_dl(policy, target_freq);
> +	if (index < 0 || index >= powernv_pstate_info.nr_pstates)
> +		return CPUFREQ_ENTRY_INVALID;

I don't think such a check is required at all. It wouldn't happen without a BUG
in kernel.

> +	freq_data.pstate_id = powernv_freqs[index].driver_data;
> +	freq_data.gpstate_id = powernv_freqs[index].driver_data;
> +	set_pstate(&freq_data);
> +
> +	return powernv_freqs[index].frequency;
> +}
> +
>  static struct cpufreq_driver powernv_cpufreq_driver = {
>  	.name		= "powernv-cpufreq",
>  	.flags		= CPUFREQ_CONST_LOOPS,
> @@ -904,6 +923,7 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
>  	.exit		= powernv_cpufreq_cpu_exit,
>  	.verify		= cpufreq_generic_frequency_table_verify,
>  	.target_index	= powernv_cpufreq_target_index,
> +	.fast_switch	= powernv_fast_switch,
>  	.get		= powernv_cpufreq_get,
>  	.stop_cpu	= powernv_cpufreq_stop_cpu,
>  	.attr		= powernv_cpu_freq_attr,
> -- 
> 2.7.4

-- 
viresh
