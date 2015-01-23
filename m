From: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/6] mfd: max77843: Add max77843 MFD driver core driver
Date: Fri, 23 Jan 2015 20:26:46 +0900
Message-ID: <54C22FF6.5060606@samsung.com>
References: <1421989367-32721-1-git-send-email-jaewon02.kim@samsung.com>
 <1421989367-32721-2-git-send-email-jaewon02.kim@samsung.com>
 <CAJKOXPfRYhJNUAE=W3zPWvyza9k_YA=hu4KjLRuLh7kie3guQA@mail.gmail.com>
 <54C1ED09.1080607@samsung.com> <1421997364.27149.5.camel@AMDC1943>
 <54C22C3B.8040403@samsung.com> <1422011884.18205.4.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1422011884.18205.4.camel@AMDC1943>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 01/23/2015 08:18 PM, Krzysztof Kozlowski wrote:
> On pi=C4=85, 2015-01-23 at 20:10 +0900, Beomho Seo wrote:
>> On 01/23/2015 04:16 PM, Krzysztof Kozlowski wrote:
>>> On pi=C4=85, 2015-01-23 at 15:41 +0900, Beomho Seo wrote:
>>>> On 01/23/2015 03:32 PM, Krzysztof Kozlowski wrote:
>>>>> 2015-01-23 6:02 GMT+01:00 Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>:
>>>>>> This patch adds MAX77843 core/irq driver to support PMIC,
>>>>>> MUIC(Micro USB Interface Controller), Charger, Fuel Gauge,
>>>>>> LED and Haptic device.
>>>>>>
>>>>>> Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>>> Signed-off-by: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>>>>> Signed-off-by: Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>>>>> ---
>>>>>>  drivers/mfd/Kconfig                  |   14 ++
>>>>>>  drivers/mfd/Makefile                 |    1 +
>>>>>>  drivers/mfd/max77843.c               |  241 +++++++++++++++++++=
+
>>>>>>  include/linux/mfd/max77843-private.h |  410 +++++++++++++++++++=
+++++++++++++++
>>>>>>  4 files changed, 666 insertions(+)
>>>>>>  create mode 100644 drivers/mfd/max77843.c
>>>>>>  create mode 100644 include/linux/mfd/max77843-private.h
>>>>>>
>>>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>>>> index 2e6b731..0c67c79 100644
>>>>>> --- a/drivers/mfd/Kconfig
>>>>>> +++ b/drivers/mfd/Kconfig
>>>>>> @@ -442,6 +442,20 @@ config MFD_MAX77693
>>>>>>           additional drivers must be enabled in order to use the=
 functionality
>>>>>>           of the device.
>>>>>>
>>>>>> +config MFD_MAX77843
>>>>>> +       bool "Maxim Semiconductor MAX77843 PMIC Support"
>>>>>> +       depends on I2C=3Dy
>>>>>> +       select MFD_CORE
>>>>>> +       select REGMAP_I2C
>>>>>> +       select REGMAP_IRQ
>>>>>> +       help
>>>>>> +         Say yes here to add support for Maxim Semiconductor MA=
X77843.
>>>>>> +         This is companion Power Management IC with LEDs, Hapti=
c, Charger,
>>>>>> +         Fuel Gauge, MUIC(Micro USB Interface Controller) contr=
ols on chip.
>>>>>> +         This driver provides common support for accessing the =
device;
>>>>>> +         additional drivers must be enabled in order to use the=
 functionality
>>>>>> +         of the device.
>>>>>> +
>>>>>>  config MFD_MAX8907
>>>>>>         tristate "Maxim Semiconductor MAX8907 PMIC Support"
>>>>>>         select MFD_CORE
>>>>>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>>>>>> index 53467e2..fe4f75c 100644
>>>>>> --- a/drivers/mfd/Makefile
>>>>>> +++ b/drivers/mfd/Makefile
>>>>>> @@ -117,6 +117,7 @@ obj-$(CONFIG_MFD_DA9063)    +=3D da9063.o
>>>>>>  obj-$(CONFIG_MFD_MAX14577)     +=3D max14577.o
>>>>>>  obj-$(CONFIG_MFD_MAX77686)     +=3D max77686.o
>>>>>>  obj-$(CONFIG_MFD_MAX77693)     +=3D max77693.o
>>>>>> +obj-$(CONFIG_MFD_MAX77843)     +=3D max77843.o
>>>>>>  obj-$(CONFIG_MFD_MAX8907)      +=3D max8907.o
>>>>>>  max8925-objs                   :=3D max8925-core.o max8925-i2c.=
o
>>>>>>  obj-$(CONFIG_MFD_MAX8925)      +=3D max8925.o
>>>>>> diff --git a/drivers/mfd/max77843.c b/drivers/mfd/max77843.c
>>>>>> new file mode 100644
>>>>>> index 0000000..d7f8b76
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/mfd/max77843.c
>>>>>> @@ -0,0 +1,241 @@
>>>>>> +/*
>>>>>> + * max77843.c - MFD core driver for the Maxim MAX77843
>>>>>> + *
>>>>>> + * Copyright (C) 2014 Samsung Electrnoics
>>>>>> + * Author: Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>>>>> + *
>>>>>> + * This program is free software; you can redistribute it and/o=
r modify
>>>>>> + * it under the terms of the GNU General Public License as publ=
ished by
>>>>>> + * the Free Software Foundation; either version 2 of the Licens=
e, or
>>>>>> + * (at your option) any later version.
>>>>>> + */
>>>>>> +
>>>>>> +#include <linux/err.h>
>>>>>> +#include <linux/i2c.h>
>>>>>> +#include <linux/init.h>
>>>>>> +#include <linux/interrupt.h>
>>>>>> +#include <linux/module.h>
>>>>>> +#include <linux/mfd/core.h>
>>>>>> +#include <linux/mfd/max77843-private.h>
>>>>>> +#include <linux/of_device.h>
>>>>>> +#include <linux/platform_device.h>
>>>>>> +
>>>>>> +static const struct mfd_cell max77843_devs[] =3D {
>>>>>> +       {
>>>>>> +               .name =3D "max77843-muic",
>>>>>> +               .of_compatible =3D "maxim,max77843-muic",
>>>>>> +       }, {
>>>>>> +               .name =3D "max77843-regulator",
>>>>>> +               .of_compatible =3D "maxim,max77843-regulator",
>>>>>> +       }, {
>>>>>> +               .name =3D "max77843-charger",
>>>>>> +               .of_compatible =3D "maxim,max77843-charger"
>>>>>> +       }, {
>>>>>> +               .name =3D "max77843-fuelgauge",
>>>>>> +               .of_compatible =3D "maxim,max77843-fuelgauge",
>>>>>> +       },
>>>>>> +};
>>>>>> +
>>>>>> +static const struct regmap_config max77843_charger_regmap_confi=
g =3D {
>>>>>> +       .reg_bits       =3D 8,
>>>>>> +       .val_bits       =3D 8,
>>>>>> +       .max_register   =3D MAX77843_CHG_REG_END,
>>>>>> +};
>>>>>> +
>>>>>> +static const struct regmap_config max77843_regmap_config =3D {
>>>>>> +       .reg_bits       =3D 8,
>>>>>> +       .val_bits       =3D 8,
>>>>>> +       .max_register   =3D MAX77843_SYS_REG_END,
>>>>>> +};
>>>>>> +
>>>>>> +static const struct regmap_irq max77843_irqs[] =3D {
>>>>>> +       /* TOPSYS interrupts */
>>>>>> +       { .reg_offset =3D 0, .mask =3D MAX77843_SYS_IRQ_SYSUVLO_=
INT, },
>>>>>> +       { .reg_offset =3D 0, .mask =3D MAX77843_SYS_IRQ_SYSOVLO_=
INT, },
>>>>>> +       { .reg_offset =3D 0, .mask =3D MAX77843_SYS_IRQ_TSHDN_IN=
T, },
>>>>>> +       { .reg_offset =3D 0, .mask =3D MAX77843_SYS_IRQ_TM_INT, =
},
>>>>>> +};
>>>>>> +
>>>>>> +static const struct regmap_irq_chip max77843_irq_chip =3D {
>>>>>> +       .name           =3D "max77843",
>>>>>> +       .status_base    =3D MAX77843_SYS_REG_SYSINTSRC,
>>>>>> +       .mask_base      =3D MAX77843_SYS_REG_SYSINTMASK,
>>>>>> +       .mask_invert    =3D false,
>>>>>> +       .num_regs       =3D 1,
>>>>>> +       .irqs           =3D max77843_irqs,
>>>>>> +       .num_irqs       =3D ARRAY_SIZE(max77843_irqs),
>>>>>> +};
>>>>>> +
>>>>>> +static int max77843_chg_init(struct max77843 *max77843)
>>>>>> +{
>>>>>
>>>>> Could this function be moved to the charger driver? This way the
>>>>> driver will manage its own resources instead of depending on pare=
nt
>>>>> MFD driver.
>>>>>
>>>>
>>>> Charger regulator and Charger share same resources.
>>>> So I include this function core driver.
>>>
>>> OK, I see... Could you describe it in comments somewhere? For examp=
le in
>>> comment above the function. Currently this looks like only as regma=
p for
>>> charger.
>>>
>>
>> Charger regulator and Charger use same regmap.
>=20
> OK, just put it in a comment around that function.
>

OK, I add comment above max77843_chg_init function.

>>
>>> Unfortunately current solution imposes problem with releasing resou=
rces.
>>> Who is the owner of i2c dummy device?
>>>
>>
>> Core driver owner of i2c dummy device.
>=20
> OK, good idea. So the core driver should be the only place to unregis=
ter
> it. So needed changes are:
> 1. Remove the i2c_unregister_device() call from
> max77843_charger_probe().
> 2. Add i2c_unregister_device(max77843->i2c_chg) in max77843_remove().
>=20
> The MFD core driver will handle it.
>=20

It will be fixed comply with your advice.

>>
>>> 1. The charger driver will unregister it if max77843_charger_probe(=
)
>>> fails. What will happen with regulator driver in such case?
>>>
>>
>> Charger is enabled/disabled by Charger regulator.
>> Currently, If charger probe fails, charger regulator failed to read =
regmap and occur panic(It have to fix.)
>>
>>
>>> 2. Who will release this i2c dummy device in normal unbind? Current=
ly it
>>> leaks.
>>>
>>
>> I think core driver release i2c dummy device in normal unbind.
>> We need to more discussion about this problem.
>> If you have any idea, I hope tell me. Again, Thank you for your advi=
ce.
>=20
> I think handling the ownership in core driver could solve this.
>=20
> Best regards,
> Krzysztof
>=20

OK. I will fix it.

Thanks,
Beomho

>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
