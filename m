From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V7 2/6] cpufreq: Stop migrating sysfs files on hotplug
Date: Tue, 09 Jun 2015 01:23:03 +0200
Message-ID: <14491230.myz5JkLhE8@vostro.rjw.lan>
References: <cover.1433767914.git.viresh.kumar@linaro.org> <6922a02c439f353c7c2bc3f09f7eae6dfbc3ea25.1433767914.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53602 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753206AbbFHW5Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 18:57:16 -0400
In-Reply-To: <6922a02c439f353c7c2bc3f09f7eae6dfbc3ea25.1433767914.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>

On Monday, June 08, 2015 06:25:28 PM Viresh Kumar wrote:
> When we hot-unplug a cpu, we remove its sysfs cpufreq directory and if
> the outgoing cpu was the owner of policy->kobj earlier then we migrate
> the sysfs directory to under another online cpu.
> 
> There are few disadvantages this brings:
> - Code Complexity
> - Slower hotplug/suspend/resume
> - sysfs file permissions are reset after all policy->cpus are offlined
> - CPUFreq stats history lost after all policy->cpus are offlined
> - Special management of sysfs stuff during suspend/resume
> 
> To overcome these, this patch modifies the way sysfs directories are
> managed:
> - Select sysfs kobjects owner while initializing policy and don't change
>   it during hotplugs. Track it with kobj_cpu created earlier.
> 
> - Create symlinks for all related CPUs (can be offline) instead of
>   affected CPUs on policy initialization and remove them only when the
>   policy is freed.
> 
> - Free policy structure only on the removal of cpufreq-driver and not
>   during hotplug/suspend/resume, detected by checking 'struct
>   subsys_interface *' (Valid only when called from
>   subsys_interface_unregister() while unregistering driver).
> 
> Apart from this, special care is taken to handle physical hoplug of CPUs
> as we wouldn't remove sysfs links or remove policies on logical
> hotplugs. Physical hotplug happens in the following sequence.
> 
> Hot removal:
> - CPU is offlined first, ~ 'echo 0 >
>   /sys/devices/system/cpu/cpuX/online'
> - Then its device is removed along with all sysfs files, cpufreq core
>   notified with cpufreq_remove_dev() callback from subsys-interface..
> 
> Hot addition:
> - First the device along with its sysfs files is added, cpufreq core
>   notified with cpufreq_add_dev() callback from subsys-interface..
> - CPU is onlined, ~ 'echo 1 > /sys/devices/system/cpu/cpuX/online'
> 
> We call the same routines with both hotplug and subsys callbacks, and we
> sense physical hotplug with cpu_offline() check in subsys callback. We
> can handle most of the stuff with regular hotplug callback paths and
> add/remove cpufreq sysfs links or free policy from subsys callbacks.
> 
> [ Something similar attempted by Saravana earlier ]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 223 ++++++++++++++++++++++++++++------------------
>  1 file changed, 138 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7eeff892c0a6..663a934259a4 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -957,28 +957,64 @@ void cpufreq_sysfs_remove_file(const struct attribute *attr)
>  }
>  EXPORT_SYMBOL(cpufreq_sysfs_remove_file);
>  
> -/* symlink affected CPUs */
> +static int add_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu)
> +{
> +	struct device *cpu_dev;
> +

If you added

	if (!policy)
		return 0;

here, you could save some lines of code below. ->


> +	pr_debug("%s: Adding symlink for CPU: %u\n", __func__, cpu);
> +
> +	cpu_dev = get_cpu_device(cpu);
> +	if (WARN_ON(!cpu_dev))
> +		return 0;
> +
> +	return sysfs_create_link(&cpu_dev->kobj, &policy->kobj, "cpufreq");
> +}
> +
> +static void remove_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu)
> +{
> +	struct device *cpu_dev;
> +
> +	pr_debug("%s: Removing symlink for CPU: %u\n", __func__, cpu);
> +
> +	cpu_dev = get_cpu_device(cpu);
> +	if (WARN_ON(!cpu_dev))
> +		return;
> +
> +	sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
> +}
> +
> +/* Add/remove symlinks for all related CPUs */
>  static int cpufreq_add_dev_symlink(struct cpufreq_policy *policy)
>  {
>  	unsigned int j;
>  	int ret = 0;
>  
> -	for_each_cpu(j, policy->cpus) {
> -		struct device *cpu_dev;
> -
> +	/* Some related CPUs might not be present (physically hotplugged) */
> +	for_each_cpu_and(j, policy->related_cpus, cpu_present_mask) {
>  		if (j == policy->kobj_cpu)
>  			continue;
>  
> -		pr_debug("Adding link for CPU: %u\n", j);
> -		cpu_dev = get_cpu_device(j);
> -		ret = sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
> -					"cpufreq");
> +		ret = add_cpu_dev_symlink(policy, j);
>  		if (ret)
>  			break;
>  	}
> +
>  	return ret;
>  }
>  
> +static void cpufreq_remove_dev_symlink(struct cpufreq_policy *policy)
> +{
> +	unsigned int j;
> +
> +	/* Some related CPUs might not be present (physically hotplugged) */
> +	for_each_cpu_and(j, policy->related_cpus, cpu_present_mask) {
> +		if (j == policy->kobj_cpu)
> +			continue;
> +
> +		remove_cpu_dev_symlink(policy, j);
> +	}
> +}
> +
>  static int cpufreq_add_dev_interface(struct cpufreq_policy *policy,
>  				     struct device *dev)
>  {
> @@ -1075,7 +1111,7 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
>  		}
>  	}
>  
> -	return sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
> +	return 0;
>  }
>  
>  static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
> @@ -1095,7 +1131,7 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
>  	return policy;
>  }
>  
> -static struct cpufreq_policy *cpufreq_policy_alloc(void)
> +static struct cpufreq_policy *cpufreq_policy_alloc(int cpu)
>  {
>  	struct cpufreq_policy *policy;
>  
> @@ -1116,6 +1152,11 @@ static struct cpufreq_policy *cpufreq_policy_alloc(void)
>  	init_completion(&policy->kobj_unregister);
>  	INIT_WORK(&policy->update, handle_update);
>  
> +	policy->cpu = cpu;
> +
> +	/* Set this once on allocation */
> +	policy->kobj_cpu = cpu;
> +
>  	return policy;
>  
>  err_free_cpumask:
> @@ -1134,10 +1175,11 @@ static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
>  	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>  			CPUFREQ_REMOVE_POLICY, policy);
>  
> -	down_read(&policy->rwsem);
> +	down_write(&policy->rwsem);
> +	cpufreq_remove_dev_symlink(policy);
>  	kobj = &policy->kobj;
>  	cmp = &policy->kobj_unregister;
> -	up_read(&policy->rwsem);
> +	up_write(&policy->rwsem);
>  	kobject_put(kobj);
>  
>  	/*
> @@ -1168,27 +1210,14 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  	kfree(policy);
>  }
>  
> -static int update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu,
> -			     struct device *cpu_dev)
> +static void update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
>  {
> -	int ret;
> -
>  	if (WARN_ON(cpu == policy->cpu))
> -		return 0;
> -
> -	/* Move kobject to the new policy->cpu */
> -	ret = kobject_move(&policy->kobj, &cpu_dev->kobj);
> -	if (ret) {
> -		pr_err("%s: Failed to move kobj: %d\n", __func__, ret);
> -		return ret;
> -	}
> +		return;
>  
>  	down_write(&policy->rwsem);
>  	policy->cpu = cpu;
> -	policy->kobj_cpu = cpu;
>  	up_write(&policy->rwsem);
> -
> -	return 0;
>  }
>  
>  /**
> @@ -1206,13 +1235,25 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>  	int ret = -ENOMEM;
>  	struct cpufreq_policy *policy;
>  	unsigned long flags;
> -	bool recover_policy = cpufreq_suspended;
> -
> -	if (cpu_is_offline(cpu))
> -		return 0;
> +	bool recover_policy = !sif;
>  
>  	pr_debug("adding CPU %u\n", cpu);
>  
> +	/*
> +	 * Only possible if 'cpu' wasn't physically present earlier and we are
> +	 * here from subsys_interface add callback. A hotplug notifier will
> +	 * follow and we will handle it like logical CPU hotplug then. For now,
> +	 * just create the sysfs link.
> +	 */
> +	if (cpu_is_offline(cpu)) {
> +		policy = per_cpu(cpufreq_cpu_data, cpu);
> +		/* No need to create link of the first cpu of a policy */
> +		if (!policy)
> +			return 0;
> +
> +		return add_cpu_dev_symlink(policy, cpu);

-> If add_cpu_dev_symlink() did the !policy check, the code above could be
rewritten as

	if (cpu_is_offline(cpu)) 
		return add_cpu_dev_symlink(per_cpu(cpufreq_cpu_data, cpu), cpu);

> +	}
> +
>  	if (!down_read_trylock(&cpufreq_rwsem))
>  		return 0;
>  
> @@ -1232,7 +1273,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>  	policy = recover_policy ? cpufreq_policy_restore(cpu) : NULL;
>  	if (!policy) {
>  		recover_policy = false;
> -		policy = cpufreq_policy_alloc();
> +		policy = cpufreq_policy_alloc(cpu);
>  		if (!policy)
>  			goto nomem_out;
>  	}
> @@ -1243,12 +1284,8 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>  	 * the creation of a brand new one. So we need to perform this update
>  	 * by invoking update_policy_cpu().
>  	 */
> -	if (recover_policy && cpu != policy->cpu) {
> -		WARN_ON(update_policy_cpu(policy, cpu, dev));
> -	} else {
> -		policy->cpu = cpu;
> -		policy->kobj_cpu = cpu;
> -	}
> +	if (recover_policy && cpu != policy->cpu)
> +		update_policy_cpu(policy, cpu);
>  
>  	cpumask_copy(policy->cpus, cpumask_of(cpu));
>  
> @@ -1427,29 +1464,14 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
>  			CPUFREQ_NAME_LEN);
>  	up_write(&policy->rwsem);
>  
> -	if (cpu != policy->kobj_cpu) {
> -		sysfs_remove_link(&dev->kobj, "cpufreq");
> -	} else if (cpus > 1) {
> -		/* Nominate new CPU */
> -		int new_cpu = cpumask_any_but(policy->cpus, cpu);
> -		struct device *cpu_dev = get_cpu_device(new_cpu);
> -
> -		sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
> -		ret = update_policy_cpu(policy, new_cpu, cpu_dev);
> -		if (ret) {
> -			if (sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
> -					      "cpufreq"))
> -				pr_err("%s: Failed to restore kobj link to cpu:%d\n",
> -				       __func__, cpu_dev->id);
> -			return ret;
> -		}
> +	if (cpu != policy->cpu)
> +		return 0;
>  
> -		if (!cpufreq_suspended)
> -			pr_debug("%s: policy Kobject moved to cpu: %d from: %d\n",
> -				 __func__, new_cpu, cpu);
> -	} else if (cpufreq_driver->stop_cpu) {
> +	if (cpus > 1)
> +		/* Nominate new CPU */
> +		update_policy_cpu(policy, cpumask_any_but(policy->cpus, cpu));
> +	else if (cpufreq_driver->stop_cpu)
>  		cpufreq_driver->stop_cpu(policy);
> -	}
>  
>  	return 0;
>  }
> @@ -1470,32 +1492,11 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
>  	cpumask_clear_cpu(cpu, policy->cpus);
>  	up_write(&policy->rwsem);
>  
> -	/* If cpu is last user of policy, free policy */
> -	if (policy_is_inactive(policy)) {
> -		if (has_target()) {
> -			ret = __cpufreq_governor(policy,
> -					CPUFREQ_GOV_POLICY_EXIT);
> -			if (ret) {
> -				pr_err("%s: Failed to exit governor\n",
> -				       __func__);
> -				return ret;
> -			}
> -		}
> -
> -		if (!cpufreq_suspended)
> -			cpufreq_policy_put_kobj(policy);
> +	/* Not the last cpu of policy, start governor again ? */
> +	if (!policy_is_inactive(policy)) {
> +		if (!has_target())
> +			return 0;
>  
> -		/*
> -		 * Perform the ->exit() even during light-weight tear-down,
> -		 * since this is a core component, and is essential for the
> -		 * subsequent light-weight ->init() to succeed.
> -		 */
> -		if (cpufreq_driver->exit)
> -			cpufreq_driver->exit(policy);
> -
> -		if (!cpufreq_suspended)
> -			cpufreq_policy_free(policy);
> -	} else if (has_target()) {
>  		ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
>  		if (!ret)
>  			ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
> @@ -1504,8 +1505,34 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
>  			pr_err("%s: Failed to start governor\n", __func__);
>  			return ret;
>  		}
> +
> +		return 0;
>  	}
>  
> +	/* If cpu is last user of policy, free policy */
> +	if (has_target()) {
> +		ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
> +		if (ret) {
> +			pr_err("%s: Failed to exit governor\n", __func__);
> +			return ret;
> +		}
> +	}
> +
> +	/* Free the policy kobjects only if the driver is getting removed. */
> +	if (sif)
> +		cpufreq_policy_put_kobj(policy);
> +
> +	/*
> +	 * Perform the ->exit() even during light-weight tear-down,
> +	 * since this is a core component, and is essential for the
> +	 * subsequent light-weight ->init() to succeed.
> +	 */
> +	if (cpufreq_driver->exit)
> +		cpufreq_driver->exit(policy);
> +
> +	if (sif)
> +		cpufreq_policy_free(policy);
> +
>  	return 0;
>  }
>  
> @@ -1519,8 +1546,34 @@ static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
>  	unsigned int cpu = dev->id;
>  	int ret;
>  
> -	if (cpu_is_offline(cpu))
> +	/*
> +	 * Only possible if 'cpu' is getting physically removed now. A hotplug
> +	 * notifier should have already been called and we just need to remove
> +	 * link or free policy here.
> +	 */
> +	if (cpu_is_offline(cpu)) {
> +		struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
> +		struct cpumask mask;
> +
> +		if (!policy)
> +			return 0;
> +
> +		cpumask_copy(&mask, policy->related_cpus);
> +		cpumask_clear_cpu(cpu, &mask);
> +
> +		/*
> +		 * Free policy only if all policy->related_cpus are removed
> +		 * physically.
> +		 */
> +		if (cpumask_intersects(&mask, cpu_present_mask)) {
> +			remove_cpu_dev_symlink(policy, cpu);
> +			return 0;
> +		}
> +
> +		cpufreq_policy_put_kobj(policy);
> +		cpufreq_policy_free(policy);
>  		return 0;
> +	}
>  
>  	ret = __cpufreq_remove_dev_prepare(dev, sif);
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
