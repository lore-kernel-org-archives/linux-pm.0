From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: cpu_cooling: fix improper order during
 initialization
Date: Wed, 1 Jun 2016 09:36:55 +0100
Message-ID: <20160601083655.GC2898@e104805>
References: <1464690722-27996-1-git-send-email-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35752 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757945AbcFAIg7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 1 Jun 2016 04:36:59 -0400
Content-Disposition: inline
In-Reply-To: <1464690722-27996-1-git-send-email-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, rui.zhang@intel.com, edubezval@gmail.com

On Tue, May 31, 2016 at 11:32:02AM +0100, Lukasz Luba wrote:
> The freq_table array is not populated before calling
> thermal_of_cooling_register. The code which populates the freq table was
> introduced in commit f6859014.
> This should be done before registering new thermal cooling device.
> The log shows effects of this wrong decision.
> [    2.172614] cpu cpu1: Failed to get voltage for frequency 1984518656000: -34
> [    2.220863] cpu cpu0: Failed to get voltage for frequency 1984524416000: -34
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

Yes, the cooling device should only be registered after all its fields
have been populated.

Acked-by: Javi Merino <javi.merino@arm.com>

> ---
>  drivers/thermal/cpu_cooling.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 6ceac4f..5b4b47e 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -857,14 +857,6 @@ __cpufreq_cooling_register(struct device_node *np,
>  		goto free_power_table;
>  	}
>  
> -	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
> -		 cpufreq_dev->id);
> -
> -	cool_dev = thermal_of_cooling_device_register(np, dev_name, cpufreq_dev,
> -						      &cpufreq_cooling_ops);
> -	if (IS_ERR(cool_dev))
> -		goto remove_idr;
> -
>  	/* Fill freq-table in descending order of frequencies */
>  	for (i = 0, freq = -1; i <= cpufreq_dev->max_level; i++) {
>  		freq = find_next_max(table, freq);
> @@ -877,6 +869,14 @@ __cpufreq_cooling_register(struct device_node *np,
>  			pr_debug("%s: freq:%u KHz\n", __func__, freq);
>  	}
>  
> +	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
> +		 cpufreq_dev->id);
> +
> +	cool_dev = thermal_of_cooling_device_register(np, dev_name, cpufreq_dev,
> +						      &cpufreq_cooling_ops);
> +	if (IS_ERR(cool_dev))
> +		goto remove_idr;
> +
>  	cpufreq_dev->clipped_freq = cpufreq_dev->freq_table[0];
>  	cpufreq_dev->cool_dev = cool_dev;
>  
> -- 
> 1.9.1
> 
