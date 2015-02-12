From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 05/18] cpufreq: Manage governor usage history with 'policy->last_governor'
Date: Wed, 11 Feb 2015 19:03:34 -0800
Message-ID: <54DC1806.9040001@codeaurora.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org> <bc7154266269beb8c6b9b3d56b529b64db33d2e2.1422346933.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59741 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbbBLDDg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Feb 2015 22:03:36 -0500
In-Reply-To: <bc7154266269beb8c6b9b3d56b529b64db33d2e2.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 01/27/2015 12:36 AM, Viresh Kumar wrote:
> History of which governor was used last is common to all CPUs within a policy
> and maintaining it per-cpu isn't the best approach for sure.
>
> Apart from wasting memory, this also increases the complexity of managing this
> data structure as it has to be updated for all CPUs.
>
> To make that somewhat simpler, lets store this information in a new field
> 'last_governor' in struct cpufreq_policy and update it on removal of last cpu of
> a policy.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 24 ++++++++++++------------
>   include/linux/cpufreq.h   |  1 +
>   2 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index f253cf45f910..4ad1e46891b5 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -57,9 +57,6 @@ static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
>   static DEFINE_RWLOCK(cpufreq_driver_lock);
>   DEFINE_MUTEX(cpufreq_governor_lock);
>
> -/* This one keeps track of the previously set governor of a removed CPU */
> -static DEFINE_PER_CPU(char[CPUFREQ_NAME_LEN], cpufreq_cpu_governor);
> -
>   /* Flag to suspend/resume CPUFreq governors */
>   static bool cpufreq_suspended;
>
> @@ -941,7 +938,7 @@ static void cpufreq_init_policy(struct cpufreq_policy *policy)
>   	memcpy(&new_policy, policy, sizeof(*policy));
>
>   	/* Update governor of new_policy to the governor used before hotplug */
> -	gov = find_governor(per_cpu(cpufreq_cpu_governor, policy->cpu));
> +	gov = find_governor(policy->last_governor);

Just change this to:

gov = policy->governor;

No need to search for the governor again. It should already be valid for 
policy that's being restored. For new policies, it would be NULL and 
would get defaulted correctly.

>   	if (gov)
>   		pr_debug("Restoring governor %s for cpu %d\n",
>   				policy->governor->name, policy->cpu);
> @@ -1366,8 +1363,9 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
>   			return ret;
>   		}
>
> -		strncpy(per_cpu(cpufreq_cpu_governor, cpu),
> -			policy->governor->name, CPUFREQ_NAME_LEN);
> +		if (cpus == 1)
> +			strncpy(policy->last_governor, policy->governor->name,
> +				CPUFREQ_NAME_LEN);
>   	}
>
>   	if (cpu != policy->cpu) {
> @@ -2096,7 +2094,8 @@ EXPORT_SYMBOL_GPL(cpufreq_register_governor);
>
>   void cpufreq_unregister_governor(struct cpufreq_governor *governor)
>   {
> -	int cpu;
> +	struct cpufreq_policy *policy;
> +	unsigned long flags;
>
>   	if (!governor)
>   		return;
> @@ -2104,12 +2103,13 @@ void cpufreq_unregister_governor(struct cpufreq_governor *governor)
>   	if (cpufreq_disabled())
>   		return;
>
> -	for_each_present_cpu(cpu) {
> -		if (cpu_online(cpu))
> -			continue;
> -		if (!strcmp(per_cpu(cpufreq_cpu_governor, cpu), governor->name))
> -			strcpy(per_cpu(cpufreq_cpu_governor, cpu), "\0");
> +	/* clear last_governor for all fallback policies */
> +	read_lock_irqsave(&cpufreq_driver_lock, flags);
> +	for_each_fallback_policy(policy) {
> +		if (!strcmp(policy->last_governor, governor->name))
> +			strcpy(policy->last_governor, "\0");
>   	}
> +	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
>
>   	mutex_lock(&cpufreq_governor_mutex);
>   	list_del(&governor->governor_list);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index df6af4cfa26a..e326cddef6db 100644
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

Kinda Nack for a couple of reasons:

1. For logical hotplugs, we don't really throw away the policy, so the 
governor pointer should already be the last governor. We can just use 
the pointer.

2. For physical hotplug of CPUs, the policies are getting freed (I 
assume and hope so). So, the "last_governor" field is going to be empty.

3. Even if we continue storing the last_governor outside of the policy, 
for physical hotplug of CPUs where the policy is getting recreated, I'm 
not sure restoring the governor is the right thing to do anyway. I'll 
explain various possible configurations below for the physical hotplug case:

a. Single policy for all CPUs: The policy never gets removed since 
there'll be at least one CPU present. So the save/restore code is never 
used.

b. Multi-cluster/policy system with per-policy tunables enabled: 
Restoring the governor is bad/incomplete since the per-policy tunables 
are lost when the governor gets POLICY_EXIT when the policy is 
destroyed. IMO, in these cases, it's better to use the default governor 
since we know that using it at cpufreq init with the default tunables 
for it is a safe/nice configuration.

c. Multi-cluster/policy system with global tunables: Restoring the 
governor works for this case, but I think it's still better to use the 
default governor to be consistent with (b) and IMO it makes more sense 
since the CPU is getting physically added for the first time.

So, long story short, I think this patch should be changed to:
1. Use policy->governor instead of find_governor(last_governor)
2. Use default governor if policy->governor is NULL
3. Completely delete all references to last_governor.

Thanks,
Saravana


-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
