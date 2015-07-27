From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 7/7] cpufreq: Separate CPU device removal from CPU online
Date: Mon, 27 Jul 2015 20:36:55 +0530
Message-ID: <20150727150655.GI18535@linux>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
 <3874727.Jpay9zgokc@vostro.rjw.lan>
 <1739669.kedIsxdRK2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1739669.kedIsxdRK2@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On 27-07-15, 16:09, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> To separate the CPU online interface from the CPU device removal
> one,

Why do you call this cpu device removal code?

> split cpufreq_online() out of cpufreq_add_dev() and make
> cpufreq_cpu_callback() call the former, while the latter will only
> be used as the CPU device removal subsystem interface callback.
> 
> While at it, notice that the return value of sif->add_dev() is
> ignored in bus_probe_device(), so (the new) cpufreq_add_dev()
> doesn't need to bother with returning anything different from 0
> and cpufreq_online() may be a void function.

That is going to change in 4.3:

https://lkml.org/lkml/2015/6/26/132

> 
> Moreover, since the return value of cpufreq_add_policy_cpu() is
> going to be ignored now too, make a void function of it as well.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Suggested-by: Russell King <linux@arm.linux.org.uk>
> ---
>  drivers/cpufreq/cpufreq.c |  125 ++++++++++++++++++++++------------------------
>  1 file changed, 61 insertions(+), 64 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -1056,19 +1056,17 @@ static int cpufreq_init_policy(struct cp
>  	return cpufreq_set_policy(policy, &new_policy);
>  }
>  
> -static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
> +static void cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
>  {
> -	int ret = 0;
> -
>  	/* Has this CPU been taken care of already? */
>  	if (cpumask_test_cpu(cpu, policy->cpus))
> -		return 0;
> +		return;
>  
>  	if (has_target()) {
> -		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
> +		int ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);

Why should we move the definition of ret here and ...

>  		if (ret) {
>  			pr_err("%s: Failed to stop governor\n", __func__);
> -			return ret;
> +			return;
>  		}
>  	}

-- 
viresh
