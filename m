From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 01/16] PM / OPP: get/put regulators from OPP core
Date: Mon, 1 Feb 2016 18:29:21 -0800
Message-ID: <20160202022921.GI4848@codeaurora.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
 <69e87438205ee12c7e884f9a3114b2f695e8b59a.1453965717.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <69e87438205ee12c7e884f9a3114b2f695e8b59a.1453965717.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 01/28, Viresh Kumar wrote:
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
> +	mutex_lock(&dev_opp_list_lock);
> +
> +	/* Check for existing list for 'dev' first */
> +	dev_opp = _find_device_opp(dev);
> +	if (IS_ERR(dev_opp)) {
> +		dev_err(dev, "Failed to find dev_opp: %ld\n", PTR_ERR(dev_opp));
> +		goto unlock;
> +	}
> +
> +	if (IS_ERR_OR_NULL(dev_opp->regulator)) {
> +		dev_err(dev, "%s: Doesn't have regulator set\n", __func__);
> +		goto unlock;
> +	}
> +
> +	/* Make sure there are no concurrent readers while updating dev_opp */
> +	WARN_ON(!list_empty(&dev_opp->opp_list));
> +
> +	regulator_put(dev_opp->regulator);
> +	dev_opp->regulator = ERR_PTR(-EINVAL);
> +
> +	/* Try freeing device_opp if this was the last blocking resource */
> +	_remove_device_opp(dev_opp);
> +
> +unlock:
> +	mutex_unlock(&dev_opp_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_put_regulator);

I'm still lost why we need this API. When the OPP is torn down we
can call regulator_put there instead. The same style seems to be
done for supported hw, and prop_name, which doesn't make any
sense either. Just tear everything down when there aren't any
more OPPs in the table.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
