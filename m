From: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/6] power: max77843_charger: Add Max77843 charger device
 driver
Date: Fri, 23 Jan 2015 16:28:20 +0900
Message-ID: <54C1F814.10400@samsung.com>
References: <1421989367-32721-1-git-send-email-jaewon02.kim@samsung.com>
 <1421989367-32721-4-git-send-email-jaewon02.kim@samsung.com>
 <CAJKOXPcLjJ3LPWC3e9KqXFA90zr14WAGGmSsdxEiJ1-ctnzefQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <CAJKOXPcLjJ3LPWC3e9KqXFA90zr14WAGGmSsdxEiJ1-ctnzefQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski.k-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Thank you for review.

On 01/23/2015 04:04 PM, Krzysztof Koz=C5=82owski wrote:
> 2015-01-23 6:02 GMT+01:00 Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>:
>> From: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>
>> This patch adds device driver of max77843 charger. This driver provi=
de
>> initialize each charging mode(e.g. fast charge, top-off mode and con=
stant
>> charging mode so on.). Additionally, control charging paramters to u=
se
>> i2c interface.
>>
>> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>>  drivers/power/Kconfig            |    7 +
>>  drivers/power/Makefile           |    1 +
>>  drivers/power/max77843_charger.c |  506 +++++++++++++++++++++++++++=
+++++++++++
>>  3 files changed, 514 insertions(+)
>>  create mode 100644 drivers/power/max77843_charger.c
>>
>> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
>> index 0108c2a..a054a28 100644
>> --- a/drivers/power/Kconfig
>> +++ b/drivers/power/Kconfig
>> @@ -332,6 +332,13 @@ config CHARGER_MAX14577
>>           Say Y to enable support for the battery charger control sy=
sfs and
>>           platform data of MAX14577/77836 MUICs.
>>
>> +config CHARGER_MAX77843
>> +       tristate "Maxim MAX77843 battery charger driver"
>> +       depends on MFD_MAX77843
>> +       help
>> +         Say Y to enable support for the battery charger control sy=
sfs and
>> +         platform data of MAX77843
>> +
>>  config CHARGER_MAX8997
>>         tristate "Maxim MAX8997/MAX8966 PMIC battery charger driver"
>>         depends on MFD_MAX8997 && REGULATOR_MAX8997
>> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
>> index dfa8942..212c6a2 100644
>> --- a/drivers/power/Makefile
>> +++ b/drivers/power/Makefile
>> @@ -50,6 +50,7 @@ obj-$(CONFIG_CHARGER_LP8788)  +=3D lp8788-charger.=
o
>>  obj-$(CONFIG_CHARGER_GPIO)     +=3D gpio-charger.o
>>  obj-$(CONFIG_CHARGER_MANAGER)  +=3D charger-manager.o
>>  obj-$(CONFIG_CHARGER_MAX14577) +=3D max14577_charger.o
>> +obj-$(CONFIG_CHARGER_MAX77843) +=3D max77843_charger.o
>>  obj-$(CONFIG_CHARGER_MAX8997)  +=3D max8997_charger.o
>>  obj-$(CONFIG_CHARGER_MAX8998)  +=3D max8998_charger.o
>>  obj-$(CONFIG_CHARGER_BQ2415X)  +=3D bq2415x_charger.o
>> diff --git a/drivers/power/max77843_charger.c b/drivers/power/max778=
43_charger.c
>> new file mode 100644
>> index 0000000..317b2cc
>> --- /dev/null
>> +++ b/drivers/power/max77843_charger.c
>> @@ -0,0 +1,506 @@
>> +/*
>> + * Charger driver for Maxim MAX77843
>> + *
>> + * Copyright (C) 2014 Samsung Electronics, Co., Ltd.
>> + * Author: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published bythe Free Software Foundation.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/power_supply.h>
>> +#include <linux/mfd/max77843-private.h>
>> +
>> +struct max77843_charger_info {
>> +       u32 fast_charge_uamp;
>> +       u32 top_off_uamp;
>> +       u32 input_uamp_limit;
>> +};
>> +
>> +struct max77843_charger {
>> +       struct device           *dev;
>> +       struct max77843         *max77843;
>> +       struct i2c_client       *client;
>> +       struct regmap           *regmap;
>> +       struct power_supply     psy;
>> +
>> +       struct max77843_charger_info    *info;
>> +};
>=20
> Why creating two separate structures?
>=20

max77843_charger_info structure just have property of charger.
If you want to merge one structure, I will revise above structure.

>> +
>> +static int max77843_charger_get_max_current(struct max77843_charger=
 *charger)
>> +{
>> +       struct regmap *regmap =3D charger->regmap;
>> +       int ret, val =3D 0;
>> +       unsigned int reg_data;
>> +
>> +       ret =3D regmap_read(regmap, MAX77843_CHG_REG_CHG_CNFG_09, &r=
eg_data);
>> +       if (ret) {
>> +               dev_err(charger->dev, "Failed to read charger regist=
er\n");
>> +               return ret;
>> +       }
>> +
>> +       if (reg_data <=3D 0x03) {
>> +               val =3D MAX77843_CHG_INPUT_CURRENT_LIMIT_MIN;
>> +       } else if (reg_data >=3D 0x78) {
>> +               val =3D MAX77843_CHG_INPUT_CURRENT_LIMIT_MAX;
>> +       } else {
>> +               val =3D reg_data / 3;
>> +               if (reg_data % 3 =3D=3D 0)
>> +                       val *=3D 100000;
>> +               else if (reg_data % 3 =3D=3D 1)
>> +                       val =3D val * 100000 + 33000;
>> +               else
>> +                       val =3D val * 100000 + 67000;
>> +       }
>> +
>> +       return val;
>> +}
>> +
>> +static int max77843_charger_get_now_current(struct max77843_charger=
 *charger)
>> +{
>> +       struct regmap *regmap =3D charger->regmap;
>> +       int ret, val =3D 0;
>> +       unsigned int reg_data;
>> +
>> +       ret =3D regmap_read(regmap, MAX77843_CHG_REG_CHG_CNFG_02, &r=
eg_data);
>> +       if (ret) {
>> +               dev_err(charger->dev, "Failed to read charger regist=
er\n");
>=20
> This error log shows up in many places. Please print also error code.
>=20
> Additionally I think it could be useful to print also details about
> register which failed. Currently user would not know which register
> access failed. Consider adding short description like "Failed to read
> current charger register: %d...". However I do not insist on this so
> it is up to you.
>=20

OK. I will fix error log.

>> +               return ret;
>> +       }
>> +
>> +       reg_data &=3D MAX77843_CHG_FAST_CHG_CURRENT_MASK;
>> +
>> +       if (reg_data <=3D 0x02)
>> +               val =3D MAX77843_CHG_FAST_CHG_CURRENT_MIN;
>> +       else if (reg_data >=3D 0x3f)
>> +               val =3D MAX77843_CHG_FAST_CHG_CURRENT_MAX;
>> +       else
>> +               val =3D reg_data * MAX77843_CHG_FAST_CHG_CURRENT_STE=
P;
>> +
>> +       return val;
>> +}
>> +
>> +static int max77843_charger_get_online(struct max77843_charger *cha=
rger)
>> +{
>> +       struct regmap *regmap =3D charger->regmap;
>> +       int ret, val =3D 0;
>> +       unsigned int reg_data;
>> +
>> +       ret =3D regmap_read(regmap, MAX77843_CHG_REG_CHG_INT_OK, &re=
g_data);
>> +       if (ret) {
>> +               dev_err(charger->dev, "Failed to read charger regist=
er\n");
>> +               return ret;
>> +       }
>> +
>> +       if (reg_data & MAX77843_CHG_CHGIN_OK)
>> +               val =3D true;
>> +       else
>> +               val =3D false;
>> +
>> +       return val;
>> +}
>> +
>> +static int max77843_charger_get_present(struct max77843_charger *ch=
arger)
>> +{
>> +       struct regmap *regmap =3D charger->regmap;
>> +       int ret, val =3D 0;
>> +       unsigned int reg_data;
>> +
>> +       ret =3D regmap_read(regmap, MAX77843_CHG_REG_CHG_DTLS_00, &r=
eg_data);
>> +       if (ret) {
>> +               dev_err(charger->dev, "Failed to read charger regist=
er\n");
>> +               return ret;
>> +       }
>> +
>> +       if (reg_data & MAX77843_CHG_BAT_DTLS)
>> +               val =3D false;
>> +       else
>> +               val =3D true;
>> +
>> +       return val;
>> +}
>> +
>> +static int max77843_charger_get_health(struct max77843_charger *cha=
rger)
>> +{
>> +       struct regmap *regmap =3D charger->regmap;
>> +       int ret, val =3D POWER_SUPPLY_HEALTH_UNKNOWN;
>> +       unsigned int reg_data;
>> +
>> +       ret =3D regmap_read(regmap, MAX77843_CHG_REG_CHG_DTLS_01, &r=
eg_data);
>> +       if (ret) {
>> +               dev_err(charger->dev, "Failed to read charger regist=
er\n");
>> +               return ret;
>> +       }
>> +
>> +       reg_data &=3D MAX77843_CHG_BAT_DTLS_MASK;
>> +
>> +       switch (reg_data) {
>> +       case MAX77843_CHG_NO_BAT:
>> +               val =3D POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
>> +               break;
>> +       case MAX77843_CHG_LOW_VOLT_BAT:
>> +       case MAX77843_CHG_OK_BAT:
>> +       case MAX77843_CHG_OK_LOW_VOLT_BAT:
>> +               val =3D POWER_SUPPLY_HEALTH_GOOD;
>> +               break;
>> +       case MAX77843_CHG_LONG_BAT_TIME:
>> +               val =3D POWER_SUPPLY_HEALTH_DEAD;
>> +               break;
>> +       case MAX77843_CHG_OVER_VOLT_BAT:
>> +       case MAX77843_CHG_OVER_CURRENT_BAT:
>> +               val =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
>> +               break;
>> +       default:
>> +               val =3D POWER_SUPPLY_HEALTH_UNKNOWN;
>> +               break;
>> +       }
>> +
>> +       return val;
>> +}
>> +
>> +static int max77843_charger_get_status(struct max77843_charger *cha=
rger)
>> +{
>> +       struct regmap *regmap =3D charger->regmap;
>> +       int ret, val =3D 0;
>> +       unsigned int reg_data;
>> +
>> +       ret =3D regmap_read(regmap, MAX77843_CHG_REG_CHG_DTLS_01, &r=
eg_data);
>> +       if (ret) {
>> +               dev_err(charger->dev, "Failed to read charger regist=
er\n");
>> +               return ret;
>> +       }
>> +
>> +       reg_data &=3D MAX77843_CHG_DTLS_MASK;
>> +
>> +       switch (reg_data) {
>> +       case MAX77843_CHG_PQ_MODE:
>> +       case MAX77843_CHG_CC_MODE:
>> +       case MAX77843_CHG_CV_MODE:
>> +               val =3D POWER_SUPPLY_STATUS_CHARGING;
>> +               break;
>> +       case MAX77843_CHG_TO_MODE:
>> +       case MAX77843_CHG_DO_MODE:
>> +               val =3D POWER_SUPPLY_STATUS_FULL;
>> +               break;
>> +       case MAX77843_CHG_HT_MODE:
>> +       case MAX77843_CHG_TF_MODE:
>> +       case MAX77843_CHG_TS_MODE:
>> +               val =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>> +               break;
>> +       case MAX77843_CHG_OFF_MODE:
>> +               val =3D POWER_SUPPLY_STATUS_DISCHARGING;
>> +               break;
>> +       default:
>> +               val =3D POWER_SUPPLY_STATUS_UNKNOWN;
>> +               break;
>> +       }
>> +
>> +       return val;
>> +}
>> +
>> +static const char *model_name =3D "MAX77843";
>> +static const char *manufacturer =3D "Maxim Integrated";
>> +
>> +static int max77843_charger_get_property(struct power_supply *psy,
>> +               enum power_supply_property psp,
>> +               union power_supply_propval *val)
>> +{
>> +       struct max77843_charger *charger =3D container_of(psy,
>> +                               struct max77843_charger, psy);
>> +
>> +       switch (psp) {
>> +       case POWER_SUPPLY_PROP_STATUS:
>> +               val->intval =3D max77843_charger_get_status(charger)=
;
>> +               break;
>> +       case POWER_SUPPLY_PROP_HEALTH:
>> +               val->intval =3D max77843_charger_get_health(charger)=
;
>> +               break;
>> +       case POWER_SUPPLY_PROP_PRESENT:
>> +               val->intval =3D max77843_charger_get_present(charger=
);
>> +               break;
>> +       case POWER_SUPPLY_PROP_ONLINE:
>> +               val->intval =3D max77843_charger_get_online(charger)=
;
>> +               break;
>> +       case POWER_SUPPLY_PROP_CURRENT_NOW:
>> +               val->intval =3D max77843_charger_get_now_current(cha=
rger);
>> +               break;
>> +       case POWER_SUPPLY_PROP_CURRENT_MAX:
>> +               val->intval =3D max77843_charger_get_max_current(cha=
rger);
>> +               break;
>> +       case POWER_SUPPLY_PROP_MODEL_NAME:
>> +               val->strval =3D  model_name;
>> +               break;
>> +       case POWER_SUPPLY_PROP_MANUFACTURER:
>> +               val->strval =3D manufacturer;
>> +               break;
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static enum power_supply_property max77843_charger_props[] =3D {
>> +       POWER_SUPPLY_PROP_STATUS,
>> +       POWER_SUPPLY_PROP_HEALTH,
>> +       POWER_SUPPLY_PROP_PRESENT,
>> +       POWER_SUPPLY_PROP_ONLINE,
>> +       POWER_SUPPLY_PROP_CURRENT_NOW,
>> +       POWER_SUPPLY_PROP_CURRENT_MAX,
>> +       POWER_SUPPLY_PROP_MODEL_NAME,
>> +       POWER_SUPPLY_PROP_MANUFACTURER,
>> +};
>> +
>> +static int max77843_charger_init_current_limit(struct max77843_char=
ger *charger)
>> +{
>> +       struct regmap *regmap =3D charger->regmap;
>> +       struct max77843_charger_info *info =3D charger->info;
>> +       unsigned int input_uamp_limit =3D info->input_uamp_limit;
>> +       int ret;
>> +       unsigned int reg_data, val;
>> +
>> +       ret =3D regmap_update_bits(regmap, MAX77843_CHG_REG_CHG_CNFG=
_02,
>> +                       MAX77843_CHG_OTG_ILIMIT_MASK,
>> +                       MAX77843_CHG_OTG_ILIMIT_900);
>> +       if (ret) {
>> +               dev_err(charger->dev, "Failed to write configure reg=
ister\n");
>=20
> Same as in case of "read" operation failures - please print also erro=
r code.
>=20

OK.

>> +               return ret;
>> +       }
>> +
>> +       if (input_uamp_limit =3D=3D MAX77843_CHG_INPUT_CURRENT_LIMIT=
_MIN) {
>> +               reg_data =3D 0x03;
>> +       } else if (input_uamp_limit =3D=3D MAX77843_CHG_INPUT_CURREN=
T_LIMIT_MAX) {
>> +               reg_data =3D 0x78;
>> +       } else {
>> +               if (input_uamp_limit < MAX77843_CHG_INPUT_CURRENT_LI=
MIT_REF)
>> +                       val =3D 0x03;
>> +               else
>> +                       val =3D 0x02;
>> +
>> +               input_uamp_limit -=3D MAX77843_CHG_INPUT_CURRENT_LIM=
IT_MIN;
>> +               input_uamp_limit /=3D MAX77843_CHG_INPUT_CURRENT_LIM=
IT_STEP;
>> +               reg_data =3D val + input_uamp_limit;
>> +       }
>> +
>> +       ret =3D regmap_write(regmap, MAX77843_CHG_REG_CHG_CNFG_09, r=
eg_data);
>> +       if (ret) {
>> +               dev_err(charger->dev, "Failed to write configure reg=
ister\n");
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>=20
> Could you merge it into:
>=20
>        ret =3D regmap_write(regmap, MAX77843_CHG_REG_CHG_CNFG_09, reg=
_data);
>        if (ret)
>               dev_err(charger->dev, "Failed to write configure regist=
er\n");
>        return ret;
>=20
>=20

I will merge it into.

>> +
>> +static int max77843_charger_init_top_off(struct max77843_charger *c=
harger)
>> +{
>> +       struct regmap *regmap =3D charger->regmap;
>> +       struct max77843_charger_info *info =3D charger->info;
>> +       unsigned int top_off_uamp =3D info->top_off_uamp;
>> +       int ret;
>> +       unsigned int reg_data;
>> +
>> +       if (top_off_uamp =3D=3D MAX77843_CHG_TOP_OFF_CURRENT_MIN) {
>> +               reg_data =3D 0x00;
>> +       } else if (top_off_uamp =3D=3D MAX77843_CHG_TOP_OFF_CURRENT_=
MAX) {
>> +               reg_data =3D 0x07;
>> +       } else {
>> +               top_off_uamp -=3D MAX77843_CHG_TOP_OFF_CURRENT_MIN;
>> +               top_off_uamp /=3D MAX77843_CHG_TOP_OFF_CURRENT_STEP;
>> +               reg_data =3D top_off_uamp;
>> +       }
>> +
>> +       ret =3D regmap_update_bits(regmap, MAX77843_CHG_REG_CHG_CNFG=
_03,
>> +                       MAX77843_CHG_TOP_OFF_CURRENT_MASK, reg_data)=
;
>> +       if (ret) {
>> +               dev_err(charger->dev, "Failed to write configure reg=
ister\n");
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>=20
> Ditto
>=20

Ditto

>> +}
>> +
>> +static int max77843_charger_init_fast_charge(struct max77843_charge=
r *charger)
>> +{
>> +       struct regmap *regmap =3D charger->regmap;
>> +       struct max77843_charger_info *info =3D charger->info;
>> +       unsigned int fast_charge_uamp =3D info->fast_charge_uamp;
>> +       int ret;
>> +       unsigned int reg_data;
>> +
>> +       if (fast_charge_uamp < info->input_uamp_limit) {
>> +               reg_data =3D 0x09;
>> +       } else if (fast_charge_uamp =3D=3D MAX77843_CHG_FAST_CHG_CUR=
RENT_MIN) {
>> +               reg_data =3D 0x02;
>> +       } else if (fast_charge_uamp =3D=3D MAX77843_CHG_FAST_CHG_CUR=
RENT_MAX) {
>> +               reg_data =3D 0x3f;
>> +       } else {
>> +               fast_charge_uamp -=3D MAX77843_CHG_FAST_CHG_CURRENT_=
MIN;
>> +               fast_charge_uamp /=3D MAX77843_CHG_FAST_CHG_CURRENT_=
STEP;
>> +               reg_data =3D 0x02 + fast_charge_uamp;
>> +       }
>> +
>> +       ret =3D regmap_update_bits(regmap, MAX77843_CHG_REG_CHG_CNFG=
_02,
>> +                       MAX77843_CHG_FAST_CHG_CURRENT_MASK, reg_data=
);
>> +       if (ret) {
>> +               dev_err(charger->dev, "Failed to write configure reg=
ister\n");
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>=20
> Ditto
>=20
>> +}
>> +
>> +static int max77843_charger_init(struct max77843_charger *charger)
>> +{
>> +       struct regmap *regmap =3D charger->regmap;
>> +       int ret;
>> +
>> +       ret =3D regmap_write(regmap, MAX77843_CHG_REG_CHG_CNFG_06,
>> +                       MAX77843_CHG_WRITE_CAP_UNBLOCK);
>> +       if (ret) {
>> +               dev_err(charger->dev, "Failed to write configure reg=
ister\n");
>> +               return ret;
>> +       }
>> +
>> +       ret =3D regmap_write(regmap, MAX77843_CHG_REG_CHG_CNFG_01,
>> +                       MAX77843_CHG_RESTART_THRESHOLD_DISABLE);
>> +       if (ret) {
>> +               dev_err(charger->dev, "Failed to write configure reg=
ister\n");
>> +               return ret;
>> +       }
>> +
>> +       ret =3D max77843_charger_init_fast_charge(charger);
>> +       if (ret) {
>> +               dev_err(charger->dev, "Failed to set fast charge mod=
e.\n");
>> +               return ret;
>> +       }
>> +
>> +       ret =3D max77843_charger_init_top_off(charger);
>> +       if (ret) {
>> +               dev_err(charger->dev, "Failed to set top off charge =
mode.\n");
>> +               return ret;
>> +       }
>> +
>> +       ret =3D max77843_charger_init_current_limit(charger);
>> +
>=20
> Why this return value is ignored?
>=20

I will fix it.

>> +       return 0;
>> +}
>> +
>> +static struct max77843_charger_info *max77843_charger_dt_init(
>> +               struct platform_device *pdev)
>> +{
>> +       struct max77843_charger_info *info;
>> +       struct device_node *np =3D pdev->dev.of_node;
>> +       int ret;
>> +
>> +       if (!np) {
>> +               dev_err(&pdev->dev, "No charger OF node\n");
>> +               return ERR_PTR(-EINVAL);
>> +       }
>> +
>> +       info =3D devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL)=
;
>> +       if (!info)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       ret =3D of_property_read_u32(np, "maxim,fast-charge-uamp",
>> +                       &info->fast_charge_uamp);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Cannot parse fast charge curren=
t.\n");
>> +               return ERR_PTR(ret);
>> +       }
>> +
>> +       ret =3D of_property_read_u32(np, "maxim,top-off-uamp",
>> +                       &info->top_off_uamp);
>> +       if (ret) {
>> +               dev_err(&pdev->dev,
>> +                       "Cannot parse primary charger termination vo=
ltage.\n");
>> +               return ERR_PTR(ret);
>> +       }
>> +
>> +       ret =3D of_property_read_u32(np, "maxim,input-uamp-limit",
>> +                       &info->input_uamp_limit);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Cannot parse input current limi=
t value\n");
>> +               return ERR_PTR(ret);
>> +       }
>> +
>> +       return info;
>> +}
>> +
>> +static int max77843_charger_probe(struct platform_device *pdev)
>> +{
>> +       struct max77843 *max77843 =3D dev_get_drvdata(pdev->dev.pare=
nt);
>> +       struct max77843_charger *charger;
>> +       int ret;
>> +
>> +       charger =3D devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_K=
ERNEL);
>> +       if (!charger)
>> +               return -ENOMEM;
>> +
>> +       platform_set_drvdata(pdev, charger);
>> +       charger->dev =3D &pdev->dev;
>> +       charger->max77843 =3D max77843;
>> +       charger->client =3D max77843->i2c_chg;
>> +       charger->regmap =3D max77843->regmap_chg;
>> +
>> +       charger->info =3D max77843_charger_dt_init(pdev);
>> +       if (IS_ERR_OR_NULL(charger->info)) {
>> +               ret =3D PTR_ERR(charger->info);
>> +               goto err_i2c;
>> +       }
>> +
>> +       charger->psy.name       =3D "max77843-charger";
>> +       charger->psy.type       =3D POWER_SUPPLY_TYPE_MAINS;
>> +       charger->psy.get_property       =3D max77843_charger_get_pro=
perty;
>> +       charger->psy.properties         =3D max77843_charger_props;
>> +       charger->psy.num_properties     =3D ARRAY_SIZE(max77843_char=
ger_props);
>> +
>> +       ret =3D max77843_charger_init(charger);
>> +       if (ret)
>> +               goto err_i2c;
>> +
>> +       ret =3D power_supply_register(&pdev->dev, &charger->psy);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Failed  to register power suppl=
y\n");
>> +               goto err_i2c;
>> +       }
>> +
>> +       return 0;
>> +
>> +err_i2c:
>> +       i2c_unregister_device(charger->client);
>=20
> This seems complicated. The MFD registers the i2c dummy for charger..=
=2E
> and sometimes charger driver unregisters it and sometimes not. The
> ownership should be in one place: probably in charger driver... but I
> asked about this in another thread so lets discuss it there.
>=20

OK. I will revise after discuss it.

> Best regards,
> Krzysztof
>=20

Thanks,
Beomho Seo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
