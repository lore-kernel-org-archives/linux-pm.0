From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Rearrange cpufreq_add_dev()
Date: Thu, 7 Apr 2016 10:00:10 +0530
Message-ID: <20160407043010.GC14903@vireshk-i7>
References: <25180596.UsWVYNr6Fj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35314 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbcDGEaN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 00:30:13 -0400
Received: by mail-pa0-f41.google.com with SMTP id td3so46828281pab.2
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2016 21:30:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <25180596.UsWVYNr6Fj@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 07-04-16, 03:31, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Reorganize the code in cpufreq_add_dev() to avoid using the ret
> variable and reduce the indentation level in it.
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -1311,26 +1311,24 @@ out_free_policy:
>   */
>  static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>  {
> +	struct cpufreq_policy *policy;
>  	unsigned cpu = dev->id;
> -	int ret;
>  
>  	dev_dbg(dev, "%s: adding CPU%u\n", __func__, cpu);
>  
> -	if (cpu_online(cpu)) {
> -		ret = cpufreq_online(cpu);
> -	} else {
> -		/*
> -		 * A hotplug notifier will follow and we will handle it as CPU
> -		 * online then.  For now, just create the sysfs link, unless
> -		 * there is no policy or the link is already present.
> -		 */
> -		struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
> +	if (cpu_online(cpu))
> +		return cpufreq_online(cpu);
>  
> -		ret = policy && !cpumask_test_and_set_cpu(cpu, policy->real_cpus)
> -			? add_cpu_dev_symlink(policy, cpu) : 0;
> -	}
> +	/*
> +	 * A hotplug notifier will follow and we will handle it as CPU online
> +	 * then.  For now, just create the sysfs link, unless there is no policy
> +	 * or the link is already present.
> +	 */
> +	policy = per_cpu(cpufreq_cpu_data, cpu);
> +	if (!policy || cpumask_test_and_set_cpu(cpu, policy->real_cpus))
> +		return 0;
>  
> -	return ret;
> +	return add_cpu_dev_symlink(policy, cpu);
>  }
>  
>  static void cpufreq_offline(unsigned int cpu)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
