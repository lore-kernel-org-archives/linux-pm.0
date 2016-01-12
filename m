From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 02/17] PM / OPP: Add APIs to set regulator-name
Date: Mon, 11 Jan 2016 17:18:25 -0800
Message-ID: <20160112011825.GH22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <30510e48c64f5aef8015e7dae838780e2c2fe86d.1450777582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:40770 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759949AbcALBS3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 20:18:29 -0500
Content-Disposition: inline
In-Reply-To: <30510e48c64f5aef8015e7dae838780e2c2fe86d.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12/22, Viresh Kumar wrote:
> This is required mostly for backward compatibility of DT users. The OPP
> layer automatically gets the regulator device currently, but the name of
> the device needs to be same as that of the device. But existing DT

The name of the device needs to be the same as that of the
device? What does that mean? Perhaps this should say the name of
the regulator/supply needs to be the same as that of the device?

The same words are in the kernel doc too.

> entries may not be following that and might have used generic names
> instead. For example, they might have used 'cpu-supply' instead of
> 'cpu0-supply'.
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index 2e49f5e9daa3..76232ee04cc6 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -492,25 +492,11 @@ struct device_list_opp *_add_list_dev(const struct device *dev,
>  	return list_dev;
>  }
>  
> -/**
> - * _add_device_opp() - Find device OPP table or allocate a new one
> - * @dev:	device for which we do this operation
> - *
> - * It tries to find an existing table first, if it couldn't find one, it
> - * allocates a new OPP table and returns that.
> - *
> - * Return: valid device_opp pointer if success, else NULL.
> - */
> -static struct device_opp *_add_device_opp(struct device *dev)
> +static struct device_opp *_add_device_opp_reg(struct device *dev,
> +					      const char *name)
>  {
>  	struct device_opp *dev_opp;
>  	struct device_list_opp *list_dev;
> -	const char *name = dev_name(dev);
> -
> -	/* Check for existing list for 'dev' first */
> -	dev_opp = _find_device_opp(dev);
> -	if (!IS_ERR(dev_opp))
> -		return dev_opp;
>  
>  	/*
>  	 * Allocate a new device OPP table. In the infrequent case where a new
> @@ -542,6 +528,27 @@ static struct device_opp *_add_device_opp(struct device *dev)
>  }
>  
>  /**
> + * _add_device_opp() - Find device OPP table or allocate a new one
> + * @dev:	device for which we do this operation

Why the tab? I know copy/paste, but still.

> + *
> + * It tries to find an existing table first, if it couldn't find one, it
> + * allocates a new OPP table and returns that.
> + *
> + * Return: valid device_opp pointer if success, else NULL.
> + */
> @@ -1091,6 +1101,127 @@ void dev_pm_opp_put_prop_name(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
>  
> +/**
> + * dev_pm_opp_set_regulator() - Set regulator name for the device
> + * @dev: Device for which regulator name is being set.
> + * @name: Name of the regulator.
> + *
> + * This is required mostly for backward compatibility of DT users. The OPP layer
> + * automatically gets the regulator device currently, but the name of the device
> + * needs to be same as that of the device. But existing DT entries may not be
> + * following that and might have used generic names instead. For example, they
> + * might have used 'cpu-supply' instead of 'cpu0-supply'.

The new v2 OPP bindings are using cpu-supply instead of
cpu0-supply. This makes it sound like cpu-supply is the old style
and we've added this API to handle it, when in reality, this is
the preferred way to do this and so we've added this API because
we almost always need it.

> + *
> + * This must be called before any OPPs are initialized for the device.
> + *
> + * Locking: The internal device_opp and opp structures are RCU protected.
> + * Hence this function internally uses RCU updater strategy with mutex locks
> + * to keep the integrity of the internal data structures. Callers should ensure
> + * that this function is *NOT* called under RCU protection or in contexts where
> + * mutex cannot be locked.
> + */
> +int dev_pm_opp_set_regulator(struct device *dev, const char *name)
> +{
> +	struct device_opp *dev_opp;
> +	struct regulator *reg;
> +	int ret = 0;
> +
> +	/* Hold our list modification lock here */
> +	mutex_lock(&dev_opp_list_lock);
> +
> +	dev_opp = _find_device_opp(dev);
> +	/* We already have a dev-opp */
> +	if (!IS_ERR(dev_opp)) {
> +		/* This should be called before OPPs are initialized */
> +		if (WARN_ON(!list_empty(&dev_opp->opp_list))) {
> +			ret = -EBUSY;
> +			goto unlock;
> +		}
> +
> +		/* Already have a regulator set? Free it and re-allocate */
> +		if (!IS_ERR(dev_opp->regulator))
> +			regulator_put(dev_opp->regulator);

Is this used in practice? It seems odd that users would be using
one regulator, and then change that to another regulator later.

> +
> +		/* Allocate the regulator */
> +		reg = regulator_get_optional(dev, name);
> +		if (IS_ERR(reg)) {
> +			ret = PTR_ERR(reg);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "%s: no regulator (%s) found: %d\n",
> +					__func__, name, ret);
> +		}
> +
> +		dev_opp->regulator = reg;
> +		goto unlock;
> +	}
> +
[...]
> +
> +/**
> + * dev_pm_opp_put_regulator() - Releases resources blocked for regulator
> + * @dev: Device for which regulator was set.
> + *
> + * Locking: The internal device_opp and opp structures are RCU protected.
> + * Hence this function internally uses RCU updater strategy with mutex locks
> + * to keep the integrity of the internal data structures. Callers should ensure
> + * that this function is *NOT* called under RCU protection or in contexts where
> + * mutex cannot be locked.
> + */
> +void dev_pm_opp_put_regulator(struct device *dev)
> +{
> +	struct device_opp *dev_opp;
> +
> +	/* Hold our list modification lock here */

Yeah, that's obvious from the code.

> +	mutex_lock(&dev_opp_list_lock);
> +
> +	/* Check for existing list for 'dev' first */
> +	dev_opp = _find_device_opp(dev);
> +	if (IS_ERR(dev_opp)) {
> +		dev_err(dev, "Failed to find dev_opp: %ld\n", PTR_ERR(dev_opp));
> +		goto unlock;
> +	}
> +
> +	/* Make sure there are no concurrent readers while updating dev_opp */
> +	WARN_ON(!list_empty(&dev_opp->opp_list));
> +
> +	if (!dev_opp->regulator_set) {
> +		dev_err(dev, "%s: Doesn't have regulator set\n", __func__);
> +		goto unlock;
> +	}
> +
> +	dev_opp->regulator_set = false;
> +
> +	/* Try freeing device_opp if this was the last blocking resource */
> +	_remove_device_opp(dev_opp);

It looks like this whole function exists to set the boolean to
false so that _remove_device_opp() can continue. What's the point
of that? From what I can tell all we're getting is symmetry in
the API by having this function, so why have this function at
all?


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
