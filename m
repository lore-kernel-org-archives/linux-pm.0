From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 1/4] thermal: Add support for hierarchical thermal
 zones
Date: Wed, 2 Mar 2016 19:12:46 -0800
Message-ID: <20160303031244.GA3379@localhost.localdomain>
References: <1448464186-26289-1-git-send-email-javi.merino@arm.com>
 <1448464186-26289-2-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36767 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbcCCDMu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 22:12:50 -0500
Content-Disposition: inline
In-Reply-To: <1448464186-26289-2-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rui.zang@intel.com, Zhang Rui <rui.zhang@intel.com>


Thanks for moving this forward Javi,

Few comments inline.

On Wed, Nov 25, 2015 at 03:09:43PM +0000, Javi Merino wrote:
> Add the ability to stack thermal zones on top of each other, creating a
> hierarchy of thermal zones.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> ---
>  Documentation/thermal/sysfs-api.txt |  39 +++++++
>  drivers/thermal/thermal_core.c      | 210 +++++++++++++++++++++++++++++++++++-
>  include/linux/thermal.h             |  41 ++++++-
>  3 files changed, 284 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
> index 10f062ea6bc2..dda24a0bdeec 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -72,6 +72,45 @@ temperature) and throttle appropriate devices.
>      It deletes the corresponding entry form /sys/class/thermal folder and
>      unbind all the thermal cooling devices it uses.
>  
> +
> +1.1.3 int thermal_zone_add_subtz(struct thermal_zone_device *tz,
> +                                 struct thermal_zone_device *subtz)

This does not match the signature proposed below in the code. But hold
on, check my comments there too.

> +
> +    Add subtz to the list of slaves of tz.  This lets you create a
> +    hierarchy of thermal zones.  The hierarchy must be a Direct
> +    Acyclic Graph (DAG).  If a loop is detected,
> +    thermal_zone_get_temp() will return -EDEADLK to prevent the
> +    deadlock.  thermal_zone_add_subtz() does not affect subtz.
> +
> +    When calculating the temperature of thermal zone tz, report it as
> +    an aggregation of the temperatures of the sub thermal zones.  For
> +    details of the aggregation function see the enum
> +    thermal_aggregation_function.
> +
> +    For example, if you have an SoC with a thermal sensor in each cpu
> +    of the two cpus you could have a thermal zone to monitor each
> +    sensor, let's call them cpu0_tz and cpu1_tz.  You could then have a
> +    a SoC thermal zone (soc_tz) without a get_temp() op which can be
> +    configured like this:
> +
> +    thermal_zone_add_subtz(soc_tz, cpu0_tz);
> +    thermal_zone_add_subtz(soc_tz, cpu1_tz);
> +
> +    Now soc_tz's temperature is the aggregation of cpu0_tz and
> +    cpu1_tz.
> +
> +
> +1.1.4 int thermal_zone_del_subtz(struct thermal_zone_device *tz,
> +                                 struct thermal_zone_device *subtz)
> +
> +    Delete subtz from the slave thermal zones of tz.  This basically
> +    reverses what thermal_zone_add_subtz() does.  If tz still has
> +    other slave thermal zones, its temperature would be the
> +    aggregation of the remaining slave thermal zones.  If tz no longer
> +    has slave thermal zones, thermal_zone_get_temp() will return
> +    -EINVAL.
> +
> +
>  1.2 thermal cooling device interface
>  1.2.1 struct thermal_cooling_device *thermal_cooling_device_register(char *name,
>  		void *devdata, struct thermal_cooling_device_ops *)
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index d9e525cc9c1c..98bdb63b3b95 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -61,6 +61,20 @@ static DEFINE_MUTEX(thermal_governor_lock);
>  
>  static struct thermal_governor *def_governor;
>  
> +/**
> + * struct thermal_zone_link - a link between "master" and "slave" thermal zones
> + * @weight:	weight of the @slave thermal zone in the master
> + *		calculation.  Used when the master thermal zone's
> + *		aggregation function is THERMAL_AGG_WEIGHTED_AVG
> + * @slave:	pointer to the slave thermal zone
> + * @node:	list node in the master thermal zone's slave_tzs list.
> + */
> +struct thermal_zone_link {
> +	int weight;
> +	struct thermal_zone_device *slave;
> +	struct list_head node;
> +};
> +

How about this struct be in thermal_core.h?  I think we should support
also aggregation functions implemented by drivers, and therefore they
should have access to this data. Also they will probably need a
driver_data too.

>  static struct thermal_governor *__find_governor(const char *name)
>  {
>  	struct thermal_governor *pos;
> @@ -465,6 +479,80 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>  }
>  
>  /**
> + * get_subtz_temp() - get the aggregate temperature of all the sub thermal zones
> + * @tz:	thermal zone pointer
> + * @temp: pointer in which to store the result
> + *
> + * Go through all the thermal zones listed in @tz slave_tzs and
> + * calculate the aggregate temperature of all of them.  The result is
> + * stored in @temp.  The function used for aggregation is defined by
> + * the thermal zone's "slave_agg_function" parameter.  It can only be
> + * THERMAL_AGG_MAX or THERMAL_AGG_WEIGHTED_AVG.  If THERMAL_AGG_MAX is
> + * used then the @temp holds the maximum temperature of all slave
> + * thermal zones.  With THERMAL_AGG_WEIGHTED_AVG a weighted average of
> + * all temperatures is calculated.  Each thermal zone's temperature is
> + * multiplied by its weight and the result is divided by the sum of
> + * all weights.  If all weights are zero, the result is the average
> + * weight of the thermal zones.
> + *
> + * Return: 0 on success, -EINVAL if there are no slave thermal zones,
> + * -E* if thermal_zone_get_temp() fails for any of the slave thermal
> + * zones.
> + */
> +static int get_subtz_temp(struct thermal_zone_device *tz, int *temp)
> +{
> +	struct thermal_zone_link *link;
> +	int ret_temp, total_weight = 0;
> +	bool all_weights_are_zero = false;
> +
> +	if (list_empty(&tz->slave_tzs))
> +		return -EINVAL;
> +
> +	if (tz->slave_agg_function == THERMAL_AGG_WEIGHTED_AVG) {
> +		int total_instances = 0;
> +
> +		list_for_each_entry(link, &tz->slave_tzs, node) {
> +			total_weight += link->weight;
> +			total_instances++;
> +		}
> +
> +		if (!total_weight) {
> +			all_weights_are_zero = true;
> +			total_weight = total_instances;
> +		} else {
> +			all_weights_are_zero = false;
> +		}
> +
> +		ret_temp = 0;
> +	} else if (tz->slave_agg_function == THERMAL_AGG_MAX) {
> +		ret_temp = INT_MIN;
> +	}
> +
> +	list_for_each_entry(link, &tz->slave_tzs, node) {
> +		int this_temp, ret;
> +
> +		ret = thermal_zone_get_temp(link->slave, &this_temp);
> +		if (ret)
> +			return ret;
> +
> +		if (tz->slave_agg_function == THERMAL_AGG_MAX) {
> +			if (this_temp > ret_temp)
> +				ret_temp = this_temp;
> +		} else if (tz->slave_agg_function == THERMAL_AGG_WEIGHTED_AVG) {
> +			int weight = all_weights_are_zero ? 1 : link->weight;
> +
> +			ret_temp += weight * this_temp;
> +		}
> +	}
> +
> +	if (tz->slave_agg_function == THERMAL_AGG_WEIGHTED_AVG)
> +		ret_temp /= total_weight;
> +
> +	*temp = ret_temp;
> +	return 0;
> +}
> +
> +/**
>   * thermal_zone_get_temp() - returns the temperature of a thermal zone
>   * @tz: a valid pointer to a struct thermal_zone_device
>   * @temp: a valid pointer to where to store the resulting temperature.
> @@ -481,11 +569,22 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>  	int crit_temp = INT_MAX;
>  	enum thermal_trip_type type;
>  
> -	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
> +	if (!tz || IS_ERR(tz))
>  		goto exit;
>  
> +	/* Avoid loops */
> +	if (tz->slave_tz_visited)
> +		return -EDEADLK;
> +
>  	mutex_lock(&tz->lock);
>  
> +	tz->slave_tz_visited = true;
> +
> +	if (!tz->ops->get_temp) {
> +		ret = get_subtz_temp(tz, temp);
> +		goto unlock;
> +	}
> +

We probably need to revisit this. Are you able to set emulation
temperature in thermal zone that has aggregation functions?

>  	ret = tz->ops->get_temp(tz, temp);
>  
>  	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
> @@ -506,7 +605,9 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>  		if (!ret && *temp < crit_temp)
>  			*temp = tz->emul_temperature;
>  	}
> - 
> +
> +unlock:
> +	tz->slave_tz_visited = false;
>  	mutex_unlock(&tz->lock);
>  exit:
>  	return ret;
> @@ -540,9 +641,6 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
>  {
>  	int count;
>  
> -	if (!tz->ops->get_temp)
> -		return;
> -
>  	update_temperature(tz);
>  
>  	for (count = 0; count < tz->trips; count++)
> @@ -1785,10 +1883,17 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>  	if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
>  		return ERR_PTR(-EINVAL);
>  
> +	if (tzp && (tzp->agg_func != THERMAL_AGG_MAX) &&
> +	    (tzp->agg_func != THERMAL_AGG_WEIGHTED_AVG))
> +		return ERR_PTR(-EINVAL);
> +
>  	tz = kzalloc(sizeof(struct thermal_zone_device), GFP_KERNEL);
>  	if (!tz)
>  		return ERR_PTR(-ENOMEM);
>  
> +	if (tzp)
> +		tz->slave_agg_function = tzp->agg_func;
> +	INIT_LIST_HEAD(&tz->slave_tzs);
>  	INIT_LIST_HEAD(&tz->thermal_instances);
>  	idr_init(&tz->idr);
>  	mutex_init(&tz->lock);
> @@ -1921,6 +2026,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  	const struct thermal_zone_params *tzp;
>  	struct thermal_cooling_device *cdev;
>  	struct thermal_zone_device *pos = NULL;
> +	struct thermal_zone_link *link, *tmp;
>  
>  	if (!tz)
>  		return;
> @@ -1958,6 +2064,9 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  
>  	mutex_unlock(&thermal_list_lock);
>  
> +	list_for_each_entry_safe(link, tmp, &tz->slave_tzs, node)
> +		thermal_zone_del_subtz(tz, link->slave);
> +
>  	thermal_zone_device_set_polling(tz, 0);
>  
>  	if (tz->type[0])
> @@ -1980,6 +2089,97 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
>  
>  /**
> + * thermal_zone_add_subtz() - add a sub thermal zone to a thermal zone
> + * @tz:	pointer to the master thermal zone
> + * @subtz: pointer to the slave thermal zone
> + * @weight: relative contribution of the sub thermal zone
> + *
> + * Add @subtz to the list of slave thermal zones of @tz.  If @tz
> + * doesn't provide a get_temp() op, its temperature will be calculated
> + * as a combination of the temperatures of its sub thermal zones.  The
> + * @weight is the relative contribution of this thermal zone when
> + * using THERMAL_AGG_WEIGHTED_AVG.  Set @weight to
> + * THERMAL_WEIGHT_DEFAULT for all sub thermal zones to do a simple
> + * average.  See get_sub_tz_temp() for more information on how the
> + * temperature for @tz is calculated.
> + *
> + * Return: 0 on success, -EINVAL if @tz or @subtz are not valid
> + * pointers, -EEXIST if the link already exists or -ENOMEM if we ran
> + * out of memory.
> + */
> +int thermal_zone_add_subtz(struct thermal_zone_device *tz,
> +			   struct thermal_zone_device *subtz, int weight)
> +{
> +	int ret;
> +	struct thermal_zone_link *link;
> +
> +	if (IS_ERR_OR_NULL(tz) || IS_ERR_OR_NULL(subtz))
> +		return -EINVAL;
> +
> +	mutex_lock(&tz->lock);
> +
> +	list_for_each_entry(link, &tz->slave_tzs, node) {
> +		if (link->slave == subtz) {
> +			ret = -EEXIST;
> +			goto unlock;
> +		}
> +	}
> +
> +	link = kzalloc(sizeof(*link), GFP_KERNEL);
> +	if (!link) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	link->slave = subtz;
> +	link->weight = weight;
> +	list_add_tail(&link->node, &tz->slave_tzs);
> +
> +	ret = 0;
> +
> +unlock:
> +	mutex_unlock(&tz->lock);
> +
> +	return ret;
> +}
> +
> +/**
> + * thermal_zone_del_subtz() - delete a sub thermal zone from its master thermal zone
> + * @tz:	pointer to the master thermal zone
> + * @subtz: pointer to the slave thermal zone
> + *
> + * Remove @subtz from the list of slave thermal zones of @tz.
> + *
> + * Return: 0 on success, -EINVAL if either thermal is invalid or if
> + * @subtz is not a slave of @tz.
> + */
> +int thermal_zone_del_subtz(struct thermal_zone_device *tz,
> +			   struct thermal_zone_device *subtz)
> +{
> +	int ret = -EINVAL;
> +	struct thermal_zone_link *link;
> +
> +	if (IS_ERR_OR_NULL(tz) || IS_ERR_OR_NULL(subtz))
> +		return -EINVAL;
> +
> +	mutex_lock(&tz->lock);
> +
> +	list_for_each_entry(link, &tz->slave_tzs, node) {
> +		if (link->slave == subtz) {
> +			list_del(&link->node);
> +			kfree(link);
> +
> +			ret = 0;
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&tz->lock);
> +
> +	return ret;
> +}
> +
> +/**
>   * thermal_zone_get_zone_by_name() - search for a zone and returns its ref
>   * @name: thermal zone name to fetch the temperature
>   *
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 4014a59828fc..dc3d2ab77ab6 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -40,7 +40,7 @@
>  /* No upper/lower limit requirement */
>  #define THERMAL_NO_LIMIT	((u32)~0)
>  
> -/* Default weight of a bound cooling device */
> +/* Default weight for cooling devices and sub thermal zones */
>  #define THERMAL_WEIGHT_DEFAULT 0
>  
>  /* Unit conversion macros */
> @@ -89,6 +89,18 @@ enum thermal_trend {
>  	THERMAL_TREND_DROP_FULL, /* apply lowest cooling action */
>  };
>  
> +/**
> + * enum thermal_aggregation_function - aggregation function for sub thermal zones
> + * @THERMAL_AGG_MAX:	calculate the maximum of all sub thermal zones
> +
> + * @THERMAL_AGG_WEIGHTED_AVG:	calculate the weighted average of all
> + *				sub thermal zones
> + */
> +enum thermal_aggregation_function {
> +	THERMAL_AGG_MAX,
> +	THERMAL_AGG_WEIGHTED_AVG,
> +};
> +
>  struct thermal_zone_device_ops {
>  	int (*bind) (struct thermal_zone_device *,
>  		     struct thermal_cooling_device *);
> @@ -170,6 +182,12 @@ struct thermal_attr {
>   * @ops:	operations this &thermal_zone_device supports
>   * @tzp:	thermal zone parameters
>   * @governor:	pointer to the governor for this thermal zone
> + * @slave_agg_function: aggretion function to calculate the
> + *			temperature as a combination of the slave thermal zones
> + *			of this thermal zone.  See enum
> + *			thermal_aggregation_function for valid values
> + * @slave_tzs:	list of thermal zones that are a slave of this thermal zone
> + * @slave_tz_visited: used to detect loops in stacked thermal zones
>   * @governor_data:	private pointer for governor data
>   * @thermal_instances:	list of &struct thermal_instance of this thermal zone
>   * @idr:	&struct idr to generate unique id for this zone's cooling
> @@ -197,6 +215,9 @@ struct thermal_zone_device {
>  	struct thermal_zone_device_ops *ops;
>  	struct thermal_zone_params *tzp;
>  	struct thermal_governor *governor;
> +	enum thermal_aggregation_function slave_agg_function;
> +	struct list_head slave_tzs;
> +	bool slave_tz_visited;
>  	void *governor_data;
>  	struct list_head thermal_instances;
>  	struct idr idr;
> @@ -311,6 +332,13 @@ struct thermal_zone_params {
>  	 * 		Used by thermal zone drivers (default 0).
>  	 */
>  	int offset;
> +
> +	/*
> +	 * aggregation function to use when calculating the
> +	 * temperature as a combination of multiple sub thermal
> +	 * zones
> +	 */
> +	enum thermal_aggregation_function agg_func;
>  };
>  
>  struct thermal_genl_event {
> @@ -405,6 +433,10 @@ struct thermal_cooling_device *
>  thermal_of_cooling_device_register(struct device_node *np, char *, void *,
>  				   const struct thermal_cooling_device_ops *);
>  void thermal_cooling_device_unregister(struct thermal_cooling_device *);
> +int thermal_zone_add_subtz(struct thermal_zone_device *,
> +			   struct thermal_zone_device *, int);
> +int thermal_zone_del_subtz(struct thermal_zone_device *,
> +			   struct thermal_zone_device *);
>  struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
>  int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
>  
> @@ -457,6 +489,13 @@ thermal_of_cooling_device_register(struct device_node *np,
>  static inline void thermal_cooling_device_unregister(
>  	struct thermal_cooling_device *cdev)
>  { }
> +static inline int thermal_zone_add_subtz(struct thermal_zone_device *tz,
> +					 struct thermal_zone_device *subtz,
> +					 int weight)
> +{ return -ENODEV; }
> +static inline int thermal_zone_del_subtz(struct thermal_zone_device *tz,
> +					 struct thermal_zone_device *subtz)
> +{ return -ENODEV; }
>  static inline struct thermal_zone_device *thermal_zone_get_zone_by_name(
>  		const char *name)
>  { return ERR_PTR(-ENODEV); }
> -- 
> 1.9.1
> 
