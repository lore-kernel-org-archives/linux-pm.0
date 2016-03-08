From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/3] thermal: of-thermal: Add devm version of
 thermal_zone_of_sensor_register
Date: Tue, 8 Mar 2016 13:29:55 -0800
Message-ID: <20160308212954.GB8820@localhost.localdomain>
References: <1457098810-11964-1-git-send-email-ldewangan@nvidia.com>
 <1457098810-11964-2-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33367 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbcCHV37 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2016 16:29:59 -0500
Content-Disposition: inline
In-Reply-To: <1457098810-11964-2-git-send-email-ldewangan@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: rui.zhang@intel.com, corbet@lwn.net, rklein@nvidia.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hello Laxman,


Minor as follows.

Can you please run ./scripts/checkpatch.pl --strict on this and remove
the warnings, errors, checks?

On Fri, Mar 04, 2016 at 07:10:08PM +0530, Laxman Dewangan wrote:
> Add resource managed version of thermal_zone_of_sensor_register() and
> thermal_zone_of_sensor_unregister().
> 
> This helps in reducing the code size in error path, remove of
> driver remove callbacks and making proper sequence for deallocations.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  drivers/thermal/of-thermal.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/thermal.h      | 18 ++++++++++

Could you also please document these under
Documentation/thermal/sysfs-api.txt?

>  2 files changed, 99 insertions(+)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 9043f8f..1d9f8dc 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -555,6 +555,87 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_of_sensor_unregister);
>  
> +static void devm_thermal_zone_of_sensor_release(struct device *dev, void *res)
> +{
> +	thermal_zone_of_sensor_unregister(dev,
> +					  *(struct thermal_zone_device **)res);
> +}
> +
> +static int devm_thermal_zone_of_sensor_match(struct device *dev, void *res,
> +					     void *data)
> +{
> +	struct thermal_zone_device **r = res;
> +
> +	if (WARN_ON(!r || !*r))
> +		return 0;
> +
> +	return *r == data;
> +}
> +
> +/**
> + * devm_thermal_zone_of_sensor_register - Resource managed version of
> + *				thermal_zone_of_sensor_register()
> + * @dev: a valid struct device pointer of a sensor device. Must contain
> + *       a valid .of_node, for the sensor node.
> + * @sensor_id: a sensor identifier, in case the sensor IP has more
> + *	       than one sensors
> + * @data: a private pointer (owned by the caller) that will be passed
> + *	  back, when a temperature reading is needed.
> + * @ops: struct thermal_zone_of_device_ops *. Must contain at least .get_temp.
> + *
> + * Refer thermal_zone_of_sensor_register() for more details.
> + *
> + * Return: On success returns a valid struct thermal_zone_device,
> + * otherwise, it returns a corresponding ERR_PTR(). Caller must
> + * check the return value with help of IS_ERR() helper.
> + * Registered hermal_zone_device device will automatically be
> + * released when device is unbounded.
> + */
> +struct thermal_zone_device *
> +devm_thermal_zone_of_sensor_register(struct device *dev, int sensor_id,
> +		void *data, const struct thermal_zone_of_device_ops *ops)
> +{
> +	struct thermal_zone_device **ptr, *tzd;
> +
> +	ptr = devres_alloc(devm_thermal_zone_of_sensor_release, sizeof(*ptr),
> +			   GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	tzd = thermal_zone_of_sensor_register(dev, sensor_id, data, ops);
> +	if (IS_ERR(tzd)) {
> +		devres_free(ptr);
> +		return tzd;
> +	}
> +
> +	*ptr = tzd;
> +	devres_add(dev, ptr);
> +
> +	return tzd;
> +}
> +EXPORT_SYMBOL_GPL(devm_thermal_zone_of_sensor_register);
> +
> +/**
> + * devm_thermal_zone_of_sensor_unregister - Resource managed version of
> + *				thermal_zone_of_sensor_unregister().
> + * @dev: Device for which which resource was allocated.
> + * @tzd: a pointer to struct thermal_zone_device where the sensor is registered.
> + *
> + * This function removes the sensor callbacks and private data from the
> + * thermal zone device registered with devm_thermal_zone_of_sensor_register()
> + * API. It will also silent the zone by remove the .get_temp() and .get_trend()
> + * thermal zone device callbacks.
> + * Normally this function will not need to be called and the resource
> + * management code will ensure that the resource is freed.
> + */
> +void devm_thermal_zone_of_sensor_unregister(struct device *dev,
> +				       struct thermal_zone_device *tzd)
> +{
> +	WARN_ON(devres_release(dev, devm_thermal_zone_of_sensor_release,
> +			       devm_thermal_zone_of_sensor_match, tzd));
> +}
> +EXPORT_SYMBOL_GPL(devm_thermal_zone_of_sensor_unregister);
> +
>  /***   functions parsing device tree nodes   ***/
>  
>  /**
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index e13a1ac..4c43b21 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -362,6 +362,11 @@ thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
>  				const struct thermal_zone_of_device_ops *ops);
>  void thermal_zone_of_sensor_unregister(struct device *dev,
>  				       struct thermal_zone_device *tz);
> +struct thermal_zone_device *
> +devm_thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
> +				const struct thermal_zone_of_device_ops *ops);
> +void devm_thermal_zone_of_sensor_unregister(struct device *dev,
> +				       struct thermal_zone_device *tz);
>  #else
>  static inline struct thermal_zone_device *
>  thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
> @@ -376,6 +381,19 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
>  {
>  }
>  
> +static inline struct thermal_zone_device *
> +devm_thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
> +				const struct thermal_zone_of_device_ops *ops)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline
> +void devm_thermal_zone_of_sensor_unregister(struct device *dev,
> +				       struct thermal_zone_device *tz)
> +{
> +}
> +
>  #endif
>  
>  #if IS_ENABLED(CONFIG_THERMAL)
> -- 
> 2.1.4
> 
