From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V3 5/5] cpufreq: postfix policy directory with the first
 CPU in related_cpus
Date: Fri, 16 Oct 2015 12:50:42 -0700
Message-ID: <56215512.1080401@codeaurora.org>
References: <20151016070842.GY19018@linux> <44a5b86d1df41812461630e5a7c5366d276e2855.1444979341.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50758 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbbJPTup (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2015 15:50:45 -0400
In-Reply-To: <44a5b86d1df41812461630e5a7c5366d276e2855.1444979341.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 10/16/2015 12:11 AM, Viresh Kumar wrote:
> The sysfs policy directory is postfixed currently with the CPU number
> for which the policy was created, which isn't necessarily the first CPU
> in related_cpus mask.
>
> To make it more consistent and predictable, lets postfix the policy with
> the first cpu in related-cpus mask.
>
> Suggested-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2->V3:
> - Fix error path where we may try to put an uninitialized kobject.
> - Break kobject_init_and_add() to kobject_init() and kobject_add().
>
>   drivers/cpufreq/cpufreq.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4fa2215cc6ec..7c48e7316d91 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1022,7 +1022,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>   {
>   	struct device *dev = get_cpu_device(cpu);
>   	struct cpufreq_policy *policy;
> -	int ret;
>
>   	if (WARN_ON(!dev))
>   		return NULL;
> @@ -1040,13 +1039,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>   	if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))
>   		goto err_free_rcpumask;
>
> -	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
> -				   cpufreq_global_kobject, "policy%u", cpu);
> -	if (ret) {
> -		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
> -		goto err_free_real_cpus;
> -	}
> -
> +	kobject_init(&policy->kobj, &ktype_cpufreq);

Oh yeah, this works better. I forgot kobject has a separate init and add 
fuctions.

>   	INIT_LIST_HEAD(&policy->policy_list);
>   	init_rwsem(&policy->rwsem);
>   	spin_lock_init(&policy->transition_lock);
> @@ -1057,8 +1050,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>   	policy->cpu = cpu;
>   	return policy;
>
> -err_free_real_cpus:
> -	free_cpumask_var(policy->real_cpus);
>   err_free_rcpumask:
>   	free_cpumask_var(policy->related_cpus);
>   err_free_cpumask:
> @@ -1163,6 +1154,16 @@ static int cpufreq_online(unsigned int cpu)
>   		cpumask_copy(policy->related_cpus, policy->cpus);
>   		/* Remember CPUs present at the policy creation time. */
>   		cpumask_and(policy->real_cpus, policy->cpus, cpu_present_mask);
> +
> +		/* Name and add the kobject */
> +		ret = kobject_add(&policy->kobj, cpufreq_global_kobject,
> +				  "policy%u",
> +				  cpumask_first(policy->related_cpus));
> +		if (ret) {
> +			pr_err("%s: failed to add policy->kobj: %d\n", __func__,
> +			       ret);
> +			goto out_exit_policy;
> +		}

Another out of patch issue that I see while reviewing this patch:

I think the existing error handling gotos aren't really cleaning things 
up well.

In the lines that follow this code we set the per_cpu(cpufreq_cpu_data) 
to point to the new policy. But if the subsequent cpu->get() fails, we 
goto out_exit_policy. But that label doesn't clean up the 
per_cpu(cpufreq_cpu_data). So, I think we need another label to jump to 
if ->get() fails

>   	}
>
>   	/*
>

Reviewed-by: Saravana Kannan <skannan@codeaurora.org>

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
