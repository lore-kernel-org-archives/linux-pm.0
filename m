From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] acpi-cpufreq: use same acpi_cpufreq_data if policy is
 shared
Date: Fri, 3 Jul 2015 14:16:57 +0530
Message-ID: <20150703084657.GB23297@linux>
References: <5596414C.4090106@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36188 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbbGCIrD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 04:47:03 -0400
Received: by pdcu2 with SMTP id u2so61348405pdc.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2015 01:47:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5596414C.4090106@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

On 03-07-15, 16:01, Pan Xinhui wrote:
> 
> cpufreq core will mark all cpus in policy->cpus as initialized
> by setting percpu cpufreq_cpu_data = policy.
> However in acpi-cpufreq, we did not set percpu acpi_cpufreq_data for
> all cpus in policy->cpus.
> That will cause a issue that when we call get_cur_freq_on_cpu for a
> cpu, it returns zero instead of a correct value.
> 
> So we shared acpi_cpufreq_data for all those cpus in policy->cpus.
> 
> Signed-off-by: xinhuix.pan <xinhuix.pan@intel.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 0136dfc..6c6dc97 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -673,6 +673,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	}
>  
>  	data->acpi_data = per_cpu_ptr(acpi_perf_data, cpu);
> +	cpumask_copy(policy->cpus, cpumask_of(cpu));

This is already done by cpufreq-core before calling ->init() and so
isn't required.

>  	per_cpu(acfreq_data, cpu) = data;
>  
>  	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC))
> @@ -712,6 +713,10 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	}
>  #endif
>  
> +	for_each_cpu(i, policy->cpus) {
> +		per_cpu(acfreq_data, i) = data;
> +	}
> +
>  	/* capability check */
>  	if (perf->state_count <= 1) {
>  		pr_debug("No P-States\n");
> @@ -843,7 +848,9 @@ err_free_mask:
>  	free_cpumask_var(data->freqdomain_cpus);
>  err_free:
>  	kfree(data);
> -	per_cpu(acfreq_data, cpu) = NULL;
> +	for_each_cpu(i, policy->cpus) {
> +		per_cpu(acfreq_data, i) = NULL;
> +	}

The per-cpu thing is basically wrong to start with. cpufreq-policy has
a field: 'driver_data', which can be used to replace this acfreq_data.
Probably use that and things will get fixed by themselves.

-- 
viresh
