From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH v2] thermal: consistently use int for trip temp
Date: Tue, 8 Mar 2016 11:24:39 +0800
Message-ID: <56DE45F7.6060307@nvidia.com>
References: <1456997626-28298-1-git-send-email-wni@nvidia.com> <56DD3A84.4080304@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4568 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469AbcCHDY3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2016 22:24:29 -0500
In-Reply-To: <56DD3A84.4080304@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org



On 2016=E5=B9=B403=E6=9C=8807=E6=97=A5 16:23, Wei Ni wrote:
> There had a build error in previous patch.
> Fixed it in this version.
> Please review it.

Add CC: linux-pm@vger.kernel.org

>=20
> Thanks.
> Wei.
>=20
> On 2016=E5=B9=B403=E6=9C=8803=E6=97=A5 17:33, Wei Ni wrote:
>> The commit 17e8351a7739 consistently use int for temperature,
>> however it missed a few in trip temperature and thermal_core.
>>
>> In current codes, the trip->temperature used "unsigned long"
>> and zone->temperature used"int", if the temperature is negative
>> value, it will get wrong result when compare temperature with
>> trip temperature.
>>
>> This patch can fix it.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  drivers/thermal/thermal_core.c | 8 ++++----
>>  include/linux/thermal.h        | 4 ++--
>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/therma=
l_core.c
>> index a0a8fd1235e2..e838786fedd8 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -684,7 +684,7 @@ trip_point_temp_store(struct device *dev, struct=
 device_attribute *attr,
>>  {
>>  	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
>>  	int trip, ret;
>> -	unsigned long temperature;
>> +	int temperature;
>> =20
>>  	if (!tz->ops->set_trip_temp)
>>  		return -EPERM;
>> @@ -692,7 +692,7 @@ trip_point_temp_store(struct device *dev, struct=
 device_attribute *attr,
>>  	if (!sscanf(attr->attr.name, "trip_point_%d_temp", &trip))
>>  		return -EINVAL;
>> =20
>> -	if (kstrtoul(buf, 10, &temperature))
>> +	if (kstrtoint(buf, 10, &temperature))
>>  		return -EINVAL;
>> =20
>>  	ret =3D tz->ops->set_trip_temp(tz, trip, temperature);
>> @@ -895,9 +895,9 @@ emul_temp_store(struct device *dev, struct devic=
e_attribute *attr,
>>  {
>>  	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
>>  	int ret =3D 0;
>> -	unsigned long temperature;
>> +	int temperature;
>> =20
>> -	if (kstrtoul(buf, 10, &temperature))
>> +	if (kstrtoint(buf, 10, &temperature))
>>  		return -EINVAL;
>> =20
>>  	if (!tz->ops->set_emul_temp) {
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index e13a1ace50e9..eee0b7ddd2c1 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -350,8 +350,8 @@ struct thermal_zone_of_device_ops {
>> =20
>>  struct thermal_trip {
>>  	struct device_node *np;
>> -	unsigned long int temperature;
>> -	unsigned long int hysteresis;
>> +	int temperature;
>> +	int hysteresis;
>>  	enum thermal_trip_type type;
>>  };
>> =20
>>
