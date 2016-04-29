From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/2] PM / OPP: add non-OF versions of
 dev_pm_opp_{cpumask_,}remove_table
Date: Fri, 29 Apr 2016 09:37:21 +0530
Message-ID: <20160429040721.GV2915@vireshk-i7>
References: <1461839114-29857-1-git-send-email-sudeep.holla@arm.com>
 <1461863237-12928-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461863237-12928-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 28-04-16, 18:07, Sudeep Holla wrote:
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index 433b60092972..e59b9e7c31ba 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -1845,13 +1845,14 @@ struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
>  
> -#ifdef CONFIG_OF
>  /**
> - * dev_pm_opp_of_remove_table() - Free OPP table entries created from static DT
> - *				  entries
> + * _dev_pm_opp_remove_table() - Free OPP table entries

This is an internal routine and doesn't really require a doc-style comment at
all. Please remove it. You can add a simple comment for things you want to
mention though.

>   * @dev:	device pointer used to lookup OPP table.
> + * @remove_dyn:	specify whether to remove only OPPs created using
> + *              static entries from DT or even the dynamically add OPPs.
>   *
> - * Free OPPs created using static entries present in DT.
> + * Free OPPs either created using static entries present in DT or even the
> + * dynamically added entries based on @remove_dyn param.
>   *
>   * Locking: The internal opp_table and opp structures are RCU protected.
>   * Hence this function indirectly uses RCU updater strategy with mutex locks
> @@ -1859,7 +1860,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
>   * that this function is *NOT* called under RCU protection or in contexts where
>   * mutex cannot be locked.
>   */
> -void dev_pm_opp_of_remove_table(struct device *dev)
> +static void _dev_pm_opp_remove_table(struct device *dev, bool remove_dyn)

Maybe s/remove_dyn/remove_all ..

>  {
>  	struct opp_table *opp_table;
>  	struct dev_pm_opp *opp, *tmp;
> @@ -1884,7 +1885,7 @@ void dev_pm_opp_of_remove_table(struct device *dev)
>  	if (list_is_singular(&opp_table->dev_list)) {
>  		/* Free static OPPs */
>  		list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
> -			if (!opp->dynamic)
> +			if (!opp->dynamic || (opp->dynamic && remove_dyn))

Well, that's a funny one :)

The second conditional statement doesn't require opp->dynamic, as that is
guaranteed to be true, as the first condition failed.

So this should be:

if (remove_all || !opp->dynamic)

>  				_opp_remove(opp_table, opp, true);
>  		}
>  	} else {
> @@ -1894,6 +1895,44 @@ void dev_pm_opp_of_remove_table(struct device *dev)
>  unlock:
>  	mutex_unlock(&opp_table_lock);
>  }
> +
> +/**
> + * dev_pm_opp_of_remove_table() - Free OPP table entries created from static DT

No, this isn't the OF specific function.

> + *				  entries
> + * @dev:	device pointer used to lookup OPP table.
> + *
> + * Free all OPPs associated with the device

Full stop at the end.

> + *
> + * Locking: The internal opp_table and opp structures are RCU protected.
> + * Hence this function indirectly uses RCU updater strategy with mutex locks
> + * to keep the integrity of the internal data structures. Callers should ensure
> + * that this function is *NOT* called under RCU protection or in contexts where
> + * mutex cannot be locked.
> + */
> +void dev_pm_opp_remove_table(struct device *dev)
> +{
> +	_dev_pm_opp_remove_table(dev, true);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_remove_table);
> +
> +#ifdef CONFIG_OF
> +/**
> + * dev_pm_opp_of_remove_table() - Free OPP table entries created from static DT
> + *				  entries
> + * @dev:	device pointer used to lookup OPP table.
> + *
> + * Free OPPs created using static entries present in DT.
> + *
> + * Locking: The internal opp_table and opp structures are RCU protected.
> + * Hence this function indirectly uses RCU updater strategy with mutex locks
> + * to keep the integrity of the internal data structures. Callers should ensure
> + * that this function is *NOT* called under RCU protection or in contexts where
> + * mutex cannot be locked.
> + */
> +void dev_pm_opp_of_remove_table(struct device *dev)
> +{
> +	_dev_pm_opp_remove_table(dev, false);
> +}
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
>  
>  /* Returns opp descriptor node for a device, caller must do of_node_put() */
> diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
> index 55cbf9bd8707..9df4ad809c26 100644
> --- a/drivers/base/power/opp/cpu.c
> +++ b/drivers/base/power/opp/cpu.c
> @@ -119,12 +119,54 @@ void dev_pm_opp_free_cpufreq_table(struct device *dev,
>  EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
>  #endif	/* CONFIG_CPU_FREQ */
>  
> +static void _dev_pm_opp_cpumask_remove_table(cpumask_var_t cpumask, bool of)
> +{
> +	struct device *cpu_dev;
> +	int cpu;
> +
> +	WARN_ON(cpumask_empty(cpumask));
> +
> +	for_each_cpu(cpu, cpumask) {
> +		cpu_dev = get_cpu_device(cpu);
> +		if (!cpu_dev) {
> +			pr_err("%s: failed to get cpu%d device\n", __func__,
> +			       cpu);
> +			continue;
> +		}

Blank line here.

> +		if (of)
> +			dev_pm_opp_of_remove_table(cpu_dev);
> +		else
> +			dev_pm_opp_remove_table(cpu_dev);
> +	}
> +}
> +
> +/**
> + * dev_pm_opp_of_cpumask_remove_table() - Removes OPP table for @cpumask

of :(

> + * @cpumask:	cpumask for which OPP table needs to be removed
> + *
> + * This removes the OPP tables for CPUs present in the @cpumask.
> + * This should be used to remove all the OPPs entries associated with
> + * the cpus in @cpumask.
> + *
> + * Locking: The internal opp_table and opp structures are RCU protected.
> + * Hence this function internally uses RCU updater strategy with mutex locks
> + * to keep the integrity of the internal data structures. Callers should ensure
> + * that this function is *NOT* called under RCU protection or in contexts where
> + * mutex cannot be locked.
> + */
> +void dev_pm_opp_cpumask_remove_table(cpumask_var_t cpumask)
> +{
> +	_dev_pm_opp_cpumask_remove_table(cpumask, false);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_cpumask_remove_table);
> +
>  #ifdef CONFIG_OF
>  /**
>   * dev_pm_opp_of_cpumask_remove_table() - Removes OPP table for @cpumask
>   * @cpumask:	cpumask for which OPP table needs to be removed
>   *
>   * This removes the OPP tables for CPUs present in the @cpumask.
> + * This should be used only to remove static entries created from DT.
>   *
>   * Locking: The internal opp_table and opp structures are RCU protected.
>   * Hence this function internally uses RCU updater strategy with mutex locks
> @@ -134,21 +176,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
>   */
>  void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
>  {
> -	struct device *cpu_dev;
> -	int cpu;
> -
> -	WARN_ON(cpumask_empty(cpumask));
> -
> -	for_each_cpu(cpu, cpumask) {
> -		cpu_dev = get_cpu_device(cpu);
> -		if (!cpu_dev) {
> -			pr_err("%s: failed to get cpu%d device\n", __func__,
> -			       cpu);
> -			continue;
> -		}
> -
> -		dev_pm_opp_of_remove_table(cpu_dev);
> -	}
> +	_dev_pm_opp_cpumask_remove_table(cpumask, true);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_remove_table);
>  
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 5b6ad31403a5..5c3781a79d31 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -66,6 +66,8 @@ int dev_pm_opp_set_regulator(struct device *dev, const char *name);
>  void dev_pm_opp_put_regulator(struct device *dev);
>  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
>  int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask);
> +void dev_pm_opp_remove_table(struct device *dev);
> +void dev_pm_opp_cpumask_remove_table(cpumask_var_t cpumask);
>  #else
>  static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
>  {
> @@ -184,6 +186,14 @@ static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_va
>  	return -ENOSYS;
>  }
>  
> +static inline void dev_pm_opp_remove_table(struct device *dev)
> +{
> +}
> +
> +static inline void dev_pm_opp_cpumask_remove_table(cpumask_var_t cpumask)
> +{
> +}
> +
>  #endif		/* CONFIG_PM_OPP */
>  
>  #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
> -- 
> 1.9.1

-- 
viresh
