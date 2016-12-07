From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 01/10] PM / OPP: Fix memory leak while adding duplicate
 OPPs
Date: Tue, 6 Dec 2016 17:09:24 -0800
Message-ID: <20161207010924.GF4388@codeaurora.org>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
 <d4addab7750d63731d8e8562e2600fa8c987f53a.1481015522.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33666 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbcLGBSq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 20:18:46 -0500
Content-Disposition: inline
In-Reply-To: <d4addab7750d63731d8e8562e2600fa8c987f53a.1481015522.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/06, Viresh Kumar wrote:
> There are two types of duplicate OPPs that get different behavior from
> the core:
> A). An earlier OPP is marked 'available' and has same freq/voltages as
>     the new one.
> B). An earlier OPP with same frequency, but is marked 'unavailable' OR
>     doesn't have same voltages as the new one.
> 
> The OPP core returns 0 for the first one, but -EEXIST for the second.
> 
> While the OPP core returns 0 for the first case, its callers don't free
> the newly allocated OPP structure which isn't used anymore. Fix that by
> returning -EBUSY instead of 0, but make the callers return 0 eventually.
> 
> As this isn't a critical fix, its not getting marked for stable kernel.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Makes sense.

> ---
>  drivers/base/power/opp/core.c | 14 ++++++++++++--
>  drivers/base/power/opp/of.c   |  6 +++++-
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index a0e6294baf1d..cc69f903fd34 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -1080,6 +1080,12 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
>  	return true;
>  }
>  
> +/*
> + * Returns:
> + * 0: On success. And appropriate error message for Duplicate OPPs.

lowercase duplicate please

> + * -EBUSY: For OPP with same freq/volt and is available.
> + * -EEXIST: For OPP with same freq but different volt or is unavailable.
> + */
>  int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
>  	     struct opp_table *opp_table)
>  {
> @@ -1112,7 +1118,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
>  
>  		/* Should we compare voltages for all regulators here ? */
>  		return opp->available &&
> -		       new_opp->supplies[0].u_volt == opp->supplies[0].u_volt ? 0 : -EEXIST;
> +		       new_opp->supplies[0].u_volt == opp->supplies[0].u_volt ? -EBUSY : -EEXIST;
>  	}
>  
>  	new_opp->opp_table = opp_table;
> @@ -1186,8 +1192,12 @@ int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
>  	new_opp->dynamic = dynamic;
>  
>  	ret = _opp_add(dev, new_opp, opp_table);
> -	if (ret)
> +	if (ret) {
> +		/* Don't return error for duplicate OPPs */

Yes, but why?

> +		if (ret == -EBUSY)
> +			ret = 0;
>  		goto free_opp;
> +	}
>  
>  	mutex_unlock(&opp_table_lock);
>  

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
