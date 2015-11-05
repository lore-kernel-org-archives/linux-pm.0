From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH v1 3/6] thermal: rockchip: Support the RK3368 SoCs in
 thermal driver
Date: Thu, 5 Nov 2015 12:54:03 +0800
Message-ID: <563AE0EB.2020608@gmail.com>
References: <1446102858-10116-1-git-send-email-wxt@rock-chips.com>
 <1446102858-10116-4-git-send-email-wxt@rock-chips.com>
 <20151103174830.GA9987@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35962 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965163AbbKEEyO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2015 23:54:14 -0500
In-Reply-To: <20151103174830.GA9987@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Caesar Wang <wxt@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

Hello Eduardo,

Thanks your comments.

=E5=9C=A8 2015=E5=B9=B411=E6=9C=8804=E6=97=A5 01:48, Eduardo Valentin =E5=
=86=99=E9=81=93:
> Hello Caesar,
>
> On Thu, Oct 29, 2015 at 03:14:15PM +0800, Caesar Wang wrote:
>> The RK3368 SoCs support to 2 channel TS-ADC, the temperature criteri=
a
>> of each channel can be configurable.
>>
>> The system has two Temperature Sensors, channel 0 is for CPU,
>> and channel 1 is for GPU.
> Please improve your patch description. I dont think this patch only
> adds the support for RK3368.
>
> I see, for example, at least two other (maybe dependencies of the
> new chip support) changes:
>
> - conversion function improvement
> - tshut value/temperature configuration
>
> Could you please split this patch in smaller changes?

Okay, Done.

That's on my local oneline.
92ffb82 thermal: rockchip: Support the RK3368 SoCs in thermal drivers
e4f5e61 thermal: rockchip: Add the flag for adc value increment or decr=
ement
b599a6b thermal: rockchip: improve the conversion function
d629c52 thermal: rockchip: trivial: fix typo in commit

I will send these in next version.

>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>>
>> ---
>>
>> Changes in v1:
>> - As Dmitry comment, make the conversion table in as a parameter.
>>
> Are you sure that this version implements this suggestion?
>
>
>>   drivers/thermal/rockchip_thermal.c | 183 +++++++++++++++++++++++++=
+++++++-----
>>   1 file changed, 158 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/ro=
ckchip_thermal.c
>> index f96c151..4748a8e 100644
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
>> @@ -75,8 +78,12 @@ struct rockchip_tsadc_chip {
>>  =20
>>   	/* Per-sensor methods */
>>   	int (*get_temp)(int chn, void __iomem *reg, int *temp);
>> -	void (*set_tshut_temp)(int chn, void __iomem *reg, long temp);
>> +	void (*set_tshut_value)(int chn, void __iomem *reg, u32 value);
> Do you have any explanation why do you need to change from temp to
> value? Can you include this in your patch description?

Okay,  I think that's *not* really needed.
I have removed this change.

>>   	void (*set_tshut_mode)(int chn, void __iomem *reg, enum tshut_mod=
e m);
>> +
>> +	/* Per-table methods */
>> +	const struct tsadc_table *table;
>> +	int table_num;
>>   };
>>  =20
>>   struct rockchip_thermal_sensor {
>> @@ -102,7 +109,7 @@ struct rockchip_thermal_data {
>>   	enum tshut_polarity tshut_polarity;
>>   };
>>  =20
>> -/* TSADC V2 Sensor info define: */
>> +/* TSADC Sensor info define: */
>>   #define TSADCV2_AUTO_CON			0x04
>>   #define TSADCV2_INT_EN				0x08
>>   #define TSADCV2_INT_PD				0x0c
>> @@ -124,6 +131,8 @@ struct rockchip_thermal_data {
>>   #define TSADCV2_INT_PD_CLEAR_MASK		~BIT(8)
>>  =20
>>   #define TSADCV2_DATA_MASK			0xfff
>> +#define TSADCV3_DATA_MASK			0x3ff
>> +
>>   #define TSADCV2_HIGHT_INT_DEBOUNCE_COUNT	4
>>   #define TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT	4
>>   #define TSADCV2_AUTO_PERIOD_TIME		250 /* msec */
>> @@ -172,21 +181,62 @@ static const struct tsadc_table v2_code_table[=
] =3D {
>>   	{3421, 125000},
>>   };
>>  =20
>> -static u32 rk_tsadcv2_temp_to_code(long temp)
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
>> +static u32 rk_tsadcv2_temp_to_code(const struct rockchip_tsadc_chip=
 *chip,
>> +				   long temp)
>>   {
> This function receives the chip structure as parameter...

Okay, we should do the table as a parameter.

>> +	const struct tsadc_table *table =3D chip->table;
>>   	int high, low, mid;
>>  =20
>>   	low =3D 0;
>> -	high =3D ARRAY_SIZE(v2_code_table) - 1;
>> +	high =3D chip->table_num - 1;
>>   	mid =3D (high + low) / 2;
>>  =20
>> -	if (temp < v2_code_table[low].temp || temp > v2_code_table[high].t=
emp)
>> +	if (temp < table[low].temp || temp > table[high].temp)
>>   		return 0;
>>  =20
>>   	while (low <=3D high) {
>> -		if (temp =3D=3D v2_code_table[mid].temp)
>> -			return v2_code_table[mid].code;
>> -		else if (temp < v2_code_table[mid].temp)
>> +		if (temp =3D=3D table[mid].temp)
>> +			return table[mid].code;
>> +		else if (temp < table[mid].temp)
>>   			high =3D mid - 1;
>>   		else
>>   			low =3D mid + 1;
> And seams to do the work.. but..
>
> I am assuming you have forgotten to continue the change in the remain=
ing
> functions: rk_tsadcv2_code_to_temp:
>
> 215
> 216         /*
> 217          * The 5C granularity provided by the table is too much. =
Let's
> 218          * assume that the relationship between sensor readings a=
nd
> 219          * temperature between 2 table entries is linear and inte=
rpolate
> 220          * to produce less granular result.
> 221          */
> 222         num =3D v2_code_table[mid].temp - v2_code_table[mid - 1].=
temp;
> 223         num *=3D v2_code_table[mid - 1].code - code;
> 224         denom =3D v2_code_table[mid - 1].code - v2_code_table[mid=
].code;
> 225         *temp =3D v2_code_table[mid - 1].temp + (num / denom);
> 226
>
>
> Please finish the change in rk_tsadcv2_code_to_temp, to use chip->tab=
le, and
>
>
>
>> @@ -235,16 +285,59 @@ static int rk_tsadcv2_code_to_temp(u32 code, i=
nt *temp)
>>   	return 0;
>>   }
>>  =20
>> +static int rk_tsadcv3_code_to_temp(u32 code, int *temp)
>> +{
>> +	unsigned int low =3D 1;
>> +	unsigned int high =3D ARRAY_SIZE(v3_code_table) - 1;
>> +	unsigned int mid =3D (low + high) / 2;
>> +	unsigned int num;
>> +	unsigned long denom;
>> +
>> +	BUILD_BUG_ON(ARRAY_SIZE(v3_code_table) < 2);
>> +
>> +	code &=3D TSADCV3_DATA_MASK;
>> +	if (code < v3_code_table[low].code)
>> +		return -EAGAIN;		/* Incorrect reading */
>> +
>> +	while (low <=3D high) {
>> +		if (code >=3D v3_code_table[mid - 1].code &&
>> +		    code < v3_code_table[mid].code)
>> +			break;
>> +		else if (code > v3_code_table[mid].code)
>> +			low =3D mid + 1;
>> +		else
>> +			high =3D mid - 1;
>> +		mid =3D (low + high) / 2;
>> +	}
>> +
>> +	/*
>> +	 * The 5C granularity provided by the table is too much. Let's
>> +	 * assume that the relationship between sensor readings and
>> +	 * temperature between 2 table entries is linear and interpolate
>> +	 * to produce less granular result.
>> +	 */
>> +	num =3D v3_code_table[mid].temp - v3_code_table[mid - 1].temp;
>> +	num *=3D code - v3_code_table[mid - 1].code;
>> +	denom =3D v3_code_table[mid].code - v3_code_table[mid - 1].code;
>> +	*temp =3D v3_code_table[mid - 1].temp + (num / denom);
>> +
>> +	return 0;
>> +}
> Do not add the above function, as it is a code duplication of
> rk_tsadcv2_code_to_temp. The above function, functionality wise, the =
same
> as rk_tsadcv2_code_to_temp, except that it uses a different table.
>
>   The suggestion is to pass the table as parameter to rk_tsadcv2_code=
_to_temp,
>   then just reuse rk_tsadcv2_code_to_temp in both cases.
>
> Would that work for you?

Thanks, I think that's ok on next version.

>> +
>>   /**
>> - * rk_tsadcv2_initialize - initialize TASDC Controller
>> - * (1) Set TSADCV2_AUTO_PERIOD, configure the interleave between
>> - * every two accessing of TSADC in normal operation.
>> - * (2) Set TSADCV2_AUTO_PERIOD_HT, configure the interleave between
>> - * every two accessing of TSADC after the temperature is higher
>> - * than COM_SHUT or COM_INT.
>> - * (3) Set TSADCV2_HIGH_INT_DEBOUNCE and TSADC_HIGHT_TSHUT_DEBOUNCE=
,
>> - * if the temperature is higher than COMP_INT or COMP_SHUT for
>> - * "debounce" times, TSADC controller will generate interrupt or TS=
HUT.
>> + * rk_tsadcv2_initialize - initialize TASDC Controller.
>> + *
>> + * (1) Set TSADC_V2_AUTO_PERIOD:
>> + *     Configure the interleave between every two accessing of
>> + *     TSADC in normal operation.
>> + *
>> + * (2) Set TSADCV2_AUTO_PERIOD_HT:
>> + *     Configure the interleave between every two accessing of
>> + *     TSADC after the temperature is higher than COM_SHUT or COM_I=
NT.
>> + *
>> + * (3) Set TSADCV2_HIGH_INT_DEBOUNCE and TSADC_HIGHT_TSHUT_DEBOUNCE=
:
>> + *     If the temperature is higher than COMP_INT or COMP_SHUT for
>> + *     "debounce" times, TSADC controller will generate interrupt o=
r TSHUT.
>>    */
>>   static void rk_tsadcv2_initialize(void __iomem *regs,
>>   				  enum tshut_polarity tshut_polarity)
>> @@ -286,6 +379,15 @@ static void rk_tsadcv2_control(void __iomem *re=
gs, bool enable)
>>   	writel_relaxed(val, regs + TSADCV2_AUTO_CON);
>>   }
>>  =20
>> +static int rk_tsadcv3_get_temp(int chn, void __iomem *regs, int *te=
mp)
>> +{
>> +	u32 val;
>> +
>> +	val =3D readl_relaxed(regs + TSADCV2_DATA(chn));
>> +
>> +	return rk_tsadcv3_code_to_temp(val, temp);
>> +}
> Same suggestion here. This function looks exactly the same as rk_tsad=
cv2_get_temp. can you just pass the chip as parameter, then?

Done, make a table as a parameter.
>> +
>>   static int rk_tsadcv2_get_temp(int chn, void __iomem *regs, int *t=
emp)
>>   {
>>   	u32 val;
>> @@ -295,12 +397,11 @@ static int rk_tsadcv2_get_temp(int chn, void _=
_iomem *regs, int *temp)
>>   	return rk_tsadcv2_code_to_temp(val, temp);
>>   }
>>  =20
>> -static void rk_tsadcv2_tshut_temp(int chn, void __iomem *regs, long=
 temp)
>> +static void rk_tsadcv2_tshut_value(int chn, void __iomem *regs, u32=
 value)
>>   {
>> -	u32 tshut_value, val;
>> +	u32 val;
>>  =20
>> -	tshut_value =3D rk_tsadcv2_temp_to_code(temp);
>> -	writel_relaxed(tshut_value, regs + TSADCV2_COMP_SHUT(chn));
>> +	writel_relaxed(value, regs + TSADCV2_COMP_SHUT(chn));
>>  =20
>>   	/* TSHUT will be valid */
>>   	val =3D readl_relaxed(regs + TSADCV2_AUTO_CON);
>> @@ -337,8 +438,31 @@ static const struct rockchip_tsadc_chip rk3288_=
tsadc_data =3D {
>>   	.irq_ack =3D rk_tsadcv2_irq_ack,
>>   	.control =3D rk_tsadcv2_control,
>>   	.get_temp =3D rk_tsadcv2_get_temp,
>> -	.set_tshut_temp =3D rk_tsadcv2_tshut_temp,
>> +	.set_tshut_value =3D rk_tsadcv2_tshut_value,
>> +	.set_tshut_mode =3D rk_tsadcv2_tshut_mode,
>> +
>> +	.table =3D v2_code_table,
>> +	.table_num =3D ARRAY_SIZE(v2_code_table),
>> +};
>> +
>> +static const struct rockchip_tsadc_chip rk3368_tsadc_data =3D {
>> +	.chn_id[SENSOR_CPU] =3D 0, /* cpu sensor is channel 0 */
>> +	.chn_id[SENSOR_GPU] =3D 1, /* gpu sensor is channel 1 */
>> +	.chn_num =3D 2, /* two channels for tsadc */
>> +
>> +	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PM=
IC */
>> +	.tshut_polarity =3D TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE =
*/
>> +	.tshut_temp =3D 95000,
>> +
>> +	.initialize =3D rk_tsadcv2_initialize,
>> +	.irq_ack =3D rk_tsadcv2_irq_ack,
>> +	.control =3D rk_tsadcv2_control,
>> +	.get_temp =3D rk_tsadcv3_get_temp,
>> +	.set_tshut_value =3D rk_tsadcv2_tshut_value,
>>   	.set_tshut_mode =3D rk_tsadcv2_tshut_mode,
>> +
>> +	.table =3D v3_code_table,
>> +	.table_num =3D ARRAY_SIZE(v3_code_table),
>>   };
>>  =20
>>   static const struct of_device_id of_rockchip_thermal_match[] =3D {
>> @@ -346,6 +470,10 @@ static const struct of_device_id of_rockchip_th=
ermal_match[] =3D {
>>   		.compatible =3D "rockchip,rk3288-tsadc",
>>   		.data =3D (void *)&rk3288_tsadc_data,
>>   	},
>> +	{
>> +		.compatible =3D "rockchip,rk3368-tsadc",
>> +		.data =3D (void *)&rk3368_tsadc_data,
>> +	},
>>   	{ /* end */ },
>>   };
>>   MODULE_DEVICE_TABLE(of, of_rockchip_thermal_match);
>> @@ -458,8 +586,10 @@ rockchip_thermal_register_sensor(struct platfor=
m_device *pdev,
>>   	const struct rockchip_tsadc_chip *tsadc =3D thermal->chip;
>>   	int error;
>>  =20
>> +	u32 tshut_value =3D rk_tsadcv2_temp_to_code(tsadc, thermal->tshut_=
temp);
>> +
>>   	tsadc->set_tshut_mode(id, thermal->regs, thermal->tshut_mode);
>> -	tsadc->set_tshut_temp(id, thermal->regs, thermal->tshut_temp);
>> +	tsadc->set_tshut_value(id, thermal->regs, tshut_value);
>>  =20
>>   	sensor->thermal =3D thermal;
>>   	sensor->id =3D id;
>> @@ -660,6 +790,9 @@ static int __maybe_unused rockchip_thermal_resum=
e(struct device *dev)
>>   	int i;
>>   	int error;
>>  =20
>> +	u32 tshut_value =3D rk_tsadcv2_temp_to_code(thermal->chip,
>> +						  thermal->tshut_temp);
>> +
>>   	error =3D clk_enable(thermal->clk);
>>   	if (error)
>>   		return error;
>> @@ -677,8 +810,8 @@ static int __maybe_unused rockchip_thermal_resum=
e(struct device *dev)
>>  =20
>>   		thermal->chip->set_tshut_mode(id, thermal->regs,
>>   					      thermal->tshut_mode);
>> -		thermal->chip->set_tshut_temp(id, thermal->regs,
>> -					      thermal->tshut_temp);
>> +		thermal->chip->set_tshut_value(id, thermal->regs,
>> +					       tshut_value);
>>   	}
>>  =20
>>   	thermal->chip->control(thermal->regs, true);
>> --=20
>> 1.9.1
>>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


--=20
Thanks,
Caesar

