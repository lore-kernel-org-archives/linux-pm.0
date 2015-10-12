From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpufreq: arm_big_little: fix frequency check when bL
 switcher is active
Date: Mon, 12 Oct 2015 14:20:26 +0100
Message-ID: <561BB39A.4020400@arm.com>
References: <1443807532.2845.25.camel@linaro.org>
 <20151007173920.GG4557@linux> <1444296229.2847.9.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47241 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801AbbJLNUa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 12 Oct 2015 09:20:30 -0400
In-Reply-To: <1444296229.2847.9.camel@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Turquette <mike.turquette@linaro.org>



On 08/10/15 10:23, Jon Medhurst (Tixy) wrote:
[...]

> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> index f1e42f8..59115a4 100644
> --- a/drivers/cpufreq/arm_big_little.c
> +++ b/drivers/cpufreq/arm_big_little.c
> @@ -149,6 +149,18 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
>   			__func__, cpu, old_cluster, new_cluster, new_rate);
>
>   	ret = clk_set_rate(clk[new_cluster], new_rate * 1000);
> +	if (!ret) {
> +		/*
> +		 * FIXME: clk_set_rate has to handle the case where clk_change_rate
> +		 * can fail due to hardware or firmware issues. Until the clk core
> +		 * layer is fixed, we can check here. In most of the cases we will
> +		 * be reading only the cached value anyway. This needs to  be removed
> +		 * once clk core is fixed.
> +		 */
> +		if (clk_get_rate(clk[new_cluster]) != new_rate * 1000)
> +			ret = -EIO;
> +	}
> +
>   	if (WARN_ON(ret)) {
>   		pr_err("clk_set_rate failed: %d, new cluster: %d\n", ret,
>   				new_cluster);
> @@ -189,15 +201,6 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
>   		mutex_unlock(&cluster_lock[old_cluster]);
>   	}
>
> -	/*
> -	 * FIXME: clk_set_rate has to handle the case where clk_change_rate
> -	 * can fail due to hardware or firmware issues. Until the clk core
> -	 * layer is fixed, we can check here. In most of the cases we will
> -	 * be reading only the cached value anyway. This needs to  be removed
> -	 * once clk core is fixed.
> -	 */
> -	if (bL_cpufreq_get_rate(cpu) != new_rate)
> -		return -EIO;
>   	return 0;
>   }
>
>
>
>

The above change looks good to me but with minor nit. You can get rid of
if(!ret) check if you move the hunk after if (WARN_ON(ret))

-- 
Regards, Sudeep
