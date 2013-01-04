From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 1/2] thermal: Add support for thermal sensor for Orion
 SoC
Date: Fri, 4 Jan 2013 11:40:08 +0200
Message-ID: <50E6A378.90503@ti.com>
References: <1355482986-885-1-git-send-email-andrew@lunn.ch> <1355482986-885-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45848 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817Ab3ADJkr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Jan 2013 04:40:47 -0500
In-Reply-To: <1355482986-885-2-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>, iwamatsu@nigauri.org, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, jgunthorpe@obsidianresearch.com, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>

Hey Andrew,

On 14-12-2012 13:03, Andrew Lunn wrote:
> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>
> Some Orion SoC has thermal sensor.
> This patch adds support for 88F6282 and 88F6283.
>
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>   .../devicetree/bindings/thermal/orion-thermal.txt  |   16 +++
>   drivers/thermal/Kconfig                            |    7 ++
>   drivers/thermal/Makefile                           |    1 +
>   drivers/thermal/orion_thermal.c                    |  133 ++++++++++++++++++++
>   4 files changed, 157 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/orion-thermal.txt
>   create mode 100644 drivers/thermal/orion_thermal.c
>
> diff --git a/Documentation/devicetree/bindings/thermal/orion-thermal.txt b/Documentation/devicetree/bindings/thermal/orion-thermal.txt
> new file mode 100644
> index 0000000..5ce925d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/orion-thermal.txt
> @@ -0,0 +1,16 @@
> +* Orion Thermal
> +
> +This initial version is for Kirkwood 88F8262 & 88F6283 SoCs, however
> +it is expected the driver will sometime in the future be expanded to
> +also support Dove, using a different compatibility string.
> +
> +Required properties:
> +- compatible : "marvell,kirkwood-thermal"
> +- reg : Address range of the thermal registers
> +
> +Example:
> +
> +	thermal@10078 {
> +		compatible = "marvell,kirkwood";
> +		reg = <0x10078 0x4>;
> +	};

How do you differentiate if the SoC has the temperature sensor? On your 
patch description you are very clear saying that this supports only 
88F8262 & 88F6283 SoCs.

> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index e1cb6bd..3bba13f 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -55,3 +55,10 @@ config EXYNOS_THERMAL
>   	help
>   	  If you say yes here you get support for TMU (Thermal Managment
>   	  Unit) on SAMSUNG EXYNOS series of SoC.
> +
> +config ORION_THERMAL
> +	tristate "Temperature sensor on Marvel Orion SoCs"
> +	depends on PLAT_ORION && THERMAL
> +	help
> +	  Support for the Orion thermal sensor driver into the Linux thermal
> +	  framework. This currently supports only 88F6282 and 88F6283.
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 885550d..2fc64aa 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -6,4 +6,5 @@ obj-$(CONFIG_THERMAL)		+= thermal_sys.o
>   obj-$(CONFIG_CPU_THERMAL)		+= cpu_cooling.o
>   obj-$(CONFIG_SPEAR_THERMAL)		+= spear_thermal.o
>   obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
> +obj-$(CONFIG_ORION_THERMAL)         	+= orion_thermal.o
>   obj-$(CONFIG_EXYNOS_THERMAL)		+= exynos_thermal.o
> diff --git a/drivers/thermal/orion_thermal.c b/drivers/thermal/orion_thermal.c
> new file mode 100644
> index 0000000..e8a2a68
> --- /dev/null
> +++ b/drivers/thermal/orion_thermal.c
> @@ -0,0 +1,133 @@
> +/*
> + * Orion thermal sensor driver
> + *
> + * Copyright (C) 2012 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + */
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/thermal.h>
> +
> +#define THERMAL_VALID_OFFSET	9
> +#define THERMAL_VALID_MASK	0x1
> +#define THERMAL_TEMP_OFFSET	10
> +#define THERMAL_TEMP_MASK	0x1FF
> +
> +/* Orion Thermal Sensor Dev Structure */
> +struct orion_thermal_dev {
> +	void __iomem *base_addr;
> +};
> +
> +static int orion_get_temp(struct thermal_zone_device *thermal,
> +			  unsigned long *temp)
> +{
> +	unsigned long reg;
> +	struct orion_thermal_dev *thermal_dev = thermal->devdata;
> +
> +	reg = readl_relaxed(thermal_dev->base_addr);
> +
> +	/* Valid check */
> +	if (!(reg >> THERMAL_VALID_OFFSET) & THERMAL_VALID_MASK) {
> +		dev_info(&thermal->device,

This state seams to be severe enough to get a dev_err level message.

> +			 "Temperature sensor reading not valid\n");
> +		return -EIO;
> +	}
> +
> +	reg = (reg >> THERMAL_TEMP_OFFSET) & THERMAL_TEMP_MASK;
> +	/* Calculate temperature. See Table 814 in 8262 hardware manual. */
> +	*temp = ((322UL - reg) * 10000UL * 1000UL) / 13625UL;
> +
> +	return 0;
> +}
> +
> +static struct thermal_zone_device_ops ops = {
> +	.get_temp = orion_get_temp,
> +};
> +
> +static int orion_thermal_probe(struct platform_device *pdev)
> +{
> +	struct thermal_zone_device *thermal = NULL;
> +	struct orion_thermal_dev *thermal_dev;
> +	struct resource *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Failed to get platform resource\n");
> +		return -ENODEV;
> +	}
> +
> +	thermal_dev = devm_kzalloc(&pdev->dev, sizeof(*thermal_dev),
> +				   GFP_KERNEL);
> +	if (!thermal_dev) {
> +		dev_err(&pdev->dev, "kzalloc fail\n");
> +		return -ENOMEM;
> +	}
> +
> +	thermal_dev->base_addr = devm_ioremap(&pdev->dev, res->start,
> +					      resource_size(res));


I believe you forgot to request this memory. I suggest you do:
+	thermal_dev->base_addr = devm_request_and_ioremap(&pdev->dev, res->start,
+					      res);


> +	if (!thermal_dev->base_addr) {
> +		dev_err(&pdev->dev, "Failed to ioremap memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	thermal = thermal_zone_device_register("orion_thermal", 0, 0,
> +				   thermal_dev, &ops, 0, 0);
> +	if (IS_ERR(thermal)) {
> +		dev_err(&pdev->dev,
> +			"Failed to register thermal zone device\n");
> +		return  PTR_ERR(thermal);
> +	}
> +
> +	platform_set_drvdata(pdev, thermal);
> +
> +	dev_info(&thermal->device,
> +		 KBUILD_MODNAME ": Thermal sensor registered\n");

Do you really need to be verbose? I suppose one can always check sysfs 
entries to see if there is a successful driver & device binding...

> +
> +	return 0;
> +}
> +
> +static int orion_thermal_exit(struct platform_device *pdev)
> +{
> +	struct thermal_zone_device *orion_thermal = platform_get_drvdata(pdev);
> +
> +	thermal_zone_device_unregister(orion_thermal);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id orion_thermal_id_table[] = {
> +	{ .compatible = "marvell,kirkwood-thermal" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, orion_thermal_id_table);
> +
> +static struct platform_driver orion_thermal_driver = {
> +	.probe = orion_thermal_probe,
> +	.remove = orion_thermal_exit,
> +	.driver = {
> +		.name = "orion_thermal",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(orion_thermal_id_table),
> +	},
> +};
> +
> +module_platform_driver(orion_thermal_driver);
> +
> +MODULE_AUTHOR("Nobuhiro Iwamatsu <iwamatsu@nigauri.org>");
> +MODULE_DESCRIPTION("orion thermal driver");
> +MODULE_LICENSE("GPL");
>

