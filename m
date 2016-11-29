From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V4 06/10] PM / OPP: Add infrastructure to manage multiple
 regulators
Date: Mon, 28 Nov 2016 16:55:12 -0800
Message-ID: <20161129005512.GQ6095@codeaurora.org>
References: <cover.1479986491.git.viresh.kumar@linaro.org>
 <9ef150da6d3344d2ad4ce884f777174a3aef5dc1.1479986491.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9ef150da6d3344d2ad4ce884f777174a3aef5dc1.1479986491.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, d-gerlach-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 11/24, Viresh Kumar wrote:
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index 37fad2eb0f47..2d5c726c920f 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -235,21 +240,41 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
>  		return 0;
>  	}
>  
> -	reg = opp_table->regulator;
> -	if (IS_ERR(reg)) {
> +	count = opp_table->regulator_count;
> +
> +	if (!count) {
>  		/* Regulator may not be required for device */
>  		rcu_read_unlock();
>  		return 0;
>  	}
>  
> -	list_for_each_entry_rcu(opp, &opp_table->opp_list, node) {
> -		if (!opp->available)
> -			continue;
> +	size = count * sizeof(*regulators);
> +	regulators = kmemdup(opp_table->regulators, size, GFP_KERNEL);

Again, can't allocate with sleeping calls under RCU read lock as
it may have disabled preemption.

> +	if (!regulators) {
> +		rcu_read_unlock();
> +		return 0;
> +	}
> +
> +	uV = kmalloc_array(count, sizeof(*uV), GFP_KERNEL);
> +	if (!uV) {
> +		kfree(regulators);
> +		rcu_read_unlock();
> +		return 0;
> +	}
>  
> -		if (opp->supply.u_volt_min < min_uV)
> -			min_uV = opp->supply.u_volt_min;
> -		if (opp->supply.u_volt_max > max_uV)
> -			max_uV = opp->supply.u_volt_max;
> +	for (i = 0; i < count; i++) {
> +		uV[i].min = ~0;
> +		uV[i].max = 0;
> +
> +		list_for_each_entry_rcu(opp, &opp_table->opp_list, node) {
> +			if (!opp->available)
> +				continue;
> +
> +			if (opp->supplies[i].u_volt_min < uV[i].min)
> +				uV[i].min = opp->supplies[i].u_volt_min;
> +			if (opp->supplies[i].u_volt_max > uV[i].max)
> +				uV[i].max = opp->supplies[i].u_volt_max;
> +		}
>  	}
>  
>  	rcu_read_unlock();
> @@ -924,35 +960,50 @@ struct dev_pm_opp *_allocate_opp(struct device *dev,
>  				 struct opp_table **opp_table)
>  {
>  	struct dev_pm_opp *opp;
> +	int count, supply_size;
> +	struct opp_table *table;
>  
> -	/* allocate new OPP node */
> -	opp = kzalloc(sizeof(*opp), GFP_KERNEL);
> -	if (!opp)
> +	table = _add_opp_table(dev);
> +	if (!table)
>  		return NULL;
>  
> -	INIT_LIST_HEAD(&opp->node);
> +	/* Allocate space for at least one supply */
> +	count = table->regulator_count ? table->regulator_count : 1;
> +	supply_size = sizeof(*opp->supplies) * count;
>  
> -	*opp_table = _add_opp_table(dev);
> -	if (!*opp_table) {
> -		kfree(opp);
> +	/* allocate new OPP node + and supplies structures */

s/+//

> +	opp = kzalloc(sizeof(*opp) + supply_size, GFP_KERNEL);
> +	if (!opp) {
> +		kfree(table);
>  		return NULL;
>  	}
>  
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
