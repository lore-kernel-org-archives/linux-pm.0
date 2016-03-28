From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 6/7][Resend] cpufreq: Support for fast frequency
 switching
Date: Mon, 28 Mar 2016 11:57:51 +0530
Message-ID: <20160328062751.GI32495@vireshk-i7>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <25154681.B5BGJ94JlQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34662 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312AbcC1G14 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Mar 2016 02:27:56 -0400
Received: by mail-pa0-f51.google.com with SMTP id fe3so91059839pab.1
        for <linux-pm@vger.kernel.org>; Sun, 27 Mar 2016 23:27:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <25154681.B5BGJ94JlQ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

Sorry for jumping in late, was busy with other stuff and travel :(

On 22-03-16, 02:53, Rafael J. Wysocki wrote:
> Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
> +++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
> @@ -458,6 +458,43 @@ static int acpi_cpufreq_target(struct cp
>  	return result;
>  }
>  
> +unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
> +				      unsigned int target_freq)
> +{
> +	struct acpi_cpufreq_data *data = policy->driver_data;
> +	struct acpi_processor_performance *perf;
> +	struct cpufreq_frequency_table *entry;
> +	unsigned int next_perf_state, next_freq, freq;
> +
> +	/*
> +	 * Find the closest frequency above target_freq.
> +	 *
> +	 * The table is sorted in the reverse order with respect to the
> +	 * frequency and all of the entries are valid (see the initialization).
> +	 */
> +	entry = data->freq_table;
> +	do {
> +		entry++;
> +		freq = entry->frequency;
> +	} while (freq >= target_freq && freq != CPUFREQ_TABLE_END);
> +	entry--;
> +	next_freq = entry->frequency;
> +	next_perf_state = entry->driver_data;
> +
> +	perf = to_perf_data(data);
> +	if (perf->state == next_perf_state) {
> +		if (unlikely(data->resume))
> +			data->resume = 0;
> +		else
> +			return next_freq;
> +	}
> +
> +	data->cpu_freq_write(&perf->control_register,
> +			     perf->states[next_perf_state].control);
> +	perf->state = next_perf_state;
> +	return next_freq;
> +}
> +
>  static unsigned long
>  acpi_cpufreq_guess_freq(struct acpi_cpufreq_data *data, unsigned int cpu)
>  {
> @@ -740,6 +777,9 @@ static int acpi_cpufreq_cpu_init(struct
>  		goto err_unreg;
>  	}
>  
> +	policy->fast_switch_possible = !acpi_pstate_strict &&
> +		!(policy_is_shared(policy) && policy->shared_type != CPUFREQ_SHARED_TYPE_ANY);
> +
>  	data->freq_table = kzalloc(sizeof(*data->freq_table) *
>  		    (perf->state_count+1), GFP_KERNEL);
>  	if (!data->freq_table) {
> @@ -874,6 +914,7 @@ static struct freq_attr *acpi_cpufreq_at
>  static struct cpufreq_driver acpi_cpufreq_driver = {
>  	.verify		= cpufreq_generic_frequency_table_verify,
>  	.target_index	= acpi_cpufreq_target,
> +	.fast_switch	= acpi_cpufreq_fast_switch,
>  	.bios_limit	= acpi_processor_get_bios_limit,
>  	.init		= acpi_cpufreq_cpu_init,
>  	.exit		= acpi_cpufreq_cpu_exit,
> Index: linux-pm/include/linux/cpufreq.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpufreq.h
> +++ linux-pm/include/linux/cpufreq.h
> @@ -102,6 +102,10 @@ struct cpufreq_policy {
>  	 */
>  	struct rw_semaphore	rwsem;
>  
> +	/* Fast switch flags */
> +	bool			fast_switch_possible;	/* Set by the driver. */
> +	bool			fast_switch_enabled;
> +
>  	/* Synchronization for frequency transitions */
>  	bool			transition_ongoing; /* Tracks transition status */
>  	spinlock_t		transition_lock;
> @@ -156,6 +160,7 @@ int cpufreq_get_policy(struct cpufreq_po
>  int cpufreq_update_policy(unsigned int cpu);
>  bool have_governor_per_policy(void);
>  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
> +void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
>  #else
>  static inline unsigned int cpufreq_get(unsigned int cpu)
>  {
> @@ -236,6 +241,8 @@ struct cpufreq_driver {
>  				  unsigned int relation);	/* Deprecated */
>  	int		(*target_index)(struct cpufreq_policy *policy,
>  					unsigned int index);
> +	unsigned int	(*fast_switch)(struct cpufreq_policy *policy,
> +				       unsigned int target_freq);
>  	/*
>  	 * Only for drivers with target_index() and CPUFREQ_ASYNC_NOTIFICATION
>  	 * unset.
> @@ -464,6 +471,8 @@ struct cpufreq_governor {
>  };
>  
>  /* Pass a target to the cpufreq driver */
> +unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> +					unsigned int target_freq);
>  int cpufreq_driver_target(struct cpufreq_policy *policy,
>  				 unsigned int target_freq,
>  				 unsigned int relation);
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -428,6 +428,57 @@ void cpufreq_freq_transition_end(struct
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_freq_transition_end);
>  
> +/*
> + * Fast frequency switching status count.  Positive means "enabled", negative
> + * means "disabled" and 0 means "not decided yet".
> + */
> +static int cpufreq_fast_switch_count;
> +static DEFINE_MUTEX(cpufreq_fast_switch_lock);
> +
> +static void cpufreq_list_transition_notifiers(void)
> +{
> +	struct notifier_block *nb;
> +
> +	pr_info("cpufreq: Registered transition notifiers:\n");
> +
> +	mutex_lock(&cpufreq_transition_notifier_list.mutex);
> +
> +	for (nb = cpufreq_transition_notifier_list.head; nb; nb = nb->next)
> +		pr_info("cpufreq: %pF\n", nb->notifier_call);
> +
> +	mutex_unlock(&cpufreq_transition_notifier_list.mutex);

This will get printed as:

cpufreq: cpufreq: Registered transition notifiers:
cpufreq: cpufreq: <func>+0x0/0x<address>
cpufreq: cpufreq: <func>+0x0/0x<address>
cpufreq: cpufreq: <func>+0x0/0x<address>

Maybe we want something like:
cpufreq: Registered transition notifiers:
  cpufreq: <func>+0x0/0x<address>
  cpufreq: <func>+0x0/0x<address>
  cpufreq: <func>+0x0/0x<address>

?

> +}
> +
> +/**
> + * cpufreq_enable_fast_switch - Enable fast frequency switching for policy.
> + * @policy: cpufreq policy to enable fast frequency switching for.
> + *
> + * Try to enable fast frequency switching for @policy.
> + *
> + * The attempt will fail if there is at least one transition notifier registered
> + * at this point, as fast frequency switching is quite fundamentally at odds
> + * with transition notifiers.  Thus if successful, it will make registration of
> + * transition notifiers fail going forward.
> + */
> +void cpufreq_enable_fast_switch(struct cpufreq_policy *policy)
> +{
> +	lockdep_assert_held(&policy->rwsem);
> +
> +	if (!policy->fast_switch_possible)
> +		return;
> +
> +	mutex_lock(&cpufreq_fast_switch_lock);
> +	if (cpufreq_fast_switch_count >= 0) {
> +		cpufreq_fast_switch_count++;
> +		policy->fast_switch_enabled = true;
> +	} else {
> +		pr_warn("cpufreq: CPU%u: Fast frequency switching not enabled\n",
> +			policy->cpu);
> +		cpufreq_list_transition_notifiers();
> +	}
> +	mutex_unlock(&cpufreq_fast_switch_lock);
> +}
> +EXPORT_SYMBOL_GPL(cpufreq_enable_fast_switch);

And, why don't we have support for disabling fast-switch support? What if we
switch to schedutil governor (from userspace) and then back to ondemand? We
don't call policy->exit for that.

>  /*********************************************************************
>   *                          SYSFS INTERFACE                          *
> @@ -1083,6 +1134,24 @@ static void cpufreq_policy_free(struct c
>  	kfree(policy);
>  }
>  
> +static void cpufreq_driver_exit_policy(struct cpufreq_policy *policy)
> +{
> +	if (policy->fast_switch_enabled) {

Shouldn't this be accessed from within lock as well ?

> +		mutex_lock(&cpufreq_fast_switch_lock);
> +
> +		policy->fast_switch_enabled = false;
> +		if (!WARN_ON(cpufreq_fast_switch_count <= 0))
> +			cpufreq_fast_switch_count--;

Shouldn't we make it more efficient and write it as:

		WARN_ON(cpufreq_fast_switch_count <= 0);
		policy->fast_switch_enabled = false;
                cpufreq_fast_switch_count--;

The WARN check will hold true only for a major bug somewhere in the core and we
shall *never* hit it.

> +		mutex_unlock(&cpufreq_fast_switch_lock);
> +	}
> +
> +	if (cpufreq_driver->exit) {
> +		cpufreq_driver->exit(policy);
> +		policy->freq_table = NULL;
> +	}
> +}
> +
>  static int cpufreq_online(unsigned int cpu)
>  {
>  	struct cpufreq_policy *policy;
> @@ -1236,8 +1305,7 @@ static int cpufreq_online(unsigned int c
>  out_exit_policy:
>  	up_write(&policy->rwsem);
>  
> -	if (cpufreq_driver->exit)
> -		cpufreq_driver->exit(policy);
> +	cpufreq_driver_exit_policy(policy);
>  out_free_policy:
>  	cpufreq_policy_free(policy, !new_policy);
>  	return ret;
> @@ -1334,10 +1402,7 @@ static void cpufreq_offline(unsigned int
>  	 * since this is a core component, and is essential for the
>  	 * subsequent light-weight ->init() to succeed.
>  	 */
> -	if (cpufreq_driver->exit) {
> -		cpufreq_driver->exit(policy);
> -		policy->freq_table = NULL;
> -	}
> +	cpufreq_driver_exit_policy(policy);
>  
>  unlock:
>  	up_write(&policy->rwsem);
> @@ -1452,8 +1517,12 @@ static unsigned int __cpufreq_get(struct
>  
>  	ret_freq = cpufreq_driver->get(policy->cpu);
>  
> -	/* Updating inactive policies is invalid, so avoid doing that. */
> -	if (unlikely(policy_is_inactive(policy)))
> +	/*
> +	 * Updating inactive policies is invalid, so avoid doing that.  Also
> +	 * if fast frequency switching is used with the given policy, the check
> +	 * against policy->cur is pointless, so skip it in that case too.
> +	 */
> +	if (unlikely(policy_is_inactive(policy)) || policy->fast_switch_enabled)
>  		return ret_freq;
>  
>  	if (ret_freq && policy->cur &&
> @@ -1465,7 +1534,6 @@ static unsigned int __cpufreq_get(struct
>  			schedule_work(&policy->update);
>  		}
>  	}
> -

Unrelated change ? And to me it looks better with the blank line ..

>  	return ret_freq;
>  }
>  
> @@ -1672,8 +1740,18 @@ int cpufreq_register_notifier(struct not
>  
>  	switch (list) {
>  	case CPUFREQ_TRANSITION_NOTIFIER:
> +		mutex_lock(&cpufreq_fast_switch_lock);
> +
> +		if (cpufreq_fast_switch_count > 0) {
> +			mutex_unlock(&cpufreq_fast_switch_lock);
> +			return -EBUSY;
> +		}
>  		ret = srcu_notifier_chain_register(
>  				&cpufreq_transition_notifier_list, nb);
> +		if (!ret)
> +			cpufreq_fast_switch_count--;
> +
> +		mutex_unlock(&cpufreq_fast_switch_lock);
>  		break;
>  	case CPUFREQ_POLICY_NOTIFIER:
>  		ret = blocking_notifier_chain_register(
> @@ -1706,8 +1784,14 @@ int cpufreq_unregister_notifier(struct n
>  
>  	switch (list) {
>  	case CPUFREQ_TRANSITION_NOTIFIER:
> +		mutex_lock(&cpufreq_fast_switch_lock);
> +
>  		ret = srcu_notifier_chain_unregister(
>  				&cpufreq_transition_notifier_list, nb);
> +		if (!ret && !WARN_ON(cpufreq_fast_switch_count >= 0))
> +			cpufreq_fast_switch_count++;

Again here, why shouldn't we write it as:

		WARN_ON(cpufreq_fast_switch_count >= 0);

		if (!ret)
			cpufreq_fast_switch_count++;

> +
> +		mutex_unlock(&cpufreq_fast_switch_lock);
>  		break;
>  	case CPUFREQ_POLICY_NOTIFIER:
>  		ret = blocking_notifier_chain_unregister(
> @@ -1726,6 +1810,34 @@ EXPORT_SYMBOL(cpufreq_unregister_notifie
>   *                              GOVERNORS                            *
>   *********************************************************************/
>  
> +/**
> + * cpufreq_driver_fast_switch - Carry out a fast CPU frequency switch.
> + * @policy: cpufreq policy to switch the frequency for.
> + * @target_freq: New frequency to set (may be approximate).
> + *
> + * Carry out a fast frequency switch from interrupt context.
> + *
> + * The driver's ->fast_switch() callback invoked by this function is expected to
> + * select the minimum available frequency greater than or equal to @target_freq
> + * (CPUFREQ_RELATION_L).
> + *
> + * This function must not be called if policy->fast_switch_enabled is unset.
> + *
> + * Governors calling this function must guarantee that it will never be invoked
> + * twice in parallel for the same policy and that it will never be called in
> + * parallel with either ->target() or ->target_index() for the same policy.
> + *
> + * If CPUFREQ_ENTRY_INVALID is returned by the driver's ->fast_switch()
> + * callback to indicate an error condition, the hardware configuration must be
> + * preserved.
> + */
> +unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> +					unsigned int target_freq)
> +{
> +	return cpufreq_driver->fast_switch(policy, target_freq);
> +}
> +EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
> +
>  /* Must set freqs->new to intermediate frequency */
>  static int __target_intermediate(struct cpufreq_policy *policy,
>  				 struct cpufreq_freqs *freqs, int index)

-- 
viresh
