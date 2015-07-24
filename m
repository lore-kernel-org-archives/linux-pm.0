From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Avoid attempts to create duplicate symbolic
 links
Date: Fri, 24 Jul 2015 19:39:43 +0530
Message-ID: <20150724140943.GC16336@linux>
References: <1660815.CyKx9SEI9c@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34630 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbbGXOJt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2015 10:09:49 -0400
Received: by pacan13 with SMTP id an13so15361600pac.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2015 07:09:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1660815.CyKx9SEI9c@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

On 23-07-15, 23:14, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit 87549141d516 (cpufreq: Stop migrating sysfs files on
> hotplug) there is a problem with CPUs that share cpufreq policy
> objects with other CPUs and are initially offline.
> 
> Say CPU1 shares a policy with CPU0 which is online and is registered
> first.  As part of the registration process, cpufreq_add_dev() is
> called for it.  It creates the policy object and a symbolic link
> to it from the CPU1's sysfs directory.  If CPU1 is registered
> subsequently and it is offline at that time, cpufreq_add_dev() will
> attempt to create a symbolic link to the policy object for it, but
> that link is present already, so a warning about that will be
> triggered.
> 
> To avoid that warning, make cpufreq use an additional CPU mask
> containing related CPUs that are actually present for each policy
> object.  That mask is initialized when the policy object is populated
> after its creation (for the first online CPU using it) and it includes
> CPUs from the "policy CPUs" mask returned by the cpufreq driver's
> ->init() callback that are physically present at that time.  Symbolic
> links to the policy are created only for the CPUs in that mask.
> 
> If cpufreq_add_dev() is invoked for an offline CPU, it checks the
> new mask and only creates the symlink if the CPU was not in it (the
> CPU is added to the mask at the same time).
> 
> In turn, cpufreq_remove_dev() drops the given CPU from the new mask,
> removes its symlink to the policy object and returns, unless it is
> the CPU owning the policy object.  In that case, the policy object
> is moved to a new CPU's sysfs directory or deleted if the CPU being
> removed was the last user of the policy.
> 
> While at it, notice that cpufreq_remove_dev() can't fail, because
> its return value is ignored, so make it ignore return values from
> __cpufreq_remove_dev_prepare() and __cpufreq_remove_dev_finish()
> and prevent these functions from aborting on errors returned by
> __cpufreq_governor().
> 
> Fixes: 87549141d516 (cpufreq: Stop migrating sysfs files on hotplug)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reported-by: Russell King <linux@arm.linux.org.uk>
> ---
> 
> This is supposed to replace the other patches sent so far to address the issue
> at hand.

Lets take this one and leave my patches. They are generating more
diff and actually doing part of the general improvements Russell
suggested.

> +	if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))

I was wondering if we should use cpumask_t type variables, so that we
don't have to allocate these masks. They are always with policies.

> @@ -1307,6 +1316,9 @@ static int cpufreq_add_dev(struct device
>  	/* related cpus should atleast have policy->cpus */
>  	cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
>  
> +	cpumask_and(policy->cpus, policy->cpus, cpu_present_mask);
> +	cpumask_or(policy->real_cpus, policy->real_cpus, policy->cpus);
> +

I will do this differently:
        cpumask_and(policy->real_cpus, policy->cpus, cpu_present_mask);

policy->cpus is anyway going to be anded with online mask.

>  	/*
>  	 * affected cpus must always be the one, which are online. We aren't
>  	 * managing offline cpus here.


>  static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
>  {

> -	ret = __cpufreq_remove_dev_prepare(dev, sif);
> +	if (cpu != policy->kobj_cpu) {
> +		remove_cpu_dev_symlink(policy, cpu);
> +	} else {
> +		/*
> +		 * This is the CPU owning the policy object.  Move it to another
> +		 * suitable CPU.
> +		 */
> +		unsigned int new_cpu = cpumask_first(policy->real_cpus);
> +		struct device *new_dev = get_cpu_device(new_cpu);
>  
> -	if (!ret)
> -		ret = __cpufreq_remove_dev_finish(dev, sif);
> +		dev_dbg(dev, "%s: Moving policy object to CPU%u\n", __func__, new_cpu);
>  
> -	return ret;
> +		policy->kobj_cpu = new_cpu;

You need to remove the link for the target cpu, like what I did in my
patch:

               sysfs_remove_link(&new_dev->kobj, "cpufreq");

> +		WARN_ON(kobject_move(&policy->kobj, &new_dev->kobj));
> +	}
> +
> +	return 0;
>  }
>  
>  static void handle_update(struct work_struct *work)

-- 
viresh
