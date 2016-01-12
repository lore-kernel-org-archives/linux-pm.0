From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 08/17] PM / OPP: Add dev_pm_opp_set_rate()
Date: Mon, 11 Jan 2016 17:40:10 -0800
Message-ID: <20160112014010.GM22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <5824076a64ad4215cfc63c238e8b8947bc996e87.1450777582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42104 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932404AbcALBkN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 20:40:13 -0500
Content-Disposition: inline
In-Reply-To: <5824076a64ad4215cfc63c238e8b8947bc996e87.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12/22, Viresh Kumar wrote:
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index 1d1b0faa825d..c76818f69f14 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -517,6 +517,148 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
>  
> +/*
> + * _set_opp_voltage() - Configure device supply for an OPP
> + * @dev:	device for which we do this operation
> + * @dev_opp:	dev_opp for the device
> + * @opp:	opp for getting supply voltage levels
> + *
> + * This is used to configure the power supply, used by the device, to the
> + * voltage levels specified by a particular OPP.
> + */
> +static int _set_opp_voltage(struct device *dev, struct device_opp *dev_opp,
> +			    struct dev_pm_opp *opp)
> +{
> +	struct regulator *reg = dev_opp->regulator;
> +	int ret;
> +
> +	/* Regulator not be available for device */
> +	if (IS_ERR(reg)) {
> +		dev_dbg(dev, "%s: regulator not available: %ld\n", __func__,
> +			PTR_ERR(reg));
> +		return 0;
> +	}
> +
> +	dev_dbg(dev, "%s: voltages (mV): %lu %lu %lu\n", __func__,
> +		opp->u_volt_min, opp->u_volt, opp->u_volt_max);
> +
> +	ret = regulator_set_voltage_triplet(reg, opp->u_volt_min, opp->u_volt,

This can't be called under an RCU read lock.

> +					    opp->u_volt_max);
> +	if (ret)
> +		dev_err(dev, "%s: failed to set voltage (%lu %lu %lu mV): %d\n",
> +			__func__, opp->u_volt_min, opp->u_volt, opp->u_volt_max,
> +			ret);
> +
> +	return ret;
> +}
> +
> +/**
> + * dev_pm_opp_set_rate() - Configure new OPP based on frequency
> + * @dev:	 device for which we do this operation
> + * @target_freq: frequency to achieve
> + *
> + * This configures the power-supplies and clock source to the levels specified
> + * by the OPP corresponding to the target_freq. It takes all necessary locks
> + * required for the operation and the caller doesn't need to care about the rcu
> + * locks.
> + */
> +int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
> +{
> +	struct device_opp *dev_opp;
> +	struct dev_pm_opp *old_opp, *opp;
> +	struct clk *clk;
> +	unsigned long freq, old_freq;
> +	int ret;
> +
> +	if (unlikely(!target_freq)) {
> +		dev_err(dev, "%s: Invalid target frequemncy %lu\n", __func__,

s/frequemncy/frequency/

> +			target_freq);
> +		return -EINVAL;
> +	}
> +
> +	rcu_read_lock();

This lock is held way too long.

> +
> +	dev_opp = _find_device_opp(dev);
> +	if (IS_ERR(dev_opp)) {
> +		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
> +		ret = PTR_ERR(dev_opp);
> +		goto unlock;
> +	}
> +
> +	clk = dev_opp->clk;
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "%s: No clock available for the device\n",
> +			__func__);
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	freq = clk_round_rate(clk, target_freq);

This can't be called under RCU.

> +	if ((long)freq <= 0)
> +		freq = target_freq;
> +
> +	old_freq = clk_get_rate(clk);

Same for this.

> +
> +	/* Return early if nothing to do */
> +	if (old_freq == freq) {
> +		dev_dbg(dev, "%s: old/new frequencies (%lu Hz) are same, nothing to do\n",
> +			__func__, freq);
> +		ret = 0;
> +		goto unlock;
> +	}
> +
> +	old_opp = dev_pm_opp_find_freq_ceil(dev, &old_freq);
> +	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
> +
> +	if (IS_ERR(opp)) {
> +		ret = PTR_ERR(opp);
> +		dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
> +			__func__, freq, ret);
> +		goto unlock;
> +	}
> +
> +	/* Scaling up? Scale voltage before frequency */
> +	if (freq > old_freq) {
> +		ret = _set_opp_voltage(dev, dev_opp, opp);
> +		if (ret)
> +			goto restore_voltage;
> +	}
> +
> +	/* Change frequency */
> +
> +	dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n",
> +		__func__, old_freq, freq);
> +
> +	ret = clk_set_rate(clk, freq);

And same for this.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
