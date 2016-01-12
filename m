From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 07/17] PM / OPP: Manage device clk
Date: Mon, 11 Jan 2016 17:32:05 -0800
Message-ID: <20160112013205.GL22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <1cdc1e6a83974a3f1bb44c0af3cd32ef94542d81.1450777582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41714 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760024AbcALBcH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 20:32:07 -0500
Content-Disposition: inline
In-Reply-To: <1cdc1e6a83974a3f1bb44c0af3cd32ef94542d81.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12/22, Viresh Kumar wrote:
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index 1bb09138cdae..1d1b0faa825d 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -596,6 +596,11 @@ static struct device_opp *_add_device_opp_reg(struct device *dev,
>  		of_node_put(np);
>  	}
>  
> +	/* Find clk for the device */
> +	dev_opp->clk = clk_get(dev, NULL);
> +	if (IS_ERR(dev_opp->clk))

We'll need the same probe defer check here so we don't print
anything. I know common clock framework doesn't return probe
defer pointers yet, but we're working on it so it would be nice
to handle it.

> +		dev_dbg(dev, "%s: Couldn't find clock\n", __func__);
> +
>  	dev_opp->regulator = regulator_get_optional(dev, name);
>  	if (IS_ERR(dev_opp->regulator))
>  		dev_info(dev, "%s: no regulator (%s) found: %ld\n", __func__,
> diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
> index a39347d8693f..42759f025ef1 100644
> --- a/drivers/base/power/opp/opp.h
> +++ b/drivers/base/power/opp/opp.h
> @@ -14,6 +14,7 @@
>  #ifndef __DRIVER_OPP_H__
>  #define __DRIVER_OPP_H__
>  
> +#include <linux/clk.h>

Again, forward declare struct clk instead of including the
header.

>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> @@ -133,6 +134,7 @@ struct device_list_opp {
>   * @supported_hw: Array of version number to support.
>   * @supported_hw_count: Number of elements in supported_hw array.
>   * @prop_name: A name to postfix to many DT properties, while parsing them.
> + * @clk:	struct clk pointer

Why tab? And perhaps it should say "clock handle" or "supply
clock" or something instead of rewording the type "struct clk *".

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
