From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: create per policy rwsem instead of per cpu cpu_policy_rwsem
Date: Wed, 18 Sep 2013 12:39:40 +0530
Message-ID: <523951B4.5090601@linux.vnet.ibm.com>
References: <141ec437a203e4384459abb22e393d83136f732d.1379432906.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <141ec437a203e4384459abb22e393d83136f732d.1379432906.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/17/2013 09:20 PM, Viresh Kumar wrote:
> We have per-cpu cpu_policy_rwsem for cpufreq core, but we never use all of them.
> We always use rwsem of policy->cpu and so we can actually make this rwsem per
> policy instead.
> 
> This patch does this change. With this change other tricky situations are also
> avoided now, like which lock to take while we are changing policy->cpu, etc.
> 
> Suggested-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Can be taken for 3.13.. Tested on my thinkpad with basic suspend/resume and
> hotplug tests.
> 
> Was rebased on pm/linux-next with following additional patches:
> cpufreq: unlock correct rwsem while updating policy->cpu
> cpufreq: make return type of lock_policy_rwsem_{read|write}() as void
>

The code looks good, but the patch doesn't apply properly, because of the code
change that went in in your patch "cpufreq: Clear policy->cpus bits in
__cpufreq_remove_dev_finish()".

> @@ -1193,12 +1147,12 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
>  			policy->governor->name, CPUFREQ_NAME_LEN);
>  #endif
> 
> -	lock_policy_rwsem_write(cpu);
> +	down_write(&policy->rwsem);
>  	cpus = cpumask_weight(policy->cpus);
> 
>  	if (cpus > 1)
>  		cpumask_clear_cpu(cpu, policy->cpus);
> -	unlock_policy_rwsem_write(cpu);
> +	up_write(&policy->rwsem);
> 
>  	if (cpu != policy->cpu) {
>  		if (!frozen)
> @@ -1239,9 +1193,9 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
>  		return -EINVAL;
>  	}
> 
> -	lock_policy_rwsem_read(cpu);
> +	down_read(&policy->rwsem);
>  	cpus = cpumask_weight(policy->cpus);
> -	unlock_policy_rwsem_read(cpu);
> +	up_read(&policy->rwsem);
>

The cpumask_clear_cpu() has been moved to _dev_finish() in Rafael's linux-next
tree. Hence the trouble. So kindly rework this patch on top of that.
 
>  	/* If cpu is last user of policy, free policy */
>  	if (cpus == 1) {
[...]
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index fcabc42..03735e7 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -85,6 +85,22 @@ struct cpufreq_policy {
>  	struct list_head        policy_list;
>  	struct kobject		kobj;
>  	struct completion	kobj_unregister;
> +
> +	/*
> +	 * The rules for this semaphore:
> +	 * - Any routine that wants to read from the policy structure will
> +	 *   do a down_read on this semaphore.
> +	 * - Any routine that will write to the policy structure and/or may take away
> +	 *   the policy altogether (eg. CPU hotplug), will hold this lock in write
> +	 *   mode before doing so.
> +	 *
> +	 * Additional rules:
> +	 * - Governor routines that can be called in cpufreq hotplug path should not
> +	 *   take this sem as top level hotplug notifier handler takes this.

I think this comment is obsolete. I don't see the top-level hotplug notifier handler
(cpufreq_cpu_callback) acquiring the rwsem. Good to fix this comment while we are
at it, perhaps in a separate patch. (The comment above __cpufreq_remove_dev about
the policy-rwsem appears to be similarly out of date).

> +	 * - Lock should not be held across
> +	 *     __cpufreq_governor(data, CPUFREQ_GOV_POLICY_EXIT);
> +	 */
> +	struct rw_semaphore	rwsem;
>  };
> 
>  /* Only for ACPI */
> 

Regards,
Srivatsa S. Bhat

