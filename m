From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Avoid a couple of races related to
 cpufreq_cpu_get()
Date: Tue, 15 Nov 2016 09:39:52 +0530
Message-ID: <20161115040952.GH4178@vireshk-i7>
References: <6245332.6H0YK9yF0m@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33259 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965837AbcKOEJ4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Nov 2016 23:09:56 -0500
Received: by mail-pg0-f50.google.com with SMTP id 3so61857423pgd.0
        for <linux-pm@vger.kernel.org>; Mon, 14 Nov 2016 20:09:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <6245332.6H0YK9yF0m@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 14-11-16, 22:51, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The cpumask_test_cpu() check in cpufreq_cpu_get_raw() is sort of
> pointless, because it may be racy with respect to CPU online/offline
> which sets/clears the policy->cpus mask.
> 
> For this reason, it is better to reserve cpufreq_cpu_get_raw() for
> the ondemand governor, which calls it for online CPUs only with CPU
> online/offline locked anyway, and move the cpumask_test_cpu() up the
> call chain.
> 
> Moreover, the callers of cpufreq_cpu_get() that really care about
> avoiding races with CPU online/offline should better carry out that
> check under policy->rwsem.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   46 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 15 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -65,6 +65,12 @@ static struct cpufreq_driver *cpufreq_dr
>  static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
>  static DEFINE_RWLOCK(cpufreq_driver_lock);
>  
> +struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
> +{
> +	return per_cpu(cpufreq_cpu_data, cpu);
> +}
> +EXPORT_SYMBOL_GPL(cpufreq_cpu_get_raw);
> +

It may be better to move this to cpufreq.h and make it inline instead
as this is really light weight now.

>  /* Flag to suspend/resume CPUFreq governors */
>  static bool cpufreq_suspended;
>  
> @@ -192,19 +198,12 @@ int cpufreq_generic_init(struct cpufreq_
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_generic_init);
>  
> -struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
> -{
> -	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
> -
> -	return policy && cpumask_test_cpu(cpu, policy->cpus) ? policy : NULL;
> -}
> -EXPORT_SYMBOL_GPL(cpufreq_cpu_get_raw);
> -
>  unsigned int cpufreq_generic_get(unsigned int cpu)
>  {
> -	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
> +	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
>  
> -	if (!policy || IS_ERR(policy->clk)) {
> +	if (!policy || !cpumask_test_cpu(cpu, policy->cpus) ||

The race you described in commit log is still valid at this point,
isn't it ?

> +	    IS_ERR(policy->clk)) {
>  		pr_err("%s: No %s associated to cpu: %d\n",
>  		       __func__, policy ? "clk" : "policy", cpu);
>  		return 0;
> @@ -240,7 +239,7 @@ struct cpufreq_policy *cpufreq_cpu_get(u
>  
>  	if (cpufreq_driver) {
>  		/* get the CPU */
> -		policy = cpufreq_cpu_get_raw(cpu);
> +		policy = per_cpu(cpufreq_cpu_data, cpu);

This changes the expectations of the users of cpufreq_cpu_get() as
this will return policy for non policy->cpus as well now. I am sure
this will break some of the assumptions at the callers and we need to
visit all the sites to make sure it is fine.

>  		if (policy)
>  			kobject_get(&policy->kobj);
>  	}
> @@ -1328,7 +1327,7 @@ static int cpufreq_offline(unsigned int
>  
>  	pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
>  
> -	policy = cpufreq_cpu_get_raw(cpu);
> +	policy = per_cpu(cpufreq_cpu_data, cpu);

I think we can keep cpufreq_cpu_get_raw() here instead, as that will
do exactly this. Also we need the policy->cpus test here.

>  	if (!policy) {
>  		pr_debug("%s: No cpu_data found\n", __func__);
>  		return 0;
> @@ -1455,7 +1454,9 @@ unsigned int cpufreq_quick_get(unsigned
>  
>  	policy = cpufreq_cpu_get(cpu);
>  	if (policy) {
> -		ret_freq = policy->cur;
> +		if (cpumask_test_cpu(cpu, policy->cpus))

We can still have the race here, isn't it ?

> +			ret_freq = policy->cur;
> +
>  		cpufreq_cpu_put(policy);
>  	}
>  
> @@ -1475,7 +1476,9 @@ unsigned int cpufreq_quick_get_max(unsig
>  	unsigned int ret_freq = 0;
>  
>  	if (policy) {
> -		ret_freq = policy->max;
> +		if (cpumask_test_cpu(cpu, policy->cpus))

Same here..

> +			ret_freq = policy->max;
> +
>  		cpufreq_cpu_put(policy);
>  	}
>  
> @@ -1526,7 +1529,10 @@ unsigned int cpufreq_get(unsigned int cp
>  
>  	if (policy) {
>  		down_read(&policy->rwsem);
> -		ret_freq = __cpufreq_get(policy);
> +
> +		if (cpumask_test_cpu(cpu, policy->cpus))
> +			ret_freq = __cpufreq_get(policy);
> +

We don't have the race here ..

>  		up_read(&policy->rwsem);
>  
>  		cpufreq_cpu_put(policy);
> @@ -2142,6 +2148,11 @@ int cpufreq_get_policy(struct cpufreq_po
>  	if (!cpu_policy)
>  		return -EINVAL;
>  
> +	if (!cpumask_test_cpu(cpu, policy->cpus)) {

This is still racy..

> +		cpufreq_cpu_put(cpu_policy);
> +		return -EINVAL;
> +	}
> +
>  	memcpy(policy, cpu_policy, sizeof(*policy));
>  
>  	cpufreq_cpu_put(cpu_policy);
> @@ -2265,6 +2276,11 @@ int cpufreq_update_policy(unsigned int c
>  
>  	down_write(&policy->rwsem);
>  
> +	if (!cpumask_test_cpu(cpu, policy->cpus)) {

This is not racy.

> +		ret = -ENODEV;
> +		goto unlock;
> +	}
> +
>  	pr_debug("updating policy for CPU %u\n", cpu);
>  	memcpy(&new_policy, policy, sizeof(*policy));
>  	new_policy.min = policy->user_policy.min;

-- 
viresh
