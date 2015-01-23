From: Beomho Seo <beomho.seo@samsung.com>
Subject: Re: [PATCH 1/6] mfd: max77843: Add max77843 MFD driver core driver
Date: Fri, 23 Jan 2015 20:10:51 +0900
Message-ID: <54C22C3B.8040403@samsung.com>
References: <1421989367-32721-1-git-send-email-jaewon02.kim@samsung.com>
 <1421989367-32721-2-git-send-email-jaewon02.kim@samsung.com>
 <CAJKOXPfRYhJNUAE=W3zPWvyza9k_YA=hu4KjLRuLh7kie3guQA@mail.gmail.com>
 <54C1ED09.1080607@samsung.com> <1421997364.27149.5.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:13645 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbbAWLKy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jan 2015 06:10:54 -0500
In-reply-to: <1421997364.27149.5.camel@AMDC1943>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Jaewon Kim <jaewon02.kim@samsung.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>

On 01/23/2015 04:16 PM, Krzysztof Kozlowski wrote:
> On pi=C4=85, 2015-01-23 at 15:41 +0900, Beomho Seo wrote:
>> On 01/23/2015 03:32 PM, Krzysztof Kozlowski wrote:
>>> 2015-01-23 6:02 GMT+01:00 Jaewon Kim <jaewon02.kim@samsung.com>:
>>>> This patch adds MAX77843 core/irq driver to support PMIC,
>>>> MUIC(Micro USB Interface Controller), Charger, Fuel Gauge,
>>>> LED and Haptic device.
>>>>
>>>> Cc: Lee Jones <lee.jones@linaro.org>
>>>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>>>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>>>> ---
>>>>  drivers/mfd/Kconfig                  |   14 ++
>>>>  drivers/mfd/Makefile                 |    1 +
>>>>  drivers/mfd/max77843.c               |  241 ++++++++++++++++++++
>>>>  include/linux/mfd/max77843-private.h |  410 +++++++++++++++++++++=
+++++++++++++
>>>>  4 files changed, 666 insertions(+)
>>>>  create mode 100644 drivers/mfd/max77843.c
>>>>  create mode 100644 include/linux/mfd/max77843-private.h
>>>>
>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>> index 2e6b731..0c67c79 100644
>>>> --- a/drivers/mfd/Kconfig
>>>> +++ b/drivers/mfd/Kconfig
>>>> @@ -442,6 +442,20 @@ config MFD_MAX77693
>>>>           additional drivers must be enabled in order to use the f=
unctionality
>>>>           of the device.
>>>>
>>>> +config MFD_MAX77843
>>>> +       bool "Maxim Semiconductor MAX77843 PMIC Support"
>>>> +       depends on I2C=3Dy
>>>> +       select MFD_CORE
>>>> +       select REGMAP_I2C
>>>> +       select REGMAP_IRQ
>>>> +       help
>>>> +         Say yes here to add support for Maxim Semiconductor MAX7=
7843.
>>>> +         This is companion Power Management IC with LEDs, Haptic,=
 Charger,
>>>> +         Fuel Gauge, MUIC(Micro USB Interface Controller) control=
s on chip.
>>>> +         This driver provides common support for accessing the de=
vice;
>>>> +         additional drivers must be enabled in order to use the f=
unctionality
>>>> +         of the device.
>>>> +
>>>>  config MFD_MAX8907
>>>>         tristate "Maxim Semiconductor MAX8907 PMIC Support"
>>>>         select MFD_CORE
>>>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>>>> index 53467e2..fe4f75c 100644
>>>> --- a/drivers/mfd/Makefile
>>>> +++ b/drivers/mfd/Makefile
>>>> @@ -117,6 +117,7 @@ obj-$(CONFIG_MFD_DA9063)    +=3D da9063.o
>>>>  obj-$(CONFIG_MFD_MAX14577)     +=3D max14577.o
>>>>  obj-$(CONFIG_MFD_MAX77686)     +=3D max77686.o
>>>>  obj-$(CONFIG_MFD_MAX77693)     +=3D max77693.o
>>>> +obj-$(CONFIG_MFD_MAX77843)     +=3D max77843.o
>>>>  obj-$(CONFIG_MFD_MAX8907)      +=3D max8907.o
>>>>  max8925-objs                   :=3D max8925-core.o max8925-i2c.o
>>>>  obj-$(CONFIG_MFD_MAX8925)      +=3D max8925.o
>>>> diff --git a/drivers/mfd/max77843.c b/drivers/mfd/max77843.c
>>>> new file mode 100644
>>>> index 0000000..d7f8b76
>>>> --- /dev/null
>>>> +++ b/drivers/mfd/max77843.c
>>>> @@ -0,0 +1,241 @@
>>>> +/*
>>>> + * max77843.c - MFD core driver for the Maxim MAX77843
>>>> + *
>>>> + * Copyright (C) 2014 Samsung Electrnoics
>>>> + * Author: Jaewon Kim <jaewon02.kim@samsung.com>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or =
modify
>>>> + * it under the terms of the GNU General Public License as publis=
hed by
>>>> + * the Free Software Foundation; either version 2 of the License,=
 or
>>>> + * (at your option) any later version.
>>>> + */
>>>> +
>>>> +#include <linux/err.h>
>>>> +#include <linux/i2c.h>
>>>> +#include <linux/init.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/mfd/core.h>
>>>> +#include <linux/mfd/max77843-private.h>
>>>> +#include <linux/of_device.h>
>>>> +#include <linux/platform_device.h>
>>>> +
>>>> +static const struct mfd_cell max77843_devs[] =3D {
>>>> +       {
>>>> +               .name =3D "max77843-muic",
>>>> +               .of_compatible =3D "maxim,max77843-muic",
>>>> +       }, {
>>>> +               .name =3D "max77843-regulator",
>>>> +               .of_compatible =3D "maxim,max77843-regulator",
>>>> +       }, {
>>>> +               .name =3D "max77843-charger",
>>>> +               .of_compatible =3D "maxim,max77843-charger"
>>>> +       }, {
>>>> +               .name =3D "max77843-fuelgauge",
>>>> +               .of_compatible =3D "maxim,max77843-fuelgauge",
>>>> +       },
>>>> +};
>>>> +
>>>> +static const struct regmap_config max77843_charger_regmap_config =
=3D {
>>>> +       .reg_bits       =3D 8,
>>>> +       .val_bits       =3D 8,
>>>> +       .max_register   =3D MAX77843_CHG_REG_END,
>>>> +};
>>>> +
>>>> +static const struct regmap_config max77843_regmap_config =3D {
>>>> +       .reg_bits       =3D 8,
>>>> +       .val_bits       =3D 8,
>>>> +       .max_register   =3D MAX77843_SYS_REG_END,
>>>> +};
>>>> +
>>>> +static const struct regmap_irq max77843_irqs[] =3D {
>>>> +       /* TOPSYS interrupts */
>>>> +       { .reg_offset =3D 0, .mask =3D MAX77843_SYS_IRQ_SYSUVLO_IN=
T, },
>>>> +       { .reg_offset =3D 0, .mask =3D MAX77843_SYS_IRQ_SYSOVLO_IN=
T, },
>>>> +       { .reg_offset =3D 0, .mask =3D MAX77843_SYS_IRQ_TSHDN_INT,=
 },
>>>> +       { .reg_offset =3D 0, .mask =3D MAX77843_SYS_IRQ_TM_INT, },
>>>> +};
>>>> +
>>>> +static const struct regmap_irq_chip max77843_irq_chip =3D {
>>>> +       .name           =3D "max77843",
>>>> +       .status_base    =3D MAX77843_SYS_REG_SYSINTSRC,
>>>> +       .mask_base      =3D MAX77843_SYS_REG_SYSINTMASK,
>>>> +       .mask_invert    =3D false,
>>>> +       .num_regs       =3D 1,
>>>> +       .irqs           =3D max77843_irqs,
>>>> +       .num_irqs       =3D ARRAY_SIZE(max77843_irqs),
>>>> +};
>>>> +
>>>> +static int max77843_chg_init(struct max77843 *max77843)
>>>> +{
>>>
>>> Could this function be moved to the charger driver? This way the
>>> driver will manage its own resources instead of depending on parent
>>> MFD driver.
>>>
>>
>> Charger regulator and Charger share same resources.
>> So I include this function core driver.
>=20
> OK, I see... Could you describe it in comments somewhere? For example=
 in
> comment above the function. Currently this looks like only as regmap =
for
> charger.
>=20

Charger regulator and Charger use same regmap.

> Unfortunately current solution imposes problem with releasing resourc=
es.
> Who is the owner of i2c dummy device?
>=20

Core driver owner of i2c dummy device.

> 1. The charger driver will unregister it if max77843_charger_probe()
> fails. What will happen with regulator driver in such case?
>=20

Charger is enabled/disabled by Charger regulator.
Currently, If charger probe fails, charger regulator failed to read reg=
map and occur panic(It have to fix.)


> 2. Who will release this i2c dummy device in normal unbind? Currently=
 it
> leaks.
>=20

I think core driver release i2c dummy device in normal unbind.
We need to more discussion about this problem.
If you have any idea, I hope tell me. Again, Thank you for your advice.

Thanks,
Beomho Seo


> Best regards,
> Krzysztof
>=20
>>
>>>> +       int ret;
>>>> +
>>>> +       max77843->i2c_chg =3D i2c_new_dummy(max77843->i2c->adapter=
, I2C_ADDR_CHG);
>>>> +       if (!max77843->i2c_chg) {
>>>> +               dev_err(&max77843->i2c->dev,
>>>> +                               "Cannot allocate I2C device for Ch=
arger\n");
>>>> +               return PTR_ERR(max77843->i2c_chg);
>>>> +       }
>>>> +       i2c_set_clientdata(max77843->i2c_chg, max77843);
>>>> +
>>>> +       max77843->regmap_chg =3D devm_regmap_init_i2c(max77843->i2=
c_chg,
>>>> +                       &max77843_charger_regmap_config);
>>>> +       if (IS_ERR(max77843->regmap_chg)) {
>>>> +               ret =3D PTR_ERR(max77843->regmap_chg);
>>>> +               goto err_chg_i2c;
>>>> +       }
>>>> +
>>>> +       return 0;
>>>> +
>>>> +err_chg_i2c:
>>>> +       i2c_unregister_device(max77843->i2c_chg);
>>>> +
>>>> +       return ret;
>>>> +}
>>>> +
>>>> +static int max77843_probe(struct i2c_client *i2c,
>>>> +                                       const struct i2c_device_id=
 *id)
>>>> +{
>>>> +       struct max77843 *max77843;
>>>> +       int ret;
>>>> +       unsigned int reg_data;
>>>> +
>>>> +       max77843 =3D devm_kzalloc(&i2c->dev, sizeof(*max77843), GF=
P_KERNEL);
>>>> +       if (!max77843)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       i2c_set_clientdata(i2c, max77843);
>>>> +       max77843->dev =3D &i2c->dev;
>>>> +       max77843->i2c =3D i2c;
>>>> +       max77843->irq =3D i2c->irq;
>>>> +
>>>> +       max77843->regmap =3D devm_regmap_init_i2c(i2c,
>>>> +                       &max77843_regmap_config);
>>>> +       if (IS_ERR(max77843->regmap)) {
>>>> +               dev_err(&i2c->dev, "Failed to allocate topsys regi=
ster map\n");
>>>> +               return PTR_ERR(max77843->regmap);
>>>> +       }
>>>> +
>>>> +       ret =3D regmap_add_irq_chip(max77843->regmap, max77843->ir=
q,
>>>> +                       IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHA=
RED,
>>>> +                       0, &max77843_irq_chip, &max77843->irq_data=
);
>>>
>>> Why shared IRQ?
>>>
>>>> +       if (ret) {
>>>> +               dev_err(&i2c->dev, "Failed to add TOPSYS IRQ chip\=
n");
>>>> +               return ret;
>>>> +       }
>>>> +
>>>> +       ret =3D regmap_read(max77843->regmap,
>>>> +                       MAX77843_SYS_REG_PMICID, &reg_data);
>>>> +       if (ret < 0) {
>>>> +               dev_err(&i2c->dev, "Failed to read PMIC ID\n");
>>>> +               goto err_pmic_id;
>>>> +       }
>>>> +       dev_info(&i2c->dev, "device ID: 0x%x\n", reg_data);
>>>> +
>>>> +       ret =3D max77843_chg_init(max77843);
>>>> +       if (ret) {
>>>> +               dev_err(&i2c->dev, "Failed to init Charger\n");
>>>> +               goto err_pmic_id;
>>>> +       }
>>>> +
>>>> +       ret =3D regmap_update_bits(max77843->regmap,
>>>> +                       MAX77843_SYS_REG_INTSRCMASK,
>>>> +                       MAX77843_INTSRC_MASK_MASK,
>>>> +                       (unsigned int)~MAX77843_INTSRC_MASK_MASK);
>>>> +       if (ret < 0) {
>>>> +               dev_err(&i2c->dev, "Failed to unmask interrupt sou=
rece\n");
>>>
>>> s/sourece/source/
>>>
>>> Best regards,
>>> Krzysztof
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pm"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

