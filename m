From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 09/12] PM / OPP: Move away from RCU locking
Date: Mon, 9 Jan 2017 15:57:27 -0800
Message-ID: <20170109235727.GA17126@codeaurora.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <2141b49d888d7b60ff317256a559ab78c1448a03.1481106919.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58496 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbdAIX53 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2017 18:57:29 -0500
Content-Disposition: inline
In-Reply-To: <2141b49d888d7b60ff317256a559ab78c1448a03.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/07, Viresh Kumar wrote:
> The RCU locking isn't well suited for the OPP core. The RCU locking fits
> better for reader heavy stuff, while the OPP core have at max one or two
> readers only at a time.
> 
> Over that, it was getting very confusing the way RCU locking was used
> with the OPP core. The individual OPPs are mostly well handled, i.e. for
> an update a new structure was created and then that replaced the older
> one. But the OPP tables were updated directly all the time from various
> parts of the core. Though they were mostly used from within RCU locked
> region, they didn't had much to do with RCU and were governed by the
> mutex instead.
> 
> And that mixed with the 'opp_table_lock' has made the core even more
> confusing.
> 
> Now that we are already managing the OPPs and the OPP tables with kernel
> reference infrastructure, we can get rid of RCU locking completely and
> simplify the code a lot.
> 
> Remove all RCU references from code and comments.
> 
> Acquire opp_table->lock while parsing the list of OPPs though.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index 2b689fc73596..b5e9600058c2 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -133,19 +117,12 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
>   */
>  unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
>  {
> -	struct dev_pm_opp *tmp_opp;
> -	unsigned long f = 0;
> -
> -	rcu_read_lock();
> -
> -	tmp_opp = rcu_dereference(opp);
> -	if (IS_ERR_OR_NULL(tmp_opp) || !tmp_opp->available)
> +	if (IS_ERR_OR_NULL(opp) || !opp->available) {

I suppose this is one thing RCU was being used for, marking OPPs
available and then having these "getter" APIs fail if the OPPs go
away. But that was never right because the OPP could have been
made unavailable after this function returned and things still
wouldn't work.

>  		pr_err("%s: Invalid parameters\n", __func__);
> -	else
> -		f = tmp_opp->rate;
> +		return 0;
> +	}
>  
> -	rcu_read_unlock();
> -	return f;
> +	return opp->rate;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
>  

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
