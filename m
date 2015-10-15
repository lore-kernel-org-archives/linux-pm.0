From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 5/5] cpufreq: postfix policy directory with the first
 CPU in related_cpus
Date: Thu, 15 Oct 2015 12:14:56 -0700
Message-ID: <561FFB30.8030406@codeaurora.org>
References: <cover.1444924623.git.viresh.kumar@linaro.org> <f64c9a0941f179d55ab95f4b9a038df0acbfefa3.1444924623.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48410 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbbJOTO6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 15:14:58 -0400
In-Reply-To: <f64c9a0941f179d55ab95f4b9a038df0acbfefa3.1444924623.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 10/15/2015 09:05 AM, Viresh Kumar wrote:
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
>   drivers/cpufreq/cpufreq.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4fa2215cc6ec..3fe13875565d 100644
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
> @@ -1040,13 +1039,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
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
>   	INIT_LIST_HEAD(&policy->policy_list);
>   	init_rwsem(&policy->rwsem);
>   	spin_lock_init(&policy->transition_lock);
> @@ -1057,7 +1049,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>   	policy->cpu = cpu;
>   	return policy;
>
> -err_free_real_cpus:
>   	free_cpumask_var(policy->real_cpus);

Delete this line too? Does GCC not complain about unreachable code?

>   err_free_rcpumask:
>   	free_cpumask_var(policy->related_cpus);
> @@ -1163,6 +1154,16 @@ static int cpufreq_online(unsigned int cpu)
>   		cpumask_copy(policy->related_cpus, policy->cpus);
>   		/* Remember CPUs present at the policy creation time. */
>   		cpumask_and(policy->real_cpus, policy->cpus, cpu_present_mask);
> +
> +		/* Initialize the kobject */
> +		ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
> +					   cpufreq_global_kobject, "policy%u",
> +					   cpumask_first(policy->related_cpus));
> +		if (ret) {
> +			pr_err("%s: failed to init policy->kobj: %d\n",
> +			       __func__, ret);
> +			goto out_exit_policy;

out_exit_policy label includes a call to cpufreq_policy_free(). That 
function needs to be changed to not call cpufreq_policy_put_kobj() in 
this case so that we don't try to kobject_put() an unallocated kobj.

Maybe you an call cpufreq_policy_put_kobj() in the error handling path 
of this function? Basically split out kojb alloc and free from policy 
alloc and free and alloc/free them around the same time 
(cpufreq_remove_Dev() will have to also call cpufreq_policy_put_kobj() 
when real_cpus is empty().

The refactor is just a suggestion. I'm looking at the latest code in a 
gitweb and making comments. So, I might have missed some corner cases in 
the refactor.

Also, it might be better to move the notifier from within 
cpufreq_policy_put_kobj() to cpufreq_policy_free()? Seems more appropriate.

Thanks,
Saravana


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
