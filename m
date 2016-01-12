From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 04/17] PM / OPP: Introduce
 dev_pm_opp_get_max_volt_latency()
Date: Tue, 12 Jan 2016 11:45:37 -0800
Message-ID: <20160112194537.GZ22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <08691b482198b0709fd258d310a5e6ecda2f1a18.1450777582.git.viresh.kumar@linaro.org>
 <20160112012512.GJ22188@codeaurora.org>
 <20160112051058.GJ1084@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42188 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbcALTpj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 14:45:39 -0500
Content-Disposition: inline
In-Reply-To: <20160112051058.GJ1084@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 01/12, Viresh Kumar wrote:
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index 052fc6b78dc3..62976d0bd61c 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -231,8 +231,62 @@ unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_clock_latency);
>  
>  /**
> + * dev_pm_opp_get_max_volt_latency() - Get max voltage latency in nanoseconds
> + * @dev: device for which we do this operation
> + *
> + * Return: This function returns the max voltage latency in nanoseconds.
> + *
> + * Locking: This function takes rcu_read_lock().

False.

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
> +	/*
> +	 * Hold our list modification lock here as regulator_set_voltage_time()
> +	 * can possibly take another mutex, which isn't allowed within rcu
> +	 * locks.
> +	 */
> +	mutex_lock(&dev_opp_list_lock);

So now we take the list modification mutex. Why can't we
rcu_read_lock(), find the min and max voltage, and then release
the read lock and ask regulator framework for the voltage time?
>From what I can tell we're just trying to make sure that the list
is stable when iterating through it to find the min/max voltage.

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
> +	if (ret > 0)
> +		latency_ns = ret * 1000;
> +
> +unlock:
> +	mutex_unlock(&dev_opp_list_lock);
> +
> +	return latency_ns;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_volt_latency);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
