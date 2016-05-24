From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v2 1/5] thermal: Add support for hardware-tracked trip
 points
Date: Tue, 24 May 2016 13:57:42 +0100
Message-ID: <20160524125741.GA8979@e104805>
References: <1462268013-14992-1-git-send-email-wxt@rock-chips.com>
 <1462268013-14992-2-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462268013-14992-2-git-send-email-wxt@rock-chips.com>
Sender: linux-doc-owner@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: edubezval@gmail.com, Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, cf@rock-chips.com, huangtao@rock-chips.com, dmitry.torokhov@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Laxman Dewangan <ldewangan@nvidia.com>, Durgadoss R <durgadoss.r@intel.com>, Leo Yan <leo.yan@linaro.org>, Ni Wade <wni@nvidia.com>, Andy Champ <andycham@amazon.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, May 03, 2016 at 05:33:29PM +0800, Caesar Wang wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> This adds support for hardware-tracked trip points to the device tree
> thermal sensor framework.
> 
> The framework supports an arbitrary number of trip points. Whenever
> the current temperature is updated, the trip points immediately
> below and above the current temperature are found. A .set_trips
> callback is then called with the temperatures. If there is no trip
> point above or below the current temperature, the passed trip
> temperature will be -INT_MAX or INT_MAX respectively. In this callback,
> the driver should program the hardware such that it is notified
> when either of these trip points are triggered. When a trip point
> is triggered, the driver should call `thermal_zone_device_update'
> for the respective thermal zone. This will cause the trip points
> to be updated again.
> 
> If .set_trips is not implemented, the framework behaves as before.
> 
> This patch is based on an earlier version from Mikko Perttunen
> <mikko.perttunen@kapsi.fi>
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: linux-pm@vger.kernel.org
> 
> ---
> 
> Changes in v2:
> - update the sysfs-api.txt for set_trips
> 
>  Documentation/thermal/sysfs-api.txt |  7 +++++
>  drivers/thermal/thermal_core.c      | 52 +++++++++++++++++++++++++++++++++++++
>  include/linux/thermal.h             |  3 +++
>  3 files changed, 62 insertions(+)
> 
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
> index efc3f3d..75d8838 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -49,6 +49,9 @@ temperature) and throttle appropriate devices.
>  	.bind: bind the thermal zone device with a thermal cooling device.
>  	.unbind: unbind the thermal zone device with a thermal cooling device.
>  	.get_temp: get the current temperature of the thermal zone.
> +	.set_trips: set the trip points window. Whenever the current temperature
> +		    is updated, the trip points immediately below and above the
> +		    current temperature are found.
>  	.get_mode: get the current mode (enabled/disabled) of the thermal zone.
>  	    - "enabled" means the kernel thermal management is enabled.
>  	    - "disabled" will prevent kernel thermal driver action upon trip points
> @@ -95,6 +98,10 @@ temperature) and throttle appropriate devices.
>  			get_temp:	a pointer to a function that reads the
>  					sensor temperature. This is mandatory
>  					callback provided by sensor driver.
> +			set_trips:      a pointer to a function that sets a
> +					temperature window. When this window is
> +					left the driver must inform the thermal
> +					core via thermal_zone_device_update.
>  			get_trend: 	a pointer to a function that reads the
>  					sensor temperature trend.
>  			set_emul_temp:	a pointer to a function that sets
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 5133cd1..e5bfbd3 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -520,6 +520,51 @@ exit:
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
>  
> +static void thermal_zone_set_trips(struct thermal_zone_device *tz)
> +{
> +	int low = -INT_MAX;
> +	int high = INT_MAX;
> +	int trip_temp, hysteresis;
> +	int temp = tz->temperature;
> +	int i, ret;
> +
> +	if (!tz->ops->set_trips)
> +		return;
> +
> +	for (i = 0; i < tz->trips; i++) {
> +		int trip_low;
> +
> +		tz->ops->get_trip_temp(tz, i, &trip_temp);
> +		tz->ops->get_trip_hyst(tz, i, &hysteresis);
> +
> +		trip_low = trip_temp - hysteresis;
> +
> +		if (trip_low < temp && trip_low > low)
> +			low = trip_low;
> +
> +		if (trip_temp > temp && trip_temp < high)
> +			high = trip_temp;
> +	}
> +
> +	/* No need to change trip points */
> +	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
> +		return;
> +
> +	tz->prev_low_trip = low;
> +	tz->prev_high_trip = high;
> +
> +	dev_dbg(&tz->device, "new temperature boundaries: %d < x < %d\n",
> +			low, high);
> +
> +	/*
> +	 * Set a temperature window. When this window is left the driver
> +	 * must inform the thermal core via thermal_zone_device_update.
> +	 */
> +	ret = tz->ops->set_trips(tz, low, high);
> +	if (ret)
> +		dev_err(&tz->device, "Failed to set trips: %d\n", ret);

This function can be called at the same time from multiple places so
it should be reentrant.  I think you should call mutex_lock(tz->lock)
before "if (tz->prev_low_trip == low && ..." and unlock it here.

> +}
> +
>  static void update_temperature(struct thermal_zone_device *tz)
>  {
>  	int temp, ret;
> @@ -569,6 +614,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
>  
>  	update_temperature(tz);
>  
> +	thermal_zone_set_trips(tz);
> +
>  	for (count = 0; count < tz->trips; count++)
>  		handle_thermal_trip(tz, count);
>  }
> @@ -754,6 +801,9 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
>  	 */
>  	ret = tz->ops->set_trip_hyst(tz, trip, temperature);
>  
> +	if (!ret)
> +		thermal_zone_set_trips(tz);
> +

You should add a similar call to thermal_zone_set_trips() in trip_point_temp_store()

>  	return ret ? ret : count;
>  }
>  
> @@ -1843,6 +1893,8 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>  	tz->trips = trips;
>  	tz->passive_delay = passive_delay;
>  	tz->polling_delay = polling_delay;
> +	tz->prev_low_trip = INT_MAX;
> +	tz->prev_high_trip = -INT_MAX;
>  	/* A new thermal zone needs to be updated anyway. */
>  	atomic_set(&tz->need_update, 1);
>  
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index e45abe7..e258359 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -98,6 +98,7 @@ struct thermal_zone_device_ops {
>  	int (*unbind) (struct thermal_zone_device *,
>  		       struct thermal_cooling_device *);
>  	int (*get_temp) (struct thermal_zone_device *, int *);
> +	int (*set_trips) (struct thermal_zone_device *, int, int);
>  	int (*get_mode) (struct thermal_zone_device *,
>  			 enum thermal_device_mode *);
>  	int (*set_mode) (struct thermal_zone_device *,
> @@ -199,6 +200,8 @@ struct thermal_zone_device {
>  	int last_temperature;
>  	int emul_temperature;
>  	int passive;
> +	int prev_low_trip;
> +	int prev_high_trip;

Please document these fields in the kerneldoc comment before struct
thermal_zone_device.

>  	unsigned int forced_passive;
>  	atomic_t need_update;
>  	struct thermal_zone_device_ops *ops;

Cheers,
Javi
