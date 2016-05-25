From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH v2 2/5] thermal: of: implement .set_trips for device tree
 thermal zones
Date: Wed, 25 May 2016 11:28:58 +0800
Message-ID: <57451BFA.4090404@gmail.com>
References: <1462268013-14992-1-git-send-email-wxt@rock-chips.com> <1462268013-14992-3-git-send-email-wxt@rock-chips.com> <20160524130139.GB8979@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33837 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbcEYD3F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2016 23:29:05 -0400
In-Reply-To: <20160524130139.GB8979@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Caesar Wang <wxt@rock-chips.com>, huangtao@rock-chips.com, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, dmitry.torokhov@gmail.com, dianders@chromium.org, linux-kernel@vger.kernel.org, edubezval@gmail.com, linux-rockchip@lists.infradead.org, smbarber@google.com, cf@rock-chips.com, briannorris@google.com, Zhang Rui <rui.zhang@intel.com>

Hi Javi,

On 2016=E5=B9=B405=E6=9C=8824=E6=97=A5 21:01, Javi Merino wrote:
> On Tue, May 03, 2016 at 05:33:30PM +0800, Caesar Wang wrote:
>> From: Sascha Hauer <s.hauer@pengutronix.de>
>>
>> This patch implemnets .set_trips for device tree thermal zones.
>> As the hardware-tracked trip points is supported by thermal core pat=
ch[0].
>>
>> patch[0]
>> "thermal: Add support for hardware-tracked trip points".
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Cc: linux-pm@vger.kernel.org
>>
>> ---
>>
>> Changes in v2:
>> - add the commit in patch[v2 2/5].
>>
>>   drivers/thermal/of-thermal.c | 12 ++++++++++++
>>   include/linux/thermal.h      |  4 ++++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-therm=
al.c
>> index b8e509c..8722e63 100644
>> --- a/drivers/thermal/of-thermal.c
>> +++ b/drivers/thermal/of-thermal.c
>> @@ -101,6 +101,17 @@ static int of_thermal_get_temp(struct thermal_z=
one_device *tz,
>>   	return data->ops->get_temp(data->sensor_data, temp);
>>   }
>>  =20
>> +static int of_thermal_set_trips(struct thermal_zone_device *tz,
>> +				int low, int high)
>> +{
>> +	struct __thermal_zone *data =3D tz->devdata;
>> +
>> +	if (!data->ops || !data->ops->set_trips)
>> +		return -EINVAL;
>> +
>> +	return data->ops->set_trips(data->sensor_data, low, high);
>> +}
>> +
>>   /**
>>    * of_thermal_get_ntrips - function to export number of available =
trip
>>    *			   points.
>> @@ -427,6 +438,7 @@ thermal_zone_of_add_sensor(struct device_node *z=
one,
>>  =20
>>   	tzd->ops->get_temp =3D of_thermal_get_temp;
>>   	tzd->ops->get_trend =3D of_thermal_get_trend;
>> +	tzd->ops->set_trips =3D of_thermal_set_trips;
> Why not do it only if ops->set_trips is set?  Something like
>
> 	if (ops->set_trips)
> 		tzd->ops->set_trips =3D of_thermal_set_trips;
>
> Otherwise, the thermal zone core will calculate the window for all
> device tree thermal zones, even if they haven't set the optional
> set_trips pointer.

Hmm, agree it in here.
fixes in next version.

> Cheers,
> Javi
>
>>   	tzd->ops->set_emul_temp =3D of_thermal_set_emul_temp;
>>   	mutex_unlock(&tzd->lock);
>>  =20
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index e258359..09053eb 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -336,12 +336,16 @@ struct thermal_genl_event {
>>    *
>>    * Optional:
>>    * @get_trend: a pointer to a function that reads the sensor tempe=
rature trend.
>> + * @set_trips: a pointer to a function that sets a temperature wind=
ow. When
>> + *	       this window is left the driver must inform the thermal co=
re via
>> + *	       thermal_zone_device_update.
>>    * @set_emul_temp: a pointer to a function that sets sensor emulat=
ed
>>    *		   temperature.
>>    */
>>   struct thermal_zone_of_device_ops {
>>   	int (*get_temp)(void *, int *);
>>   	int (*get_trend)(void *, long *);
>> +	int (*set_trips)(void *, int, int);
>>   	int (*set_emul_temp)(void *, int);
>>   	int (*set_trip_temp)(void *, int, int);
>>   };
>> --=20
>> 1.9.1
>>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

