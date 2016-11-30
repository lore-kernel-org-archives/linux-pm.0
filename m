From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V6 06/10] PM / OPP: Add infrastructure to manage multiple
 regulators
Date: Wed, 30 Nov 2016 14:37:12 -0800
Message-ID: <20161130223712.GM6095@codeaurora.org>
References: <cover.1480481312.git.viresh.kumar@linaro.org>
 <3b3ce1dac198fb668b97e81490bcbcf03d31e40d.1480481312.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3b3ce1dac198fb668b97e81490bcbcf03d31e40d.1480481312.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, d-gerlach-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 11/30, Viresh Kumar wrote:
> @@ -1337,26 +1408,44 @@ struct opp_table *dev_pm_opp_set_regulator(struct device *dev, const char *name)
>  		goto err;
>  	}
>  
> -	/* Already have a regulator set */
> -	if (WARN_ON(!IS_ERR(opp_table->regulator))) {
> +	/* Already have regulators set */
> +	if (WARN_ON(opp_table->regulators)) {
>  		opp_table = ERR_PTR(-EBUSY);
>  		goto err;
>  	}
> -	/* Allocate the regulator */
> -	reg = regulator_get_optional(dev, name);
> -	if (IS_ERR(reg)) {
> -		opp_table = (struct opp_table *)reg;
> -		if (PTR_ERR(reg) != -EPROBE_DEFER)
> -			dev_err(dev, "%s: no regulator (%s) found: %ld\n",
> -				__func__, name, PTR_ERR(reg));
> +
> +	opp_table->regulators = kmalloc_array(count,
> +					      sizeof(*opp_table->regulators),
> +					      GFP_KERNEL);
> +	if (!opp_table->regulators) {
> +		opp_table = ERR_PTR(-ENOMEM);
>  		goto err;
>  	}
>  
> -	opp_table->regulator = reg;
> +	for (i = 0; i < count; i++) {
> +		reg = regulator_get_optional(dev, names[i]);
> +		if (IS_ERR(reg)) {
> +			opp_table = (struct opp_table *)reg;

This should be an ERR_CAST() instead. But this is not based on
the correct patch anyway so this should be rebased.

> +			if (PTR_ERR(reg) != -EPROBE_DEFER)
> +				dev_err(dev, "%s: no regulator (%s) found: %ld\n",
> +					__func__, names[i], PTR_ERR(reg));
> +			goto free_regulators;
> +		}
> +
> +		opp_table->regulators[i] = reg;
> +	}
> +
> +	opp_table->regulator_count = count;
>  
>  	mutex_unlock(&opp_table_lock);
>  	return opp_table;
>  
> +free_regulators:
> +	while (i != 0)
> +		regulator_put(opp_table->regulators[--i]);
> +
> +	kfree(opp_table->regulators);
> +	opp_table->regulators = NULL;
>  err:
>  	_remove_opp_table(opp_table);
>  unlock:
> @@ -1364,10 +1453,10 @@ struct opp_table *dev_pm_opp_set_regulator(struct device *dev, const char *name)
>  
>  	return opp_table;
>  }
> -EXPORT_SYMBOL_GPL(dev_pm_opp_set_regulator);
> +EXPORT_SYMBOL_GPL(dev_pm_opp_set_regulators);
>  
>  /**
> - * dev_pm_opp_put_regulator() - Releases resources blocked for regulator
> + * dev_pm_opp_put_regulators() - Releases resources blocked for regulators
>   * @opp_table: opp_table returned from dev_pm_opp_set_regulator

This needs an update too                  ^

>   *
>   * Locking: The internal opp_table and opp structures are RCU protected.
> diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
> index c897676ca35f..95f433db4ac7 100644
> --- a/drivers/base/power/opp/debugfs.c
> +++ b/drivers/base/power/opp/debugfs.c
> @@ -34,6 +35,46 @@ void opp_debug_remove_one(struct dev_pm_opp *opp)
>  	debugfs_remove_recursive(opp->dentry);
>  }
>  
> +static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
> +				      struct opp_table *opp_table,
> +				      struct dentry *pdentry)
> +{
> +	struct dentry *d;
> +	int i = 0;
> +	char *name;
> +
> +	/* Always create at least supply-0 directory */
> +	do {
> +		name = kasprintf(GFP_KERNEL, "supply-%d", i);

Sorry I haven't noticed this before. Wouldn't we want to put the
supply name here instead of a number?

> +
> +		/* Create per-opp directory */
> +		d = debugfs_create_dir(name, pdentry);
> +
> +		kfree(name);
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 4d3ec92cbabf..1cd1fcfe835a 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -188,7 +188,10 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	 */
>  	name = find_supply_name(cpu_dev);
>  	if (name) {
> -		opp_table = dev_pm_opp_set_regulator(cpu_dev, name);
> +		const char *names[] = {name};
> +
> +		opp_table = dev_pm_opp_set_regulators(cpu_dev, names,
> +						ARRAY_SIZE(names));

This can be simplified to: 

		opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1);

>  		if (IS_ERR(opp_table)) {
>  			ret = PTR_ERR(opp_table);
>  			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
