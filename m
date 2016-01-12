From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 04/17] PM / OPP: Introduce
 dev_pm_opp_get_max_volt_latency()
Date: Mon, 11 Jan 2016 17:25:12 -0800
Message-ID: <20160112012512.GJ22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <08691b482198b0709fd258d310a5e6ecda2f1a18.1450777582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41382 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760AbcALBZO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 20:25:14 -0500
Content-Disposition: inline
In-Reply-To: <08691b482198b0709fd258d310a5e6ecda2f1a18.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12/22, Viresh Kumar wrote:
> @@ -230,6 +230,55 @@ unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_clock_latency);
>  
>  /**
> + * dev_pm_opp_get_max_volt_latency() - Get max voltage latency in nanoseconds
> + * @dev:	device for which we do this operation

Weird tab again.

> + *
> + * Return: This function returns the max voltage latency in nanoseconds.
> + *
> + * Locking: This function takes rcu_read_lock().
> + */
> +unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
> +{
> +	struct device_opp *dev_opp;
> +	struct dev_pm_opp *opp;
> +	struct regulator *reg;
> +	unsigned long latency_ns = 0;
> +	unsigned long min_uV = ~0, max_uV = 0;
> +	int ret;
> +
> +	rcu_read_lock();
> +
> +	dev_opp = _find_device_opp(dev);
> +	if (IS_ERR(dev_opp))
> +		goto unlock;
> +
> +	reg = dev_opp->regulator;
> +	/* Regulator may not be available for device */
> +	if (IS_ERR(reg))
> +		goto unlock;
> +
> +	list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
> +		if (!opp->available)
> +			continue;
> +
> +		if (opp->u_volt_min < min_uV)
> +			min_uV = opp->u_volt_min;
> +		if (opp->u_volt_max > max_uV)
> +			max_uV = opp->u_volt_max;
> +	}
> +
> +	ret = regulator_set_voltage_time(reg, min_uV, max_uV);

Doesn't rcu_read_lock() disable preemption sometimes? I don't
think we can call regulator ops with preemption disabled because
regulators use mutex locking. It looks like
regulator_list_voltage() may take a mutex anyway.

> +	if (ret > 0)
> +		latency_ns += ret * 1000;

Why add to 0? Perhaps this should just be an assignment?

> +
> +unlock:
> +	rcu_read_unlock();
> +
> +	return latency_ns;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_volt_latency);
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
