From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / OPP: of_property_count_u32_elems() can return errors
Date: Thu, 17 Sep 2015 11:13:28 -0700
Message-ID: <20150917181328.GQ23081@codeaurora.org>
References: <46a47430b8d65f509d47fe3ad1264c6b23086d61.1442508974.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33101 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbbIQSNb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2015 14:13:31 -0400
Content-Disposition: inline
In-Reply-To: <46a47430b8d65f509d47fe3ad1264c6b23086d61.1442508974.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 09/17, Viresh Kumar wrote:
> +++ b/drivers/base/power/opp.c
> @@ -889,13 +889,22 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
>  /* TODO: Support multiple regulators */
>  static int opp_get_microvolt(struct dev_pm_opp *opp, struct device *dev)
>  {
> +	struct property *prop;
>  	u32 microvolt[3] = {0};
>  	int count, ret;
>  
> -	count = of_property_count_u32_elems(opp->np, "opp-microvolt");
> -	if (!count)
> +	/* Missing property isn't a problem, but an invalid entry is */
> +	prop = of_find_property(opp->np, "opp-microvolt", NULL);

Prop isn't used anywhere so why not remove the local variable and
test the result of this call inside the if condition?

> +	if (!prop)
>  		return 0;
>  
> +	count = of_property_count_u32_elems(opp->np, "opp-microvolt");
> +	if (count < 0) {

We can't test count for -EINVAL to detect the missing property
because -EINVAL is also returned on a non-multiple of u32 length
property? Maybe we shouldn't worry about that case and turn
-EINVAL into 0.

> +		dev_err(dev, "%s: Invalid opp-microvolt property (%d)\n",
> +			__func__, count);
> +		return count;

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
