From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 5/8] PM / OPP: Add infrastructure to manage multiple
 regulators
Date: Mon, 24 Oct 2016 09:05:18 +0530
Message-ID: <20161024033518.GB24749@vireshk-i7>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
 <32c1feabb59b1f00e1cefde606e3ec7ef738ac12.1476952750.git.viresh.kumar@linaro.org>
 <580A9798.9070403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:32857 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756932AbcJXDfY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Oct 2016 23:35:24 -0400
Received: by mail-pf0-f174.google.com with SMTP id 128so90114299pfz.0
        for <linux-pm@vger.kernel.org>; Sun, 23 Oct 2016 20:35:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <580A9798.9070403@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, broonie@kernel.org

On 21-10-16, 17:32, Dave Gerlach wrote:
> Hi,
> On 10/20/2016 03:44 AM, Viresh Kumar wrote:
> > This patch adds infrastructure to manage multiple regulators and updates
> > the only user (cpufreq-dt) of dev_pm_opp_set{put}_regulator().
> >
> > This is preparatory work for adding full support for devices with
> > multiple regulators.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/base/power/opp/core.c    | 220 ++++++++++++++++++++++++++-------------
> >  drivers/base/power/opp/debugfs.c |  48 +++++++--
> >  drivers/base/power/opp/of.c      | 102 +++++++++++++-----
> >  drivers/base/power/opp/opp.h     |  10 +-
> >  drivers/cpufreq/cpufreq-dt.c     |   9 +-
> >  include/linux/pm_opp.h           |   8 +-
> >  6 files changed, 276 insertions(+), 121 deletions(-)
> >
> > diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> > index 37fad2eb0f47..45c70ce07864 100644
> > --- a/drivers/base/power/opp/core.c
> > +++ b/drivers/base/power/opp/core.c
> > @@ -93,6 +93,8 @@ struct opp_table *_find_opp_table(struct device *dev)
> >   * Return: voltage in micro volt corresponding to the opp, else
> >   * return 0
> >   *
> > + * This is useful only for devices with single power supply.
> > + *
> >   * Locking: This function must be called under rcu_read_lock(). opp is a rcu
> >   * protected pointer. This means that opp which could have been fetched by
> >   * opp_find_freq_{exact,ceil,floor} functions is valid as long as we are
> > @@ -112,7 +114,7 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
> >  	if (IS_ERR_OR_NULL(tmp_opp))
> >  		pr_err("%s: Invalid parameters\n", __func__);
> >  	else
> > -		v = tmp_opp->supply.u_volt;
> > +		v = tmp_opp->supplies[0].u_volt;
> >
> >  	return v;
> >  }
> > @@ -222,10 +224,10 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
> >  {
> >  	struct opp_table *opp_table;
> >  	struct dev_pm_opp *opp;
> > -	struct regulator *reg;
> > +	struct regulator *reg, **regulators;
> >  	unsigned long latency_ns = 0;
> > -	unsigned long min_uV = ~0, max_uV = 0;
> > -	int ret;
> > +	unsigned long *min_uV, *max_uV;
> > +	int ret, size, i, count;
> >
> >  	rcu_read_lock();
> >
> > @@ -235,21 +237,44 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
> >  		return 0;
> >  	}
> >
> > -	reg = opp_table->regulator;
> > -	if (IS_ERR(reg)) {
> > +	count = opp_table->regulator_count;
> > +
> > +	if (!count) {
> >  		/* Regulator may not be required for device */
> >  		rcu_read_unlock();
> >  		return 0;
> >  	}
> >
> > -	list_for_each_entry_rcu(opp, &opp_table->opp_list, node) {
> > -		if (!opp->available)
> > -			continue;
> > +	size = count * sizeof(*regulators);
> > +	regulators = kmemdup(opp_table->regulators, size, GFP_KERNEL);
> > +	if (!regulators) {
> > +		rcu_read_unlock();
> > +		return 0;
> > +	}
> > +
> > +	min_uV = kmalloc(count * (sizeof(*min_uV) + sizeof(*max_uV)),
> > +			 GFP_KERNEL);
> > +	if (!min_uV) {
> > +		kfree(regulators);
> > +		rcu_read_unlock();
> > +		return 0;
> > +	}
> > +
> > +	max_uV = min_uV + count;
> > +
> > +	for (i = 0; i < count; i++) {
> > +		min_uV[i] = ~0;
> > +		max_uV[i] = 0;
> > +
> > +		list_for_each_entry_rcu(opp, &opp_table->opp_list, node) {
> > +			if (!opp->available)
> > +				continue;
> >
> > -		if (opp->supply.u_volt_min < min_uV)
> > -			min_uV = opp->supply.u_volt_min;
> > -		if (opp->supply.u_volt_max > max_uV)
> > -			max_uV = opp->supply.u_volt_max;
> > +			if (opp->supplies[i].u_volt_min < min_uV[i])
> > +				min_uV[i] = opp->supplies[i].u_volt_min;
> > +			if (opp->supplies[i].u_volt_max > max_uV[i])
> > +				max_uV[i] = opp->supplies[i].u_volt_max;
> > +		}
> >  	}
> >
> >  	rcu_read_unlock();
> > @@ -258,9 +283,14 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
> >  	 * The caller needs to ensure that opp_table (and hence the regulator)
> >  	 * isn't freed, while we are executing this routine.
> >  	 */
> > -	ret = regulator_set_voltage_time(reg, min_uV, max_uV);
> > -	if (ret > 0)
> > -		latency_ns = ret * 1000;
> > +	for (i = 0; reg = regulators[i], i < count; i++) {
> > +		ret = regulator_set_voltage_time(reg, min_uV[i], max_uV[i]);
> > +		if (ret > 0)
> > +			latency_ns += ret * 1000;
> > +	}
> > +
> > +	kfree(min_uV);
> > +	kfree(regulators);
> >
> >  	return latency_ns;
> >  }
> > @@ -580,7 +610,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
> >  {
> >  	struct opp_table *opp_table;
> >  	struct dev_pm_opp *old_opp, *opp;
> > -	struct regulator *reg;
> > +	struct regulator *reg = ERR_PTR(-ENXIO);
> >  	struct clk *clk;
> >  	unsigned long freq, old_freq;
> >  	struct dev_pm_opp_supply old_supply, new_supply;
> > @@ -633,14 +663,23 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
> >  		return ret;
> >  	}
> >
> > +	if (opp_table->regulators) {
> > +		/* This function only supports single regulator per device */
> > +		if (WARN_ON(opp_table->regulator_count > 1)) {
> > +			dev_err(dev, "multiple regulators not supported\n");
> > +			rcu_read_unlock();
> > +			return -EINVAL;
> > +		}
> > +
> > +		reg = opp_table->regulators[0];
> > +	}
> > +
> >  	if (IS_ERR(old_opp))
> >  		old_supply.u_volt = 0;
> >  	else
> > -		memcpy(&old_supply, &old_opp->supply, sizeof(old_supply));
> > +		memcpy(&old_supply, old_opp->supplies, sizeof(old_supply));
> >
> > -	memcpy(&new_supply, &opp->supply, sizeof(new_supply));
> > -
> > -	reg = opp_table->regulator;
> > +	memcpy(&new_supply, opp->supplies, sizeof(new_supply));
> >
> >  	rcu_read_unlock();
> >
> > @@ -764,9 +803,6 @@ static struct opp_table *_add_opp_table(struct device *dev)
> >
> >  	_of_init_opp_table(opp_table, dev);
> >
> > -	/* Set regulator to a non-NULL error value */
> > -	opp_table->regulator = ERR_PTR(-ENXIO);
> > -
> >  	/* Find clk for the device */
> >  	opp_table->clk = clk_get(dev, NULL);
> >  	if (IS_ERR(opp_table->clk)) {
> > @@ -815,7 +851,7 @@ static void _remove_opp_table(struct opp_table *opp_table)
> >  	if (opp_table->prop_name)
> >  		return;
> >
> > -	if (!IS_ERR(opp_table->regulator))
> > +	if (opp_table->regulators)
> >  		return;
> >
> >  	/* Release clk */
> > @@ -924,35 +960,49 @@ struct dev_pm_opp *_allocate_opp(struct device *dev,
> >  				 struct opp_table **opp_table)
> >  {
> >  	struct dev_pm_opp *opp;
> > +	int count, supply_size;
> > +	struct opp_table *table;
> >
> > -	/* allocate new OPP node */
> > -	opp = kzalloc(sizeof(*opp), GFP_KERNEL);
> > -	if (!opp)
> > +	table = _add_opp_table(dev);
> > +	if (!table)
> >  		return NULL;
> >
> > -	INIT_LIST_HEAD(&opp->node);
> > +	/* Allocate space for at least one supply */
> > +	count = table->regulator_count ? table->regulator_count : 1;
> > +	supply_size = sizeof(*opp->supplies) * count;
> >
> > -	*opp_table = _add_opp_table(dev);
> > -	if (!*opp_table) {
> > -		kfree(opp);
> > +	/* allocate new OPP node + and supplies structures */
> > +	opp = kzalloc(sizeof(*opp) + supply_size, GFP_KERNEL);
> > +	if (!opp) {
> > +		kfree(table);
> >  		return NULL;
> >  	}
> >
> > +	opp->supplies = (struct dev_pm_opp_supply *)(opp + 1);
> > +	INIT_LIST_HEAD(&opp->node);
> > +
> > +	*opp_table = table;
> > +
> >  	return opp;
> >  }
> >
> >  static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
> >  					 struct opp_table *opp_table)
> >  {
> > -	struct regulator *reg = opp_table->regulator;
> > -
> > -	if (!IS_ERR(reg) &&
> > -	    !regulator_is_supported_voltage(reg, opp->supply.u_volt_min,
> > -					    opp->supply.u_volt_max)) {
> > -		pr_warn("%s: OPP minuV: %lu maxuV: %lu, not supported by regulator\n",
> > -			__func__, opp->supply.u_volt_min,
> > -			opp->supply.u_volt_max);
> > -		return false;
> > +	struct regulator *reg;
> > +	int i;
> > +
> > +	for (i = 0; i < opp_table->regulator_count; i++) {
> > +		reg = opp_table->regulators[i];
> > +
> > +		if (!regulator_is_supported_voltage(reg,
> > +					opp->supplies[i].u_volt_min,
> > +					opp->supplies[i].u_volt_max)) {
> > +			pr_warn("%s: OPP minuV: %lu maxuV: %lu, not supported by regulator\n",
> > +				__func__, opp->supplies[i].u_volt_min,
> > +				opp->supplies[i].u_volt_max);
> > +			return false;
> > +		}
> >  	}
> >
> >  	return true;
> > @@ -984,12 +1034,13 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
> >
> >  		/* Duplicate OPPs */
> >  		dev_warn(dev, "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
> > -			 __func__, opp->rate, opp->supply.u_volt,
> > -			 opp->available, new_opp->rate, new_opp->supply.u_volt,
> > -			 new_opp->available);
> > +			 __func__, opp->rate, opp->supplies[0].u_volt,
> > +			 opp->available, new_opp->rate,
> > +			 new_opp->supplies[0].u_volt, new_opp->available);
> >
> > +		/* Should we compare voltages for all regulators here ? */
> >  		return opp->available &&
> > -		       new_opp->supply.u_volt == opp->supply.u_volt ? 0 : -EEXIST;
> > +		       new_opp->supplies[0].u_volt == opp->supplies[0].u_volt ? 0 : -EEXIST;
> >  	}
> >
> >  	new_opp->opp_table = opp_table;
> > @@ -1056,9 +1107,9 @@ int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
> >  	/* populate the opp table */
> >  	new_opp->rate = freq;
> >  	tol = u_volt * opp_table->voltage_tolerance_v1 / 100;
> > -	new_opp->supply.u_volt = u_volt;
> > -	new_opp->supply.u_volt_min = u_volt - tol;
> > -	new_opp->supply.u_volt_max = u_volt + tol;
> > +	new_opp->supplies[0].u_volt = u_volt;
> > +	new_opp->supplies[0].u_volt_min = u_volt - tol;
> > +	new_opp->supplies[0].u_volt_max = u_volt + tol;
> >  	new_opp->available = true;
> >  	new_opp->dynamic = dynamic;
> >
> > @@ -1303,12 +1354,14 @@ void dev_pm_opp_put_prop_name(struct device *dev)
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
> >
> >  /**
> > - * dev_pm_opp_set_regulator() - Set regulator name for the device
> > + * dev_pm_opp_set_regulators() - Set regulator names for the device
> >   * @dev: Device for which regulator name is being set.
> > - * @name: Name of the regulator.
> > + * @names: Array of pointers to the names of the regulator.
> > + * @count: Number of regulators.
> >   *
> >   * In order to support OPP switching, OPP layer needs to know the name of the
> > - * device's regulator, as the core would be required to switch voltages as well.
> > + * device's regulators, as the core would be required to switch voltages as
> > + * well.
> >   *
> >   * This must be called before any OPPs are initialized for the device.
> >   *
> > @@ -1318,11 +1371,12 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
> >   * that this function is *NOT* called under RCU protection or in contexts where
> >   * mutex cannot be locked.
> >   */
> > -int dev_pm_opp_set_regulator(struct device *dev, const char *name)
> > +int dev_pm_opp_set_regulators(struct device *dev, const char *names[],
> > +			      unsigned int count)
> >  {
> >  	struct opp_table *opp_table;
> >  	struct regulator *reg;
> > -	int ret;
> > +	int ret, i;
> >
> >  	mutex_lock(&opp_table_lock);
> >
> > @@ -1338,26 +1392,43 @@ int dev_pm_opp_set_regulator(struct device *dev, const char *name)
> >  		goto err;
> >  	}
> >
> > -	/* Already have a regulator set */
> > -	if (WARN_ON(!IS_ERR(opp_table->regulator))) {
> > +	/* Already have regulators set */
> > +	if (WARN_ON(opp_table->regulators)) {
> >  		ret = -EBUSY;
> >  		goto err;
> >  	}
> > -	/* Allocate the regulator */
> > -	reg = regulator_get_optional(dev, name);
> > -	if (IS_ERR(reg)) {
> > -		ret = PTR_ERR(reg);
> > -		if (ret != -EPROBE_DEFER)
> > -			dev_err(dev, "%s: no regulator (%s) found: %d\n",
> > -				__func__, name, ret);
> > +
> > +	opp_table->regulators = kmalloc_array(count,
> > +					      sizeof(*opp_table->regulators),
> > +					      GFP_KERNEL);
> > +	if (!opp_table->regulators)
> >  		goto err;
> > +
> > +	for (i = 0; i < count; i++) {
> > +		reg = regulator_get_optional(dev, names[i]);
> > +		pr_info("%s: %d: %p: %s\n", __func__, __LINE__, reg, names[i]);
> 
> Think this is leftover debug msg?

Yes.

> > +		if (IS_ERR(reg)) {
> > +			ret = PTR_ERR(reg);
> > +			if (ret != -EPROBE_DEFER)
> > +				dev_err(dev, "%s: regulator (%s) not found: %d\n",
> > +					__func__, names[i], ret);
> > +			goto free_regulators;
> > +		}
> > +
> > +		opp_table->regulators[i] = reg;
> >  	}
> >
> > -	opp_table->regulator = reg;
> > +	opp_table->regulator_count = count;
> >
> >  	mutex_unlock(&opp_table_lock);
> >  	return 0;
> >
> > +free_regulators:
> > +	while (i != 0)
> > +		regulator_put(opp_table->regulators[--i]);
> > +
> > +	kfree(opp_table->regulators);
> > +	opp_table->regulators = NULL;
> >  err:
> >  	_remove_opp_table(opp_table);
> >  unlock:
> > @@ -1365,11 +1436,11 @@ int dev_pm_opp_set_regulator(struct device *dev, const char *name)
> >
> >  	return ret;
> >  }
> > -EXPORT_SYMBOL_GPL(dev_pm_opp_set_regulator);
> > +EXPORT_SYMBOL_GPL(dev_pm_opp_set_regulators);
> >
> >  /**
> > - * dev_pm_opp_put_regulator() - Releases resources blocked for regulator
> > - * @dev: Device for which regulator was set.
> > + * dev_pm_opp_put_regulators() - Releases resources blocked for regulators
> > + * @dev: Device for which regulators were set.
> >   *
> >   * Locking: The internal opp_table and opp structures are RCU protected.
> >   * Hence this function internally uses RCU updater strategy with mutex locks
> > @@ -1377,9 +1448,10 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_regulator);
> >   * that this function is *NOT* called under RCU protection or in contexts where
> >   * mutex cannot be locked.
> >   */
> > -void dev_pm_opp_put_regulator(struct device *dev)
> > +void dev_pm_opp_put_regulators(struct device *dev)
> >  {
> >  	struct opp_table *opp_table;
> > +	int i;
> >
> >  	mutex_lock(&opp_table_lock);
> >
> > @@ -1391,16 +1463,20 @@ void dev_pm_opp_put_regulator(struct device *dev)
> >  		goto unlock;
> >  	}
> >
> > -	if (IS_ERR(opp_table->regulator)) {
> > -		dev_err(dev, "%s: Doesn't have regulator set\n", __func__);
> > +	if (!opp_table->regulators) {
> > +		dev_err(dev, "%s: Doesn't have regulators set\n", __func__);
> >  		goto unlock;
> >  	}
> >
> >  	/* Make sure there are no concurrent readers while updating opp_table */
> >  	WARN_ON(!list_empty(&opp_table->opp_list));
> >
> > -	regulator_put(opp_table->regulator);
> > -	opp_table->regulator = ERR_PTR(-ENXIO);
> > +	for (i = opp_table->regulator_count - 1; i >= 0; i--)
> > +		regulator_put(opp_table->regulators[i]);
> > +
> > +	kfree(opp_table->regulators);
> > +	opp_table->regulators = NULL;
> > +	opp_table->regulator_count = 0;
> >
> >  	/* Try freeing opp_table if this was the last blocking resource */
> >  	_remove_opp_table(opp_table);
> > @@ -1408,7 +1484,7 @@ void dev_pm_opp_put_regulator(struct device *dev)
> >  unlock:
> >  	mutex_unlock(&opp_table_lock);
> >  }
> > -EXPORT_SYMBOL_GPL(dev_pm_opp_put_regulator);
> > +EXPORT_SYMBOL_GPL(dev_pm_opp_put_regulators);
> >
> >  /**
> >   * dev_pm_opp_add()  - Add an OPP table from a table definitions
> > diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
> > index c897676ca35f..cb5e5fde3d39 100644
> > --- a/drivers/base/power/opp/debugfs.c
> > +++ b/drivers/base/power/opp/debugfs.c
> > @@ -34,6 +34,43 @@ void opp_debug_remove_one(struct dev_pm_opp *opp)
> >  	debugfs_remove_recursive(opp->dentry);
> >  }
> >
> > +static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
> > +				      struct opp_table *opp_table,
> > +				      struct dentry *pdentry)
> > +{
> > +	struct dentry *d;
> > +	int i = 0;
> > +	char name[] = "supply-X"; /* support only 0-9 supplies */
> > +
> > +	/* Always create at least supply-0 directory */
> > +	do {
> > +		name[7] = i + '0';
> > +
> > +		/* Create per-opp directory */
> > +		d = debugfs_create_dir(name, pdentry);
> > +		if (!d)
> > +			return false;
> > +
> > +		if (!debugfs_create_ulong("u_volt_target", S_IRUGO, d,
> > +					  &opp->supplies[i].u_volt))
> > +			return false;
> > +
> > +		if (!debugfs_create_ulong("u_volt_min", S_IRUGO, d,
> > +					  &opp->supplies[i].u_volt_min))
> > +			return false;
> > +
> > +		if (!debugfs_create_ulong("u_volt_max", S_IRUGO, d,
> > +					  &opp->supplies[i].u_volt_max))
> > +			return false;
> > +
> > +		if (!debugfs_create_ulong("u_amp", S_IRUGO, d,
> > +					  &opp->supplies[i].u_amp))
> > +			return false;
> > +	} while (++i < opp_table->regulator_count);
> > +
> > +	return true;
> > +}
> > +
> >  int opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
> >  {
> >  	struct dentry *pdentry = opp_table->dentry;
> > @@ -63,16 +100,7 @@ int opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
> >  	if (!debugfs_create_ulong("rate_hz", S_IRUGO, d, &opp->rate))
> >  		return -ENOMEM;
> >
> > -	if (!debugfs_create_ulong("u_volt_target", S_IRUGO, d, &opp->supply.u_volt))
> > -		return -ENOMEM;
> > -
> > -	if (!debugfs_create_ulong("u_volt_min", S_IRUGO, d, &opp->supply.u_volt_min))
> > -		return -ENOMEM;
> > -
> > -	if (!debugfs_create_ulong("u_volt_max", S_IRUGO, d, &opp->supply.u_volt_max))
> > -		return -ENOMEM;
> > -
> > -	if (!debugfs_create_ulong("u_amp", S_IRUGO, d, &opp->supply.u_amp))
> > +	if (!opp_debug_create_supplies(opp, opp_table, d))
> >  		return -ENOMEM;
> >
> >  	if (!debugfs_create_ulong("clock_latency_ns", S_IRUGO, d,
> > diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
> > index b7fcd0a1b58b..c857fb07a5bc 100644
> > --- a/drivers/base/power/opp/of.c
> > +++ b/drivers/base/power/opp/of.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/device.h>
> >  #include <linux/of.h>
> > +#include <linux/slab.h>
> >  #include <linux/export.h>
> >
> >  #include "opp.h"
> > @@ -105,12 +106,13 @@ static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
> 
> Though not in the patch there's a comment to
> 
> /* TODO: Support multiple regulators */
> 
> in the file right above the below opp_parse_supplies function that can probably
> be removed as part of this patch.

Sure.

-- 
viresh
