From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: Re: [PATCH v3 1/6] mfd: max77843: Add max77843 MFD driver core driver
Date: Mon, 23 Feb 2015 10:43:23 +0900
Message-ID: <54EA85BB.4050600@samsung.com>
References: <1423025771-4139-1-git-send-email-jaewon02.kim@samsung.com>
 <1423025771-4139-2-git-send-email-jaewon02.kim@samsung.com>
 <20150216135155.GI14545@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150216135155.GI14545@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, Beomho Seo <beomho.seo@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Lee Jones,

On 02/16/2015 10:51 PM, Lee Jones wrote:
> On Wed, 04 Feb 2015, Jaewon Kim wrote:
>
>> This patch adds MAX77843 core/irq driver to support PMIC,
>> MUIC(Micro USB Interface Controller), Charger, Fuel Gauge,
>> LED and Haptic device.
>>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>> ---
>>   drivers/mfd/Kconfig                  |   14 ++
>>   drivers/mfd/Makefile                 |    1 +
>>   drivers/mfd/max77843.c               |  245 +++++++++++++++++++
>>   include/linux/mfd/max77843-private.h |  441 ++++++++++++++++++++++++++++++++++
>>   4 files changed, 701 insertions(+)
>>   create mode 100644 drivers/mfd/max77843.c
>>   create mode 100644 include/linux/mfd/max77843-private.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 2e6b731..0c67c79 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -442,6 +442,20 @@ config MFD_MAX77693
>>   	  additional drivers must be enabled in order to use the functionality
>>   	  of the device.
>>   
>> +config MFD_MAX77843
>> +	bool "Maxim Semiconductor MAX77843 PMIC Support"
>> +	depends on I2C=y
>> +	select MFD_CORE
>> +	select REGMAP_I2C
>> +	select REGMAP_IRQ
>> +	help
>> +	  Say yes here to add support for Maxim Semiconductor MAX77843.
>> +	  This is companion Power Management IC with LEDs, Haptic, Charger,
>> +	  Fuel Gauge, MUIC(Micro USB Interface Controller) controls on chip.
>> +	  This driver provides common support for accessing the device;
>> +	  additional drivers must be enabled in order to use the functionality
>> +	  of the device.
>> +
>>   config MFD_MAX8907
>>   	tristate "Maxim Semiconductor MAX8907 PMIC Support"
>>   	select MFD_CORE
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index 53467e2..fe4f75c 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -117,6 +117,7 @@ obj-$(CONFIG_MFD_DA9063)	+= da9063.o
>>   obj-$(CONFIG_MFD_MAX14577)	+= max14577.o
>>   obj-$(CONFIG_MFD_MAX77686)	+= max77686.o
>>   obj-$(CONFIG_MFD_MAX77693)	+= max77693.o
>> +obj-$(CONFIG_MFD_MAX77843)	+= max77843.o
> This is the 11th MAX driver.  Can't they be supported using device
> specific data structures instead of taking a 'one file per device'
> approach?
Kzysztof answered already, we try to merge with other files.
But MAX77843 can`t merge with another MAX drivers.
Because This driver has new features (e.g AFC charger, Reverse Boost, 4 
channel LED driver, etc)
so new registers extended and moved.

>
>>   obj-$(CONFIG_MFD_MAX8907)	+= max8907.o
>>   max8925-objs			:= max8925-core.o max8925-i2c.o
>>   obj-$(CONFIG_MFD_MAX8925)	+= max8925.o
>> diff --git a/drivers/mfd/max77843.c b/drivers/mfd/max77843.c
>> new file mode 100644
>> index 0000000..191a557
>> --- /dev/null
>> +++ b/drivers/mfd/max77843.c
>> @@ -0,0 +1,245 @@
>> +/*
>> + * max77843.c - MFD core driver for the Maxim MAX77843
>> + *
>> + * Copyright (C) 2015 Samsung Electronics
>> + * Author: Jaewon Kim <jaewon02.kim@samsung.com>
>> + * Author: Beomho Seo <beomho.seo@samsung.com>
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
> [...]
>
>> +static int max77843_probe(struct i2c_client *i2c,
>> +					const struct i2c_device_id *id)
> Strange tabbing here.

I will fix it in next version.
>
>> +{
>> +	struct max77843 *max77843;
>> +	unsigned int reg_data;
>> +	int ret;
>> +
>> +	max77843 = devm_kzalloc(&i2c->dev, sizeof(*max77843), GFP_KERNEL);
>> +	if (!max77843)
>> +		return -ENOMEM;
>> +
>> +	i2c_set_clientdata(i2c, max77843);
>> +	max77843->dev = &i2c->dev;
>> +	max77843->i2c = i2c;
>> +	max77843->irq = i2c->irq;
>> +
>> +	max77843->regmap = devm_regmap_init_i2c(i2c,
>> +			&max77843_regmap_config);
>> +	if (IS_ERR(max77843->regmap)) {
>> +		dev_err(&i2c->dev, "Failed to allocate topsys register map\n");
>> +		return PTR_ERR(max77843->regmap);
>> +	}
>> +
>> +	ret = regmap_add_irq_chip(max77843->regmap, max77843->irq,
>> +			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
>> +			0, &max77843_irq_chip, &max77843->irq_data);
>> +	if (ret) {
>> +		dev_err(&i2c->dev, "Failed to add TOPSYS IRQ chip\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = regmap_read(max77843->regmap,
>> +			MAX77843_SYS_REG_PMICID, &reg_data);
>> +	if (ret < 0) {
>> +		dev_err(&i2c->dev, "Failed to read PMIC ID\n");
>> +		goto err_pmic_id;
>> +	}
>> +	dev_info(&i2c->dev, "device ID: 0x%x\n", reg_data);
>> +
>> +	ret = max77843_chg_init(max77843);
>> +	if (ret) {
>> +		dev_err(&i2c->dev, "Failed to init Charger\n");
>> +		goto err_pmic_id;
>> +	}
>> +
>> +	ret = regmap_update_bits(max77843->regmap,
>> +			MAX77843_SYS_REG_INTSRCMASK,
>> +			MAX77843_INTSRC_MASK_MASK,
>> +			(unsigned int)~MAX77843_INTSRC_MASK_MASK);
> This stuff looks so much better/easier to read if you line up against
> the '('.

Okay, I will line up against '('.
>
>> +	if (ret < 0) {
>> +		dev_err(&i2c->dev, "Failed to unmask interrupt source\n");
>> +		goto err_pmic_id;
>> +	}
>> +
>> +	ret = mfd_add_devices(max77843->dev, -1, max77843_devs,
>> +			ARRAY_SIZE(max77843_devs), NULL, 0, NULL);
>> +	if (ret < 0) {
>> +		dev_err(&i2c->dev, "Failed to add mfd device\n");
>> +		goto err_pmic_id;
>> +	}
>> +
>> +	device_init_wakeup(max77843->dev, 1);
>> +
>> +	return 0;
>> +
>> +err_pmic_id:
>> +	regmap_del_irq_chip(max77843->irq, max77843->irq_data);
>> +
>> +	return ret;
>> +}
>> +
>> +static int max77843_remove(struct i2c_client *i2c)
>> +{
>> +	struct max77843 *max77843 = i2c_get_clientdata(i2c);
>> +
>> +	mfd_remove_devices(max77843->dev);
>> +
>> +	regmap_del_irq_chip(max77843->irq, max77843->irq_data);
>> +
>> +	i2c_unregister_device(max77843->i2c_chg);
>> +	i2c_unregister_device(max77843->i2c);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id max77843_dt_match[] = {
>> +	{ .compatible = "maxim,max77843", },
>> +	{ /* sentinel */ },
>> +};
>> +
>> +static const struct i2c_device_id max77843_id[] = {
>> +	{ "max77843", },
>> +	{ /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(i2c, max77843_id);
>> +
>> +static int __maybe_unused max77843_suspend(struct device *dev)
>> +{
>> +	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
>> +	struct max77843 *max77843 = i2c_get_clientdata(i2c);
>> +
>> +	if (device_may_wakeup(dev))
>> +		enable_irq_wake(max77843->irq);
>> +	disable_irq(max77843->irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused max77843_resume(struct device *dev)
>> +{
>> +	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
>> +	struct max77843 *max77843 = i2c_get_clientdata(i2c);
>> +
>> +	if (device_may_wakeup(dev))
>> +		disable_irq_wake(max77843->irq);
>> +	enable_irq(max77843->irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(max77843_pm, max77843_suspend, max77843_resume);
>> +
>> +static struct i2c_driver max77843_i2c_driver = {
>> +	.driver		= {
> More strange whitespace stuff.
>
> I'm gussing you haven't run checkpatch.pl.
>
> Please do so and fix-up the warnings.

".drivers" is seven letters. So, it seems like a white space but it is tab
Anyway, I will not lining up driver structure in next version.

>   
>> +		.name		= "max77843",
>> +		.pm		= &max77843_pm,
>> +		.of_match_table = max77843_dt_match,
>> +	},
> Lining these up with the '=' doesn't make the code any better IMO.
>
> [...]
>

Thanks to review my patch.
I will send version4 soon.


Thanks,
Jaewon Kim
