From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 07/16] PM / OPP: Add support to parse
 "operating-points-v2" bindings
Date: Thu, 30 Jul 2015 22:51:06 -0700
Message-ID: <20150731055106.GJ3159@codeaurora.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <6d8d9cd0c3ae2d3fa8c3aadedb5ac403785b7675.1438166099.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35567 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbbGaFvI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 01:51:08 -0400
Content-Disposition: inline
In-Reply-To: <6d8d9cd0c3ae2d3fa8c3aadedb5ac403785b7675.1438166099.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 07/29, Viresh Kumar wrote:
> This adds support in OPP library to parse and create list of OPPs from
> operating-points-v2 bindings. It takes care of most of the properties of
> new bindings (except shared-opp, which will be handled separately).
> 
> For backward compatibility, we keep supporting earlier bindings. We try
> to search for the new bindings first, in case they aren't present we
> look for the old deprecated ones.
> 
> There are few things marked as TODO:
> - Support for multiple OPP tables
> - Support for multiple regulators
> 
> They should be fixed separately.
> 
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

One question below:

> @@ -679,6 +691,125 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
>  	return ret;
>  }
>  
> +/* TODO: Support multiple regulators */
> +static int opp_get_microvolt(struct dev_pm_opp *opp, struct device *dev)
> +{
> +	u32 microvolt[3] = {0};
> +	int count, ret;
> +
> +	count = of_property_count_u32_elems(opp->np, "opp-microvolt");
> +	if (!count)
> +		return 0;
> +
> +	/* There can be one or three elements here */
> +	if (count != 1 && count != 3) {
> +		dev_err(dev, "%s: Invalid number of elements in opp-microvolt property (%d)\n",
> +			__func__, count);
> +		return -EINVAL;
> +	}
> +
> +	ret = of_property_read_u32_array(opp->np, "opp-microvolt", microvolt,
> +					 count);
> +	if (ret) {
> +		dev_err(dev, "%s: error parsing opp-microvolt: %d\n", __func__,
> +			ret);
> +		return -EINVAL;
> +	}
> +
> +	opp->u_volt = microvolt[0];
> +	opp->u_volt_min = microvolt[1];
> +	opp->u_volt_max = microvolt[2];

Should the default be 0 and ULONG_MAX for volt_min/volt_max when
there's on element?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
