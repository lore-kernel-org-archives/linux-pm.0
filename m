From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: Separate CPU device removal from CPU online
Date: Thu, 23 Jul 2015 12:09:42 +0530
Message-ID: <20150723063942.GF5322@linux>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
 <15986005.VczafT3nkj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34408 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbbGWGjs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 02:39:48 -0400
Received: by pacan13 with SMTP id an13so153868468pac.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2015 23:39:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <15986005.VczafT3nkj@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 23-07-15, 02:04, Rafael J. Wysocki wrote:
> +static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
> +{
> +	unsigned int cpu = dev->id;
> +	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
> +
> +	pr_debug("%s: adding CPU %u\n", __func__, cpu);
> +
> +	if (policy && policy->kobj_cpu != cpu) {

Why are you comparing cpu against kobj_cpu ? I don't think it can ever
be false.

> +		int ret;
> +
> +		pr_debug("%s: Adding symlink for CPU: %u\n", __func__, cpu);

dev_dbg

> +		ret = sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
> +		if (ret) {
> +			dev_dbg(dev, "%s: Failed to create link (%d)\n",

dev_err

> +				__func__, ret);
> +			return ret;
> +		}
> +
> +		/* Track CPUs for which sysfs links are created */
> +		cpumask_set_cpu(cpu, policy->linked_cpus);
> +	}
> +
> +	return cpu_online(cpu) ? cpufreq_dev_online(dev, false) : 0;
> +}

Looks fine otherwise. Thanks for getting your hands dirty :)

>  static void cpufreq_offline_prepare(unsigned int cpu)
>  {
>  	struct cpufreq_policy *policy;
> @@ -2344,31 +2343,35 @@ unlock:
>  }
>  EXPORT_SYMBOL(cpufreq_update_policy);
>  
> +static void cpufreq_cpu_online(unsigned int cpu)
> +{
> +	struct device *dev = get_cpu_device(cpu);
> +
> +	if (dev)
> +		cpufreq_dev_online(dev, true);
> +}

What about dropping this wrapper function and ...

>  static int cpufreq_cpu_callback(struct notifier_block *nfb,
>  					unsigned long action, void *hcpu)
>  {
>  	unsigned int cpu = (unsigned long)hcpu;
> -	struct device *dev;
>  
> -	dev = get_cpu_device(cpu);

... keeping this as is? And then we can do
s/cpufreq_dev_online/cpufreq_cpu_online which suits better.

> -	if (dev) {
> -		switch (action & ~CPU_TASKS_FROZEN) {
> -		case CPU_ONLINE:
> -			cpufreq_add_dev(dev, NULL);
> -			break;
> -
> -		case CPU_DOWN_PREPARE:
> -			cpufreq_offline_prepare(cpu);
> -			break;
> -
> -		case CPU_POST_DEAD:
> -			cpufreq_offline_finish(cpu);
> -			break;
> -
> -		case CPU_DOWN_FAILED:
> -			cpufreq_add_dev(dev, NULL);
> -			break;
> -		}
> +	switch (action & ~CPU_TASKS_FROZEN) {
> +	case CPU_ONLINE:
> +		cpufreq_cpu_online(cpu);
> +		break;
> +
> +	case CPU_DOWN_PREPARE:
> +		cpufreq_offline_prepare(cpu);
> +		break;
> +
> +	case CPU_POST_DEAD:
> +		cpufreq_offline_finish(cpu);
> +		break;
> +
> +	case CPU_DOWN_FAILED:
> +		cpufreq_cpu_online(cpu);
> +		break;
>  	}
>  	return NOTIFY_OK;
>  }

-- 
viresh
