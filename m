From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH RFC 6/9] OPP: Add and export helper to update voltage
Date: Wed, 10 Apr 2019 15:54:29 +0530
Message-ID: <20190410102429.r6j6brm5kspmqxc3@vireshk-i7>
References: <20190328152822.532-1-sibis@codeaurora.org>
 <20190328152822.532-7-sibis@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190328152822.532-7-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sibi Sankar <sibis@codeaurora.org>
Cc: robh+dt@kernel.org, andy.gross@linaro.org, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org, georgi.djakov@linaro.org, bjorn.andersson@linaro.org, david.brown@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org, rnayak@codeaurora.org, cw00.choi@samsung.com, linux-pm@vger.kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org, dianders@chromium.org
List-Id: linux-pm@vger.kernel.org

On 28-03-19, 20:58, Sibi Sankar wrote:
> Add and export 'dev_pm_opp_update_voltage' to find and update voltage
> of an opp for a given frequency. This will be useful to update the opps
> with voltages read back from firmware.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/opp/core.c     | 62 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h | 10 +++++++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index addaf7aae9ae..c066cd120a33 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2090,6 +2090,68 @@ int dev_pm_opp_disable(struct device *dev, unsigned long freq)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_disable);
>  
> +static int _opp_update_voltage(struct device *dev, unsigned long freq,
> +			       unsigned long u_volt)
> +{
> +	struct opp_table *opp_table;
> +	struct dev_pm_opp *tmp_opp, *opp = ERR_PTR(-ENODEV);
> +	int r = 0;

s/r/ret/

> +
> +	/* Find the opp_table */
> +	opp_table = _find_opp_table(dev);
> +	if (IS_ERR(opp_table)) {
> +		r = PTR_ERR(opp_table);
> +		dev_warn(dev, "%s: Device OPP not found (%d)\n", __func__, r);

Why dev_warn instead of dev_err which is normally used in this file ? And you
weren't searching for OPP but opp_table. Put out the correct error message
please.

> +		return r;
> +	}
> +
> +	mutex_lock(&opp_table->lock);
> +
> +	/* Do we have the frequency? */
> +	list_for_each_entry(tmp_opp, &opp_table->opp_list, node) {
> +		if (tmp_opp->rate == freq) {
> +			opp = tmp_opp;
> +			break;
> +		}
> +	}
> +
> +	if (IS_ERR(opp)) {
> +		r = PTR_ERR(opp);
> +		goto unlock;
> +	}
> +
> +	/* update only if the opp is disabled */
> +	if (opp->available)
> +		goto unlock;
> +

What about reusing dev_pm_opp_find_freq_exact() instead of the above code in
this routine ?

> +	opp->supplies[0].u_volt = u_volt;
> +
> +unlock:
> +	mutex_unlock(&opp_table->lock);
> +	dev_pm_opp_put_opp_table(opp_table);
> +	return r;
> +}
> +
> +/**
> + * dev_pm_opp_update_voltage() - find and update voltage of an opp
> + *				 for a given frequency
> + * @dev:	device for which we do this operation
> + * @freq:	OPP frequency to update voltage
> + * @u_volt:	voltage requested for this opp
> + *
> + * This is useful only for devices with single power supply.
> + *
> + * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
> + * copy operation, returns 0 if no modification was done OR modification was
> + * successful.
> + */
> +int dev_pm_opp_update_voltage(struct device *dev, unsigned long freq,
> +			      unsigned long u_volt)
> +{
> +	return _opp_update_voltage(dev, freq, u_volt);

Remove the unnecessary wrapper and open code this routine here. While at it, you
should updated min/max/target and not just target voltage.

> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_update_voltage);
> +
>  /**
>   * dev_pm_opp_register_notifier() - Register OPP notifier for the device
>   * @dev:	Device for which notifier needs to be registered
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index d7cb0e65c4f0..58490f6839ce 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -130,6 +130,9 @@ int dev_pm_opp_enable(struct device *dev, unsigned long freq);
>  
>  int dev_pm_opp_disable(struct device *dev, unsigned long freq);
>  
> +int dev_pm_opp_update_voltage(struct device *dev, unsigned long freq,
> +			      unsigned long u_volt);
> +
>  int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb);
>  int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb);
>  
> @@ -265,6 +268,13 @@ static inline int dev_pm_opp_disable(struct device *dev, unsigned long freq)
>  	return 0;
>  }
>  
> +static inline int dev_pm_opp_update_voltage(struct device *dev,
> +					    unsigned long freq,
> +					    unsigned long u_volt)
> +{
> +	return 0;
> +}
> +
>  static inline int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb)
>  {
>  	return -ENOTSUPP;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project

-- 
viresh
