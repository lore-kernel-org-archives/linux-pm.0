From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 09/20] cpufreq: Get rid of cpufreq_cpu_data_fallback
Date: Wed, 01 Apr 2015 21:20:55 -0700
Message-ID: <551CC3A7.4050702@codeaurora.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org> <931526f13b5213db72a6f6cc31730ee82ac9b780.1424345053.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58746 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbbDBEU6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 00:20:58 -0400
In-Reply-To: <931526f13b5213db72a6f6cc31730ee82ac9b780.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 02/19/2015 03:32 AM, Viresh Kumar wrote:
> We can extract the same information from cpufreq_cpu_data as it is also
> available for inactive policies now.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 25 ++++++-------------------
>   1 file changed, 6 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e27b2a7bd9b3..f849b2a33d3e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -112,7 +112,6 @@ static LIST_HEAD(cpufreq_governor_list);
>    */
>   static struct cpufreq_driver *cpufreq_driver;
>   static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
> -static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data_fallback);
>   static DEFINE_RWLOCK(cpufreq_driver_lock);
>   DEFINE_MUTEX(cpufreq_governor_lock);
>
> @@ -1092,13 +1091,14 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
>   	unsigned long flags;
>
>   	read_lock_irqsave(&cpufreq_driver_lock, flags);
> -
> -	policy = per_cpu(cpufreq_cpu_data_fallback, cpu);
> -
> +	policy = per_cpu(cpufreq_cpu_data, cpu);
>   	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
>
> -	if (policy)
> +	if (likely(policy)) {
> +		/* Policy should be inactive here */
> +		WARN_ON(!policy_is_inactive(policy));
>   		policy->governor = NULL;
> +	}
>
>   	return policy;
>   }
> @@ -1394,11 +1394,8 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>   	if (cpufreq_driver->exit)
>   		cpufreq_driver->exit(policy);
>   err_set_policy_cpu:
> -	if (recover_policy) {
> -		/* Do not leave stale fallback data behind. */
> -		per_cpu(cpufreq_cpu_data_fallback, cpu) = NULL;
> +	if (recover_policy)
>   		cpufreq_policy_put_kobj(policy);
> -	}
>   	cpufreq_policy_free(policy);
>
>   nomem_out:
> @@ -1412,21 +1409,11 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
>   {
>   	unsigned int cpu = dev->id, cpus;
>   	int ret;
> -	unsigned long flags;
>   	struct cpufreq_policy *policy;
>
>   	pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
>
> -	write_lock_irqsave(&cpufreq_driver_lock, flags);
> -
>   	policy = cpufreq_cpu_get_raw(cpu);
> -
> -	/* Save the policy somewhere when doing a light-weight tear-down */
> -	if (cpufreq_suspended)
> -		per_cpu(cpufreq_cpu_data_fallback, cpu) = policy;
> -
> -	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> -
>   	if (!policy) {
>   		pr_debug("%s: No cpu_data found\n", __func__);
>   		return -EINVAL;
>

Acked-by: Saravana Kannan <skannan@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
