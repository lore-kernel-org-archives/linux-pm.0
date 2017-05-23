From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/4] PM / OPP: Reorganize _generic_set_opp_regulator()
Date: Mon, 22 May 2017 18:09:47 -0700
Message-ID: <20170523010947.GI20170@codeaurora.org>
References: <cover.1494995911.git.viresh.kumar@linaro.org>
 <7b9df40efa69d646840c097c04c56c7f42f458c4.1494995911.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50522 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759123AbdEWBJt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 May 2017 21:09:49 -0400
Content-Disposition: inline
In-Reply-To: <7b9df40efa69d646840c097c04c56c7f42f458c4.1494995911.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 05/17, Viresh Kumar wrote:
> The code was overly complicated here because of the limitations that we
> had with RCUs (Couldn't use opp-table and OPPs outside RCU protected
> section and can't call sleep-able routines from within that). But that
> is long gone now.
> 
> Reorganize _generic_set_opp_regulator() in order to avoid using "struct
> dev_pm_set_opp_data" and copying data into it for the case where
> opp_table->set_opp is not set.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/opp/core.c | 73 ++++++++++++++++++++-----------------------
>  1 file changed, 34 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index dae61720b314..402b9e86d77c 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -543,17 +543,18 @@ _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
>  	return ret;
>  }
>  
> -static int _generic_set_opp(struct dev_pm_set_opp_data *data)
> +static int _generic_set_opp_regulator(struct opp_table *opp_table,

Can opp_table be const?

> +				      struct device *dev,

Maybe dev too, but that looks like a ripple effect so maybe
in another patch.

> +				      unsigned long old_freq,
> +				      unsigned long freq,
> +				      struct dev_pm_opp_supply *old_supply,
> +				      struct dev_pm_opp_supply *new_supply)

Otherwise

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
