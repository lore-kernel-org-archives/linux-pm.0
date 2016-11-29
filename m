From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V4 08/10] PM / OPP: Allow platform specific custom
 set_opp() callbacks
Date: Mon, 28 Nov 2016 17:16:35 -0800
Message-ID: <20161129011635.GV6095@codeaurora.org>
References: <cover.1479986491.git.viresh.kumar@linaro.org>
 <743654b6d2b18f94cd36b8b700c028f67cebaada.1479986492.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51212 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754939AbcK2BQh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 20:16:37 -0500
Content-Disposition: inline
In-Reply-To: <743654b6d2b18f94cd36b8b700c028f67cebaada.1479986492.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org, devicetree@vger.kernel.org

On 11/24, Viresh Kumar wrote:
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index 99491f4099e5..7c945d5950bf 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -673,6 +673,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  {
>  	struct opp_table *opp_table;
>  	unsigned long freq, old_freq;
> +	int (*set_opp)(struct device *dev, struct dev_pm_set_opp_data *data);

Curious why dev is an argument that isn't part of struct
dev_pm_set_opp_data here? Is there some benefit to keeping it
split out?

>  	struct dev_pm_opp *old_opp, *opp;
>  	struct regulator **regulators;
>  	struct dev_pm_set_opp_data *data;
> @@ -1488,7 +1497,7 @@ int dev_pm_opp_set_regulators(struct device *dev, const char * const names[],
>  
>  	opp_table->regulator_count = count;
>  
> -	/* Allocate block only once to pass to ->set_rate() */
> +	/* Allocate block only once to pass to ->set_opp() */

Ah here it is.

>  	ret = _allocate_set_opp_data(opp_table);
>  	if (ret)
>  		goto free_regulators;
> @@ -1563,6 +1572,109 @@ void dev_pm_opp_put_regulators(struct device *dev)
>  EXPORT_SYMBOL_GPL(dev_pm_opp_put_regulators);
>  
>  /**
> + * dev_pm_opp_register_set_opp_helper() - Register custom OPP set rate helper

s/custom OPP set rate/custom set OPP/ ?

> + * @dev: Device for which the helper is getting registered.
> + * @set_opp: Custom set OPP helper.
> + *
> + * This is useful to support complex platforms (like platforms with multiple
> + * regulators per device), instead of the generic OPP set rate helper.
> + *
> + * This must be called before any OPPs are initialized for the device.
> + *
> + * Locking: The internal opp_table and opp structures are RCU protected.
> + * Hence this function internally uses RCU updater strategy with mutex locks
> + * to keep the integrity of the internal data structures. Callers should ensure
> + * that this function is *NOT* called under RCU protection or in contexts where
> + * mutex cannot be locked.
> + */

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
