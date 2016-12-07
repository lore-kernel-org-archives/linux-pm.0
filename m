From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 07/10] PM / OPP: Don't allocate OPP table from
 _opp_allocate()
Date: Tue, 6 Dec 2016 17:02:21 -0800
Message-ID: <20161207010221.GE4388@codeaurora.org>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
 <ab1dbd94f4638ac04a9dd4b526ddaaf136154dd1.1481015522.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58302 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbcLGBCX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 20:02:23 -0500
Content-Disposition: inline
In-Reply-To: <ab1dbd94f4638ac04a9dd4b526ddaaf136154dd1.1481015522.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/06, Viresh Kumar wrote:
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index ef114cf9edcd..6bcbb64a5582 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -1030,33 +1029,24 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
>  EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
>  
>  struct dev_pm_opp *_opp_allocate(struct device *dev,
> -				 struct opp_table **opp_table)
> +				 struct opp_table *opp_table)

Please call it table instead.

>  {
>  	struct dev_pm_opp *opp;
>  	int count, supply_size;
> -	struct opp_table *table;
> -
> -	table = _add_opp_table(dev);

Is this the only user of dev? Why do we keep passing dev to this
function then?

> -	if (!table)
> -		return NULL;
>  
>  	/* Allocate space for at least one supply */
> -	count = table->regulator_count ? table->regulator_count : 1;
> +	count = opp_table->regulator_count ? opp_table->regulator_count : 1;

We keep it table so that this doesn't change.

>  	supply_size = sizeof(*opp->supplies) * count;
>  
> @@ -1142,6 +1132,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
>  
>  /**
>   * _opp_add_v1() - Allocate a OPP based on v1 bindings.
> + * @opp_table:	OPP table
>   * @dev:	device for which we do this operation
>   * @freq:	Frequency in Hz for this OPP
>   * @u_volt:	Voltage in uVolts for this OPP
> @@ -1167,22 +1158,16 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
>   *		Duplicate OPPs (both freq and volt are same) and !opp->available
>   * -ENOMEM	Memory allocation failure
>   */
> -int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
> -		bool dynamic)
> +int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
> +		unsigned long freq, long u_volt, bool dynamic)
>  {
> -	struct opp_table *opp_table;
>  	struct dev_pm_opp *new_opp;
>  	unsigned long tol;
>  	int ret;
>  
> -	/* Hold our table modification lock here */
> -	mutex_lock(&opp_table_lock);

Can we have a mutex locked assertion here? Or a note in the
comments that we assume the opp table lock is held?

> -
> -	new_opp = _opp_allocate(dev, &opp_table);
> -	if (!new_opp) {
> -		ret = -ENOMEM;
> -		goto unlock;
> -	}
> +	new_opp = _opp_allocate(dev, opp_table);
> +	if (!new_opp)
> +		return -ENOMEM;
>  
>  	/* populate the opp table */
>  	new_opp->rate = freq;

Also, now we call the srcu notifier chain with the opp_table_lock
held? That seems not so good. Do we need to drop it and reaquire
the lock across the table lock? Or perhaps we should rethink
widening the lock this much across the notifier.

> @@ -1731,7 +1713,25 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_register_put_opp_helper);
>   */
>  int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
>  {
> -	return _opp_add_v1(dev, freq, u_volt, true);
> +	struct opp_table *opp_table;
> +	int ret;
> +
> +	/* Hold our table modification lock here */
> +	mutex_lock(&opp_table_lock);
> +
> +	opp_table = _add_opp_table(dev);
> +	if (!opp_table) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	ret = _opp_add_v1(opp_table, dev, freq, u_volt, true);
> +	if (ret)
> +		_remove_opp_table(opp_table);
> +
> +unlock:
> +	mutex_unlock(&opp_table_lock);

I'd call it table here too, given that we don't have other tables
inside OPP anyway. But no problem either way.

> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_add);
>  
> diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
> index 442fa46c4f5c..37dd79378f39 100644
> --- a/drivers/base/power/opp/of.c
> +++ b/drivers/base/power/opp/of.c
> @@ -431,9 +421,10 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
>  /* Initializes OPP tables based on old-deprecated bindings */
>  static int _of_add_opp_table_v1(struct device *dev)
>  {
> +	struct opp_table *opp_table;
>  	const struct property *prop;
>  	const __be32 *val;
> -	int nr, ret;
> +	int nr, ret = 0;
>  
>  	prop = of_find_property(dev->of_node, "operating-points", NULL);
>  	if (!prop)
> @@ -451,22 +442,33 @@ static int _of_add_opp_table_v1(struct device *dev)
>  		return -EINVAL;
>  	}
>  
> +	/* Hold our table modification lock here */

This comment is fairly worthless.

> +	mutex_lock(&opp_table_lock);
> +
> +	opp_table = _add_opp_table(dev);
> +	if (!opp_table) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +
>  	val = prop->value;
>  	while (nr) {
>  		unsigned long freq = be32_to_cpup(val++) * 1000;
>  		unsigned long volt = be32_to_cpup(val++);
>  
> -		ret = _opp_add_v1(dev, freq, volt, false);
> +		ret = _opp_add_v1(opp_table, dev, freq, volt, false);
>  		if (ret) {
>  			dev_err(dev, "%s: Failed to add OPP %ld (%d)\n",
>  				__func__, freq, ret);
> -			dev_pm_opp_of_remove_table(dev);
> -			return ret;
> +			_dev_pm_opp_remove_table(opp_table, dev, false);
> +			break;
>  		}
>  		nr -= 2;
>  	}
>  
> -	return 0;
> +unlock:
> +	mutex_unlock(&opp_table_lock);
> +	return ret;
>  }
>  
>  /**

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
