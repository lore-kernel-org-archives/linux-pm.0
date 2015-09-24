From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH 2/5] thermal: rockchip: Support the RK3368 SoCs in thermal
 driver
Date: Thu, 24 Sep 2015 10:27:50 +0800
Message-ID: <56035FA6.4060306@gmail.com>
References: <1442808971-2619-1-git-send-email-wxt@rock-chips.com> <1442808971-2619-3-git-send-email-wxt@rock-chips.com> <20150921170851.GH17389@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33490 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563AbbIXC2B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2015 22:28:01 -0400
In-Reply-To: <20150921170851.GH17389@dtor-ws>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Caesar Wang <wxt@rock-chips.com>, mark.rutland@arm.com, devicetree@vger.kernel.org, heiko@sntech.de, inux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, catalin.marinas@arm.com, ijc+devicetree@hellion.org.uk, will.deacon@arm.com, edubezval@gmail.com, linux-rockchip@lists.infradead.org, robh+dt@kernel.org, galak@codeaurora.org, olof@lixom.net, rui.zhang@intel.com, linux-arm-kernel@lists.infradead.org

Hi Dmitry,

=E5=9C=A8 2015=E5=B9=B409=E6=9C=8822=E6=97=A5 01:08, Dmitry Torokhov =E5=
=86=99=E9=81=93:
> Hi Caesar,
>
> On Mon, Sep 21, 2015 at 12:16:08PM +0800, Caesar Wang wrote:
>> The RK3368 SoCs support to 2 channel TS-ADC, the temperature criteri=
a
>> of each channel can be configurable.
>>
>> The system has two Temperature Sensors, channel 0 is for CPU,
>> and channel 1 is for GPU.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> ---
>>
>>   drivers/thermal/rockchip_thermal.c | 201 +++++++++++++++++++++++++=
+++++++-----
>>   1 file changed, 176 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/ro=
ckchip_thermal.c
>> index 4d5b7d4..16d2476 100644
>> --- a/drivers/thermal/rockchip_thermal.c
>> +++ b/drivers/thermal/rockchip_thermal.c
>> @@ -1,6 +1,9 @@
>>   /*
>>    * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
>>    *
>> + * Copyright (c) 2015, Fuzhou Rockchip Electronics Co., Ltd
>> + * Caesar Wang <wxt@rock-chips.com>
>> + *
>>    * This program is free software; you can redistribute it and/or m=
odify it
>>    * under the terms and conditions of the GNU General Public Licens=
e,
>>    * version 2, as published by the Free Software Foundation.
>> @@ -43,16 +46,11 @@ enum tshut_polarity {
>>   	TSHUT_HIGH_ACTIVE,
>>   };
>>  =20
>> -/**
>> - * The system has three Temperature Sensors.  channel 0 is reserved=
,
>> - * channel 1 is for CPU, and channel 2 is for GPU.
>> - */
>> -enum sensor_id {
>> -	SENSOR_CPU =3D 1,
>> -	SENSOR_GPU,
>> -};
>> -
>>   struct rockchip_tsadc_chip {
>> +	/* The sensor id of chip correspond to the ADC channel */
>> +	int cpu_id;
>> +	int gpu_id;
>> +
>>   	/* The hardware-controlled tshut property */
>>   	long tshut_temp;
>>   	enum tshut_mode tshut_mode;
>> @@ -72,10 +70,11 @@ struct rockchip_tsadc_chip {
>>   struct rockchip_thermal_sensor {
>>   	struct rockchip_thermal_data *thermal;
>>   	struct thermal_zone_device *tzd;
>> -	enum sensor_id id;
>> +	int id;
>>   };
>>  =20
>> -#define NUM_SENSORS	2 /* Ignore unused sensor 0 */
>> +/* Two sensors: CPU and GPU */
>> +#define NUM_SENSORS	2
>>  =20
>>   struct rockchip_thermal_data {
>>   	const struct rockchip_tsadc_chip *chip;
>> @@ -94,7 +93,7 @@ struct rockchip_thermal_data {
>>   	enum tshut_polarity tshut_polarity;
>>   };
>>  =20
>> -/* TSADC V2 Sensor info define: */
>> +/* TSADC Sensor info define: */
>>   #define TSADCV2_AUTO_CON			0x04
>>   #define TSADCV2_INT_EN				0x08
>>   #define TSADCV2_INT_PD				0x0c
>> @@ -116,6 +115,8 @@ struct rockchip_thermal_data {
>>   #define TSADCV2_INT_PD_CLEAR_MASK		~BIT(8)
>>  =20
>>   #define TSADCV2_DATA_MASK			0xfff
>> +#define TSADCV3_DATA_MASK			0x3ff
>> +
>>   #define TSADCV2_HIGHT_INT_DEBOUNCE_COUNT	4
>>   #define TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT	4
>>   #define TSADCV2_AUTO_PERIOD_TIME		250 /* msec */
>> @@ -164,6 +165,45 @@ static const struct tsadc_table v2_code_table[]=
 =3D {
>>   	{3421, 125000},
>>   };
>>  =20
>> +static const struct tsadc_table v3_code_table[] =3D {
>> +	{0, -40000},
>> +	{106, -40000},
>> +	{108, -35000},
>> +	{110, -30000},
>> +	{112, -25000},
>> +	{114, -20000},
>> +	{116, -15000},
>> +	{118, -10000},
>> +	{120, -5000},
>> +	{122, 0},
>> +	{124, 5000},
>> +	{126, 10000},
>> +	{128, 15000},
>> +	{130, 20000},
>> +	{132, 25000},
>> +	{134, 30000},
>> +	{136, 35000},
>> +	{138, 40000},
>> +	{140, 45000},
>> +	{142, 50000},
>> +	{144, 55000},
>> +	{146, 60000},
>> +	{148, 65000},
>> +	{150, 70000},
>> +	{152, 75000},
>> +	{154, 80000},
>> +	{156, 85000},
>> +	{158, 90000},
>> +	{160, 95000},
>> +	{162, 100000},
>> +	{163, 105000},
>> +	{165, 110000},
>> +	{167, 115000},
>> +	{169, 120000},
>> +	{171, 125000},
>> +	{TSADCV3_DATA_MASK, 125000},
>> +};
>> +
>>   static u32 rk_tsadcv2_temp_to_code(long temp)
>>   {
>>   	int high, low, mid;
>> @@ -227,16 +267,83 @@ static int rk_tsadcv2_code_to_temp(u32 code, i=
nt *temp)
>>   	return 0;
>>   }
>>  =20
>> +static u32 rk_tsadcv3_temp_to_code(long temp)
>> +{
>> +	int high, low, mid;
>> +
>> +	low =3D 0;
>> +	high =3D ARRAY_SIZE(v3_code_table) - 1;
>> +	mid =3D (high + low) / 2;
>> +
>> +	if (temp < v3_code_table[low].temp || temp > v3_code_table[high].t=
emp)
>> +		return 0;
> How is this different from v2 conversion except for the table being
> used? I think you should be able to reuse the conversion routines if =
you
> pass the conversion table in as a parameter.

The table_v3 is same with the table_v2 but the anolog data of ADC.

Do you want to reuse the conversion routines,?  I know the conversion=20
routines is same in
rk_tsadcv3_temp_to_code() if we have many socs maybe the ADC analog dat=
a=20
are different.

Says:

rk_tsadcv3_temp_to_code(temp, xxx)

{
     ...

yyyy =3D  rk_tsadcv2_temp_to_code(temp)

=2E..
}
=2E..


I guess you want to independent the adc value,after all the temperature=
=20
points are same.

Says: maybe i will better likely on this.

//3066/3188
=2E....

//3288

static const struct tsadc_table v2_code_table[] =3D {
	{0,3800,3792,3783, 3774,3765, 3756,3747,......
},


//3368

static const struct tsadc_table v3_code_table[] =3D {
	{0,106,108,110,112,114,......
},

//next socs

  ....

Dmitry, I know you don't mean that.:-)

I'm no sure if this way will better for the thermal driver.


> Thanks.
>


--=20
Thanks,
Caesar

