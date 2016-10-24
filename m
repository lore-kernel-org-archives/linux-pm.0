From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 2/8] PM / OPP: Don't use OPP structure outside of rcu
 protected section
Date: Mon, 24 Oct 2016 15:52:38 -0700
Message-ID: <20161024225238.GR26139@codeaurora.org>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
 <7a0754e64236db2a977c6a6402c222fea6dc866d.1476952750.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7a0754e64236db2a977c6a6402c222fea6dc866d.1476952750.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/20, Viresh Kumar wrote:
> The OPP structure must not be used out of the rcu protected section.
> Cache the values to be used in separate variables instead.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Was this found by visual inspection or through some static
checker? Just curious.

> @@ -633,6 +634,14 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  		return ret;
>  	}
>  
> +	if (IS_ERR(old_opp)) {
> +		old_u_volt = 0;
> +	} else {
> +		old_u_volt = old_opp->u_volt;
> +		old_u_volt_min = old_opp->u_volt_min;
> +		old_u_volt_max = old_opp->u_volt_max;
> +	}
> +
>  	u_volt = opp->u_volt;
>  	u_volt_min = opp->u_volt_min;
>  	u_volt_max = opp->u_volt_max;
> @@ -677,9 +686,10 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  			__func__, old_freq);
>  restore_voltage:
>  	/* This shouldn't harm even if the voltages weren't updated earlier */
> -	if (!IS_ERR(old_opp))
> -		_set_opp_voltage(dev, reg, old_opp->u_volt,
> -				 old_opp->u_volt_min, old_opp->u_volt_max);
> +	if (old_u_volt) {

What if old_u_volt == 0 is valid? We could have another variable
like 'valid' or something that we use to figure out if we should
set values instead. Then this isn't a potential pitfall.

> +		_set_opp_voltage(dev, reg, old_u_volt, old_u_volt_min,
> +				 old_u_volt_max);
> +	}
>  
>  	return ret;
>  }

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
