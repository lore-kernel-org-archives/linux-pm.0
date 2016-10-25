From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 5/8] PM / OPP: Add infrastructure to manage multiple
 regulators
Date: Tue, 25 Oct 2016 09:49:53 -0700
Message-ID: <20161025164953.GT26139@codeaurora.org>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
 <32c1feabb59b1f00e1cefde606e3ec7ef738ac12.1476952750.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <32c1feabb59b1f00e1cefde606e3ec7ef738ac12.1476952750.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/20, Viresh Kumar wrote:
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index 37fad2eb0f47..45c70ce07864 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -235,21 +237,44 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
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

How do we allocate under RCU? Doesn't that spit out big warnings?

> +	if (!regulators) {
> +		rcu_read_unlock();
> +		return 0;
> +	}
> +
> +	min_uV = kmalloc(count * (sizeof(*min_uV) + sizeof(*max_uV)),

Do we imagine min_uV is going to be a different size from max_uV?
It may be better to have a struct for min/max pair and then
stride them. Then the kmalloc() can become a kmalloc_array().

> +			 GFP_KERNEL);
> +	if (!min_uV) {
> +		kfree(regulators);
> +		rcu_read_unlock();
> +		return 0;
> +	}
> +
> +	max_uV = min_uV + count;
> +
> +	for (i = 0; i < count; i++) {
> +		min_uV[i] = ~0;
> +		max_uV[i] = 0;
> +
> +		list_for_each_entry_rcu(opp, &opp_table->opp_list, node) {
> +			if (!opp->available)
> +				continue;
>  
> -		if (opp->supply.u_volt_min < min_uV)
> -			min_uV = opp->supply.u_volt_min;
> -		if (opp->supply.u_volt_max > max_uV)
> -			max_uV = opp->supply.u_volt_max;
> +			if (opp->supplies[i].u_volt_min < min_uV[i])
> +				min_uV[i] = opp->supplies[i].u_volt_min;
> +			if (opp->supplies[i].u_volt_max > max_uV[i])
> +				max_uV[i] = opp->supplies[i].u_volt_max;
> +		}
>  	}
>  
>  	rcu_read_unlock();
> @@ -924,35 +960,49 @@ struct dev_pm_opp *_allocate_opp(struct device *dev,
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
> +	opp = kzalloc(sizeof(*opp) + supply_size, GFP_KERNEL);
> +	if (!opp) {
> +		kfree(table);
>  		return NULL;
>  	}
>  
> +	opp->supplies = (struct dev_pm_opp_supply *)(opp + 1);

So put the supplies at the end of the OPP structure as an empty
array?

> +	INIT_LIST_HEAD(&opp->node);
> +
> +	*opp_table = table;
> +
>  	return opp;
>  }
>  
>  static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
>  					 struct opp_table *opp_table)
>  {
> -	struct regulator *reg = opp_table->regulator;
> -
> -	if (!IS_ERR(reg) &&
> -	    !regulator_is_supported_voltage(reg, opp->supply.u_volt_min,
> -					    opp->supply.u_volt_max)) {
> -		pr_warn("%s: OPP minuV: %lu maxuV: %lu, not supported by regulator\n",
> -			__func__, opp->supply.u_volt_min,
> -			opp->supply.u_volt_max);
> -		return false;
> +	struct regulator *reg;
> +	int i;
> +
> +	for (i = 0; i < opp_table->regulator_count; i++) {
> +		reg = opp_table->regulators[i];
> +
> +		if (!regulator_is_supported_voltage(reg,
> +					opp->supplies[i].u_volt_min,
> +					opp->supplies[i].u_volt_max)) {
> +			pr_warn("%s: OPP minuV: %lu maxuV: %lu, not supported by regulator\n",
> +				__func__, opp->supplies[i].u_volt_min,
> +				opp->supplies[i].u_volt_max);
> +			return false;
> +		}
>  	}
>  
>  	return true;
> @@ -984,12 +1034,13 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
>  
>  		/* Duplicate OPPs */
>  		dev_warn(dev, "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
> -			 __func__, opp->rate, opp->supply.u_volt,
> -			 opp->available, new_opp->rate, new_opp->supply.u_volt,
> -			 new_opp->available);
> +			 __func__, opp->rate, opp->supplies[0].u_volt,
> +			 opp->available, new_opp->rate,
> +			 new_opp->supplies[0].u_volt, new_opp->available);
>  
> +		/* Should we compare voltages for all regulators here ? */
>  		return opp->available &&
> -		       new_opp->supply.u_volt == opp->supply.u_volt ? 0 : -EEXIST;
> +		       new_opp->supplies[0].u_volt == opp->supplies[0].u_volt ? 0 : -EEXIST;
>  	}
>  
>  	new_opp->opp_table = opp_table;
> @@ -1303,12 +1354,14 @@ void dev_pm_opp_put_prop_name(struct device *dev)
>  EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
>  
>  /**
> - * dev_pm_opp_set_regulator() - Set regulator name for the device
> + * dev_pm_opp_set_regulators() - Set regulator names for the device
>   * @dev: Device for which regulator name is being set.
> - * @name: Name of the regulator.
> + * @names: Array of pointers to the names of the regulator.
> + * @count: Number of regulators.
>   *
>   * In order to support OPP switching, OPP layer needs to know the name of the
> - * device's regulator, as the core would be required to switch voltages as well.
> + * device's regulators, as the core would be required to switch voltages as
> + * well.
>   *
>   * This must be called before any OPPs are initialized for the device.
>   *
> @@ -1318,11 +1371,12 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
>   * that this function is *NOT* called under RCU protection or in contexts where
>   * mutex cannot be locked.
>   */
> -int dev_pm_opp_set_regulator(struct device *dev, const char *name)
> +int dev_pm_opp_set_regulators(struct device *dev, const char *names[],

Make names a const char * const *? I seem to recall arrays as
function arguments has some problem but my C mastery is failing
right now.

> +			      unsigned int count)
>  {
>  	struct opp_table *opp_table;
>  	struct regulator *reg;
> -	int ret;
> +	int ret, i;
>  
>  	mutex_lock(&opp_table_lock);
>  
> @@ -1338,26 +1392,43 @@ int dev_pm_opp_set_regulator(struct device *dev, const char *name)
>  		goto err;
>  	}
>  
> -	/* Already have a regulator set */
> -	if (WARN_ON(!IS_ERR(opp_table->regulator))) {
> +	/* Already have regulators set */
> +	if (WARN_ON(opp_table->regulators)) {
>  		ret = -EBUSY;
>  		goto err;
>  	}
> -	/* Allocate the regulator */
> -	reg = regulator_get_optional(dev, name);
> -	if (IS_ERR(reg)) {
> -		ret = PTR_ERR(reg);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev, "%s: no regulator (%s) found: %d\n",
> -				__func__, name, ret);
> +
> +	opp_table->regulators = kmalloc_array(count,
> +					      sizeof(*opp_table->regulators),
> +					      GFP_KERNEL);
> +	if (!opp_table->regulators)
>  		goto err;
> +
> +	for (i = 0; i < count; i++) {
> +		reg = regulator_get_optional(dev, names[i]);
> +		pr_info("%s: %d: %p: %s\n", __func__, __LINE__, reg, names[i]);

Debug noise?

> +		if (IS_ERR(reg)) {
> +			ret = PTR_ERR(reg);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "%s: regulator (%s) not found: %d\n",
> +					__func__, names[i], ret);
> +			goto free_regulators;
> +		}
> +
> +		opp_table->regulators[i] = reg;
>  	}
>  
> -	opp_table->regulator = reg;
> +	opp_table->regulator_count = count;
>  
>  	mutex_unlock(&opp_table_lock);
>  	return 0;
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
> diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
> index c897676ca35f..cb5e5fde3d39 100644
> --- a/drivers/base/power/opp/debugfs.c
> +++ b/drivers/base/power/opp/debugfs.c
> @@ -34,6 +34,43 @@ void opp_debug_remove_one(struct dev_pm_opp *opp)
>  	debugfs_remove_recursive(opp->dentry);
>  }
>  
> +static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
> +				      struct opp_table *opp_table,
> +				      struct dentry *pdentry)
> +{
> +	struct dentry *d;
> +	int i = 0;
> +	char name[] = "supply-X"; /* support only 0-9 supplies */

But we don't verify that's the case? Why not use kasprintf() and
free() and then there isn't any limit?

> +
> +	/* Always create at least supply-0 directory */
> +	do {
> +		name[7] = i + '0';
> +
> +		/* Create per-opp directory */
> +		d = debugfs_create_dir(name, pdentry);
> +		if (!d)
> +			return false;
> +
> +		if (!debugfs_create_ulong("u_volt_target", S_IRUGO, d,
> +					  &opp->supplies[i].u_volt))
> +			return false;
> +
> +		if (!debugfs_create_ulong("u_volt_min", S_IRUGO, d,
> +					  &opp->supplies[i].u_volt_min))
> +			return false;
> +
> +		if (!debugfs_create_ulong("u_volt_max", S_IRUGO, d,
> +					  &opp->supplies[i].u_volt_max))
> +			return false;
> +
> +		if (!debugfs_create_ulong("u_amp", S_IRUGO, d,
> +					  &opp->supplies[i].u_amp))
> +			return false;
> +	} while (++i < opp_table->regulator_count);
> +
> +	return true;
> +}
> +
>  int opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
>  {
>  	struct dentry *pdentry = opp_table->dentry;
> diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
> index b7fcd0a1b58b..c857fb07a5bc 100644
> --- a/drivers/base/power/opp/of.c
> +++ b/drivers/base/power/opp/of.c
> @@ -105,12 +106,13 @@ static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
>  static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
>  			      struct opp_table *opp_table)
>  {
> -	u32 microvolt[3] = {0};
> -	u32 val;
> -	int count, ret;
> +	u32 *microvolt, *microamp = NULL;
> +	int supplies, vcount, icount, ret, i, j;
>  	struct property *prop = NULL;
>  	char name[NAME_MAX];
>  
> +	supplies = opp_table->regulator_count ? opp_table->regulator_count : 1;

We can't have regulator_count == 1 by default?

> +
>  	/* Search for "opp-microvolt-<name>" */
>  	if (opp_table->prop_name) {
>  		snprintf(name, sizeof(name), "opp-microvolt-%s",
> @@ -155,7 +155,8 @@ enum opp_table_access {
>   * @supported_hw_count: Number of elements in supported_hw array.
>   * @prop_name: A name to postfix to many DT properties, while parsing them.
>   * @clk: Device's clock handle
> - * @regulator: Supply regulator
> + * @regulators: Supply regulators
> + * @regulator_count: Number of Power Supply regulators

Lowercase Power Supply please.

>   * @dentry:	debugfs dentry pointer of the real device directory (not links).
>   * @dentry_name: Name of the real dentry.
>   *
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 5c07ae05d69a..15cb26118dc7 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -186,7 +186,10 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	 */
>  	name = find_supply_name(cpu_dev);
>  	if (name) {
> -		ret = dev_pm_opp_set_regulator(cpu_dev, name);
> +		const char *names[] = {name};
> +
> +		ret = dev_pm_opp_set_regulators(cpu_dev, names,

We can't just do &names instead here? Hmm...

> +						ARRAY_SIZE(names));
>  		if (ret) {
>  			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
>  				policy->cpu, ret);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
