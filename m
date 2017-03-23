From: Jon Mason <jon.mason@broadcom.com>
Subject: Re: [PATCH 2/2] thermal: broadcom: add Northstar thermal driver
Date: Thu, 23 Mar 2017 13:14:20 -0400
Message-ID: <20170323171417.GB8228@broadcom.com>
References: <20170318155632.18099-1-zajec5@gmail.com>
 <20170318155632.18099-2-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33227 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752503AbdCWRO0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 13:14:26 -0400
Received: by mail-qk0-f182.google.com with SMTP id y76so186032450qkb.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 10:14:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170318155632.18099-2-zajec5@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>

On Sat, Mar 18, 2017 at 04:56:32PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Northstar is a SoC family commonly used in home routers. This commit
> adds a driver for checking CPU temperature.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  drivers/thermal/Kconfig               |  5 ++
>  drivers/thermal/Makefile              |  1 +
>  drivers/thermal/broadcom/Kconfig      |  7 +++
>  drivers/thermal/broadcom/Makefile     |  1 +
>  drivers/thermal/broadcom/ns-thermal.c | 93 +++++++++++++++++++++++++++++++++++
>  5 files changed, 107 insertions(+)
>  create mode 100644 drivers/thermal/broadcom/Kconfig
>  create mode 100644 drivers/thermal/broadcom/Makefile
>  create mode 100644 drivers/thermal/broadcom/ns-thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 776b34396144..008e173ec825 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -392,6 +392,11 @@ config MTK_THERMAL
>  	  Enable this option if you want to have support for thermal management
>  	  controller present in Mediatek SoCs
>  
> +menu "Broadcom thermal drivers"
> +depends on ARCH_BCM || COMPILE_TEST
> +source "drivers/thermal/broadcom/Kconfig"
> +endmenu
> +
>  menu "Texas Instruments thermal drivers"
>  depends on ARCH_HAS_BANDGAP || COMPILE_TEST
>  depends on HAS_IOMEM
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 7adae2029355..549d81b6363c 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -27,6 +27,7 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
>  thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
>  
>  # platform thermal drivers
> +obj-y				+= broadcom/
>  obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
>  obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
>  obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
> diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/Kconfig
> new file mode 100644
> index 000000000000..08457a461794
> --- /dev/null
> +++ b/drivers/thermal/broadcom/Kconfig
> @@ -0,0 +1,7 @@
> +config BCM_NS_THERMAL
> +	tristate "Northstar thermal driver"
> +	depends on ARCH_BCM_5301X || COMPILE_TEST
> +	help
> +	  Northstar's DMU (Device Management Unit) block contains a thermal
> +	  sensor that allows checking CPU temperature. This driver provides
> +	  support for it.

The register layout for the NS PVTMON is the same for NSP and NS2.
So, you might want to make this more generic.  Perhaps iProc or
Northstar family.  I did a quick look, and I didn't see PVTMON
registers in Cygnus, so maybe the latter is better.  Also, the depends
should be tweaked to have NSP, etc.

> diff --git a/drivers/thermal/broadcom/Makefile b/drivers/thermal/broadcom/Makefile
> new file mode 100644
> index 000000000000..059df9a0ed69
> --- /dev/null
> +++ b/drivers/thermal/broadcom/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_BCM_NS_THERMAL)		+= ns-thermal.o
> diff --git a/drivers/thermal/broadcom/ns-thermal.c b/drivers/thermal/broadcom/ns-thermal.c
> new file mode 100644
> index 000000000000..1ec710febc55
> --- /dev/null
> +++ b/drivers/thermal/broadcom/ns-thermal.c
> @@ -0,0 +1,93 @@
> +/*
> + * Copyright (C) 2017 Rafał Miłecki <rafal@milecki.pl>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/thermal.h>
> +
> +#define PVTMON_CONTROL0		0x00
> +#define PVTMON_STATUS		0x08
> +
> +struct ns_thermal {
> +	void __iomem *pvtmon;
> +};
> +
> +static int ns_thermal_get_temp(void *data, int *temp)
> +{
> +	struct ns_thermal *ns_thermal = data;
> +	u32 val;
> +
> +	val = readl(ns_thermal->pvtmon + PVTMON_STATUS);
> +	*temp = 418000 - (val * 556);
> +
> +	return 0;
> +}
> +
> +const struct thermal_zone_of_device_ops ns_thermal_ops = {
> +	.get_temp = ns_thermal_get_temp,
> +};
> +
> +static int ns_thermal_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ns_thermal *ns_thermal;
> +	struct thermal_zone_device *tzd;
> +	u32 val;
> +
> +	ns_thermal = devm_kzalloc(dev, sizeof(*ns_thermal), GFP_KERNEL);
> +	if (!ns_thermal)
> +		return -ENOMEM;
> +
> +	ns_thermal->pvtmon = of_iomap(dev_of_node(dev), 0);
> +	if (WARN_ON(!ns_thermal->pvtmon))
> +		return -ENOENT;
> +
> +	val = readl(ns_thermal->pvtmon + PVTMON_CONTROL0);
> +	if (val & 0xf)
> +		writel(val & ~0xf, ns_thermal->pvtmon + PVTMON_CONTROL0);

This appears to be zeroing the register.  You are either intentionally
excluding the Voltage DAC (bits 4-13) or don't know it is there.  I do
not know this IP block well enough to know if there are negative
consiquences from zeroing this, but the power on default is 0
(assording to the spec).

FYI, writing a 1 to bit 0 will "power down" PVTMON.

Also, PVTMON Select (bits 1-3):
0 - Temp Monitor Enable
1-6 - Various Voltage Monitoring Settings
7 - Test mode

So, if this driver is ever expanded to do voltage too, then the
setting of PVTMON_CONTROL0 will need to move to the
ns_thermal_get_temp above.


Thanks,
Jon

> +
> +	tzd = devm_thermal_zone_of_sensor_register(dev, 0, ns_thermal,
> +						   &ns_thermal_ops);
> +	if (IS_ERR(tzd)) {
> +		iounmap(ns_thermal->pvtmon);
> +		return PTR_ERR(tzd);
> +	}
> +
> +	platform_set_drvdata(pdev, ns_thermal);
> +
> +	return 0;
> +}
> +
> +static int ns_thermal_remove(struct platform_device *pdev)
> +{
> +	struct ns_thermal *ns_thermal = platform_get_drvdata(pdev);
> +
> +	iounmap(ns_thermal->pvtmon);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ns_thermal_of_match[] = {
> +	{ .compatible = "brcm,ns-thermal", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ns_thermal_of_match);
> +
> +static struct platform_driver ns_thermal_driver = {
> +	.probe		= ns_thermal_probe,
> +	.remove		= ns_thermal_remove,
> +	.driver = {
> +		.name = "ns-thermal",
> +		.of_match_table = ns_thermal_of_match,
> +	},
> +};
> +module_platform_driver(ns_thermal_driver);
> +
> +MODULE_DESCRIPTION("Northstar thermal driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.11.0
> 
