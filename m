From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC][PATCH 1/2] cpufreq: intel_pstate: Expose global sysfs
 attributes upfront
Date: Tue, 10 Jan 2017 12:48:55 -0800
Message-ID: <1484081335.28749.11.camel@linux.intel.com>
References: <21825845.nN3skUNMsO@aspire.rjw.lan>
         <2389828.jxMzLa8mev@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50526 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750790AbdAJUs5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Jan 2017 15:48:57 -0500
In-Reply-To: <2389828.jxMzLa8mev@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

On Thu, 2017-01-05 at 02:51 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Expose the intel_pstate's global sysfs attributes before registering
> the driver to prepare for the addition of an attribute that also will
> have to work if the driver is not registered.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 

[...]

>  #ifdef CONFIG_ACPI
> @@ -1055,12 +1058,22 @@ static ssize_t show_turbo_pct(struct kob
>  	int total, no_turbo, turbo_pct;
>  	uint32_t turbo_fp;
>  
> +	mutex_lock(&intel_pstate_driver_lock);
> +
> +	if (!driver_registered) {
> +		mutex_unlock(&intel_pstate_limits_lock);
It should be
                mutex_unlock(&intel_pstate_driver_lock);

> +		return -EAGAIN;
> +	}
> +
>  	cpu = all_cpu_data[0];
>  
> 
[...]

> @@ -1070,8 +1083,18 @@ static ssize_t show_num_pstates(struct k
>  	struct cpudata *cpu;
>  	int total;
>  
> +	mutex_lock(&intel_pstate_driver_lock);
> +
> +	if (!driver_registered) {
> +		mutex_unlock(&intel_pstate_limits_lock);
Change to
                mutex_unlock(&intel_pstate_driver_lock);

> +		return -EAGAIN;
> +	}
> +
>  	cpu = all_cpu_data[0];
>  	total = cpu->pstate.turbo_pstate - cpu->pstate.min_pstate +
> 1;
> +
> +	mutex_unlock(&intel_pstate_driver_lock);
> +
>  	return sprintf(buf, "%u\n", total);
>  }
>  
> @@ -1080,12 +1103,21 @@ static ssize_t show_no_turbo(struct kobj
>  {
>  	ssize_t ret;
>  
> +	mutex_lock(&intel_pstate_driver_lock);
> +
> +	if (!driver_registered) {
> +		mutex_unlock(&intel_pstate_limits_lock);
Same here
                mutex_unlock(&intel_pstate_driver_lock);

> +		return -EAGAIN;
> +	}
> +
>  	update_turbo_state();
>  	if (limits->turbo_disabled)
>  		ret = sprintf(buf, "%u\n", limits->turbo_disabled);
>  	else
>  		ret = sprintf(buf, "%u\n", limits->no_turbo);
>  
> +	mutex_unlock(&intel_pstate_driver_lock);
> +
>  	return ret;
>  }
>  
> @@ -1099,6 +1131,13 @@ static ssize_t store_no_turbo(struct kob
>  	if (ret != 1)
>  		return -EINVAL;
>  
> +	mutex_lock(&intel_pstate_driver_lock);
> +
> +	if (!driver_registered) {
> +		mutex_unlock(&intel_pstate_driver_lock);
> +		return -EAGAIN;
> +	}
> +
>  	mutex_lock(&intel_pstate_limits_lock);       if (limits-
> >turbo_disabled) {
>                 pr_warn("Turbo disabled by BIOS or unavailable on
> processor\n");
>                 mutex_unlock(&intel_pstate_limits_lock);
Also
		mutex_unlock(&intel_pstate_driver_lock);> 

>                 return -EPERM;
>         }
>  
>  	update_turbo_state();
> @@ -1114,6 +1153,8 @@ static ssize_t store_no_turbo(struct kob
>  
>  	intel_pstate_update_policies();
>  
> +	mutex_unlock(&intel_pstate_driver_lock);
> +
>  	return count;
>  }
> 

Thanks,
Srinivas

