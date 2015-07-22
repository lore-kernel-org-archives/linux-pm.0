From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V2] cpufreq: Fix double addition of sysfs links
Date: Wed, 22 Jul 2015 14:15:39 +0100
Message-ID: <20150722131539.GU7557@n2100.arm.linux.org.uk>
References: <20150718163149.GP7557@n2100.arm.linux.org.uk>
 <35d0bb6829c6c8a5fec7c55e45d9293946c0221b.1437566548.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <35d0bb6829c6c8a5fec7c55e45d9293946c0221b.1437566548.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 22, 2015 at 05:37:18PM +0530, Viresh Kumar wrote:
> Consider a dual core (0/1) system with two CPUs:
> - sharing clock/voltage rails and hence cpufreq-policy
> - CPU1 is offline while the cpufreq driver is registered
> - cpufreq_add_dev() is called from subsys callback for CPU0 and we
>   create the policy for the group of CPUs and create links for all
>   present CPUs, i.e. CPU1 as well.
> - cpufreq_add_dev() is called from subsys callback for CPU1, we find
>   that the cpu is offline and we try to create a sysfs link for CPU1.
> 
> This results in double addtion of the sysfs link and we will get this:
> 
> WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x60/0x7c()
> sysfs: cannot create duplicate filename '/devices/system/cpu/cpu1/cpufreq'
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.2.0-rc2+ #1704
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> Backtrace:
> [<c0013248>] (dump_backtrace) from [<c00133e4>] (show_stack+0x18/0x1c)
>  r6:c01a1f30 r5:0000001f r4:00000000 r3:00000000
> [<c00133cc>] (show_stack) from [<c076920c>] (dump_stack+0x7c/0x98)
> [<c0769190>] (dump_stack) from [<c0029ab4>] (warn_slowpath_common+0x80/0xbc)
>  r4:d74abbd0 r3:d74c0000
> [<c0029a34>] (warn_slowpath_common) from [<c0029b94>] (warn_slowpath_fmt+0x38/0x40)
>  r8:ffffffef r7:00000000 r6:d75a8960 r5:c0993280 r4:d6b4d000
> [<c0029b60>] (warn_slowpath_fmt) from [<c01a1f30>] (sysfs_warn_dup+0x60/0x7c)
>  r3:d6b4dfe7 r2:c0930750
> [<c01a1ed0>] (sysfs_warn_dup) from [<c01a22c8>] (sysfs_do_create_link_sd+0xb8/0xc0)
>  r6:d75a8960 r5:c0993280 r4:d00aba20
> [<c01a2210>] (sysfs_do_create_link_sd) from [<c01a22fc>] (sysfs_create_link+0x2c/0x3c)
>  r10:00000001 r8:c14db3c8 r7:d7b89010 r6:c0ae7c60 r5:d7b89010 r4:d00d1200
> [<c01a22d0>] (sysfs_create_link) from [<c0506160>] (add_cpu_dev_symlink+0x34/0x5c)
> [<c050612c>] (add_cpu_dev_symlink) from [<c05084d0>] (cpufreq_add_dev+0x674/0x794)
>  r5:00000001 r4:00000000
> [<c0507e5c>] (cpufreq_add_dev) from [<c03db114>] (subsys_interface_register+0x8c/0xd0)
>  r10:00000003 r9:d7bb01f0 r8:c14db3c8 r7:00106738 r6:c0ae7c60 r5:c0acbd08
>  r4:c0ae7e20
> [<c03db088>] (subsys_interface_register) from [<c0508a2c>] (cpufreq_register_driver+0x104/0x1f4)
> 
> The check for offline-cpu in cpufreq_add_dev() is to ensure that link
> gets added for the CPUs which weren't physically present earlier and
> that misses the case where a CPU is offline while registering the
> driver.
> 
> To fix this properly, don't create these links when the policy get
> initialized. Rather wait for individual subsys callback for CPUs to
> add/remove these links. This simplifies most of the code leaving
> cpufreq_remove_dev().
> 
> The problem is that, we might remove cpu which was owner of policy->kobj
> in sysfs, before other CPUs are removed. Fix this by the solution we
> have been using until very recently, in which we move the kobject to any
> other CPU, for which remove is yet to be called.
> 
> Tested on dual core exynos board with cpufreq-dt driver. The driver was
> compiled as module and inserted/removed multiple times on a running
> kernel.
> 
> Fixes: 87549141d516 ("cpufreq: Stop migrating sysfs files on hotplug")
> Reported-and-suggested-by: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V1->V2: Completely changed, please review again :)
> 
> @Rafael: I didn't review your solution and gave this one because I
> thought Russell suggested the right thing. i.e. don't create links in
> the beginning.
> 
> This is based of 4.2-rc3 and so your other patch,
> https://patchwork.kernel.org/patch/6839031/ has to be rebased over it.
> 
> I didn't rebase this patch over yours for two reasons:
> - Yours wasn't necessarily 4.2 material.
> - I already mentioned a problem in that patch.
> 
> @Russell: I hope this will look much better than V1 to you. Please give
> it a try once you get some time.
> 
>  drivers/cpufreq/cpufreq.c | 165 ++++++++++++++++++----------------------------
>  include/linux/cpufreq.h   |   1 +
>  2 files changed, 65 insertions(+), 101 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 26063afb3eba..81c2417e52f4 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -966,67 +966,6 @@ void cpufreq_sysfs_remove_file(const struct attribute *attr)
>  }
>  EXPORT_SYMBOL(cpufreq_sysfs_remove_file);
>  
> -static int add_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu)
> -{
> -	struct device *cpu_dev;
> -
> -	pr_debug("%s: Adding symlink for CPU: %u\n", __func__, cpu);
> -
> -	if (!policy)
> -		return 0;
> -
> -	cpu_dev = get_cpu_device(cpu);
> -	if (WARN_ON(!cpu_dev))
> -		return 0;
> -
> -	return sysfs_create_link(&cpu_dev->kobj, &policy->kobj, "cpufreq");
> -}
> -
> -static void remove_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu)
> -{
> -	struct device *cpu_dev;
> -
> -	pr_debug("%s: Removing symlink for CPU: %u\n", __func__, cpu);
> -
> -	cpu_dev = get_cpu_device(cpu);
> -	if (WARN_ON(!cpu_dev))
> -		return;
> -
> -	sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
> -}
> -
> -/* Add/remove symlinks for all related CPUs */
> -static int cpufreq_add_dev_symlink(struct cpufreq_policy *policy)
> -{
> -	unsigned int j;
> -	int ret = 0;
> -
> -	/* Some related CPUs might not be present (physically hotplugged) */
> -	for_each_cpu_and(j, policy->related_cpus, cpu_present_mask) {
> -		if (j == policy->kobj_cpu)
> -			continue;
> -
> -		ret = add_cpu_dev_symlink(policy, j);
> -		if (ret)
> -			break;
> -	}
> -
> -	return ret;
> -}
> -
> -static void cpufreq_remove_dev_symlink(struct cpufreq_policy *policy)
> -{
> -	unsigned int j;
> -
> -	/* Some related CPUs might not be present (physically hotplugged) */
> -	for_each_cpu_and(j, policy->related_cpus, cpu_present_mask) {
> -		if (j == policy->kobj_cpu)
> -			continue;
> -
> -		remove_cpu_dev_symlink(policy, j);
> -	}
> -}
> -
>  static int cpufreq_add_dev_interface(struct cpufreq_policy *policy,
>  				     struct device *dev)
>  {
> @@ -1057,7 +996,7 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy,
>  			return ret;
>  	}
>  
> -	return cpufreq_add_dev_symlink(policy);
> +	return 0;
>  }
>  
>  static void cpufreq_init_policy(struct cpufreq_policy *policy)
> @@ -1163,11 +1102,14 @@ static struct cpufreq_policy *cpufreq_policy_alloc(struct device *dev)
>  	if (!zalloc_cpumask_var(&policy->related_cpus, GFP_KERNEL))
>  		goto err_free_cpumask;
>  
> +	if (!zalloc_cpumask_var(&policy->symlinks, GFP_KERNEL))
> +		goto err_free_related_cpumask;
> +
>  	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq, &dev->kobj,
>  				   "cpufreq");
>  	if (ret) {
>  		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
> -		goto err_free_rcpumask;
> +		goto err_free_symlink_cpumask;
>  	}
>  
>  	INIT_LIST_HEAD(&policy->policy_list);
> @@ -1184,7 +1126,9 @@ static struct cpufreq_policy *cpufreq_policy_alloc(struct device *dev)
>  
>  	return policy;
>  
> -err_free_rcpumask:
> +err_free_symlink_cpumask:
> +	free_cpumask_var(policy->symlinks);
> +err_free_related_cpumask:
>  	free_cpumask_var(policy->related_cpus);
>  err_free_cpumask:
>  	free_cpumask_var(policy->cpus);
> @@ -1204,7 +1148,6 @@ static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy, bool notify)
>  					     CPUFREQ_REMOVE_POLICY, policy);
>  
>  	down_write(&policy->rwsem);
> -	cpufreq_remove_dev_symlink(policy);
>  	kobj = &policy->kobj;
>  	cmp = &policy->kobj_unregister;
>  	up_write(&policy->rwsem);
> @@ -1234,6 +1177,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy, bool notify)
>  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>  
>  	cpufreq_policy_put_kobj(policy, notify);
> +	free_cpumask_var(policy->symlinks);
>  	free_cpumask_var(policy->related_cpus);
>  	free_cpumask_var(policy->cpus);
>  	kfree(policy);
> @@ -1252,26 +1196,37 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>  {
>  	unsigned int j, cpu = dev->id;
>  	int ret = -ENOMEM;
> -	struct cpufreq_policy *policy;
> +	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
>  	unsigned long flags;
>  	bool recover_policy = !sif;
>  
>  	pr_debug("adding CPU %u\n", cpu);
>  
> +	/* sysfs links are only created on subsys callback */
> +	if (sif && policy) {
> +		pr_debug("%s: Adding symlink for CPU: %u\n", __func__, cpu);

dev_dbg() ?

> +		ret = sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
> +		if (ret) {
> +			dev_err(dev, "%s: Failed to create link for cpu %d (%d)\n",
> +				__func__, cpu, ret);

I wonder why we print the CPU number - since it's from dev->id, isn't it
included in the struct device name printed by dev_err() already?

> +			return ret;
> +		}
> +
> +		/* Track CPUs for which sysfs links are created */
> +		cpumask_set_cpu(cpu, policy->symlinks);
> +	}
> +

I guess this will do for -rc, but it's not particularly nice.  Can I
suggest splitting the two operations here - the add_dev callback from
the subsys interface, and the handling of hotplug online/offline
notifications.

You only need to do the above for the subsys interface, and you only
need to do the remainder if the CPU was online.

Also, what about the CPU "owning" the policy?

So, this would become:

static int cpufreq_cpu_online(struct device *dev)
{
	pr_debug("bringing CPU%d online\n", dev->id);
	... stuff to do when CPU is online ...
}

static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
{
	unsigned int cpu = dev->id;
	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);

	pr_debug("adding CPU %u\n", cpu);

	if (policy && policy->kobj_cpu != cpu) {
		dev_dbg(dev, "%s: Adding cpufreq symlink\n", __func__);
		ret = sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
		if (ret) {
			dev_err(dev,
				"%s: Failed to create cpufreq symlink (%d)\n",
				__func__, ret);
			return ret;
		}

		/* Track CPUs for which sysfs links are created */
		cpumask_set_cpu(cpu, policy->symlinks);
	}

	/* Now do the remainder if the CPU is already online */
	if (cpu_online(cpu))
		return cpufreq_cpu_online(dev);

	return 0;
}

Next, change the cpufreq_add_dev(dev, NULL) in the hotplug notifier call
to cpufreq_cpu_online(dev) instead.

Doing the similar thing for the cpufreq_remove_dev() path would also make
sense.

>  	/*
> -	 * Only possible if 'cpu' wasn't physically present earlier and we are
> -	 * here from subsys_interface add callback. A hotplug notifier will
> -	 * follow and we will handle it like logical CPU hotplug then. For now,
> -	 * just create the sysfs link.
> +	 * A hotplug notifier will follow and we will take care of rest
> +	 * of the initialization then.
>  	 */
>  	if (cpu_is_offline(cpu))
> -		return add_cpu_dev_symlink(per_cpu(cpufreq_cpu_data, cpu), cpu);
> +		return 0;
>  
>  	if (!down_read_trylock(&cpufreq_rwsem))
>  		return 0;
>  
>  	/* Check if this CPU already has a policy to manage it */
> -	policy = per_cpu(cpufreq_cpu_data, cpu);
>  	if (policy && !policy_is_inactive(policy)) {
>  		WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus));
>  		ret = cpufreq_add_policy_cpu(policy, cpu, dev);
> @@ -1506,10 +1461,6 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
>  	if (cpufreq_driver->exit)
>  		cpufreq_driver->exit(policy);
>  
> -	/* Free the policy only if the driver is getting removed. */
> -	if (sif)
> -		cpufreq_policy_free(policy, true);
> -
>  	return 0;
>  }
>  
> @@ -1521,42 +1472,54 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
>  static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
>  {
>  	unsigned int cpu = dev->id;
> +	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
>  	int ret;
>  
> -	/*
> -	 * Only possible if 'cpu' is getting physically removed now. A hotplug
> -	 * notifier should have already been called and we just need to remove
> -	 * link or free policy here.
> -	 */
> -	if (cpu_is_offline(cpu)) {
> -		struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
> -		struct cpumask mask;
> +	if (!policy)
> +		return 0;
>  
> -		if (!policy)
> -			return 0;
> +	if (cpu_online(cpu)) {
> +		ret = __cpufreq_remove_dev_prepare(dev, sif);
> +		if (!ret)
> +			ret = __cpufreq_remove_dev_finish(dev, sif);
> +		if (ret)
> +			return ret;

Here, I have to wonder about this.  If you look at the code in
drivers/base/bus.c, you'll notice that the ->remove_dev return code is
not used (personally, I hate interfaces which are created with an int
return type for a removal operation, but then ignore the return code.
Either have the return code and use it, or don't confuse driver authors
by having one.)

What this means is that in the remove path, the device _is_ going away,
whether you like it or not.  So, if you have an error early in your
remove path, returning that error does you no good - you end up leaking
memory because subsequent cleanup doesn't get done.

It's better to either ensure that your removal path can't fail, or if it
can, to reasonably clean up as much as you can (which here, means
continuing to remove the symlink.)

If you adopt my suggestion above, then cpufreq_remove_dev() becomes
something like:

static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
{
	unsigned int cpu = dev->id;
	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);

	if (cpu_is_online(cpu))
		cpufreq_cpu_offline(dev);

	if (policy) {
		if (cpumask_test_cpu(cpu, policy->symlinks)) {
			dev_dbg(dev, "%s: Removing cpufreq symlink\n",
				__func__);
			cpumask_clear_cpu(cpu, policy->symlinks);
			sysfs_remove_link(&dev->kobj, "cpufreq");
		}

		if (policy->kobj_cpu == cpu) {
			... migration code and final CPU deletion code ...
		}
	}

	return 0;
}

which IMHO is easier to read and follow, and more symetrical with
cpufreq_add_dev().

Now, I'm left wondering about a few things:

1. whether having a CPU "own" the policy, and having the cpufreq/ directory
   beneath the cpuN node is a good idea, or whether it would be better to
   place this in the /sys/devices/system/cpufreq/ subdirectory and always
   symlink to there.  It strikes me that would simplify the code a little.

2. whether using a kref to track the usage of the policy would be better
   than tracking symlink weight (or in the case of (1) being adopted,
   whether the symlink cpumask becomes empty.)  Note that the symlink
   weight becoming zero without (1) (in other words, no symlinks) is not
   the correct condition for freeing the policy - we still have one CPU,
   that being the CPU for policy->kobj_cpu.

3. what happens when 'policy' is NULL at the point when the first (few) CPUs
   are added - how do the symlinks get created later if/when policy becomes
   non-NULL (can it?)

4. what about policy->related_cpus ?  What if one of the CPUs being added is
   not in policy->related_cpus?  Should we still go ahead and create the
   symlink?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
