From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 09/18] cpufreq: Mark policy->governor = NULL for fallback
 policies
Date: Wed, 11 Feb 2015 19:22:10 -0800
Message-ID: <54DC1C62.40303@codeaurora.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org> <ee81ef766064a79a5332f390d39dc3e4cca5fca5.1422346933.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60471 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719AbbBLDWQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Feb 2015 22:22:16 -0500
In-Reply-To: <ee81ef766064a79a5332f390d39dc3e4cca5fca5.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 01/27/2015 12:36 AM, Viresh Kumar wrote:
> Later commits would change the way policies are managed today. Policies wouldn't
> be freed on cpu hotplug (currently they aren't freed on suspend), and while the
> CPU is offline, the sysfs cpufreq files would still be present.
>
> Because we don't mark policy->governor as NULL, it still contains pointer of the
> last governor it used. And when we read the 'scaling_governor' file, it shows
> the old value.
>
> To prevent from this, mark policy->governor as NULL after we have issued
> CPUFREQ_GOV_POLICY_EXIT event for its governor.
>

I don't see anything wrong with scaling_governor showing the last used 
governor when the CPUs are just logically hotplug removed. In the 
physical hotplug case, the whole directory would go away and the policy 
would be freed. So, this is not a concern there.

Also, longer term (after your series goes in), I think we actually 
should NOT send POLICY_EXIT on just logical hotplug. That way, the 
governor tunables are not lost across a logical hotplug.

-Saravana

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 21c8ef6073d7..ed36c09f83cc 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1032,9 +1032,6 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
>   	}
>   	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
>
> -	if (policy)
> -		policy->governor = NULL;
> -
>   	return policy;
>   }
>
> @@ -1466,6 +1463,8 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
>
>   		if (!cpufreq_suspended)
>   			cpufreq_policy_free(policy);
> +		else
> +			policy->governor = NULL;
>   	} else if (has_target()) {
>   		ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
>   		if (!ret)
>


-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
