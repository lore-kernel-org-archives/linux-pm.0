From: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/6] mfd: max77843: Add max77843 MFD driver core driver
Date: Fri, 23 Jan 2015 15:41:13 +0900
Message-ID: <54C1ED09.1080607@samsung.com>
References: <1421989367-32721-1-git-send-email-jaewon02.kim@samsung.com>
 <1421989367-32721-2-git-send-email-jaewon02.kim@samsung.com>
 <CAJKOXPfRYhJNUAE=W3zPWvyza9k_YA=hu4KjLRuLh7kie3guQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <CAJKOXPfRYhJNUAE=W3zPWvyza9k_YA=hu4KjLRuLh7kie3guQA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 01/23/2015 03:32 PM, Krzysztof Kozlowski wrote:
> 2015-01-23 6:02 GMT+01:00 Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>:
>> This patch adds MAX77843 core/irq driver to support PMIC,
>> MUIC(Micro USB Interface Controller), Charger, Fuel Gauge,
>> LED and Haptic device.
>>
>> Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>>  drivers/mfd/Kconfig                  |   14 ++
>>  drivers/mfd/Makefile                 |    1 +
>>  drivers/mfd/max77843.c               |  241 ++++++++++++++++++++
>>  include/linux/mfd/max77843-private.h |  410 ++++++++++++++++++++++++++++++++++
>>  4 files changed, 666 insertions(+)
>>  create mode 100644 drivers/mfd/max77843.c
>>  create mode 100644 include/linux/mfd/max77843-private.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 2e6b731..0c67c79 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -442,6 +442,20 @@ config MFD_MAX77693
>>           additional drivers must be enabled in order to use the functionality
>>           of the device.
>>
>> +config MFD_MAX77843
>> +       bool "Maxim Semiconductor MAX77843 PMIC Support"
>> +       depends on I2C=y
>> +       select MFD_CORE
>> +       select REGMAP_I2C
>> +       select REGMAP_IRQ
>> +       help
>> +         Say yes here to add support for Maxim Semiconductor MAX77843.
>> +         This is companion Power Management IC with LEDs, Haptic, Charger,
>> +         Fuel Gauge, MUIC(Micro USB Interface Controller) controls on chip.
>> +         This driver provides common support for accessing the device;
>> +         additional drivers must be enabled in order to use the functionality
>> +         of the device.
>> +
>>  config MFD_MAX8907
>>         tristate "Maxim Semiconductor MAX8907 PMIC Support"
>>         select MFD_CORE
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index 53467e2..fe4f75c 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -117,6 +117,7 @@ obj-$(CONFIG_MFD_DA9063)    += da9063.o
>>  obj-$(CONFIG_MFD_MAX14577)     += max14577.o
>>  obj-$(CONFIG_MFD_MAX77686)     += max77686.o
>>  obj-$(CONFIG_MFD_MAX77693)     += max77693.o
>> +obj-$(CONFIG_MFD_MAX77843)     += max77843.o
>>  obj-$(CONFIG_MFD_MAX8907)      += max8907.o
>>  max8925-objs                   := max8925-core.o max8925-i2c.o
>>  obj-$(CONFIG_MFD_MAX8925)      += max8925.o
>> diff --git a/drivers/mfd/max77843.c b/drivers/mfd/max77843.c
>> new file mode 100644
>> index 0000000..d7f8b76
>> --- /dev/null
>> +++ b/drivers/mfd/max77843.c
>> @@ -0,0 +1,241 @@
>> +/*
>> + * max77843.c - MFD core driver for the Maxim MAX77843
>> + *
>> + * Copyright (C) 2014 Samsung Electrnoics
>> + * Author: Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/i2c.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/mfd/max77843-private.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +
>> +static const struct mfd_cell max77843_devs[] = {
>> +       {
>> +               .name = "max77843-muic",
>> +               .of_compatible = "maxim,max77843-muic",
>> +       }, {
>> +               .name = "max77843-regulator",
>> +               .of_compatible = "maxim,max77843-regulator",
>> +       }, {
>> +               .name = "max77843-charger",
>> +               .of_compatible = "maxim,max77843-charger"
>> +       }, {
>> +               .name = "max77843-fuelgauge",
>> +               .of_compatible = "maxim,max77843-fuelgauge",
>> +       },
>> +};
>> +
>> +static const struct regmap_config max77843_charger_regmap_config = {
>> +       .reg_bits       = 8,
>> +       .val_bits       = 8,
>> +       .max_register   = MAX77843_CHG_REG_END,
>> +};
>> +
>> +static const struct regmap_config max77843_regmap_config = {
>> +       .reg_bits       = 8,
>> +       .val_bits       = 8,
>> +       .max_register   = MAX77843_SYS_REG_END,
>> +};
>> +
>> +static const struct regmap_irq max77843_irqs[] = {
>> +       /* TOPSYS interrupts */
>> +       { .reg_offset = 0, .mask = MAX77843_SYS_IRQ_SYSUVLO_INT, },
>> +       { .reg_offset = 0, .mask = MAX77843_SYS_IRQ_SYSOVLO_INT, },
>> +       { .reg_offset = 0, .mask = MAX77843_SYS_IRQ_TSHDN_INT, },
>> +       { .reg_offset = 0, .mask = MAX77843_SYS_IRQ_TM_INT, },
>> +};
>> +
>> +static const struct regmap_irq_chip max77843_irq_chip = {
>> +       .name           = "max77843",
>> +       .status_base    = MAX77843_SYS_REG_SYSINTSRC,
>> +       .mask_base      = MAX77843_SYS_REG_SYSINTMASK,
>> +       .mask_invert    = false,
>> +       .num_regs       = 1,
>> +       .irqs           = max77843_irqs,
>> +       .num_irqs       = ARRAY_SIZE(max77843_irqs),
>> +};
>> +
>> +static int max77843_chg_init(struct max77843 *max77843)
>> +{
> 
> Could this function be moved to the charger driver? This way the
> driver will manage its own resources instead of depending on parent
> MFD driver.
> 

Charger regulator and Charger share same resources.
So I include this function core driver.

>> +       int ret;
>> +
>> +       max77843->i2c_chg = i2c_new_dummy(max77843->i2c->adapter, I2C_ADDR_CHG);
>> +       if (!max77843->i2c_chg) {
>> +               dev_err(&max77843->i2c->dev,
>> +                               "Cannot allocate I2C device for Charger\n");
>> +               return PTR_ERR(max77843->i2c_chg);
>> +       }
>> +       i2c_set_clientdata(max77843->i2c_chg, max77843);
>> +
>> +       max77843->regmap_chg = devm_regmap_init_i2c(max77843->i2c_chg,
>> +                       &max77843_charger_regmap_config);
>> +       if (IS_ERR(max77843->regmap_chg)) {
>> +               ret = PTR_ERR(max77843->regmap_chg);
>> +               goto err_chg_i2c;
>> +       }
>> +
>> +       return 0;
>> +
>> +err_chg_i2c:
>> +       i2c_unregister_device(max77843->i2c_chg);
>> +
>> +       return ret;
>> +}
>> +
>> +static int max77843_probe(struct i2c_client *i2c,
>> +                                       const struct i2c_device_id *id)
>> +{
>> +       struct max77843 *max77843;
>> +       int ret;
>> +       unsigned int reg_data;
>> +
>> +       max77843 = devm_kzalloc(&i2c->dev, sizeof(*max77843), GFP_KERNEL);
>> +       if (!max77843)
>> +               return -ENOMEM;
>> +
>> +       i2c_set_clientdata(i2c, max77843);
>> +       max77843->dev = &i2c->dev;
>> +       max77843->i2c = i2c;
>> +       max77843->irq = i2c->irq;
>> +
>> +       max77843->regmap = devm_regmap_init_i2c(i2c,
>> +                       &max77843_regmap_config);
>> +       if (IS_ERR(max77843->regmap)) {
>> +               dev_err(&i2c->dev, "Failed to allocate topsys register map\n");
>> +               return PTR_ERR(max77843->regmap);
>> +       }
>> +
>> +       ret = regmap_add_irq_chip(max77843->regmap, max77843->irq,
>> +                       IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
>> +                       0, &max77843_irq_chip, &max77843->irq_data);
> 
> Why shared IRQ?
> 
>> +       if (ret) {
>> +               dev_err(&i2c->dev, "Failed to add TOPSYS IRQ chip\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = regmap_read(max77843->regmap,
>> +                       MAX77843_SYS_REG_PMICID, &reg_data);
>> +       if (ret < 0) {
>> +               dev_err(&i2c->dev, "Failed to read PMIC ID\n");
>> +               goto err_pmic_id;
>> +       }
>> +       dev_info(&i2c->dev, "device ID: 0x%x\n", reg_data);
>> +
>> +       ret = max77843_chg_init(max77843);
>> +       if (ret) {
>> +               dev_err(&i2c->dev, "Failed to init Charger\n");
>> +               goto err_pmic_id;
>> +       }
>> +
>> +       ret = regmap_update_bits(max77843->regmap,
>> +                       MAX77843_SYS_REG_INTSRCMASK,
>> +                       MAX77843_INTSRC_MASK_MASK,
>> +                       (unsigned int)~MAX77843_INTSRC_MASK_MASK);
>> +       if (ret < 0) {
>> +               dev_err(&i2c->dev, "Failed to unmask interrupt sourece\n");
> 
> s/sourece/source/
> 
> Best regards,
> Krzysztof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
