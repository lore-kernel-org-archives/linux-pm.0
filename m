From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/4] thermal: Add support for hardware-tracked trip points
Date: Wed, 27 Apr 2016 14:48:45 -0700
Message-ID: <20160427214843.GA6438@localhost.localdomain>
References: <1461553367-24744-1-git-send-email-wxt@rock-chips.com>
 <1461553367-24744-2-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34017 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbcD0Vsu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 17:48:50 -0400
Content-Disposition: inline
In-Reply-To: <1461553367-24744-2-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, dmitry.torokhov@gmail.com, huangtao@rock-chips.com, eddie.cai@rock-chips.com, Sascha Hauer <s.hauer@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

A couple of comments as follows,

On Mon, Apr 25, 2016 at 11:02:44AM +0800, Caesar Wang wrote:
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
> ---
> 
>  drivers/thermal/thermal_core.c | 48 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/thermal.h        |  3 +++

Given that this is adding a new feature in the framework, I would prefer
if you could also describe the .set_trips() in the sysfs-api.txt
documentation file.

A short description of the expectation of what the framework is going to
do is also welcome. For example, are drivers supposed to setup the
polling together with the threshold based approach?

>  2 files changed, 51 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index f1db496..cfef8cc 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -520,6 +520,47 @@ exit:
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

Did I understand correctly that you will be flooded by IRQs when you
have:
1. One single trip point.
2. Your temp is above trip_temp

With the above, you would program as threshold:
high == trip_temp
low == trip_temp - hyst

And the IRQ would fire immediattely, causing a device update, causing a
reprogramming, causing another irq, and this would continue, until the
temperature goes below trip_temp, right?

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
> +	ret = tz->ops->set_trips(tz, low, high);
> +	if (ret)
> +		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
> +}
> +
>  static void update_temperature(struct thermal_zone_device *tz)
>  {
>  	int temp, ret;
> @@ -569,6 +610,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
>  
>  	update_temperature(tz);
>  
> +	thermal_zone_set_trips(tz);
> +
>  	for (count = 0; count < tz->trips; count++)
>  		handle_thermal_trip(tz, count);
>  }
> @@ -754,6 +797,9 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
>  	 */
>  	ret = tz->ops->set_trip_hyst(tz, trip, temperature);
>  
> +	if (!ret)
> +		thermal_zone_set_trips(tz);
> +

You would probably want to do the same on trip_point_temp_store().

>  	return ret ? ret : count;
>  }
>  
> @@ -1843,6 +1889,8 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
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
>  	unsigned int forced_passive;
>  	atomic_t need_update;
>  	struct thermal_zone_device_ops *ops;
> -- 
> 1.9.1
> 
