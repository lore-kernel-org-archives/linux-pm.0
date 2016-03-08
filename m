From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 3/3] thermal: max77620: Add thermal driver for reporting
 junction temp
Date: Tue, 8 Mar 2016 13:24:56 -0800
Message-ID: <20160308212455.GA8820@localhost.localdomain>
References: <1457098810-11964-1-git-send-email-ldewangan@nvidia.com>
 <1457098810-11964-4-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34886 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbcCHVY7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2016 16:24:59 -0500
Content-Disposition: inline
In-Reply-To: <1457098810-11964-4-git-send-email-ldewangan@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: rui.zhang@intel.com, corbet@lwn.net, rklein@nvidia.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


Hello Laxman,

Thanks for working on this. Impressed how simplified these drivers are
becoming. I really liked you added the so waited devm_ helpers. Very
minor comments as follows (now that you will send a new version anyway).

On Fri, Mar 04, 2016 at 07:10:10PM +0530, Laxman Dewangan wrote:
> Maxim Semiconductor Max77620 supports alarm interrupts when
> its die temperature crosses 120C and 140C. These threshold
> temperatures are not configurable.
> 
> Add thermal driver to register PMIC die temperature as thermal
> zone sensor and capture the die temperature warning interrupts
> to notifying the client.

Are any of these critical?

> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  drivers/thermal/Kconfig            |   9 +++
>  drivers/thermal/Makefile           |   1 +
>  drivers/thermal/thermal-max77620.c | 151 +++++++++++++++++++++++++++++++++++++

Given that it is a DT based driver, please add also a binding entry
under Documentation/devicetree/bindings/thermal/


>  3 files changed, 161 insertions(+)
>  create mode 100644 drivers/thermal/thermal-max77620.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 5e7c97a..faba1a3 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -194,6 +194,15 @@ config IMX_THERMAL
>  	  cpufreq is used as the cooling device to throttle CPUs when the
>  	  passive trip is crossed.
>  
> +config MAX77620_THERMAL
> +	tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
> +	depends on MFD_MAX77620

Can this be COMPILE_TEST'ed?

> +	depends on OF

> +	help
> +	  Support for die junction temperature warning alarm for Maxim
> +	  Semiconductor PMIC MAX77620 device. Device generates alert
> +	  signal/interrupt when die temperature cross its threshold.
> +

Somehow checkpatch.pl --strict is complaining about this entry. Can you
please check?


>  config SPEAR_THERMAL
>  	tristate "SPEAr thermal sensor driver"
>  	depends on PLAT_SPEAR || COMPILE_TEST
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 8e9cbc3..c6bc2bd 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_DOVE_THERMAL)  	+= dove_thermal.o
>  obj-$(CONFIG_DB8500_THERMAL)	+= db8500_thermal.o
>  obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
>  obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
> +obj-$(CONFIG_MAX77620_THERMAL)	+= thermal-max77620.o
>  obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+= db8500_cpufreq_cooling.o
>  obj-$(CONFIG_INTEL_POWERCLAMP)	+= intel_powerclamp.o
>  obj-$(CONFIG_X86_PKG_TEMP_THERMAL)	+= x86_pkg_temp_thermal.o
> diff --git a/drivers/thermal/thermal-max77620.c b/drivers/thermal/thermal-max77620.c
> new file mode 100644
> index 0000000..846da62
> --- /dev/null
> +++ b/drivers/thermal/thermal-max77620.c
> @@ -0,0 +1,151 @@
> +/*
> + * Junction temperature thermal driver for Maxim Max77620.
> + *
> + * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
> + *
> + * Author: Laxman Dewangan <ldewangan@nvidia.com>
> + *	   Mallikarjun Kasoju <mkasoju@nvidia.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/max77620.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +
> +#define MAX77620_NORMAL_OPERATING_TEMP	100000
> +#define MAX77620_TJALARM1_TEMP		120000
> +#define MAX77620_TJALARM1_TEMP		140000
> +
> +struct max77620_therm_info {
> +	struct device			*dev;
> +	struct regmap			*rmap;
> +	struct thermal_zone_device	*tz_device;
> +	int				irq_tjalarm1;
> +	int				irq_tjalarm2;
> +};
> +
> +static int max77620_thermal_read_temp(void *data, int *temp)
> +{
> +	struct max77620_therm_info *mtherm = data;
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(mtherm->rmap, MAX77620_REG_STATLBT, &val);
> +	if (ret < 0) {
> +		dev_err(mtherm->dev, "Failed to read STATLBT, %d\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	if (val & MAX77620_IRQ_TJALRM2_MASK)
> +		*temp = MAX77620_TJALARM2_TEMP;
> +	else if (val & MAX77620_IRQ_TJALRM1_MASK)
> +		*temp = MAX77620_TJALARM1_TEMP;
> +	else
> +		*temp = MAX77620_NORMAL_OPERATING_TEMP;

So, no way at all to get a temp?

> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops max77620_thermal_ops = {
> +	.get_temp = max77620_thermal_read_temp,
> +};
> +
> +static irqreturn_t max77620_thermal_irq(int irq, void *data)
> +{
> +	struct max77620_therm_info *mtherm = data;
> +
> +	if (irq == mtherm->irq_tjalarm1)
> +		dev_warn(mtherm->dev, "Junction Temp Alarm1(120C) occurred\n");
> +	else if (irq == mtherm->irq_tjalarm2)
> +		dev_warn(mtherm->dev, "Junction Temp Alarm2(140C) occurred\n");
> +
> +	thermal_zone_device_update(mtherm->tz_device);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int max77620_thermal_probe(struct platform_device *pdev)
> +{
> +	struct max77620_therm_info *mtherm;
> +	int ret;
> +
> +	if (!pdev->dev.of_node)
> +		pdev->dev.of_node = pdev->dev.parent->of_node;

Why is this needed?

> +
> +	mtherm = devm_kzalloc(&pdev->dev, sizeof(*mtherm), GFP_KERNEL);
> +	if (!mtherm)
> +		return -ENOMEM;
> +
> +	mtherm->irq_tjalarm1 = platform_get_irq(pdev, 0);
> +	mtherm->irq_tjalarm2 = platform_get_irq(pdev, 1);
> +	if ((mtherm->irq_tjalarm1 < 0) || (mtherm->irq_tjalarm2 < 0)) {
> +		dev_err(&pdev->dev, "Alarm irq number not available\n");
> +		return -EINVAL;
> +	}
> +
> +	mtherm->dev = &pdev->dev;
> +	mtherm->rmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!mtherm->rmap) {
> +		dev_err(&pdev->dev, "Failed to get parent regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	mtherm->tz_device = devm_thermal_zone_of_sensor_register(&pdev->dev, 0,
> +				mtherm, &max77620_thermal_ops);
> +	if (IS_ERR(mtherm->tz_device)) {
> +		ret = PTR_ERR(mtherm->tz_device);
> +		dev_err(&pdev->dev, "Failed to register thermal zone, %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, mtherm->irq_tjalarm1, NULL,
> +					max77620_thermal_irq,
> +					IRQF_ONESHOT | IRQF_SHARED,
> +					dev_name(&pdev->dev), mtherm);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to request irq1, %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, mtherm->irq_tjalarm2, NULL,
> +					max77620_thermal_irq,
> +					IRQF_ONESHOT | IRQF_SHARED,
> +					dev_name(&pdev->dev), mtherm);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to request irq2, %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, mtherm);
nit: empty line here.
> +	return 0;
> +}
> +
> +static struct platform_device_id max77620_thermal_devtype[] = {
> +	{ .name = "max77620-thermal", },
> +	{},
> +};
> +
> +static struct platform_driver max77620_thermal_driver = {
> +	.driver = {
> +		.name = "max77620-thermal",
> +	},
> +	.probe = max77620_thermal_probe,
> +	.id_table = max77620_thermal_devtype,
> +};
> +
> +module_platform_driver(max77620_thermal_driver);
> +
> +MODULE_DESCRIPTION("Max77620 Junction temperature Thermal driver");
> +MODULE_ALIAS("platform:max77620-thermal");
> +MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
> +MODULE_AUTHOR("Mallikarjun Kasoju <mkasoju@nvidia.com>");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.1.4
> 
