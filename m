From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 08/20] cpufreq: Don't clear cpufreq_cpu_data and policy
 list for inactive policies
Date: Wed, 01 Apr 2015 21:14:55 -0700
Message-ID: <551CC23F.2030504@codeaurora.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org> <7bf6a7ce048290ec871c608883f9c9908adc5345.1424345053.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57937 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbbDBEO5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 00:14:57 -0400
In-Reply-To: <7bf6a7ce048290ec871c608883f9c9908adc5345.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 02/19/2015 03:32 AM, Viresh Kumar wrote:
> Now that we can check policy->cpus to find if policy is active or not, we don't
> need to clean cpufreq_cpu_data and delete policy from the list on light weight
> tear down of policies (like in suspend).
>
> To make it consistent and clean, set cpufreq_cpu_data for all related CPUs when
> the policy is first created and clean it only while it is freed.
>
> Also update cpufreq_cpu_get_raw() to check if cpu is part of policy->cpus mask,
> so that we don't end up getting policies for unmanaged CPUs.

When you say unmanaged CPUs, do you mean offline CPUs? If so, could you 
use that term instead? The term unmanaged is kinda ambiguous. This 
comment applies to the entire series.

> In order to make sure that no users of 'policy' are using an inactive policy,
> use cpufreq_cpu_get_raw() instead of directly accessing cpufreq_cpu_data.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 79 ++++++++++++++++++++---------------------------
>   1 file changed, 34 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e728c796c327..e27b2a7bd9b3 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -250,10 +250,18 @@ int cpufreq_generic_init(struct cpufreq_policy *policy,
>   }
>   EXPORT_SYMBOL_GPL(cpufreq_generic_init);
>

<SNIP>

> @@ -1053,7 +1055,6 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
>   				  unsigned int cpu, struct device *dev)
>   {
>   	int ret = 0;
> -	unsigned long flags;
>
>   	/* Is cpu already managed ? */
>   	if (cpumask_test_cpu(cpu, policy->cpus))
> @@ -1068,13 +1069,7 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
>   	}
>
>   	down_write(&policy->rwsem);
> -
> -	write_lock_irqsave(&cpufreq_driver_lock, flags);
> -
>   	cpumask_set_cpu(cpu, policy->cpus);
> -	per_cpu(cpufreq_cpu_data, cpu) = policy;
> -	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> -
>   	up_write(&policy->rwsem);
>
>   	if (has_target()) {
> @@ -1165,6 +1160,17 @@ static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
>
>   static void cpufreq_policy_free(struct cpufreq_policy *policy)
>   {
> +	unsigned long flags;
> +	int cpu;
> +
> +	/* Remove policy from list */
> +	write_lock_irqsave(&cpufreq_driver_lock, flags);
> +	list_del(&policy->policy_list);
> +
> +	for_each_cpu(cpu, policy->related_cpus)
> +		per_cpu(cpufreq_cpu_data, cpu) = NULL;
> +	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> +
>   	free_cpumask_var(policy->related_cpus);
>   	free_cpumask_var(policy->cpus);
>   	kfree(policy);
> @@ -1286,12 +1292,12 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>   			       __func__, ret);
>   			goto err_init_policy_kobj;
>   		}
> -	}
>
> -	write_lock_irqsave(&cpufreq_driver_lock, flags);
> -	for_each_cpu(j, policy->cpus)
> -		per_cpu(cpufreq_cpu_data, j) = policy;
> -	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> +		write_lock_irqsave(&cpufreq_driver_lock, flags);
> +		for_each_cpu(j, policy->related_cpus)
> +			per_cpu(cpufreq_cpu_data, j) = policy;
> +		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> +	}

Why not do this is cpufreq_policy_alloc() to be consistent/symmetric 
with cpufreq_policy_free()? You had to set cpufreq_cpu_data/add to the 
list this late in cpufreq_add_dev before because you shouldn't be adding 
a unfinished policy to the cpufreq_cpu_data/list. But now that you check 
for policy->cpus before returning it, you may be do all of this in 
cpufreq_policy_alloc()?

>   	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
>   		policy->cur = cpufreq_driver->get(policy->cpu);
> @@ -1350,11 +1356,11 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>   			goto err_out_unregister;
>   		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>   				CPUFREQ_CREATE_POLICY, policy);
> -	}
>
> -	write_lock_irqsave(&cpufreq_driver_lock, flags);
> -	list_add(&policy->policy_list, &cpufreq_policy_list);
> -	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> +		write_lock_irqsave(&cpufreq_driver_lock, flags);
> +		list_add(&policy->policy_list, &cpufreq_policy_list);
> +		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> +	}

You could probably do this as part of policy alloc too?

>
>   	cpufreq_init_policy(policy);
>
> @@ -1378,11 +1384,6 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>

Rest of the patch looks good.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
