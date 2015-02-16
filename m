From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/6] mfd: max77843: Add max77843 MFD driver core driver
Date: Mon, 16 Feb 2015 13:51:55 +0000
Message-ID: <20150216135155.GI14545@x1>
References: <1423025771-4139-1-git-send-email-jaewon02.kim@samsung.com>
 <1423025771-4139-2-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:58383 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442AbbBPNwB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Feb 2015 08:52:01 -0500
Received: by mail-we0-f178.google.com with SMTP id w62so29267342wes.9
        for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2015 05:51:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1423025771-4139-2-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, Beomho Seo <beomho.seo@samsung.com>

On Wed, 04 Feb 2015, Jaewon Kim wrote:

> This patch adds MAX77843 core/irq driver to support PMIC,
> MUIC(Micro USB Interface Controller), Charger, Fuel Gauge,
> LED and Haptic device.
>=20
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> ---
>  drivers/mfd/Kconfig                  |   14 ++
>  drivers/mfd/Makefile                 |    1 +
>  drivers/mfd/max77843.c               |  245 +++++++++++++++++++
>  include/linux/mfd/max77843-private.h |  441 ++++++++++++++++++++++++=
++++++++++
>  4 files changed, 701 insertions(+)
>  create mode 100644 drivers/mfd/max77843.c
>  create mode 100644 include/linux/mfd/max77843-private.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 2e6b731..0c67c79 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -442,6 +442,20 @@ config MFD_MAX77693
>  	  additional drivers must be enabled in order to use the functional=
ity
>  	  of the device.
> =20
> +config MFD_MAX77843
> +	bool "Maxim Semiconductor MAX77843 PMIC Support"
> +	depends on I2C=3Dy
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	help
> +	  Say yes here to add support for Maxim Semiconductor MAX77843.
> +	  This is companion Power Management IC with LEDs, Haptic, Charger,
> +	  Fuel Gauge, MUIC(Micro USB Interface Controller) controls on chip=
=2E
> +	  This driver provides common support for accessing the device;
> +	  additional drivers must be enabled in order to use the functional=
ity
> +	  of the device.
> +
>  config MFD_MAX8907
>  	tristate "Maxim Semiconductor MAX8907 PMIC Support"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 53467e2..fe4f75c 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -117,6 +117,7 @@ obj-$(CONFIG_MFD_DA9063)	+=3D da9063.o
>  obj-$(CONFIG_MFD_MAX14577)	+=3D max14577.o
>  obj-$(CONFIG_MFD_MAX77686)	+=3D max77686.o
>  obj-$(CONFIG_MFD_MAX77693)	+=3D max77693.o
> +obj-$(CONFIG_MFD_MAX77843)	+=3D max77843.o

This is the 11th MAX driver.  Can't they be supported using device
specific data structures instead of taking a 'one file per device'
approach?

>  obj-$(CONFIG_MFD_MAX8907)	+=3D max8907.o
>  max8925-objs			:=3D max8925-core.o max8925-i2c.o
>  obj-$(CONFIG_MFD_MAX8925)	+=3D max8925.o
> diff --git a/drivers/mfd/max77843.c b/drivers/mfd/max77843.c
> new file mode 100644
> index 0000000..191a557
> --- /dev/null
> +++ b/drivers/mfd/max77843.c
> @@ -0,0 +1,245 @@
> +/*
> + * max77843.c - MFD core driver for the Maxim MAX77843
> + *
> + * Copyright (C) 2015 Samsung Electronics
> + * Author: Jaewon Kim <jaewon02.kim@samsung.com>
> + * Author: Beomho Seo <beomho.seo@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/max77843-private.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>

[...]

> +static int max77843_probe(struct i2c_client *i2c,
> +					const struct i2c_device_id *id)

Strange tabbing here.

> +{
> +	struct max77843 *max77843;
> +	unsigned int reg_data;
> +	int ret;
> +
> +	max77843 =3D devm_kzalloc(&i2c->dev, sizeof(*max77843), GFP_KERNEL)=
;
> +	if (!max77843)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, max77843);
> +	max77843->dev =3D &i2c->dev;
> +	max77843->i2c =3D i2c;
> +	max77843->irq =3D i2c->irq;
> +
> +	max77843->regmap =3D devm_regmap_init_i2c(i2c,
> +			&max77843_regmap_config);
> +	if (IS_ERR(max77843->regmap)) {
> +		dev_err(&i2c->dev, "Failed to allocate topsys register map\n");
> +		return PTR_ERR(max77843->regmap);
> +	}
> +
> +	ret =3D regmap_add_irq_chip(max77843->regmap, max77843->irq,
> +			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
> +			0, &max77843_irq_chip, &max77843->irq_data);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Failed to add TOPSYS IRQ chip\n");
> +		return ret;
> +	}
> +
> +	ret =3D regmap_read(max77843->regmap,
> +			MAX77843_SYS_REG_PMICID, &reg_data);
> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "Failed to read PMIC ID\n");
> +		goto err_pmic_id;
> +	}
> +	dev_info(&i2c->dev, "device ID: 0x%x\n", reg_data);
> +
> +	ret =3D max77843_chg_init(max77843);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Failed to init Charger\n");
> +		goto err_pmic_id;
> +	}
> +
> +	ret =3D regmap_update_bits(max77843->regmap,
> +			MAX77843_SYS_REG_INTSRCMASK,
> +			MAX77843_INTSRC_MASK_MASK,
> +			(unsigned int)~MAX77843_INTSRC_MASK_MASK);

This stuff looks so much better/easier to read if you line up against
the '('.

> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "Failed to unmask interrupt source\n");
> +		goto err_pmic_id;
> +	}
> +
> +	ret =3D mfd_add_devices(max77843->dev, -1, max77843_devs,
> +			ARRAY_SIZE(max77843_devs), NULL, 0, NULL);
> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "Failed to add mfd device\n");
> +		goto err_pmic_id;
> +	}
> +
> +	device_init_wakeup(max77843->dev, 1);
> +
> +	return 0;
> +
> +err_pmic_id:
> +	regmap_del_irq_chip(max77843->irq, max77843->irq_data);
> +
> +	return ret;
> +}
> +
> +static int max77843_remove(struct i2c_client *i2c)
> +{
> +	struct max77843 *max77843 =3D i2c_get_clientdata(i2c);
> +
> +	mfd_remove_devices(max77843->dev);
> +
> +	regmap_del_irq_chip(max77843->irq, max77843->irq_data);
> +
> +	i2c_unregister_device(max77843->i2c_chg);
> +	i2c_unregister_device(max77843->i2c);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id max77843_dt_match[] =3D {
> +	{ .compatible =3D "maxim,max77843", },
> +	{ /* sentinel */ },
> +};
> +
> +static const struct i2c_device_id max77843_id[] =3D {
> +	{ "max77843", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(i2c, max77843_id);
> +
> +static int __maybe_unused max77843_suspend(struct device *dev)
> +{
> +	struct i2c_client *i2c =3D container_of(dev, struct i2c_client, dev=
);
> +	struct max77843 *max77843 =3D i2c_get_clientdata(i2c);
> +
> +	if (device_may_wakeup(dev))
> +		enable_irq_wake(max77843->irq);
> +	disable_irq(max77843->irq);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused max77843_resume(struct device *dev)
> +{
> +	struct i2c_client *i2c =3D container_of(dev, struct i2c_client, dev=
);
> +	struct max77843 *max77843 =3D i2c_get_clientdata(i2c);
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(max77843->irq);
> +	enable_irq(max77843->irq);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(max77843_pm, max77843_suspend, max77843_res=
ume);
> +
> +static struct i2c_driver max77843_i2c_driver =3D {
> +	.driver		=3D {

More strange whitespace stuff.

I'm gussing you haven't run checkpatch.pl.

Please do so and fix-up the warnings.
=20
> +		.name		=3D "max77843",
> +		.pm		=3D &max77843_pm,
> +		.of_match_table =3D max77843_dt_match,
> +	},

Lining these up with the '=3D' doesn't make the code any better IMO.

[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
