From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 07/16] PM / OPP: Add dev_pm_opp_set_rate()
Date: Mon, 1 Feb 2016 18:10:46 -0800
Message-ID: <20160202021046.GH4848@codeaurora.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
 <9151a47d7235855032be559372398edf809fe52b.1453965717.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43140 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbcBBCKs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2016 21:10:48 -0500
Content-Disposition: inline
In-Reply-To: <9151a47d7235855032be559372398edf809fe52b.1453965717.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>

On 01/28, Viresh Kumar wrote:
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index 7d7749ce1ce4..2672f4bfec41 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -529,6 +529,182 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
>  
> +/*
> + * The caller needs to ensure that device_opp (and hence the clk) isn't freed,
> + * while clk returned here is used.
> + */
> +static struct clk *_get_opp_clk(struct device *dev)
> +{
> +	struct device_opp *dev_opp;
> +	struct clk *clk;
> +
> +	rcu_read_lock();
> +
> +	dev_opp = _find_device_opp(dev);
> +	if (IS_ERR(dev_opp)) {
> +		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
> +		clk = (struct clk *)dev_opp;

clk = ERR_CAST(dev_opp);

> +		goto unlock;
> +	}
> +
> +	clk = dev_opp->clk;
> +	if (IS_ERR(clk))
> +		dev_err(dev, "%s: No clock available for the device\n",
> +			__func__);
> +
> +unlock:
> +	rcu_read_unlock();
> +	return clk;
> +}
> +
> +static int _set_opp_voltage(struct device *dev, struct regulator *reg,
> +			    unsigned long u_volt, unsigned long u_volt_min,
> +			    unsigned long u_volt_max)
> +{
> +	int ret;
> +
> +	/* Regulator not be available for device */

not available?

> +	if (IS_ERR(reg)) {
> +		dev_dbg(dev, "%s: regulator not available: %ld\n", __func__,
> +			PTR_ERR(reg));
> +		return 0;
> +	}
> +
> +	dev_dbg(dev, "%s: voltages (mV): %lu %lu %lu\n", __func__, u_volt_min,
> +		u_volt, u_volt_max);
> +
> +	ret = regulator_set_voltage_triplet(reg, u_volt_min, u_volt,
> +					    u_volt_max);
> +	if (ret)
> +		dev_err(dev, "%s: failed to set voltage (%lu %lu %lu mV): %d\n",
> +			__func__, u_volt_min, u_volt, u_volt_max, ret);
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
> + * by the OPP corresponding to the target_freq.
> + *
> + * Locking: This function takes rcu_read_lock().
> + */
> +int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
> +{
> +	struct device_opp *dev_opp;
> +	struct dev_pm_opp *old_opp, *opp;
> +	struct regulator *reg;
> +	struct clk *clk;
> +	unsigned long freq, old_freq;
> +	unsigned long u_volt, u_volt_min, u_volt_max;
> +	unsigned long ou_volt, ou_volt_min, ou_volt_max;
> +	int ret;
> +
> +	if (unlikely(!target_freq)) {
> +		dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
> +			target_freq);
> +		return -EINVAL;
> +	}
> +
> +	clk = _get_opp_clk(dev);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	freq = clk_round_rate(clk, target_freq);
> +	if ((long)freq <= 0)
> +		freq = target_freq;
> +
> +	old_freq = clk_get_rate(clk);
> +
> +	/* Return early if nothing to do */
> +	if (old_freq == freq) {
> +		dev_dbg(dev, "%s: old/new frequencies (%lu Hz) are same, nothing to do\n",
> +			__func__, freq);
> +		return 0;
> +	}
> +
> +	rcu_read_lock();
> +
> +	dev_opp = _find_device_opp(dev);
> +	if (IS_ERR(dev_opp)) {
> +		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
> +		ret = PTR_ERR(dev_opp);
> +		goto unlock;
> +	}
> +
> +	old_opp = dev_pm_opp_find_freq_ceil(dev, &old_freq);
> +	if (!IS_ERR(old_opp)) {
> +		ou_volt = old_opp->u_volt;
> +		ou_volt_min = old_opp->u_volt_min;
> +		ou_volt_max = old_opp->u_volt_max;
> +	} else {
> +		dev_err(dev, "%s: failed to find Current OPP for freq %lu (%ld)\n",

Why is current capitalized?

> +			__func__, old_freq, PTR_ERR(old_opp));
> +	}
> +
> +	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
> +	if (IS_ERR(opp)) {
> +		ret = PTR_ERR(opp);
> +		dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
> +			__func__, freq, ret);
> +		goto unlock;
> +	}
> +
> +	u_volt = opp->u_volt;
> +	u_volt_min = opp->u_volt_min;
> +	u_volt_max = opp->u_volt_max;
> +
> +	reg = dev_opp->regulator;
> +
> +	rcu_read_unlock();
> +
> +	/* Scaling up? Scale voltage before frequency */
> +	if (freq > old_freq) {
> +		ret = _set_opp_voltage(dev, reg, u_volt, u_volt_min,
> +				       u_volt_max);
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
> +	if (ret) {
> +		dev_err(dev, "%s: failed to set clock rate: %d\n", __func__,
> +			ret);
> +		goto restore_voltage;
> +	}
> +
> +	/* Scaling down? Scale voltage after frequency */
> +	if (freq < old_freq) {
> +		ret = _set_opp_voltage(dev, reg, u_volt, u_volt_min,
> +				       u_volt_max);
> +		if (ret)
> +			goto restore_freq;
> +	}
> +
> +	return 0;
> +
> +restore_freq:
> +	if (clk_set_rate(clk, old_freq))
> +		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
> +			__func__, old_freq);
> +restore_voltage:
> +	/* This shouldn't harm even if the voltages weren't updated earlier */
> +	if (!IS_ERR(old_opp))
> +		_set_opp_voltage(dev, reg, ou_volt, ou_volt_min, ou_volt_max);
> +unlock:
> +	rcu_read_unlock();

The error gotos above this don't have rcu lock held, so this is
sometimes wrong to do.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
