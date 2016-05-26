From: Caesar Wang <wxt@rock-chips.com>
Subject: Re: [PATCH v3 1/5] thermal: Add support for hardware-tracked trip
 points
Date: Thu, 26 May 2016 08:34:34 +0800
Message-ID: <5746449A.7070803@rock-chips.com>
References: <1464148069-26254-1-git-send-email-wxt@rock-chips.com> <1464148069-26254-2-git-send-email-wxt@rock-chips.com> <20160525164258.GA11807@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160525164258.GA11807@e104805>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Caesar Wang <wxt@rock-chips.com>, huangtao@rock-chips.com, Jonathan Corbet <corbet@lwn.net>, Ni Wade <wni@nvidia.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, dmitry.torokhov@gmail.com, peter@piie.net, dianders@chromium.org, linux-doc@vger.kernel.org, edubezval@gmail.com, linux-rockchip@lists.infradead.org, Laxman Dewangan <ldewangan@nvidia.com>, smbarber@google.com, Leo Yan <leo.yan@linaro.org>, cf@rock-chips.com, briannorris@google.com, Zhang Rui <rui.zhang@intel.com>, Andy Champ <andycham@amazon.com>
List-Id: linux-pm@vger.kernel.org


On 2016=E5=B9=B405=E6=9C=8826=E6=97=A5 00:42, Javi Merino wrote:
> Hi Caesar,
>
> On Wed, May 25, 2016 at 11:47:45AM +0800, Caesar Wang wrote:
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
>> Changes in v3:
>> - as Javi comments on https://patchwork.kernel.org/patch/9001281/.
>> - add the lock for preventing the called from multi placce
>> - add the note for pre_low/high_trip.
>>
>> Changes in v2:
>> - update the sysfs-api.txt for set_trips.
>>
>>   Documentation/thermal/sysfs-api.txt |  7 +++++
>>   drivers/thermal/thermal_core.c      | 52 +++++++++++++++++++++++++=
++++++++++++
>>   include/linux/thermal.h             |  7 +++++
>>   3 files changed, 66 insertions(+)
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
>> index 5133cd1..e5bfbd3 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -520,6 +520,51 @@ exit:
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
>> +
>> +		if (trip_low < temp && trip_low > low)
>> +			low =3D trip_low;
>> +
>> +		if (trip_temp > temp && trip_temp < high)
>> +			high =3D trip_temp;
>> +	}
>> +
>> +	/* No need to change trip points */
>> +	if (tz->prev_low_trip =3D=3D low && tz->prev_high_trip =3D=3D high=
)
>> +		return;
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
> In the v2 review
> (http://article.gmane.org/gmane.linux.documentation/38442) you agreed
> to add locking but you haven't done it.  Maybe you sent the wrong
> version?

My god!
Yep, I remember to change it. Somehow why ...

Thanks Javi for looking over it.

Hoping the next version is the final version.:-)

-Caesar

>
> Cheers,
> Javi
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


--=20
caesar wang | software engineer | wxt@rock-chip.com
