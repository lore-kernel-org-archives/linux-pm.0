From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 2/2] power: supply: Add Spreadtrum SC2731 charger support
Date: Thu, 30 Aug 2018 11:08:59 +0800
Message-ID: <CAMz4kuJGbvKKVvXmGKaEMbu87bY1nQqB+Zvo5UTpv1gwCG41mQ@mail.gmail.com>
References: <5fcd93bbbcd55a5c23f1c75effdc3670ce7a811b.1535446321.git.baolin.wang@linaro.org>
 <e8a3aba289cd2505db4a8891256bf731f32072cd.1535446321.git.baolin.wang@linaro.org>
 <CAJKOXPd48mSp5srOzr4FkEgb2aS-nqkt+egxbuMi6qodtO1JYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPd48mSp5srOzr4FkEgb2aS-nqkt+egxbuMi6qodtO1JYw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 29 August 2018 at 22:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> I'll try one more time... but without HTML from Gmail. Previous mail
> bounced from lists.
>
> On Tue, 28 Aug 2018 at 11:04, Baolin Wang <baolin.wang@linaro.org> wrote:
>>
>> This patch adds the SC2731 PMIC switch charger support.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  drivers/power/supply/Kconfig          |    7 +
>>  drivers/power/supply/Makefile         |    1 +
>>  drivers/power/supply/sc2731_charger.c |  451 ++++++++++++++++++++++++++=
+++++++
>>  3 files changed, 459 insertions(+)
>>  create mode 100644 drivers/power/supply/sc2731_charger.c
>>
>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>> index ff6dab0..f27cf07 100644
>> --- a/drivers/power/supply/Kconfig
>> +++ b/drivers/power/supply/Kconfig
>> @@ -645,4 +645,11 @@ config CHARGER_CROS_USBPD
>>           what is connected to USB PD ports from the EC and converts
>>           that into power_supply properties.
>>
>> +config CHARGER_SC2731
>> +       tristate "Spreadtrum SC2731 charger driver"
>> +       depends on MFD_SC27XX_PMIC || COMPILE_TEST
>> +       help
>> +        Say Y here to enable support for battery charging with SC2731
>> +        PMIC chips.
>> +
>>  endif # POWER_SUPPLY
>> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefi=
le
>> index a26b402..767105b 100644
>> --- a/drivers/power/supply/Makefile
>> +++ b/drivers/power/supply/Makefile
>> @@ -85,3 +85,4 @@ obj-$(CONFIG_CHARGER_TPS65217)        +=3D tps65217_ch=
arger.o
>>  obj-$(CONFIG_AXP288_FUEL_GAUGE) +=3D axp288_fuel_gauge.o
>>  obj-$(CONFIG_AXP288_CHARGER)   +=3D axp288_charger.o
>>  obj-$(CONFIG_CHARGER_CROS_USBPD)       +=3D cros_usbpd-charger.o
>> +obj-$(CONFIG_CHARGER_SC2731)   +=3D sc2731_charger.o
>> diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/suppl=
y/sc2731_charger.c
>> new file mode 100644
>> index 0000000..49ae16a
>> --- /dev/null
>> +++ b/drivers/power/supply/sc2731_charger.c
>> @@ -0,0 +1,451 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (C) 2018 Spreadtrum Communications Inc.
>> +
>> +#include <linux/err.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/power_supply.h>
>> +#include <linux/slab.h>
>
> slab.h includes looks not needed.

Right. will remove it.

>
>> +#include <linux/usb/phy.h>
>> +#include <linux/regmap.h>
>> +#include <linux/extcon.h>
>
> Looks not used.

Will remove it.

>
>> +#include <linux/notifier.h>
>> +#include <linux/of.h>
>> +
>> +/* PMIC global registers definition */
>> +#define SC2731_CHARGE_STATUS           0xedc
>> +#define SC2731_CHARGE_FULL             BIT(4)
>> +#define SC2731_MODULE_EN1              0xc0c
>> +#define SC2731_CHARGE_EN               BIT(5)
>> +
>> +/* SC2731 switch charger registers definition */
>> +#define SC2731_CHG_CFG0                        0x0
>> +#define SC2731_CHG_CFG1                        0x4
>> +#define SC2731_CHG_CFG2                        0x8
>> +#define SC2731_CHG_CFG3                        0xc
>> +#define SC2731_CHG_CFG4                        0x10
>> +#define SC2731_CHG_CFG5                        0x28
>> +
>> +/* SC2731_CHG_CFG0 register definition */
>> +#define SC2731_PRECHG_RNG_SHIFT                11
>> +#define SC2731_PRECHG_RNG_MASK         GENMASK(12, 11)
>> +
>> +#define SC2731_TERMINATION_VOL_MASK    GENMASK(2, 1)
>> +#define SC2731_TERMINATION_VOL_SHIFT   1
>> +#define SC2731_TERMINATION_VOL_CAL_MASK        GENMASK(8, 3)
>> +#define SC2731_TERMINATION_VOL_CAL_SHIFT       3
>> +#define SC2731_TERMINATION_CUR_MASK    GENMASK(2, 0)
>> +
>> +#define SC2731_CC_EN                   BIT(13)
>> +#define SC2731_CHARGER_PD              BIT(0)
>> +
>> +/* SC2731_CHG_CFG1 register definition */
>> +#define SC2731_CUR_MASK                        GENMASK(5, 0)
>> +
>> +/* SC2731_CHG_CFG5 register definition */
>> +#define SC2731_CUR_LIMIT_SHIFT         8
>> +#define SC2731_CUR_LIMIT_MASK          GENMASK(9, 8)
>> +
>> +#define SC2731_CURRENT_LIMIT_100       100
>> +#define SC2731_CURRENT_LIMIT_500       500
>> +#define SC2731_CURRENT_LIMIT_900       900
>> +#define SC2731_CURRENT_LIMIT_2000      2000
>> +
>> +#define SC2731_CURRENT_PRECHG          450
>> +#define SC2731_CURRENT_STEP            50
>
> What units are used for all these currents?

Sorry for confusing, and will add comments to explain these macros or
add one postfix =E2=80=98MA=E2=80=99.

>
>> +
>> +struct sc2731_charger_info {
>> +       struct device *dev;
>> +       struct regmap *regmap;
>> +       struct usb_phy *usb_phy;
>> +       struct notifier_block usb_notify;
>> +       struct power_supply *psy_usb;
>> +       bool charging;
>> +       u32 base;
>> +};
>> +
>> +static void sc2731_charger_stop_charge(struct sc2731_charger_info *info=
)
>> +{
>> +       regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG0,
>> +                          SC2731_CC_EN, 0);
>> +
>> +       regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG0,
>> +                          SC2731_CHARGER_PD, SC2731_CHARGER_PD);
>> +}
>> +
>> +static int sc2731_charger_start_charge(struct sc2731_charger_info *info=
)
>> +{
>> +       int ret;
>> +
>> +       /* Enable charger constant current mode */
>> +       ret =3D regmap_update_bits(info->regmap, info->base + SC2731_CHG=
_CFG0,
>> +                                SC2731_CC_EN, SC2731_CC_EN);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* Start charging */
>> +       return regmap_update_bits(info->regmap, info->base + SC2731_CHG_=
CFG0,
>> +                                 SC2731_CHARGER_PD, 0);
>> +}
>> +
>> +static int sc2731_charger_set_current_limit(struct sc2731_charger_info =
*info,
>> +                                           u32 limit)
>> +{
>> +       u32 val;
>> +
>> +       if (limit <=3D SC2731_CURRENT_LIMIT_100)
>> +               val =3D 0;
>> +       else if (limit <=3D SC2731_CURRENT_LIMIT_500)
>> +               val =3D 3;
>> +       else if (limit <=3D SC2731_CURRENT_LIMIT_900)
>> +               val =3D 2;
>> +       else
>> +               val =3D 1;
>> +
>> +       return regmap_update_bits(info->regmap, info->base + SC2731_CHG_=
CFG5,
>> +                                 SC2731_CUR_LIMIT_MASK,
>> +                                 val << SC2731_CUR_LIMIT_SHIFT);
>> +}
>> +
>> +static int sc2731_charger_set_current(struct sc2731_charger_info *info,=
 u32 cur)
>> +{
>> +       u32 val;
>> +       int ret;
>> +
>> +       if (cur > SC2731_CURRENT_LIMIT_2000)
>> +               cur =3D SC2731_CURRENT_LIMIT_2000;
>> +       else if (cur < SC2731_CURRENT_PRECHG)
>> +               cur =3D SC2731_CURRENT_PRECHG;
>> +
>> +       /* Calculte the step value, each step is 50 mA */
>
> s/Calculte/Calculate/

Sorry for typos.

>
>> +       val =3D (cur - SC2731_CURRENT_PRECHG) / SC2731_CURRENT_STEP;
>> +
>> +       /* Set pre-charge current as 450 mA */
>> +       ret =3D regmap_update_bits(info->regmap, info->base + SC2731_CHG=
_CFG0,
>> +                                SC2731_PRECHG_RNG_MASK,
>> +                                0x3 << SC2731_PRECHG_RNG_SHIFT);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return regmap_update_bits(info->regmap, info->base + SC2731_CHG_=
CFG1,
>> +                                 SC2731_CUR_MASK, val);
>> +}
>> +
>> +static int sc2731_charger_get_status(struct sc2731_charger_info *info)
>> +{
>> +       u32 val;
>> +       int ret;
>> +
>> +       ret =3D regmap_read(info->regmap, SC2731_CHARGE_STATUS, &val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (val & SC2731_CHARGE_FULL)
>> +               return POWER_SUPPLY_STATUS_FULL;
>> +
>> +       return POWER_SUPPLY_STATUS_CHARGING;
>> +}
>> +
>> +static int sc2731_charger_get_current(struct sc2731_charger_info *info,
>> +                                     u32 *cur)
>> +{
>> +       int ret;
>> +       u32 val;
>> +
>> +       ret =3D regmap_read(info->regmap, info->base + SC2731_CHG_CFG1, =
&val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       val &=3D SC2731_CUR_MASK;
>> +       *cur =3D val * SC2731_CURRENT_STEP + SC2731_CURRENT_PRECHG;
>
> One empty line please.

OK.

>
>> +       return 0;
>> +}
>> +
>> +static int sc2731_charger_get_current_limit(struct sc2731_charger_info =
*info,
>> +                                           u32 *cur)
>> +{
>> +       int ret;
>> +       u32 val;
>> +
>> +       ret =3D regmap_read(info->regmap, info->base + SC2731_CHG_CFG5, =
&val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       val =3D (val & SC2731_CUR_LIMIT_MASK) >> SC2731_CUR_LIMIT_SHIFT;
>> +
>> +       switch (val) {
>> +       case 0:
>> +               *cur =3D SC2731_CURRENT_LIMIT_100;
>> +               break;
>> +
>> +       case 1:
>> +               *cur =3D SC2731_CURRENT_LIMIT_2000;
>> +               break;
>> +
>> +       case 2:
>> +               *cur =3D SC2731_CURRENT_LIMIT_900;
>> +               break;
>> +
>> +       case 3:
>> +               *cur =3D SC2731_CURRENT_LIMIT_500;
>> +               break;
>> +
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int
>> +sc2731_charger_usb_set_property(struct power_supply *psy,
>> +                               enum power_supply_property psp,
>> +                               const union power_supply_propval *val)
>> +{
>> +       struct sc2731_charger_info *info =3D power_supply_get_drvdata(ps=
y);
>> +       int ret;
>> +
>> +       switch (psp) {
>> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>> +               ret =3D sc2731_charger_set_current(info, val->intval);
>> +               if (ret < 0)
>> +                       dev_warn(info->dev, "set charge current failed\n=
");
>> +               break;
>> +       case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>> +               ret =3D sc2731_charger_set_current_limit(info, val->intv=
al);
>> +               if (ret < 0)
>> +                       dev_warn(info->dev, "set input current limit fai=
led\n");
>> +               break;
>> +       default:
>> +               ret =3D -EINVAL;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static int sc2731_charger_usb_get_property(struct power_supply *psy,
>> +                                          enum power_supply_property ps=
p,
>> +                                          union power_supply_propval *v=
al)
>> +{
>> +       struct sc2731_charger_info *info =3D power_supply_get_drvdata(ps=
y);
>> +       u32 cur;
>> +       int ret;
>> +
>> +       switch (psp) {
>> +       case POWER_SUPPLY_PROP_STATUS:
>> +               if (info->charging)
>> +                       val->intval =3D sc2731_charger_get_status(info);
>> +               else
>> +                       val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING=
;
>> +               break;
>> +
>> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>> +               if (!info->charging) {
>> +                       val->intval =3D 0;
>> +                       break;
>> +               }
>> +
>> +               ret =3D sc2731_charger_get_current(info, &cur);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               val->intval =3D cur;
>> +               break;
>> +
>> +       case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>> +               if (!info->charging) {
>> +                       val->intval =3D 0;
>> +                       break;
>> +               }
>> +
>> +               ret =3D sc2731_charger_get_current_limit(info, &cur);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               val->intval =3D cur;
>> +               break;
>> +
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int sc2731_charger_property_is_writeable(struct power_supply *ps=
y,
>> +                                               enum power_supply_proper=
ty psp)
>> +{
>> +       int ret;
>> +
>> +       switch (psp) {
>> +       case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>> +       case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>> +               ret =3D 1;
>> +               break;
>> +       default:
>> +               ret =3D 0;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static enum power_supply_property sc2731_usb_props[] =3D {
>> +       POWER_SUPPLY_PROP_STATUS,
>> +       POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
>> +       POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>> +};
>> +
>> +static const struct power_supply_desc sc2731_charger_desc =3D {
>> +       .name                   =3D "sc2731_charger",
>> +       .type                   =3D POWER_SUPPLY_TYPE_USB,
>> +       .properties             =3D sc2731_usb_props,
>> +       .num_properties         =3D ARRAY_SIZE(sc2731_usb_props),
>> +       .get_property           =3D sc2731_charger_usb_get_property,
>> +       .set_property           =3D sc2731_charger_usb_set_property,
>> +       .property_is_writeable  =3D sc2731_charger_property_is_writeable=
,
>> +};
>> +
>> +static int sc2731_charger_usb_change(struct notifier_block *nb,
>> +                                    unsigned long limit, void *data)
>> +{
>> +       struct sc2731_charger_info *info =3D
>> +               container_of(nb, struct sc2731_charger_info, usb_notify)=
;
>> +       int ret;
>> +
>> +       /* set current limitation and start to charge */
>> +       if (limit > 0) {
>> +               ret =3D sc2731_charger_set_current_limit(info, limit);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               ret =3D sc2731_charger_set_current(info, limit);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               ret =3D sc2731_charger_start_charge(info);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               info->charging =3D true;
>> +               return 0;
>> +       }
>> +
>> +       /* Stop charging */
>> +       sc2731_charger_stop_charge(info);
>> +       info->charging =3D false;
>
> Here and in other places (get_property) you depend on information from
> USB phy. But maybe your device already provides information whether it
> is charging or not. It should be more accurate.

Make sense. Will think about this issue.

>
>> +
>> +       return 0;
>> +}
>> +
>> +static int sc2731_charger_hw_init(struct sc2731_charger_info *info)
>> +{
>> +       int ret;
>> +
>> +       /* Enable charger module */
>> +       ret =3D regmap_update_bits(info->regmap, SC2731_MODULE_EN1,
>> +                                SC2731_CHARGE_EN, SC2731_CHARGE_EN);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* Set default charge termination current to 120 mA */
>> +       ret =3D regmap_update_bits(info->regmap, info->base + SC2731_CHG=
_CFG2,
>> +                                SC2731_TERMINATION_CUR_MASK, 0x2);
>
> Looks like DeviceTree property.

OK.

>
>> +       if (ret)
>> +               goto error;
>> +
>> +       /* Set default charge termination voltage to 4.35V */
>
> Looks like DeviceTree property.

OK. Thanks for your comments.


--=20
Baolin Wang
Best Regards
