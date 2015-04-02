From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 10/20] cpufreq: Don't traverse list of all policies
 for adding policy for a cpu
Date: Wed, 01 Apr 2015 21:24:28 -0700
Message-ID: <551CC47C.4030504@codeaurora.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org> <3311b25e3e3f698ad654215d7bf9a1c3613b7d78.1424345053.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58791 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbbDBEYa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 00:24:30 -0400
In-Reply-To: <3311b25e3e3f698ad654215d7bf9a1c3613b7d78.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 02/19/2015 03:32 AM, Viresh Kumar wrote:
> We reach here while adding policy for a CPU and enter into the 'if' block only
> if a policy already exists for the CPU in question. As cpufreq_cpu_data is
> filled once and for all now, we can reuse it to find the relevant policy instead
> of traversing the list of all policies.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index f849b2a33d3e..20d5f4590c4b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1211,7 +1211,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>   {
>   	unsigned int j, cpu = dev->id;
>   	int ret = -ENOMEM;
> -	struct cpufreq_policy *policy, *tpolicy;
> +	struct cpufreq_policy *policy;
>   	unsigned long flags;
>   	bool recover_policy = cpufreq_suspended;
>
> @@ -1224,16 +1224,13 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>   		return 0;
>
>   	/* Check if this cpu already has a policy to manage it */
> -	read_lock_irqsave(&cpufreq_driver_lock, flags);
> -	for_each_active_policy(policy, tpolicy) {
> -		if (cpumask_test_cpu(cpu, policy->related_cpus)) {
> -			read_unlock_irqrestore(&cpufreq_driver_lock, flags);
> -			ret = cpufreq_add_policy_cpu(policy, cpu, dev);
> -			up_read(&cpufreq_rwsem);
> -			return ret;
> -		}
> +	policy = per_cpu(cpufreq_cpu_data, cpu);
> +	if (policy && !policy_is_inactive(policy)) {
> +		WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus));
> +		ret = cpufreq_add_policy_cpu(policy, cpu, dev);
> +		up_read(&cpufreq_rwsem);
> +		return ret;
>   	}
> -	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
>
>   	/*
>   	 * Restore the saved policy when doing light-weight init and fall back
>

Acked-by: Saravana Kannan <skannan@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
