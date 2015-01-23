From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: Re: [PATCH 5/6] regulator: max77843: Add max77843 regulator driver
Date: Fri, 23 Jan 2015 16:26:38 +0900
Message-ID: <54C1F7AE.6080805@samsung.com>
References: <1421989367-32721-1-git-send-email-jaewon02.kim@samsung.com>
 <1421989367-32721-6-git-send-email-jaewon02.kim@samsung.com>
 <CAJKOXPdWTE6CQC57oV5vsz4TNK4H8==ehpd=3OOMYnJRW+ifWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:54894 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbbAWH0l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jan 2015 02:26:41 -0500
In-reply-to: <CAJKOXPdWTE6CQC57oV5vsz4TNK4H8==ehpd=3OOMYnJRW+ifWw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski.k@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, Beomho Seo <beomho.seo@samsung.com>

Hi Krzysztof,

2015=EB=85=84 01=EC=9B=94 23=EC=9D=BC 16:18=EC=97=90 Krzysztof Koz=C5=82=
owski =EC=9D=B4(=EA=B0=80) =EC=93=B4 =EA=B8=80:
> 2015-01-23 6:02 GMT+01:00 Jaewon Kim <jaewon02.kim@samsung.com>:
>> This patch adds new regulator driver to support max77843
>> MFD(Multi Function Device) chip`s regulators.
>> The Max77843 has two voltage regulators for USB safeout.
>>
>> Cc: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> ---
>>   drivers/regulator/Kconfig    |    8 ++
>>   drivers/regulator/Makefile   |    1 +
>>   drivers/regulator/max77843.c |  259 ++++++++++++++++++++++++++++++=
++++++++++++
>>   3 files changed, 268 insertions(+)
>>   create mode 100644 drivers/regulator/max77843.c
>>
>> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
>> index c3a60b5..c1f9c33 100644
>> --- a/drivers/regulator/Kconfig
>> +++ b/drivers/regulator/Kconfig
>> @@ -414,6 +414,14 @@ config REGULATOR_MAX77802
>>            Exynos5420/Exynos5800 SoCs to control various voltages.
>>            It includes support for control of voltage and ramp speed=
=2E
>>
>> +config REGULATOR_MAX77843
>> +       tristate "Maxim 77843 regulator"
>> +       depends on MFD_MAX77843
>> +       help
>> +         This driver controls a Maxim 77843 regulator.
>> +         The regulator include two 'SAFEOUT' for USB(Universal Seri=
al Bus)
>> +         This is suitable for Exynos5433 SoC chips.
>> +
>>   config REGULATOR_MC13XXX_CORE
>>          tristate
>>
>> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
>> index 1f28ebf..12408d6 100644
>> --- a/drivers/regulator/Makefile
>> +++ b/drivers/regulator/Makefile
>> @@ -55,6 +55,7 @@ obj-$(CONFIG_REGULATOR_MAX8998) +=3D max8998.o
>>   obj-$(CONFIG_REGULATOR_MAX77686) +=3D max77686.o
>>   obj-$(CONFIG_REGULATOR_MAX77693) +=3D max77693.o
>>   obj-$(CONFIG_REGULATOR_MAX77802) +=3D max77802.o
>> +obj-$(CONFIG_REGULATOR_MAX77843) +=3D max77843.o
>>   obj-$(CONFIG_REGULATOR_MC13783) +=3D mc13783-regulator.o
>>   obj-$(CONFIG_REGULATOR_MC13892) +=3D mc13892-regulator.o
>>   obj-$(CONFIG_REGULATOR_MC13XXX_CORE) +=3D  mc13xxx-regulator-core.=
o
>> diff --git a/drivers/regulator/max77843.c b/drivers/regulator/max778=
43.c
>> new file mode 100644
>> index 0000000..86afc7a
>> --- /dev/null
>> +++ b/drivers/regulator/max77843.c
>> @@ -0,0 +1,259 @@
>> +/*
>> + * max77843.c - Regulator driver for the Maxim MAX77843
>> + *
>> + * Copyright (C) 2014 Samsung Electrnoics
>> + * Author: Jaewon Kim <jaewon02.kim@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License as publishe=
d by
>> + * the Free Software Foundation; either version 2 of the License, o=
r
>> + * (at your option) any later version.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regulator/driver.h>
>> +#include <linux/regulator/machine.h>
>> +#include <linux/mfd/max77843-private.h>
>> +#include <linux/regulator/of_regulator.h>
>> +
>> +#define MAX77843_SUPPORTED_VOLTAGE_NUM 4
>> +
>> +enum max77843_regulator_type {
>> +       MAX77843_SAFEOUT1 =3D 0,
>> +       MAX77843_SAFEOUT2,
>> +       MAX77843_CHARGER,
>> +
>> +       MAX77843_NUM,
>> +};
>> +
>> +static const unsigned int max77843_regulator_table[] =3D {
>> +       4850000,
>> +       4900000,
>> +       4950000,
>> +       3300000,
>> +};
>> +
>> +static int max77843_reg_is_enabled(struct regulator_dev *rdev)
>> +{
>> +       struct regmap *regmap =3D rdev->regmap;
>> +       int ret;
>> +       unsigned int reg;
>> +
>> +       ret =3D regmap_read(regmap, rdev->desc->enable_reg, &reg);
>> +       if (ret) {
>> +               dev_err(&rdev->dev, "Fialed to read charger register=
\n");
>> +               return ret;
>> +       }
>> +
>> +       return (reg & rdev->desc->enable_mask) =3D=3D rdev->desc->en=
able_mask;
>> +}
>> +
>> +static int max77843_reg_get_current_limit(struct regulator_dev *rde=
v)
>> +{
>> +       struct regmap *regmap =3D rdev->regmap;
>> +       unsigned int chg_min_uA =3D rdev->constraints->min_uA;
>> +       unsigned int chg_max_uA =3D rdev->constraints->max_uA;
>> +       unsigned int val;
>> +       int ret;
>> +       unsigned int reg, sel;
>> +
>> +       ret =3D regmap_read(regmap, MAX77843_CHG_REG_CHG_CNFG_02, &r=
eg);
>> +       if (ret) {
>> +               dev_err(&rdev->dev, "Failed to read charger register=
\n");
>> +               return ret;
>> +       }
>> +
>> +       sel =3D reg & MAX77843_CHG_FAST_CHG_CURRENT_MASK;
>> +
>> +       if (sel < 0x03)
>> +               sel =3D 0;
>> +       else
>> +               sel -=3D 2;
>> +
>> +       val =3D chg_min_uA + MAX77843_CHG_FAST_CHG_CURRENT_STEP * se=
l;
>> +       if (val > chg_max_uA)
>> +               return -EINVAL;
>> +
>> +       return val;
>> +}
>> +
>> +static int max77843_reg_set_current_limit(struct regulator_dev *rde=
v,
>> +               int min_uA, int max_uA)
>> +{
>> +       struct regmap *regmap =3D rdev->regmap;
>> +       unsigned int chg_min_uA =3D rdev->constraints->min_uA;
>> +       int sel =3D 0;
>> +
>> +       while (chg_min_uA + MAX77843_CHG_FAST_CHG_CURRENT_STEP * sel=
 < min_uA)
>> +               sel++;
>> +
>> +       if (chg_min_uA + MAX77843_CHG_FAST_CHG_CURRENT_STEP * sel > =
max_uA)
>> +               return -EINVAL;
>> +
>> +       sel +=3D 2;
>> +
>> +       return regmap_write(regmap, MAX77843_CHG_REG_CHG_CNFG_02, se=
l);
>> +}
>> +
>> +static struct regulator_ops max77843_charger_ops =3D {
>> +       .is_enabled             =3D max77843_reg_is_enabled,
>> +       .enable                 =3D regulator_enable_regmap,
>> +       .disable                =3D regulator_disable_regmap,
>> +       .get_current_limit      =3D max77843_reg_get_current_limit,
>> +       .set_current_limit      =3D max77843_reg_set_current_limit,
>> +};
>> +
>> +static struct regulator_ops max77843_regulator_ops =3D {
>> +       .is_enabled             =3D regulator_is_enabled_regmap,
>> +       .enable                 =3D regulator_enable_regmap,
>> +       .disable                =3D regulator_disable_regmap,
>> +       .list_voltage           =3D regulator_list_voltage_table,
>> +       .get_voltage_sel        =3D regulator_get_voltage_sel_regmap=
,
>> +       .set_voltage_sel        =3D regulator_set_voltage_sel_regmap=
,
>> +};
>> +
>> +static const struct regulator_desc max77843_supported_regulators[] =
=3D {
>> +       [MAX77843_SAFEOUT1] =3D {
>> +               .name           =3D "SAFEOUT1",
>> +               .id             =3D MAX77843_SAFEOUT1,
>> +               .ops            =3D &max77843_regulator_ops,
>> +               .type           =3D REGULATOR_VOLTAGE,
>> +               .owner          =3D THIS_MODULE,
>> +               .n_voltages     =3D MAX77843_SUPPORTED_VOLTAGE_NUM,
>> +               .volt_table     =3D max77843_regulator_table,
>> +               .enable_reg     =3D MAX77843_SYS_REG_SAFEOUTCTRL,
>> +               .enable_mask    =3D MAX77843_REG_SAFEOUTCTRL_ENSAFEO=
UT1,
>> +               .vsel_reg       =3D MAX77843_SYS_REG_SAFEOUTCTRL,
>> +               .vsel_mask      =3D MAX77843_REG_SAFEOUTCTRL_SAFEOUT=
1_MASK,
>> +       },
>> +       [MAX77843_SAFEOUT2] =3D {
>> +               .name           =3D "SAFEOUT2",
>> +               .id             =3D MAX77843_SAFEOUT2,
>> +               .ops            =3D &max77843_regulator_ops,
>> +               .type           =3D REGULATOR_VOLTAGE,
>> +               .owner          =3D THIS_MODULE,
>> +               .n_voltages     =3D MAX77843_SUPPORTED_VOLTAGE_NUM,
>> +               .volt_table     =3D max77843_regulator_table,
>> +               .enable_reg     =3D MAX77843_SYS_REG_SAFEOUTCTRL,
>> +               .enable_mask    =3D MAX77843_REG_SAFEOUTCTRL_ENSAFEO=
UT2,
>> +               .vsel_reg       =3D MAX77843_SYS_REG_SAFEOUTCTRL,
>> +               .vsel_mask      =3D MAX77843_REG_SAFEOUTCTRL_SAFEOUT=
2_MASK,
>> +       },
>> +       [MAX77843_CHARGER] =3D {
>> +               .name           =3D "CHARGER",
>> +               .id             =3D MAX77843_CHARGER,
>> +               .ops            =3D &max77843_charger_ops,
>> +               .type           =3D REGULATOR_CURRENT,
>> +               .owner          =3D THIS_MODULE,
>> +               .enable_reg     =3D MAX77843_CHG_REG_CHG_CNFG_00,
>> +               .enable_mask    =3D MAX77843_CHG_MASK,
>> +       },
>> +};
>> +
>> +static struct of_regulator_match max77843_regulator_matches[] =3D {
>> +       { .name =3D "SAFEOUT1", },
>> +       { .name =3D "SAFEOUT2", },
>> +       { .name =3D "CHARGER", },
>> +};
>> +
>> +static struct regmap *max77843_get_regmap(struct max77843 *max77843=
, int reg_id)
>> +{
>> +       switch (reg_id) {
>> +       case MAX77843_SAFEOUT1:
>> +       case MAX77843_SAFEOUT2:
>> +               return max77843->regmap;
>> +       case MAX77843_CHARGER:
>> +               return max77843->regmap_chg;
>> +       default:
>> +               return max77843->regmap;
>> +       }
>> +}
>> +
>> +static int max77843_regulator_dt_parse(struct platform_device *pdev=
)
>> +{
>> +       struct device_node *np;
>> +       int ret;
>> +
>> +       np =3D of_get_child_by_name(pdev->dev.parent->of_node, "regu=
lators");
>> +       if (!np) {
>> +               dev_err(&pdev->dev,
>> +                       "Cannot get child OF node for regulators\n")=
;
>> +               return -EINVAL;
>> +       }
>> +
>> +       ret =3D of_regulator_match(&pdev->dev, np, max77843_regulato=
r_matches,
>> +                       ARRAY_SIZE(max77843_regulator_matches));
>> +       if (ret < 0) {
>> +               dev_err(&pdev->dev, "Cannot parsing regulator init d=
ata\n");
>> +               return ret;
>> +       }
>> +
>> +       of_node_put(np);
>> +
>> +       return 0;
> Use simplified DT parsing method (of_match and regulators_node from
> regulators_desc). This function could be removed then.

Thanks to advice.
I will use more simplified method in next version.
>
> Best regards,
> Krzysztof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Thanks,
Jaewon Kim
