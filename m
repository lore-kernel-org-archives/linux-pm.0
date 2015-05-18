From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: [PATCH 11/15] thermal: thermal: Add support for hardware-tracked
 trip points
Date: Mon, 18 May 2015 12:06:50 +0300
Message-ID: <5559ABAA.6040001@kapsi.fi>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de> <1431507163-19933-12-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:46442 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752275AbbERJHM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 18 May 2015 05:07:12 -0400
In-Reply-To: <1431507163-19933-12-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>

Thanks for picking up this patch :)

Sorry for being late with these, but here's a few comments..

On 05/13/2015 11:52 AM, Sascha Hauer wrote:
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
 > ---
 >  drivers/thermal/thermal_core.c | 43 
++++++++++++++++++++++++++++++++++++++++++
 >  include/linux/thermal.h        |  3 +++
 >  2 files changed, 46 insertions(+)
 >
 > diff --git a/drivers/thermal/thermal_core.c 
b/drivers/thermal/thermal_core.c
 > index 6bbf61f..3ae1795 100644
 > --- a/drivers/thermal/thermal_core.c
 > +++ b/drivers/thermal/thermal_core.c
 > @@ -453,6 +453,45 @@ int thermal_zone_get_temp(struct 
thermal_zone_device *tz, int *temp)
 >  }
 >  EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
 >
 > +static void thermal_zone_set_trips(struct thermal_zone_device *tz)
 > +{
 > +	int low = -INT_MAX;
 > +	int high = INT_MAX;
 > +	int trip_temp, hysteresis;
 > +	int temp = tz->temperature;
 > +	int i;
 > +
 > +	if (!tz->ops->set_trips)
 > +		return;
 > +
 > +	/* No need to change trip points */
 > +	if (temp > tz->prev_low_trip && temp < tz->prev_high_trip)
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
 > +	tz->prev_low_trip = low;
 > +	tz->prev_high_trip = high;
 > +
 > +	dev_dbg(&tz->device, "new temperature boundaries: %d < x < %d\n",
 > +			low, high);
 > +
 > +	tz->ops->set_trips(tz, low, high);

This should probably do something if set_trips returns an error code; at 
least an error message, perhaps enable polling? I'm not exactly sure 
what safety features the thermal framework has in general if errors happen..

One interesting thing I noticed was that at least the bang-bang governor 
only acts if the temperature is properly smaller than (trip temp - 
hysteresis). So perhaps we should specify the non-tripping range as 
[low, high)? Or we could change bang-bang.

 > +}
 > +
 >  void thermal_zone_device_update(struct thermal_zone_device *tz)
 >  {
 >  	int temp, ret, count;
 > @@ -479,6 +518,8 @@ void thermal_zone_device_update(struct 
thermal_zone_device *tz)
 >  	dev_dbg(&tz->device, "last_temperature=%d, current_temperature=%d\n",
 >  				tz->last_temperature, tz->temperature);
 >
 > +	thermal_zone_set_trips(tz);
 > +
 >  	for (count = 0; count < tz->trips; count++)
 >  		handle_thermal_trip(tz, count);
 >  }

set_trips should also be called from temp_store and other places that 
modify values that affect the trip points.

 > @@ -1494,6 +1535,8 @@ struct thermal_zone_device 
*thermal_zone_device_register(const char *type,
 >  	tz->trips = trips;
 >  	tz->passive_delay = passive_delay;
 >  	tz->polling_delay = polling_delay;
 > +	tz->prev_low_trip = INT_MAX;
 > +	tz->prev_high_trip = -INT_MAX;
 >
 >  	dev_set_name(&tz->device, "thermal_zone%d", tz->id);
 >  	result = device_register(&tz->device);
 > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
 > index 07bd5e8..aef6e13 100644
 > --- a/include/linux/thermal.h
 > +++ b/include/linux/thermal.h
 > @@ -87,6 +87,7 @@ struct thermal_zone_device_ops {
 >  	int (*unbind) (struct thermal_zone_device *,
 >  		       struct thermal_cooling_device *);
 >  	int (*get_temp) (struct thermal_zone_device *, int *);
 > +	int (*set_trips) (struct thermal_zone_device *, int, int);
 >  	int (*get_mode) (struct thermal_zone_device *,
 >  			 enum thermal_device_mode *);
 >  	int (*set_mode) (struct thermal_zone_device *,
 > @@ -180,6 +181,8 @@ struct thermal_zone_device {
 >  	int last_temperature;
 >  	int emul_temperature;
 >  	int passive;
 > +	int prev_low_trip;
 > +	int prev_high_trip;
 >  	unsigned int forced_passive;
 >  	const struct thermal_zone_device_ops *ops;
 >  	const struct thermal_zone_params *tzp;
 >
