From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 08/10] PM / OPP: Rename dev_pm_opp_get_suspend_opp() and
 return OPP rate
Date: Tue, 6 Dec 2016 17:21:41 -0800
Message-ID: <20161207012141.GL4388@codeaurora.org>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
 <1da9ba0dd518f51fa73ca33e06ba868a267fb5d6.1481015522.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34406 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbcLGBVn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 20:21:43 -0500
Content-Disposition: inline
In-Reply-To: <1da9ba0dd518f51fa73ca33e06ba868a267fb5d6.1481015522.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/06, Viresh Kumar wrote:
> There is only one user of dev_pm_opp_get_suspend_opp() and that uses it
> to get the OPP rate for the suspend_opp.
> 
> Rename dev_pm_opp_get_suspend_opp() as dev_pm_opp_get_suspend_opp_freq()
> and return the rate directly from it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/opp/core.c | 27 +++++++++++++--------------
>  drivers/cpufreq/cpufreq-dt.c  |  7 +------
>  include/linux/pm_opp.h        |  6 +++---
>  3 files changed, 17 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index 6bcbb64a5582..6fd098618683 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -328,32 +328,31 @@ unsigned long dev_pm_opp_get_max_transition_latency(struct device *dev)
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_transition_latency);
>  
>  /**
> - * dev_pm_opp_get_suspend_opp() - Get suspend opp
> + * dev_pm_opp_get_suspend_opp_freq() - Get frequency of suspend opp

Please indicate units of frequency.

>   * @dev:	device for which we do this operation
>   *
> - * Return: This function returns pointer to the suspend opp if it is
> - * defined and available, otherwise it returns NULL.
> - *
> - * Locking: This function must be called under rcu_read_lock(). opp is a rcu
> - * protected pointer. The reason for the same is that the opp pointer which is
> - * returned will remain valid for use with opp_get_{voltage, freq} only while
> - * under the locked area. The pointer returned must be used prior to unlocking
> - * with rcu_read_unlock() to maintain the integrity of the pointer.
> + * Return: This function returns the frequency of the OPP marked as suspend_opp
> + * if one is available, else returns 0;
>   */
> -struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev)
> +unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
>  {
>  	struct opp_table *opp_table;
> +	unsigned long freq = 0;
>  
> -	opp_rcu_lockdep_assert();
> +	rcu_read_lock();
>  
>  	opp_table = _find_opp_table(dev);
>  	if (IS_ERR(opp_table) || !opp_table->suspend_opp ||
>  	    !opp_table->suspend_opp->available)
> -		return NULL;
> +		goto unlock;
>  
> -	return opp_table->suspend_opp;
> +	freq = dev_pm_opp_get_freq(opp_table->suspend_opp) / 1000;

Why do we include the / 1000? Perhaps we should just return freq
and have the caller divide.

> +
> +unlock:
> +	rcu_read_unlock();
> +	return freq;
>  }
> -EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp);
> +EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_freq);
>  
>  /**
>   * dev_pm_opp_get_opp_count() - Get number of opps available in the opp table
> @@ -159,9 +159,9 @@ static inline unsigned long dev_pm_opp_get_max_transition_latency(struct device
>  	return 0;
>  }
>  
> -static inline struct dev_pm_opp *dev_pm_opp_get_suspend_opp(struct device *dev)
> +static inline unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
>  {
> -	return NULL;
> +	return 0;

Dividing 0 by anything is just 0 anyway.

>  }

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
