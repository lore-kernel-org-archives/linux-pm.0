From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 11/20] cpufreq: Manage governor usage history with
 'policy->last_governor'
Date: Wed, 01 Apr 2015 21:34:11 -0700
Message-ID: <551CC6C3.2000102@codeaurora.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org> <073c66088540954706ba5ffc0e4c2efa4759d197.1424345053.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58930 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbbDBEeN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 00:34:13 -0400
In-Reply-To: <073c66088540954706ba5ffc0e4c2efa4759d197.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 02/19/2015 03:32 AM, Viresh Kumar wrote:
> History of which governor was used last is common to all CPUs within a policy
> and maintaining it per-cpu isn't the best approach for sure.
>
> Apart from wasting memory, this also increases the complexity of managing this
> data structure as it has to be updated for all CPUs.
>
> To make that somewhat simpler, lets store this information in a new field
> 'last_governor' in struct cpufreq_policy and update it on removal of last cpu of
> a policy.

This governor restore code actually has bug -- at least in 3.12 (I 
think) but probably has a bug in this kernel too. So, this patch 
actually also fixes a bug.

The bug has to do with restoring the wrong governor (as in, not the 
governor that was last picked by userspace) for a particular hot plug 
sequence.

Assume one cluster has CPUs 2, 3.
Assume default governor is performance.
CPU2 is first brought online.
Governor is changed to ondemand.
CPU2 is taken offline.
CPU3 is brought online.
Governor gets set to performance.
So, governor for the cluster is now not what was last picked by userspace.

>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 30 +++++++++++++++---------------
>   include/linux/cpufreq.h   |  1 +
>   2 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 20d5f4590c4b..b7cd1bf97044 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -115,9 +115,6 @@ static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
>   static DEFINE_RWLOCK(cpufreq_driver_lock);
>   DEFINE_MUTEX(cpufreq_governor_lock);
>
> -/* This one keeps track of the previously set governor of a removed CPU */
> -static DEFINE_PER_CPU(char[CPUFREQ_NAME_LEN], cpufreq_cpu_governor);
> -
>   /* Flag to suspend/resume CPUFreq governors */
>   static bool cpufreq_suspended;
>
> @@ -1028,7 +1025,7 @@ static void cpufreq_init_policy(struct cpufreq_policy *policy)
>   	memcpy(&new_policy, policy, sizeof(*policy));
>
>   	/* Update governor of new_policy to the governor used before hotplug */
> -	gov = find_governor(per_cpu(cpufreq_cpu_governor, policy->cpu));
> +	gov = find_governor(policy->last_governor);
>   	if (gov)
>   		pr_debug("Restoring governor %s for cpu %d\n",
>   				policy->governor->name, policy->cpu);
> @@ -1422,14 +1419,15 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
>   			pr_err("%s: Failed to stop governor\n", __func__);
>   			return ret;
>   		}
> -
> -		strncpy(per_cpu(cpufreq_cpu_governor, cpu),
> -			policy->governor->name, CPUFREQ_NAME_LEN);
>   	}
>
> -	down_read(&policy->rwsem);
> +	down_write(&policy->rwsem);
>   	cpus = cpumask_weight(policy->cpus);
> -	up_read(&policy->rwsem);
> +
> +	if (has_target() && cpus == 1)
> +		strncpy(policy->last_governor, policy->governor->name,
> +			CPUFREQ_NAME_LEN);
> +	up_write(&policy->rwsem);
>
>   	if (cpu != policy->cpu) {
>   		sysfs_remove_link(&dev->kobj, "cpufreq");
> @@ -2142,7 +2140,8 @@ EXPORT_SYMBOL_GPL(cpufreq_register_governor);
>
>   void cpufreq_unregister_governor(struct cpufreq_governor *governor)
>   {
> -	int cpu;
> +	struct cpufreq_policy *policy, *tpolicy;
> +	unsigned long flags;
>
>   	if (!governor)
>   		return;
> @@ -2150,12 +2149,13 @@ void cpufreq_unregister_governor(struct cpufreq_governor *governor)
>   	if (cpufreq_disabled())
>   		return;
>
> -	for_each_present_cpu(cpu) {
> -		if (cpu_online(cpu))
> -			continue;
> -		if (!strcmp(per_cpu(cpufreq_cpu_governor, cpu), governor->name))
> -			strcpy(per_cpu(cpufreq_cpu_governor, cpu), "\0");
> +	/* clear last_governor for all inactive policies */
> +	read_lock_irqsave(&cpufreq_driver_lock, flags);

You are writing to a variable that's protected. This should be a write lock.

> +	for_each_inactive_policy(policy, tpolicy) {
> +		if (!strcmp(policy->last_governor, governor->name))
> +			strcpy(policy->last_governor, "\0");
>   	}
> +	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
>
>   	mutex_lock(&cpufreq_governor_mutex);
>   	list_del(&governor->governor_list);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 2ee4888c1f47..48e37c07eb84 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -80,6 +80,7 @@ struct cpufreq_policy {
>   	struct cpufreq_governor	*governor; /* see below */
>   	void			*governor_data;
>   	bool			governor_enabled; /* governor start/stop flag */
> +	char			last_governor[CPUFREQ_NAME_LEN]; /* last governor used */
>
>   	struct work_struct	update; /* if update_policy() needs to be
>   					 * called, but you're in IRQ context */
>

Nack due to lock.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
