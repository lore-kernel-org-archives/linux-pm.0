From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 01/22] cpufreq/acpi-cpufreq: Convert to hotplug state
 machine
Date: Mon, 28 Nov 2016 10:45:20 +0530
Message-ID: <20161128051520.GA9104@vireshk-i7>
References: <20161126231350.10321-1-bigeasy@linutronix.de>
 <20161126231350.10321-2-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161126231350.10321-2-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de, tglx@linutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 27-11-16, 00:13, Sebastian Andrzej Siewior wrote:
> Install the callbacks via the state machine.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 93 ++++++++++++++++++++----------------------
>  1 file changed, 45 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 297e9128fe9f..2c29cbaca7b5 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -536,46 +536,33 @@ static void free_acpi_perf_data(void)
>  	free_percpu(acpi_perf_data);
>  }
>  
> -static int boost_notify(struct notifier_block *nb, unsigned long action,
> -		      void *hcpu)
> +static int cpufreq_boost_online(unsigned int cpu)
> +{
> +	const struct cpumask *cpumask;
> +
> +	cpumask = get_cpu_mask(cpu);
> +	/*
> +	 * On the CPU_UP path we simply keep the boost-disable flag
> +	 * in sync with the current global state.
> +	 */
> +	boost_set_msrs(acpi_cpufreq_driver.boost_enabled, cpumask);
> +	return 0;
> +}
> +
> +static int cpufreq_boost_down_prep(unsigned int cpu)
>  {
> -	unsigned cpu = (long)hcpu;
>  	const struct cpumask *cpumask;
>  
>  	cpumask = get_cpu_mask(cpu);
>  
>  	/*
>  	 * Clear the boost-disable bit on the CPU_DOWN path so that
> -	 * this cpu cannot block the remaining ones from boosting. On
> -	 * the CPU_UP path we simply keep the boost-disable flag in
> -	 * sync with the current global state.
> +	 * this cpu cannot block the remaining ones from boosting.
>  	 */
> -
> -	switch (action) {
> -	case CPU_DOWN_FAILED:
> -	case CPU_DOWN_FAILED_FROZEN:
> -	case CPU_ONLINE:
> -	case CPU_ONLINE_FROZEN:
> -		boost_set_msrs(acpi_cpufreq_driver.boost_enabled, cpumask);
> -		break;
> -
> -	case CPU_DOWN_PREPARE:
> -	case CPU_DOWN_PREPARE_FROZEN:
> -		boost_set_msrs(1, cpumask);
> -		break;
> -
> -	default:
> -		break;
> -	}
> -
> -	return NOTIFY_OK;
> +	boost_set_msrs(1, cpumask);
> +	return 0;
>  }
>  
> -
> -static struct notifier_block boost_nb = {
> -	.notifier_call          = boost_notify,
> -};
> -
>  /*
>   * acpi_cpufreq_early_init - initialize ACPI P-States library
>   *
> @@ -922,37 +909,47 @@ static struct cpufreq_driver acpi_cpufreq_driver = {
>  	.attr		= acpi_cpufreq_attr,
>  };
>  
> +static enum cpuhp_state acpi_cpufreq_online;
> +
>  static void __init acpi_cpufreq_boost_init(void)
>  {
> -	if (boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA)) {
> -		msrs = msrs_alloc();
> +	int ret;
>  
> -		if (!msrs)
> -			return;
> +	if (!(boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA)))
> +		return;
>  
> -		acpi_cpufreq_driver.set_boost = set_boost;
> -		acpi_cpufreq_driver.boost_enabled = boost_state(0);
> +	msrs = msrs_alloc();
>  
> -		cpu_notifier_register_begin();
> +	if (!msrs)
> +		return;
>  
> -		/* Force all MSRs to the same value */
> -		boost_set_msrs(acpi_cpufreq_driver.boost_enabled,
> -			       cpu_online_mask);

Why isn't this required anymore ?

> +	acpi_cpufreq_driver.set_boost = set_boost;
> +	acpi_cpufreq_driver.boost_enabled = boost_state(0);
>  
> -		__register_cpu_notifier(&boost_nb);
> -
> -		cpu_notifier_register_done();
> +	/*
> +	 * This calls the online callback on all online cpu and forces all
> +	 * MSRs to the same value.
> +	 */
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "cpufreq/acpi:online",
> +				cpufreq_boost_online, cpufreq_boost_down_prep);
> +	if (ret < 0) {
> +		pr_err("acpi_cpufreq: failed to register hotplug callbacks\n");
> +		msrs_free(msrs);

If 'msrs = NULL' is required to be done in the _exit() routine, then it should
be done here as well. Right?

> +		return;
>  	}
> +	acpi_cpufreq_online = ret;
>  }
>  
>  static void acpi_cpufreq_boost_exit(void)
>  {
> -	if (msrs) {
> -		unregister_cpu_notifier(&boost_nb);
> +	if (!msrs)
> +		return;
>  
> -		msrs_free(msrs);
> -		msrs = NULL;
> -	}
> +	if (acpi_cpufreq_online >= 0)
> +		cpuhp_remove_state_nocalls(acpi_cpufreq_online);
> +
> +	msrs_free(msrs);
> +	msrs = NULL;
>  }
>  
>  static int __init acpi_cpufreq_init(void)
> -- 
> 2.10.2

-- 
viresh
