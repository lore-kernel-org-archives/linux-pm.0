From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Update][PATCH v7 7/7] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Wed, 30 Mar 2016 11:00:11 +0530
Message-ID: <20160330053011.GF8773@vireshk-i7>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <6666532.7ULg06hQ7e@vostro.rjw.lan>
 <145931680.Kk1xSBT0Ro@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <145931680.Kk1xSBT0Ro@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 30-03-16, 04:00, Rafael J. Wysocki wrote:
> +static int sugov_init(struct cpufreq_policy *policy)
> +{
> +	struct sugov_policy *sg_policy;
> +	struct sugov_tunables *tunables;
> +	unsigned int lat;
> +	int ret = 0;
> +
> +	/* State should be equivalent to EXIT */
> +	if (policy->governor_data)
> +		return -EBUSY;
> +
> +	sg_policy = sugov_policy_alloc(policy);
> +	if (!sg_policy)
> +		return -ENOMEM;
> +
> +	mutex_lock(&global_tunables_lock);
> +
> +	if (global_tunables) {
> +		if (WARN_ON(have_governor_per_policy())) {
> +			ret = -EINVAL;
> +			goto free_sg_policy;
> +		}
> +		policy->governor_data = sg_policy;
> +		sg_policy->tunables = global_tunables;
> +
> +		gov_attr_set_get(&global_tunables->attr_set, &sg_policy->tunables_hook);
> +		goto out;
> +	}
> +
> +	tunables = sugov_tunables_alloc(sg_policy);
> +	if (!tunables) {
> +		ret = -ENOMEM;
> +		goto free_sg_policy;
> +	}
> +
> +	tunables->rate_limit_us = LATENCY_MULTIPLIER;
> +	lat = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
> +	if (lat)
> +		tunables->rate_limit_us *= lat;
> +
> +	policy->governor_data = sg_policy;
> +	sg_policy->tunables = tunables;
> +
> +	ret = kobject_init_and_add(&tunables->attr_set.kobj, &sugov_tunables_ktype,
> +				   get_governor_parent_kobj(policy), "%s",
> +				   schedutil_gov.name);
> +	if (ret)
> +		goto fail;
> +
> + out:
> +	mutex_unlock(&global_tunables_lock);
> +
> +	cpufreq_enable_fast_switch(policy);
> +	return 0;
> +
> + fail:
> +	policy->governor_data = NULL;
> +	sugov_tunables_free(tunables);
> +
> + free_sg_policy:
> +	mutex_unlock(&global_tunables_lock);
> +
> +	sugov_policy_free(sg_policy);
> +	pr_err("cpufreq: schedutil governor initialization failed (error %d)\n", ret);
> +	return ret;
> +}

The current version of this looks good to me and takes care of all the issues I
raised earlier. Thanks.

> +static int sugov_limits(struct cpufreq_policy *policy)
> +{
> +	struct sugov_policy *sg_policy = policy->governor_data;
> +
> +	if (!policy->fast_switch_enabled) {
> +		mutex_lock(&sg_policy->work_lock);
> +
> +		if (policy->max < policy->cur)
> +			__cpufreq_driver_target(policy, policy->max,
> +						CPUFREQ_RELATION_H);
> +		else if (policy->min > policy->cur)
> +			__cpufreq_driver_target(policy, policy->min,
> +						CPUFREQ_RELATION_L);
> +
> +		mutex_unlock(&sg_policy->work_lock);
> +	}
> +
> +	sg_policy->need_freq_update = true;

I am wondering why we need to do this for !fast_switch_enabled case?

> +	return 0;
> +}

Apart from that:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
