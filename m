From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 9/9] PM / OPP: Don't assume platform doesn't have
 regulators
Date: Wed, 9 Nov 2016 17:17:28 -0800
Message-ID: <20161110011728.GV16026@codeaurora.org>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
 <f1fa8223ab9b9a1183626ec42608ec966a4bc425.1477463128.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54986 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbcKJBRa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2016 20:17:30 -0500
Content-Disposition: inline
In-Reply-To: <f1fa8223ab9b9a1183626ec42608ec966a4bc425.1477463128.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org

On 10/26, Viresh Kumar wrote:
> If the regulators aren't set explicitly by the platform, the OPP core
> assumes that the platform doesn't have any regulator and uses the
> clk-only callback.
> 
> If the platform failed to register a regulator with the core, then this
> can turn out to be a dangerous assumption as the OPP core will try to
> change clk without changing regulators.
> 
> Handle that properly by making sure that the DT didn't had any entries

s/had/have/

> for supply voltages as well.
> 
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index 3298fac01bb0..34cd48dfe89e 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -734,7 +734,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  
>  	/* Only frequency scaling */
>  	if (!regulators) {
> -		rcu_read_unlock();
> +		/*
> +		 * DT contained supply ratings? Consider platform failed to set
> +		 * regulators.
> +		 */
> +		if (unlikely(opp->supplies[0].u_volt)) {
> +			rcu_read_unlock();
> +			dev_err(dev, "%s: Regulator not registered with OPP core\n",
> +				__func__);
> +			return -EINVAL;
> +		}
> +

Don't we need an rcu_read_unlock() here as well?

>  		return _generic_set_opp_clk_only(dev, clk, old_freq, freq);
>  	}
>  

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
