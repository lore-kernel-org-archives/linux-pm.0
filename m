From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] cpufreq: dt: disable unsupported OPPs
Date: Mon, 27 Oct 2014 23:41:31 +0100
Message-ID: <2016630.oUihJzu2TF@vostro.rjw.lan>
References: <1414155955-13640-1-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1414155955-13640-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-sh-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-pm@vger.kernel.org

On Friday, October 24, 2014 03:05:55 PM Lucas Stach wrote:
> If the regulator connected to the CPU voltage plane doesn't
> support an OPP specified voltage with the acceptable tolerance
> it's better to just disable the OPP instead of constantly
> failing the voltage scaling later on.
> 
> Includes as fix to move initialization of opp_freq outside
> the loop in order to avoid an endless loop.
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

> ---
> v3:
> - squash in fix from Geert Uytterhoeven
> resend 2:
> - no functional change, rebase against latest Linus tree
> - added Viresh's ack
> resend:
> - no functional change, split out from the imx5 cpufreq series
> v2:
> - rebase on top of pm/linux-next
> ---
>  drivers/cpufreq/cpufreq-dt.c | 66 +++++++++++++++++++++++++++-----------------
>  1 file changed, 41 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 92c162af5045..7789affa7eb8 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -187,6 +187,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	struct device *cpu_dev;
>  	struct regulator *cpu_reg;
>  	struct clk *cpu_clk;
> +	unsigned long min_uV = ~0, max_uV = 0;
>  	unsigned int transition_latency;
>  	int ret;
>  
> @@ -206,16 +207,10 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	/* OPPs might be populated at runtime, don't check for error here */
>  	of_init_opp_table(cpu_dev);
>  
> -	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
> -	if (ret) {
> -		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
> -		goto out_put_node;
> -	}
> -
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>  	if (!priv) {
>  		ret = -ENOMEM;
> -		goto out_free_table;
> +		goto out_put_node;
>  	}
>  
>  	of_property_read_u32(np, "voltage-tolerance", &priv->voltage_tolerance);
> @@ -224,30 +219,51 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  		transition_latency = CPUFREQ_ETERNAL;
>  
>  	if (!IS_ERR(cpu_reg)) {
> -		struct dev_pm_opp *opp;
> -		unsigned long min_uV, max_uV;
> -		int i;
> +		unsigned long opp_freq = 0;
>  
>  		/*
> -		 * OPP is maintained in order of increasing frequency, and
> -		 * freq_table initialised from OPP is therefore sorted in the
> -		 * same order.
> +		 * Disable any OPPs where the connected regulator isn't able to
> +		 * provide the specified voltage and record minimum and maximum
> +		 * voltage levels.
>  		 */
> -		for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++)
> -			;
> -		rcu_read_lock();
> -		opp = dev_pm_opp_find_freq_exact(cpu_dev,
> -				freq_table[0].frequency * 1000, true);
> -		min_uV = dev_pm_opp_get_voltage(opp);
> -		opp = dev_pm_opp_find_freq_exact(cpu_dev,
> -				freq_table[i-1].frequency * 1000, true);
> -		max_uV = dev_pm_opp_get_voltage(opp);
> -		rcu_read_unlock();
> +		while (1) {
> +			struct dev_pm_opp *opp;
> +			unsigned long opp_uV, tol_uV;
> +
> +			rcu_read_lock();
> +			opp = dev_pm_opp_find_freq_ceil(cpu_dev, &opp_freq);
> +			if (IS_ERR(opp)) {
> +				rcu_read_unlock();
> +				break;
> +			}
> +			opp_uV = dev_pm_opp_get_voltage(opp);
> +			rcu_read_unlock();
> +
> +			tol_uV = opp_uV * priv->voltage_tolerance / 100;
> +			if (regulator_is_supported_voltage(cpu_reg, opp_uV,
> +							   opp_uV + tol_uV)) {
> +				if (opp_uV < min_uV)
> +					min_uV = opp_uV;
> +				if (opp_uV > max_uV)
> +					max_uV = opp_uV;
> +			} else {
> +				dev_pm_opp_disable(cpu_dev, opp_freq);
> +			}
> +
> +			opp_freq++;
> +		}
> +
>  		ret = regulator_set_voltage_time(cpu_reg, min_uV, max_uV);
>  		if (ret > 0)
>  			transition_latency += ret * 1000;
>  	}
>  
> +	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
> +	if (ret) {
> +		pr_err("failed to init cpufreq table: %d\n", ret);
> +		goto out_free_priv;
> +	}
> +
>  	/*
>  	 * For now, just loading the cooling device;
>  	 * thermal DT code takes care of matching them.
> @@ -286,9 +302,9 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  
>  out_cooling_unregister:
>  	cpufreq_cooling_unregister(priv->cdev);
> -	kfree(priv);
> -out_free_table:
>  	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
> +out_free_priv:
> +	kfree(priv);
>  out_put_node:
>  	of_node_put(np);
>  out_put_reg_clk:
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
