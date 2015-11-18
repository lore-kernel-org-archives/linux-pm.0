From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/3] PM / OPP: Parse 'opp-supported-hw' binding
Date: Wed, 18 Nov 2015 14:53:59 -0800
Message-ID: <20151118225358.GJ32672@codeaurora.org>
References: <cover.1447669859.git.viresh.kumar@linaro.org>
 <6d603a73028b40493b280ba7ac9c3fcb51bb2362.1447669859.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39143 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932297AbbKRWyB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 17:54:01 -0500
Content-Disposition: inline
In-Reply-To: <6d603a73028b40493b280ba7ac9c3fcb51bb2362.1447669859.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, nm@ti.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Shawn Guo <shawnguo@kernel.org>

On 11/16, Viresh Kumar wrote:
> @@ -834,6 +837,150 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev)
>  }
>  
>  /**
> + * dev_pm_opp_set_supported_hw() - Set supported platforms
> + * @dev: Device for which the regulator has to be set.
> + * @versions: Array of hierarchy of versions to match.
> + * @count: Number of elements in the array.
> + *
> + * This is required only for the V2 bindings, and it enables a platform to
> + * specify the hierarchy of versions it supports. OPP layer will then enable
> + * OPPs, which are available for those versions, based on its 'opp-supported-hw'
> + * property.
> + */
> +int dev_pm_opp_set_supported_hw(struct device *dev, u32 *versions,

versions could be const.

> +				unsigned int count)
> +{
> +	struct device_opp *dev_opp;
> +	int ret = 0;
> +
> +	if (!dev || !versions || !count) {
> +		pr_err("%s: Invalid arguments, dev:0x%p, ver:0x%p, count:%u\n",
> +		       __func__, dev, versions, count);

Weird 0x(null) prints may be here. Do we really need this check
at all though? Users should know what they're doing.

> +		return -EINVAL;
> +	}
> +
> +	/* Operations on OPP structures must be done from within rcu locks */
> +	rcu_read_lock();
> +
> +	dev_opp = _add_device_opp(dev);
> +	if (!dev_opp)
> +		return -ENOMEM;
> +
> +	/* Do we already have a version hierarchy associated with dev_opp? */
> +	if (dev_opp->supported_hw) {
> +		dev_err(dev, "%s: Already have supported hardware list\n",
> +			__func__);
> +		ret = -EINVAL;

Maybe -EBUSY is more appropriate?

> +		goto unlock;
> +	}
> +
> +	dev_opp->supported_hw = kmemdup(versions, count * sizeof(*versions),
> +					GFP_KERNEL);
> +	if (!dev_opp->supported_hw) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	dev_opp->supported_hw_count = count;
> +
> +unlock:
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_set_supported_hw);
> +
> +/**
> + * dev_pm_opp_put_supported_hw() - Releases resources blocked for supported hw
> + * @dev: Device for which the regulator has to be set.

regulator or OPP?

> + *
> + * This is required only for the V2 bindings, and is called for a matching
> + * dev_pm_opp_set_supported_hw(). Until this is called, the device_opp structure
> + * will not be freed.
> + */
> +void dev_pm_opp_put_supported_hw(struct device *dev)
> +{
> +	struct device_opp *dev_opp;
> +
> +	if (!dev) {
> +		pr_err("%s: Invalid argument dev:0x%p\n", __func__, dev);

dev is NULL.. so this prints :0x(null) all the time? And really,
who is calling this with a NULL dev? 

> +		return;
> +	}
> +
> +	/* Operations on OPP structures must be done from within rcu locks */
> +	rcu_read_lock();
> +
> +	/* Check for existing list for 'dev' first */
> +	dev_opp = _find_device_opp(dev);

Plus this checks for a NULL dev so we really don't need that
check for a NULL dev at the top at all.

> +	if (IS_ERR(dev_opp)) {
> +		dev_err(dev, "Failed to find dev_opp: %ld\n", PTR_ERR(dev_opp));
> +		goto unlock;
> +	}
> +
[...]
> +
> +static bool _opp_is_supported(struct device *dev, struct device_opp *dev_opp,
> +			      struct device_node *np)
> +{
> +	unsigned int count;
> +	u32 *versions;
> +	bool supported = true;
> +	int ret;
> +
> +	if (!dev_opp->supported_hw)
> +		return true;
> +
> +	count = of_property_count_u32_elems(np, "opp-supported-hw");
> +	if (count != dev_opp->supported_hw_count) {
> +		dev_warn(dev, "%s: supported-hw count mismatch, plat:%u != DT:%u\n",
> +			 __func__, dev_opp->supported_hw_count, count);
> +		return false;
> +	}
> +
> +	versions = kcalloc(count, sizeof(*versions), GFP_KERNEL);
> +	if (!versions)
> +		return false;
> +
> +	ret = of_property_read_u32_array(np, "opp-supported-hw", versions,
> +					 count);
> +	if (ret) {
> +		dev_warn(dev, "%s: failed to read opp-supported-hw property: %d\n",
> +			 __func__, ret);
> +		supported = false;
> +		goto free_versions;
> +	}
> +
> +	while (count--) {
> +		/* Both of these are bitwise masks of the versions */
> +		if (!(versions[count] & dev_opp->supported_hw[count])) {
> +			supported = false;
> +			break;
> +		}
> +	}
> +
> +free_versions:
> +	kfree(versions);

Why do we need to allocate an array to check the property a u32
at a time? We should be able to call of_property_read_u32_index()
in a loop and check that against the version array. No allocation
needed.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
