From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 06/17] PM / OPP: Parse clock-latency and
 voltage-tolerance for v1 bindings
Date: Mon, 11 Jan 2016 17:29:05 -0800
Message-ID: <20160112012905.GK22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <25cb4d7e9169815448193bd93305fae31a83792c.1450777582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41574 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760AbcALB3H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 20:29:07 -0500
Content-Disposition: inline
In-Reply-To: <25cb4d7e9169815448193bd93305fae31a83792c.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12/22, Viresh Kumar wrote:
> @@ -580,6 +581,21 @@ static struct device_opp *_add_device_opp_reg(struct device *dev,
>  		return NULL;
>  	}
>  
> +	/*
> +	 * Only required for backward compatibility with v1 bindings, but isn't
> +	 * harmful for other cases. And so we do it unconditionally.
> +	 */
> +	np = of_node_get(dev->of_node);
> +	if (np) {
> +		u32 val;
> +
> +		if (!of_property_read_u32(np, "clock-latency", &val))
> +			dev_opp->clock_latency_ns_max = val;
> +		of_property_read_u32(np, "voltage-tolerance",
> +				     &dev_opp->voltage_tolerance_v1);

Why do we conditionalize the assignment for clock latency but not
for voltage tolerance?

> +		of_node_put(np);
> +	}
> +
>  	dev_opp->regulator = regulator_get_optional(dev, name);
>  	if (IS_ERR(dev_opp->regulator))
>  		dev_info(dev, "%s: no regulator (%s) found: %ld\n", __func__,

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
