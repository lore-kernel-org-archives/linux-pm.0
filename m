From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 6/7][Resend] cpufreq: Support for fast frequency switching
Date: Tue, 29 Mar 2016 14:31:29 +0200
Message-ID: <4593467.njUdrHldHe@vostro.rjw.lan>
References: <7262976.zPkLj56ATU@vostro.rjw.lan> <25154681.B5BGJ94JlQ@vostro.rjw.lan> <20160328062751.GI32495@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160328062751.GI32495@vireshk-i7>
Sender: linux-acpi-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, March 28, 2016 11:57:51 AM Viresh Kumar wrote:
> Sorry for jumping in late, was busy with other stuff and travel :(
> 

[cut]

> > +static void cpufreq_list_transition_notifiers(void)
> > +{
> > +	struct notifier_block *nb;
> > +
> > +	pr_info("cpufreq: Registered transition notifiers:\n");
> > +
> > +	mutex_lock(&cpufreq_transition_notifier_list.mutex);
> > +
> > +	for (nb = cpufreq_transition_notifier_list.head; nb; nb = nb->next)
> > +		pr_info("cpufreq: %pF\n", nb->notifier_call);
> > +
> > +	mutex_unlock(&cpufreq_transition_notifier_list.mutex);
> 
> This will get printed as:
> 
> cpufreq: cpufreq: Registered transition notifiers:
> cpufreq: cpufreq: <func>+0x0/0x<address>
> cpufreq: cpufreq: <func>+0x0/0x<address>
> cpufreq: cpufreq: <func>+0x0/0x<address>
> 
> Maybe we want something like:
> cpufreq: Registered transition notifiers:
>   cpufreq: <func>+0x0/0x<address>
>   cpufreq: <func>+0x0/0x<address>
>   cpufreq: <func>+0x0/0x<address>
> 
> ?

You seem to be saying that pr_fmt() already has "cpufreq: " in it.  Fair enough.

> > +}
> > +
> > +/**
> > + * cpufreq_enable_fast_switch - Enable fast frequency switching for policy.
> > + * @policy: cpufreq policy to enable fast frequency switching for.
> > + *
> > + * Try to enable fast frequency switching for @policy.
> > + *
> > + * The attempt will fail if there is at least one transition notifier registered
> > + * at this point, as fast frequency switching is quite fundamentally at odds
> > + * with transition notifiers.  Thus if successful, it will make registration of
> > + * transition notifiers fail going forward.
> > + */
> > +void cpufreq_enable_fast_switch(struct cpufreq_policy *policy)
> > +{
> > +	lockdep_assert_held(&policy->rwsem);
> > +
> > +	if (!policy->fast_switch_possible)
> > +		return;
> > +
> > +	mutex_lock(&cpufreq_fast_switch_lock);
> > +	if (cpufreq_fast_switch_count >= 0) {
> > +		cpufreq_fast_switch_count++;
> > +		policy->fast_switch_enabled = true;
> > +	} else {
> > +		pr_warn("cpufreq: CPU%u: Fast frequency switching not enabled\n",
> > +			policy->cpu);
> > +		cpufreq_list_transition_notifiers();
> > +	}
> > +	mutex_unlock(&cpufreq_fast_switch_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(cpufreq_enable_fast_switch);
> 
> And, why don't we have support for disabling fast-switch support? What if we
> switch to schedutil governor (from userspace) and then back to ondemand? We
> don't call policy->exit for that.

Disabling fast switch can be automatic depending on whether or not
fast_switch_enabled is set, but I clearly forgot about the manual governor
switch case.

It should be fine to do it before calling cpufreq_governor(_EXIT) then.


> >  /*********************************************************************
> >   *                          SYSFS INTERFACE                          *
> > @@ -1083,6 +1134,24 @@ static void cpufreq_policy_free(struct c
> >  	kfree(policy);
> >  }
> >  
> > +static void cpufreq_driver_exit_policy(struct cpufreq_policy *policy)
> > +{
> > +	if (policy->fast_switch_enabled) {
> 
> Shouldn't this be accessed from within lock as well ?
> 
> > +		mutex_lock(&cpufreq_fast_switch_lock);
> > +
> > +		policy->fast_switch_enabled = false;
> > +		if (!WARN_ON(cpufreq_fast_switch_count <= 0))
> > +			cpufreq_fast_switch_count--;
> 
> Shouldn't we make it more efficient and write it as:
> 
> 		WARN_ON(cpufreq_fast_switch_count <= 0);
> 		policy->fast_switch_enabled = false;
>                 cpufreq_fast_switch_count--;
> 
> The WARN check will hold true only for a major bug somewhere in the core and we
> shall *never* hit it.

The point here is to avoid the decrementation if the WARN_ON() triggers too.

> > +		mutex_unlock(&cpufreq_fast_switch_lock);
> > +	}
> > +
> > +	if (cpufreq_driver->exit) {
> > +		cpufreq_driver->exit(policy);
> > +		policy->freq_table = NULL;
> > +	}
> > +}
> > +
> >  static int cpufreq_online(unsigned int cpu)
> >  {
> >  	struct cpufreq_policy *policy;
> > @@ -1236,8 +1305,7 @@ static int cpufreq_online(unsigned int c
> >  out_exit_policy:
> >  	up_write(&policy->rwsem);
> >  
> > -	if (cpufreq_driver->exit)
> > -		cpufreq_driver->exit(policy);
> > +	cpufreq_driver_exit_policy(policy);
> >  out_free_policy:
> >  	cpufreq_policy_free(policy, !new_policy);
> >  	return ret;
> > @@ -1334,10 +1402,7 @@ static void cpufreq_offline(unsigned int
> >  	 * since this is a core component, and is essential for the
> >  	 * subsequent light-weight ->init() to succeed.
> >  	 */
> > -	if (cpufreq_driver->exit) {
> > -		cpufreq_driver->exit(policy);
> > -		policy->freq_table = NULL;
> > -	}
> > +	cpufreq_driver_exit_policy(policy);
> >  
> >  unlock:
> >  	up_write(&policy->rwsem);
> > @@ -1452,8 +1517,12 @@ static unsigned int __cpufreq_get(struct
> >  
> >  	ret_freq = cpufreq_driver->get(policy->cpu);
> >  
> > -	/* Updating inactive policies is invalid, so avoid doing that. */
> > -	if (unlikely(policy_is_inactive(policy)))
> > +	/*
> > +	 * Updating inactive policies is invalid, so avoid doing that.  Also
> > +	 * if fast frequency switching is used with the given policy, the check
> > +	 * against policy->cur is pointless, so skip it in that case too.
> > +	 */
> > +	if (unlikely(policy_is_inactive(policy)) || policy->fast_switch_enabled)
> >  		return ret_freq;
> >  
> >  	if (ret_freq && policy->cur &&
> > @@ -1465,7 +1534,6 @@ static unsigned int __cpufreq_get(struct
> >  			schedule_work(&policy->update);
> >  		}
> >  	}
> > -
> 
> Unrelated change ? And to me it looks better with the blank line ..

Yes, it is unrelated.

> >  	return ret_freq;
> >  }
> >  
> > @@ -1672,8 +1740,18 @@ int cpufreq_register_notifier(struct not
> >  
> >  	switch (list) {
> >  	case CPUFREQ_TRANSITION_NOTIFIER:
> > +		mutex_lock(&cpufreq_fast_switch_lock);
> > +
> > +		if (cpufreq_fast_switch_count > 0) {
> > +			mutex_unlock(&cpufreq_fast_switch_lock);
> > +			return -EBUSY;
> > +		}
> >  		ret = srcu_notifier_chain_register(
> >  				&cpufreq_transition_notifier_list, nb);
> > +		if (!ret)
> > +			cpufreq_fast_switch_count--;
> > +
> > +		mutex_unlock(&cpufreq_fast_switch_lock);
> >  		break;
> >  	case CPUFREQ_POLICY_NOTIFIER:
> >  		ret = blocking_notifier_chain_register(
> > @@ -1706,8 +1784,14 @@ int cpufreq_unregister_notifier(struct n
> >  
> >  	switch (list) {
> >  	case CPUFREQ_TRANSITION_NOTIFIER:
> > +		mutex_lock(&cpufreq_fast_switch_lock);
> > +
> >  		ret = srcu_notifier_chain_unregister(
> >  				&cpufreq_transition_notifier_list, nb);
> > +		if (!ret && !WARN_ON(cpufreq_fast_switch_count >= 0))
> > +			cpufreq_fast_switch_count++;
> 
> Again here, why shouldn't we write it as:

And same here again, I don't want the incrementation to happen if the WARN_ON()
triggers.

Thanks,
Rafael

