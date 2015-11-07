From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH v2 6/9] thermal: rockchip: Support the RK3368 SoCs in
 thermal drivers
Date: Sat, 07 Nov 2015 22:25:36 +0800
Message-ID: <563E09E0.8070105@gmail.com>
References: <1446700685-18017-1-git-send-email-wxt@rock-chips.com>	<1446700685-18017-7-git-send-email-wxt@rock-chips.com> <CAHp75Vd+UnqOigOV9aDrpdczFD2R+gm1iFhUe-C6vc5U-x3e1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35226 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056AbbKGOZx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 7 Nov 2015 09:25:53 -0500
In-Reply-To: <CAHp75Vd+UnqOigOV9aDrpdczFD2R+gm1iFhUe-C6vc5U-x3e1g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Caesar Wang <wxt@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, Eduardo Valentin <edubezval@gmail.com>, linux-rockchip@lists.infradead.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>



=E5=9C=A8 2015=E5=B9=B411=E6=9C=8807=E6=97=A5 03:39, Andy Shevchenko =E5=
=86=99=E9=81=93:
> On Thu, Nov 5, 2015 at 7:18 AM, Caesar Wang <wxt@rock-chips.com> wrot=
e:
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
>> Changes in v2:
>> - remove some unused, completed on other patchs.
>>
>> Changes in v1: None
>>
>>   drivers/thermal/rockchip_thermal.c | 72 ++++++++++++++++++++++++++=
++++++++++++
>>   1 file changed, 72 insertions(+)
>>
>> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/ro=
ckchip_thermal.c
>> index 9df027f..47a8873 100644
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
>> @@ -152,6 +155,8 @@ struct rockchip_thermal_data {
>>   #define TSADCV2_INT_PD_CLEAR_MASK              ~BIT(8)
>>
>>   #define TSADCV2_DATA_MASK                      0xfff
>> +#define TSADCV3_DATA_MASK                      0x3ff
>> +
>>   #define TSADCV2_HIGHT_INT_DEBOUNCE_COUNT       4
>>   #define TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT     4
>>   #define TSADCV2_AUTO_PERIOD_TIME               250 /* msec */
>> @@ -200,6 +205,45 @@ static const struct tsadc_table v2_code_table[]=
 =3D {
>>          {3421, 125000},
>>   };
>>
>> +static const struct tsadc_table v3_code_table[] =3D {
>> +       {0, -40000},
>> +       {106, -40000},
>> +       {108, -35000},
>> +       {110, -30000},
>> +       {112, -25000},
>> +       {114, -20000},
>> +       {116, -15000},
>> +       {118, -10000},
>> +       {120, -5000},
>> +       {122, 0},
>> +       {124, 5000},
>> +       {126, 10000},
>> +       {128, 15000},
>> +       {130, 20000},
>> +       {132, 25000},
>> +       {134, 30000},
>> +       {136, 35000},
>> +       {138, 40000},
>> +       {140, 45000},
>> +       {142, 50000},
>> +       {144, 55000},
>> +       {146, 60000},
>> +       {148, 65000},
>> +       {150, 70000},
>> +       {152, 75000},
>> +       {154, 80000},
>> +       {156, 85000},
>> +       {158, 90000},
>> +       {160, 95000},
>> +       {162, 100000},
>> +       {163, 105000},
>> +       {165, 110000},
>> +       {167, 115000},
>> +       {169, 120000},
>> +       {171, 125000},
>> +       {TSADCV3_DATA_MASK, 125000},
> Why not function which returns one value based on the other?
>
> x < 106:   -40000
> 161 >=3D x >=3D 106: -40000 + 5000 * (x - 106) / 2
> 171 >=3D x >=3D 162: 100000 + 5000 * (x - 162)
> x > 171 =3D 125000

1) Every SoCs conversion table come from the TRM.
2) Barrier for using with other SoCs

the rockchip-thermal driver  is compatible for series SoCs for rockchip=
=2E

>> +};
>> +
>>   static u32 rk_tsadcv2_temp_to_code(struct chip_tsadc_table table,
>>                                     long temp)
>>   {
>> @@ -408,11 +452,39 @@ static const struct rockchip_tsadc_chip rk3288=
_tsadc_data =3D {
>>          },
>>   };
>>
>> +static const struct rockchip_tsadc_chip rk3368_tsadc_data =3D {
>> +       .chn_id[SENSOR_CPU] =3D 0, /* cpu sensor is channel 0 */
>> +       .chn_id[SENSOR_GPU] =3D 1, /* gpu sensor is channel 1 */
>> +       .chn_num =3D 2, /* two channels for tsadc */
>> +
>> +       .tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO g=
ive PMIC */
>> +       .tshut_polarity =3D TSHUT_LOW_ACTIVE, /* default TSHUT LOW A=
CTIVE */
>> +       .tshut_temp =3D 95000,
>> +
>> +       .initialize =3D rk_tsadcv2_initialize,
>> +       .irq_ack =3D rk_tsadcv2_irq_ack,
>> +       .control =3D rk_tsadcv2_control,
>> +       .get_temp =3D rk_tsadcv2_get_temp,
>> +       .set_tshut_temp =3D rk_tsadcv2_tshut_temp,
>> +       .set_tshut_mode =3D rk_tsadcv2_tshut_mode,
>> +
>> +       .table =3D {
>> +               .id =3D v3_code_table,
>> +               .length =3D ARRAY_SIZE(v3_code_table),
>> +               .data_mask =3D TSADCV3_DATA_MASK,
>> +               .flag =3D ADC_DECREMENT,
>> +       },
>> +};
>> +
>>   static const struct of_device_id of_rockchip_thermal_match[] =3D {
>>          {
>>                  .compatible =3D "rockchip,rk3288-tsadc",
>>                  .data =3D (void *)&rk3288_tsadc_data,
>>          },
>> +       {
>> +               .compatible =3D "rockchip,rk3368-tsadc",
>> +               .data =3D (void *)&rk3368_tsadc_data,
>> +       },
>>          { /* end */ },
>>   };
>>   MODULE_DEVICE_TABLE(of, of_rockchip_thermal_match);
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>
>
