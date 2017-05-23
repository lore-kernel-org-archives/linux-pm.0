From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 3/4] PM / OPP: opp-microvolt is not optional if
 regulators are set
Date: Mon, 22 May 2017 18:20:53 -0700
Message-ID: <20170523012053.GK20170@codeaurora.org>
References: <cover.1494995911.git.viresh.kumar@linaro.org>
 <0e9ac75f0e94d7b0bff9a398b501e2fe4f409051.1494995911.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55118 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753115AbdEWBUz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 May 2017 21:20:55 -0400
Content-Disposition: inline
In-Reply-To: <0e9ac75f0e94d7b0bff9a398b501e2fe4f409051.1494995911.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 05/17, Viresh Kumar wrote:
> If dev_pm_opp_set_regulators() is called for a device and its regulators
> are set in the OPP core, the OPP nodes for the device must contain the
> "opp-microvolt" property, otherwise there is something wrong and we
> better error out.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/opp/of.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
> index 779428676f63..c6fc8cbad10d 100644
> --- a/drivers/base/power/opp/of.c
> +++ b/drivers/base/power/opp/of.c
> @@ -131,8 +131,15 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
>  		prop = of_find_property(opp->np, name, NULL);
>  
>  		/* Missing property isn't a problem, but an invalid entry is */
> -		if (!prop)
> -			return 0;
> +		if (!prop) {
> +			/* The regulator-count must be zero here */

Comment is restating code with no insight into what's so special,
how about:

			/*
			 * But it better not be missing if we're
			 * expecting OPP core to manage regulators
			 */

Although I suppose the dev_err message is pretty good.

> +			if (!opp_table->regulator_count)
> +				return 0;
> +
> +			dev_err(dev, "%s: opp-microvolt missing even if regulators are available\n",

"missing although OPP managing regulators"?

> +				__func__);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
