From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 04/18] cpufreq: Manage fallback policies in a list
Date: Tue, 03 Feb 2015 01:41:45 +0100
Message-ID: <4877089.HgQ3LJW3cC@vostro.rjw.lan>
References: <cover.1422346933.git.viresh.kumar@linaro.org> <43d728016b775d1b0fc02c981eb0520ac08297f5.1422346933.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65104 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965178AbbBCASv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Feb 2015 19:18:51 -0500
In-Reply-To: <43d728016b775d1b0fc02c981eb0520ac08297f5.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org

On Tuesday, January 27, 2015 02:06:10 PM Viresh Kumar wrote:
> Policies manage a group of CPUs and tracking them on per-cpu basis isn't the
> best approach for sure.
> 
> The obvious loss is the amount of memory consumed for keeping a per-cpu copy of
> the same pointer. But the bigger problem is managing such a data structure as we
> need to update it for all policy->cpus.
> 
> To make it simple, lets manage fallback CPUs in a list rather than a per-cpu
> variable.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 51 +++++++++++++++++++++++++++--------------------
>  include/linux/cpufreq.h   |  5 ++++-
>  2 files changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index cf8ce523074f..f253cf45f910 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -37,6 +37,11 @@ static LIST_HEAD(cpufreq_policy_list);
>  #define for_each_policy(__policy)				\
>  	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
>  
> +/* Iterate over offline CPUs policies */
> +static LIST_HEAD(cpufreq_fallback_list);
> +#define for_each_fallback_policy(__policy)			\
> +	list_for_each_entry(__policy, &cpufreq_fallback_list, fallback_list)
> +
>  /* Iterate over governors */
>  static LIST_HEAD(cpufreq_governor_list);
>  #define for_each_governor(__governor)				\
> @@ -49,7 +54,6 @@ static LIST_HEAD(cpufreq_governor_list);
>   */
>  static struct cpufreq_driver *cpufreq_driver;
>  static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
> -static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data_fallback);
>  static DEFINE_RWLOCK(cpufreq_driver_lock);
>  DEFINE_MUTEX(cpufreq_governor_lock);
>  
> @@ -999,13 +1003,16 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
>  
>  static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
>  {
> -	struct cpufreq_policy *policy;
> +	struct cpufreq_policy *policy = NULL, *temp;
>  	unsigned long flags;
>  
>  	read_lock_irqsave(&cpufreq_driver_lock, flags);
> -
> -	policy = per_cpu(cpufreq_cpu_data_fallback, cpu);
> -
> +	for_each_fallback_policy(temp) {
> +		if (cpumask_test_cpu(cpu, temp->related_cpus)) {
> +			policy = temp;
> +			break;
> +		}

This becomes quite inefficient on a system with many CPUs having different
policies.  My approach would be to somehow attach the fallback policy information
to the CPU device object.

> +	}
>  	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
>  
>  	if (policy)
> @@ -1029,6 +1036,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(void)
>  		goto err_free_cpumask;
>  
>  	INIT_LIST_HEAD(&policy->policy_list);
> +	INIT_LIST_HEAD(&policy->fallback_list);
>  	init_rwsem(&policy->rwsem);
>  	spin_lock_init(&policy->transition_lock);
>  	init_waitqueue_head(&policy->transition_wait);
> @@ -1142,6 +1150,11 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>  		policy = cpufreq_policy_alloc();
>  		if (!policy)
>  			goto nomem_out;
> +	} else {
> +		/* Don't need fallback list anymore */
> +		write_lock_irqsave(&cpufreq_driver_lock, flags);
> +		list_del(&policy->fallback_list);
> +		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>  	}
>  
>  	/*
> @@ -1296,11 +1309,8 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>  	if (cpufreq_driver->exit)
>  		cpufreq_driver->exit(policy);
>  err_set_policy_cpu:
> -	if (recover_policy) {
> -		/* Do not leave stale fallback data behind. */
> -		per_cpu(cpufreq_cpu_data_fallback, cpu) = NULL;
> +	if (recover_policy)
>  		cpufreq_policy_put_kobj(policy);
> -	}
>  	cpufreq_policy_free(policy);
>  
>  nomem_out:
> @@ -1333,21 +1343,22 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
>  
>  	pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
>  
> -	write_lock_irqsave(&cpufreq_driver_lock, flags);
> -
>  	policy = per_cpu(cpufreq_cpu_data, cpu);
> -
> -	/* Save the policy somewhere when doing a light-weight tear-down */
> -	if (cpufreq_suspended)
> -		per_cpu(cpufreq_cpu_data_fallback, cpu) = policy;
> -
> -	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> -
>  	if (!policy) {
>  		pr_debug("%s: No cpu_data found\n", __func__);
>  		return -EINVAL;
>  	}
>  
> +	down_read(&policy->rwsem);
> +	cpus = cpumask_weight(policy->cpus);
> +	up_read(&policy->rwsem);
> +
> +	/* Save the policy when doing a light-weight tear-down of last cpu */
> +	write_lock_irqsave(&cpufreq_driver_lock, flags);
> +	if (cpufreq_suspended && cpus == 1)
> +		list_add(&policy->fallback_list, &cpufreq_fallback_list);
> +	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> +
>  	if (has_target()) {
>  		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
>  		if (ret) {
> @@ -1359,10 +1370,6 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
>  			policy->governor->name, CPUFREQ_NAME_LEN);
>  	}
>  
> -	down_read(&policy->rwsem);
> -	cpus = cpumask_weight(policy->cpus);
> -	up_read(&policy->rwsem);
> -
>  	if (cpu != policy->cpu) {
>  		sysfs_remove_link(&dev->kobj, "cpufreq");
>  	} else if (cpus > 1) {
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 2ee4888c1f47..df6af4cfa26a 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -87,7 +87,10 @@ struct cpufreq_policy {
>  	struct cpufreq_real_policy	user_policy;
>  	struct cpufreq_frequency_table	*freq_table;
>  
> -	struct list_head        policy_list;
> +	/* Internal lists */
> +	struct list_head        policy_list;	/* policies of online CPUs */
> +	struct list_head	fallback_list;	/* policies of offline CPUs */
> +
>  	struct kobject		kobj;
>  	struct completion	kobj_unregister;
>  
> 

