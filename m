From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 3/3] PM / OPP: Parse 'opp-<prop>-<name>' bindings
Date: Wed, 18 Nov 2015 17:12:41 -0800
Message-ID: <20151119011241.GK32672@codeaurora.org>
References: <cover.1447669859.git.viresh.kumar@linaro.org>
 <c90cf734ae1cc009601a69cdcc744d412c7b9cfa.1447669859.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46990 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbbKSBMn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 20:12:43 -0500
Content-Disposition: inline
In-Reply-To: <c90cf734ae1cc009601a69cdcc744d412c7b9cfa.1447669859.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, nm@ti.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Shawn Guo <shawnguo@kernel.org>

On 11/16, Viresh Kumar wrote:
> @@ -794,20 +806,32 @@ static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
>  }
>  
>  /* TODO: Support multiple regulators */
> -static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
> +static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
> +			      struct device_opp *dev_opp)
>  {
>  	u32 microvolt[3] = {0};
>  	u32 val;
>  	int count, ret;
> +	struct property *prop;
> +	char name[NAME_MAX];
>  
> -	/* Missing property isn't a problem, but an invalid entry is */
> -	if (!of_find_property(opp->np, "opp-microvolt", NULL))
> -		return 0;
> +	/* Search for both "opp-microvolt-<name>" and "opp-microvolt" */
> +	_opp_create_prop_name(name, "opp-microvolt", dev_opp->prop_name);
>  
> -	count = of_property_count_u32_elems(opp->np, "opp-microvolt");
> +	prop = of_find_property(opp->np, name, NULL);
> +	if (!prop) {
> +		_opp_create_prop_name(name, "opp-microvolt", NULL);

Why not just NUL terminate the string after the t in microvolt
that's already there?

> +		prop = of_find_property(opp->np, name, NULL);
> +
> +		/* Missing property isn't a problem, but an invalid entry is */
> +		if (!prop)
> +			return 0;
> +	}
> +
> +	count = of_property_count_u32_elems(opp->np, name);
>  	if (count < 0) {
> -		dev_err(dev, "%s: Invalid opp-microvolt property (%d)\n",
> -			__func__, count);
> +		dev_err(dev, "%s: Invalid %s property (%d)\n",
> +			__func__, name, count);
>  		return count;
>  	}
>  
> @@ -830,7 +852,15 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
>  	opp->u_volt_min = microvolt[1];
>  	opp->u_volt_max = microvolt[2];
>  
> -	if (!of_property_read_u32(opp->np, "opp-microamp", &val))
> +	/* Search for both "opp-microamp-<name>" and "opp-microamp" */
> +	_opp_create_prop_name(name, "opp-microamp", dev_opp->prop_name);
> +	prop = of_find_property(opp->np, name, NULL);
> +	if (!prop) {
> +		_opp_create_prop_name(name, "opp-microamp", NULL);

Same comment here.

> +		prop = of_find_property(opp->np, name, NULL);
> +	}
> +
> +	if (prop && !of_property_read_u32(opp->np, "opp-microamp", &val))
>  		opp->u_amp = val;
>  
>  	return 0;
> @@ -935,6 +965,98 @@ void dev_pm_opp_put_supported_hw(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_put_supported_hw);
>  
> +/**
> + * dev_pm_opp_set_prop_name() - Set prop-extn name
> + * @dev: Device for which the regulator has to be set.
> + * @name: name to postfix to properties.
> + *
> + * This is required only for the V2 bindings, and it enables a platform to
> + * specify the extn to be used for certain property names. The properties to
> + * which the extension will apply are opp-microvolt and opp-microamp. OPP core
> + * should postfix the property name with -<name> while looking for them.
> + */
> +int dev_pm_opp_set_prop_name(struct device *dev, const char *name)
> +{
> +	struct device_opp *dev_opp;
> +	int ret = 0;
> +
> +	if (!dev || !name) {
> +		pr_err("%s: Invalid arguments, dev:0x%p, name:%p\n", __func__,
> +		       dev, name);
> +		return -EINVAL;

Same defensive programming and printing NULL comments from patch
2 apply here.

> +	}
> +
> +	/* Operations on OPP structures must be done from within rcu locks */
> +	rcu_read_lock();
> +
> +	dev_opp = _add_device_opp(dev);
> +	if (!dev_opp)

goto unlock?

> +		return -ENOMEM;
> +
> +	/* Do we already have a prop-name associated with dev_opp? */
> +	if (dev_opp->prop_name) {
> +		dev_err(dev, "%s: Already have prop-name %s\n", __func__,
> +			dev_opp->prop_name);
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	dev_opp->prop_name = kstrdup(name, GFP_KERNEL);

I'm very confused now on the whole locking scheme. How can we be
modifying the dev_opp under an rcu_read_lock? Don't we need to
hold a stronger lock than a read lock because _add_device_opp()
has already published the structure we're modifying here?

> +	if (!dev_opp->prop_name) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +unlock:
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_set_prop_name);
> +
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index d12471ed14a2..eec973130951 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -141,6 +143,13 @@ static inline int dev_pm_opp_set_supported_hw(struct device *dev, u32 *versions,
>  
>  static inline void dev_pm_opp_put_supported_hw(struct device *dev) {}
>  
> +static inline int dev_pm_opp_set_prop_name(struct device *dev, const char *name)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline void dev_pm_opp_put_prop_name(struct device *dev) {}

How is cpufreq-dt going to be changed to support this? I wonder
if it would be better to hide these sorts of things behind a
wrapper on top of the guts of dev_pm_opp_of_add_table(). That way
the lifetime of the prop_name and hw_versions are contained to
the same lifetime rules as the device's OPP table. Right now it
seems like we're asking OPP initializers to call two or three
functions in the right order to get the table initialized
properly, which is not as easy as calling one function.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
