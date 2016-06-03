From: Caesar Wang <wxt@rock-chips.com>
Subject: Re: [RESEND PATCH v4 1/5] thermal: Add support for hardware-tracked
 trip points
Date: Fri, 03 Jun 2016 16:54:03 +0800
Message-ID: <575145AB.7030703@rock-chips.com>
References: <1464338208-8105-1-git-send-email-wxt@rock-chips.com> <1464338208-8105-2-git-send-email-wxt@rock-chips.com> <20160602173012.GB2966@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.136]:54728 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbcFCIyZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jun 2016 04:54:25 -0400
In-Reply-To: <20160602173012.GB2966@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Caesar Wang <wxt@rock-chips.com>, huangtao@rock-chips.com, Jonathan Corbet <corbet@lwn.net>, Ni Wade <wni@nvidia.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, dmitry.torokhov@gmail.com, peter@piie.net, dianders@chromium.org, linux-doc@vger.kernel.org, edubezval@gmail.com, linux-rockchip@lists.infradead.org, Laxman Dewangan <ldewangan@nvidia.com>, smbarber@google.com, Leo Yan <leo.yan@linaro.org>, cf@rock-chips.com, briannorris@google.com, Zhang Rui <rui.zhang@intel.com>, Andy Champ <andycham@amazon.com>

Javi,

Thanks your comments.

On 2016=E5=B9=B406=E6=9C=8803=E6=97=A5 01:30, Javi Merino wrote:
> Hi Caesar,
>
> On Fri, May 27, 2016 at 04:36:44PM +0800, Caesar Wang wrote:
>> From: Sascha Hauer <s.hauer@pengutronix.de>
>>
>> This adds support for hardware-tracked trip points to the device tre=
e
>> thermal sensor framework.
>>
>> The framework supports an arbitrary number of trip points. Whenever
>> the current temperature is updated, the trip points immediately
>> below and above the current temperature are found. A .set_trips
>> callback is then called with the temperatures. If there is no trip
>> point above or below the current temperature, the passed trip
>> temperature will be -INT_MAX or INT_MAX respectively. In this callba=
ck,
>> the driver should program the hardware such that it is notified
>> when either of these trip points are triggered. When a trip point
>> is triggered, the driver should call `thermal_zone_device_update'
>> for the respective thermal zone. This will cause the trip points
>> to be updated again.
>>
>> If .set_trips is not implemented, the framework behaves as before.
>>
>> This patch is based on an earlier version from Mikko Perttunen
>> <mikko.perttunen@kapsi.fi>
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Cc: linux-pm@vger.kernel.org
>>
>> ---
>>
>> Changes in v4:
>> - Missing the lock added in v3.
>>
>> Changes in v3:
>> - as Javi comments on https://patchwork.kernel.org/patch/9001281/.
>> - add the lock for preventing the called from multi placce
>> - add the note for pre_low/high_trip.
>>
>> Changes in v2:
>> - update the sysfs-api.txt for set_trips.
>>
>>   Documentation/thermal/sysfs-api.txt |  7 +++++
>>   drivers/thermal/thermal_core.c      | 56 +++++++++++++++++++++++++=
++++++++++++
>>   include/linux/thermal.h             |  7 +++++
>>   3 files changed, 70 insertions(+)
>>
>> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/the=
rmal/sysfs-api.txt
>> index efc3f3d..75d8838 100644
>> --- a/Documentation/thermal/sysfs-api.txt
>> +++ b/Documentation/thermal/sysfs-api.txt
>> @@ -49,6 +49,9 @@ temperature) and throttle appropriate devices.
>>   	.bind: bind the thermal zone device with a thermal cooling device=
=2E
>>   	.unbind: unbind the thermal zone device with a thermal cooling de=
vice.
>>   	.get_temp: get the current temperature of the thermal zone.
>> +	.set_trips: set the trip points window. Whenever the current tempe=
rature
>> +		    is updated, the trip points immediately below and above the
>> +		    current temperature are found.
>>   	.get_mode: get the current mode (enabled/disabled) of the thermal=
 zone.
>>   	    - "enabled" means the kernel thermal management is enabled.
>>   	    - "disabled" will prevent kernel thermal driver action upon t=
rip points
>> @@ -95,6 +98,10 @@ temperature) and throttle appropriate devices.
>>   			get_temp:	a pointer to a function that reads the
>>   					sensor temperature. This is mandatory
>>   					callback provided by sensor driver.
>> +			set_trips:      a pointer to a function that sets a
>> +					temperature window. When this window is
>> +					left the driver must inform the thermal
>> +					core via thermal_zone_device_update.
>>   			get_trend: 	a pointer to a function that reads the
>>   					sensor temperature trend.
>>   			set_emul_temp:	a pointer to a function that sets
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/therma=
l_core.c
>> index 5133cd1..0591438 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -520,6 +520,55 @@ exit:
>>   }
>>   EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
>>  =20
>> +static void thermal_zone_set_trips(struct thermal_zone_device *tz)
>> +{
>> +	int low =3D -INT_MAX;
>> +	int high =3D INT_MAX;
>> +	int trip_temp, hysteresis;
>> +	int temp =3D tz->temperature;
>> +	int i, ret;
>> +
>> +	if (!tz->ops->set_trips)
>> +		return;
>> +
>> +	for (i =3D 0; i < tz->trips; i++) {
>> +		int trip_low;
>> +
>> +		tz->ops->get_trip_temp(tz, i, &trip_temp);
>> +		tz->ops->get_trip_hyst(tz, i, &hysteresis);
>> +
>> +		trip_low =3D trip_temp - hysteresis;
> You only use the hysteresis for the low trip point and not for the
> high trip point.  Shouldn't you also add:
>
> 		trip_high =3D trip_temp + hysteresis;
>
> ...

I don't think so, I think we didn't need add the for trip_high.

We should triggle the trip points () in time when passive cooling,
and throttle the frequency with the related governor. (After all that's=
=20
used for high temperature)
---

Maybe, we should think about the low temperature for thermal. (e.g. -10=
=20
degree, -20 degree....)
The rockchip some SoCs have the hardware low temperature interrupts for=
=20
thermal,
but I haven't got up it.

>
>> +
>> +		if (trip_low < temp && trip_low > low)
>> +			low =3D trip_low;
>> +
>> +		if (trip_temp > temp && trip_temp < high)
>> +			high =3D trip_temp;
> ... and here:
>
> 		if (trip_high > temp && trip_high < high)
> 			high =3D trip_high;

Ditto

>> +	}
>> +
>> +	/* No need to change trip points */
>> +	if (tz->prev_low_trip =3D=3D low && tz->prev_high_trip =3D=3D high=
)
>> +		return;
>> +
>> +	mutex_lock(&tz->lock);
> I think you should get the lock for the whole function, including the
> read of tz->temperature .  I know I said that the lock should be
> acquired before the if condition before but thinking about it, I thin=
k
> there may be a race condition if userspace updates the hysteresis
> while thermal_zone_device_update() is updating the temperature: you
> could have the cpu that is updating the hysteresis seeing the old
> temperature while the cpu that is updating the temperature would see
> the old hysteresis.  I think it's safer if this whole function is
> protected from the lock, from the read of tz->temperature until the
> end.

Okay, I agree with you in here. :)
Thanks.

-
Caesar
>
> Cheers,
> Javi
>
>> +
>> +	tz->prev_low_trip =3D low;
>> +	tz->prev_high_trip =3D high;
>> +
>> +	dev_dbg(&tz->device, "new temperature boundaries: %d < x < %d\n",
>> +			low, high);
>> +
>> +	/*
>> +	 * Set a temperature window. When this window is left the driver
>> +	 * must inform the thermal core via thermal_zone_device_update.
>> +	 */
>> +	ret =3D tz->ops->set_trips(tz, low, high);
>> +	if (ret)
>> +		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
>> +
>> +	mutex_unlock(&tz->lock);
>> +}
>> +
>>   static void update_temperature(struct thermal_zone_device *tz)
>>   {
>>   	int temp, ret;
>> @@ -569,6 +618,8 @@ void thermal_zone_device_update(struct thermal_z=
one_device *tz)
>>  =20
>>   	update_temperature(tz);
>>  =20
>> +	thermal_zone_set_trips(tz);
>> +
>>   	for (count =3D 0; count < tz->trips; count++)
>>   		handle_thermal_trip(tz, count);
>>   }
>> @@ -754,6 +805,9 @@ trip_point_hyst_store(struct device *dev, struct=
 device_attribute *attr,
>>   	 */
>>   	ret =3D tz->ops->set_trip_hyst(tz, trip, temperature);
>>  =20
>> +	if (!ret)
>> +		thermal_zone_set_trips(tz);
>> +
>>   	return ret ? ret : count;
>>   }
>>  =20
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


--=20
caesar wang | software engineer | wxt@rock-chip.com


