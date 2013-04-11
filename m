From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [v2,01/14] thermal: Rename driver 'kirkwood' -> 'mvebu'
Date: Thu, 11 Apr 2013 12:00:48 -0400
Message-ID: <5166DE30.3020001@ti.com>
References: <1363991114-4225-2-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1363991114-4225-2-git-send-email-ezequiel.garcia@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-pm@vger.kernel.org, eduardo.valentin@ti.com, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello Ezequiel,

Two minor comments.

On 22-03-2013 18:25, Ezequiel Garcia wrote:
> This driver will support several Marvell SoC, so it is convenient
> to rename it to 'mvebu' to represent accurately the hardware it
> supports.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>
> ---
> .../bindings/thermal/kirkwood-thermal.txt          |   15 ---
>   .../devicetree/bindings/thermal/mvebu-thermal.txt  |   15 +++
>   drivers/thermal/Kconfig                            |   10 +-
>   drivers/thermal/Makefile                           |    2 +-
>   drivers/thermal/kirkwood_thermal.c                 |  134 --------------------
>   drivers/thermal/mvebu_thermal.c                    |  134 ++++++++++++++++++++
>   6 files changed, 155 insertions(+), 155 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
>   create mode 100644 Documentation/devicetree/bindings/thermal/mvebu-thermal.txt
>   delete mode 100644 drivers/thermal/kirkwood_thermal.c
>   create mode 100644 drivers/thermal/mvebu_thermal.c

When sending renames, use git format-patch --find-renames. The summary 
will be much descriptive on what you have done.

I tried applying this patch on top of linux-next, linus/master, 
ruis/thermal, on top of the your suggested dependencies, and all failed. 
What is your base?

>
> diff --git a/Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt b/Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
> deleted file mode 100644
> index 8c0f5eb..0000000
> --- a/Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -* Kirkwood Thermal
> -
> -This version is for Kirkwood 88F8262 & 88F6283 SoCs. Other kirkwoods
> -don't contain a thermal sensor.
> -
> -Required properties:
> -- compatible : "marvell,kirkwood-thermal"
> -- reg : Address range of the thermal registers
> -
> -Example:
> -
> -	thermal@10078 {
> -		compatible = "marvell,kirkwood-thermal";
> -		reg = <0x10078 0x4>;
> -	};
> diff --git a/Documentation/devicetree/bindings/thermal/mvebu-thermal.txt b/Documentation/devicetree/bindings/thermal/mvebu-thermal.txt
> new file mode 100644
> index 0000000..8c0f5eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/mvebu-thermal.txt
> @@ -0,0 +1,15 @@
> +* Kirkwood Thermal
> +
> +This version is for Kirkwood 88F8262 & 88F6283 SoCs. Other kirkwoods
> +don't contain a thermal sensor.
> +
> +Required properties:
> +- compatible : "marvell,kirkwood-thermal"
> +- reg : Address range of the thermal registers
> +
> +Example:
> +
> +	thermal@10078 {
> +		compatible = "marvell,kirkwood-thermal";
> +		reg = <0x10078 0x4>;
> +	};
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index a764f16..74f6b97 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -101,13 +101,13 @@ config RCAR_THERMAL
>   	  Enable this to plug the R-Car thermal sensor driver into the Linux
>   	  thermal framework
>
> -config KIRKWOOD_THERMAL
> -	tristate "Temperature sensor on Marvell Kirkwood SoCs"
> -	depends on ARCH_KIRKWOOD
> +config MVEBU_THERMAL
> +	tristate "Temperature sensor on Marvell EBU SoCs"
> +	depends on PLAT_ORION
>   	depends on OF
>   	help
> -	  Support for the Kirkwood thermal sensor driver into the Linux thermal
> -	  framework. Only kirkwood 88F6282 and 88F6283 have this sensor.
> +	  Support for the thermal controllers available in several Marvell
> +	  EBU SoCs in the thermal framework.
>
>   config EXYNOS_THERMAL
>   	tristate "Temperature sensor on Samsung EXYNOS"
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index d3a2b38..40293a1 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -15,7 +15,7 @@ obj-$(CONFIG_CPU_THERMAL)	+= cpu_cooling.o
>   # platform thermal drivers
>   obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
>   obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
> -obj-$(CONFIG_KIRKWOOD_THERMAL)  += kirkwood_thermal.o
> +obj-$(CONFIG_MVEBU_THERMAL)	+= mvebu_thermal.o
>   obj-$(CONFIG_EXYNOS_THERMAL)	+= exynos_thermal.o
>   obj-$(CONFIG_DOVE_THERMAL)  	+= dove_thermal.o
>   obj-$(CONFIG_DB8500_THERMAL)	+= db8500_thermal.o
> diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
> deleted file mode 100644
> index 19320dd..0000000
> --- a/drivers/thermal/kirkwood_thermal.c
> +++ /dev/null
> @@ -1,134 +0,0 @@
> -/*
> - * Kirkwood thermal sensor driver
> - *
> - * Copyright (C) 2012 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
> - *
> - */
> -#include <linux/device.h>
> -#include <linux/err.h>
> -#include <linux/io.h>
> -#include <linux/kernel.h>
> -#include <linux/of.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/thermal.h>
> -
> -#define KIRKWOOD_THERMAL_VALID_OFFSET	9
> -#define KIRKWOOD_THERMAL_VALID_MASK	0x1
> -#define KIRKWOOD_THERMAL_TEMP_OFFSET	10
> -#define KIRKWOOD_THERMAL_TEMP_MASK	0x1FF
> -
> -/* Kirkwood Thermal Sensor Dev Structure */
> -struct kirkwood_thermal_priv {
> -	void __iomem *sensor;
> -};
> -
> -static int kirkwood_get_temp(struct thermal_zone_device *thermal,
> -			  unsigned long *temp)
> -{
> -	unsigned long reg;
> -	struct kirkwood_thermal_priv *priv = thermal->devdata;
> -
> -	reg = readl_relaxed(priv->sensor);
> -
> -	/* Valid check */
> -	if (!((reg >> KIRKWOOD_THERMAL_VALID_OFFSET) &
> -	    KIRKWOOD_THERMAL_VALID_MASK)) {
> -		dev_err(&thermal->device,
> -			"Temperature sensor reading not valid\n");
> -		return -EIO;
> -	}
> -
> -	/*
> -	 * Calculate temperature. According to Marvell internal
> -	 * documentation the formula for this is:
> -	 * Celsius = (322-reg)/1.3625
> -	 */
> -	reg = (reg >> KIRKWOOD_THERMAL_TEMP_OFFSET) &
> -		KIRKWOOD_THERMAL_TEMP_MASK;
> -	*temp = ((3220000000UL - (10000000UL * reg)) / 13625);
> -
> -	return 0;
> -}
> -
> -static struct thermal_zone_device_ops ops = {
> -	.get_temp = kirkwood_get_temp,
> -};
> -
> -static const struct of_device_id kirkwood_thermal_id_table[] = {
> -	{ .compatible = "marvell,kirkwood-thermal" },
> -	{}
> -};
> -
> -static int kirkwood_thermal_probe(struct platform_device *pdev)
> -{
> -	struct thermal_zone_device *thermal = NULL;
> -	struct kirkwood_thermal_priv *priv;
> -	struct resource *res;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "Failed to get platform resource\n");
> -		return -ENODEV;
> -	}
> -
> -	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> -		return -ENOMEM;
> -
> -	priv->sensor = devm_request_and_ioremap(&pdev->dev, res);
> -	if (!priv->sensor) {
> -		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
> -		return -EADDRNOTAVAIL;
> -	}
> -
> -	thermal = thermal_zone_device_register("kirkwood_thermal", 0, 0,
> -					       priv, &ops, NULL, 0, 0);
> -	if (IS_ERR(thermal)) {
> -		dev_err(&pdev->dev,
> -			"Failed to register thermal zone device\n");
> -		return PTR_ERR(thermal);
> -	}
> -
> -	platform_set_drvdata(pdev, thermal);
> -
> -	return 0;
> -}
> -
> -static int kirkwood_thermal_exit(struct platform_device *pdev)
> -{
> -	struct thermal_zone_device *kirkwood_thermal =
> -		platform_get_drvdata(pdev);
> -
> -	thermal_zone_device_unregister(kirkwood_thermal);
> -	platform_set_drvdata(pdev, NULL);
> -
> -	return 0;
> -}
> -
> -MODULE_DEVICE_TABLE(of, kirkwood_thermal_id_table);
> -
> -static struct platform_driver kirkwood_thermal_driver = {
> -	.probe = kirkwood_thermal_probe,
> -	.remove = kirkwood_thermal_exit,
> -	.driver = {
> -		.name = "kirkwood_thermal",
> -		.owner = THIS_MODULE,
> -		.of_match_table = of_match_ptr(kirkwood_thermal_id_table),
> -	},
> -};
> -
> -module_platform_driver(kirkwood_thermal_driver);
> -
> -MODULE_AUTHOR("Nobuhiro Iwamatsu <iwamatsu@nigauri.org>");
> -MODULE_DESCRIPTION("kirkwood thermal driver");
> -MODULE_LICENSE("GPL");
> diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
> new file mode 100644
> index 0000000..19320dd
> --- /dev/null
> +++ b/drivers/thermal/mvebu_thermal.c
> @@ -0,0 +1,134 @@
> +/*
> + * Kirkwood thermal sensor driver
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
> +#define KIRKWOOD_THERMAL_VALID_OFFSET	9
> +#define KIRKWOOD_THERMAL_VALID_MASK	0x1
> +#define KIRKWOOD_THERMAL_TEMP_OFFSET	10
> +#define KIRKWOOD_THERMAL_TEMP_MASK	0x1FF
> +
> +/* Kirkwood Thermal Sensor Dev Structure */
> +struct kirkwood_thermal_priv {
> +	void __iomem *sensor;
> +};
> +
> +static int kirkwood_get_temp(struct thermal_zone_device *thermal,
> +			  unsigned long *temp)
> +{
> +	unsigned long reg;
> +	struct kirkwood_thermal_priv *priv = thermal->devdata;
> +
> +	reg = readl_relaxed(priv->sensor);
> +
> +	/* Valid check */
> +	if (!((reg >> KIRKWOOD_THERMAL_VALID_OFFSET) &
> +	    KIRKWOOD_THERMAL_VALID_MASK)) {
> +		dev_err(&thermal->device,
> +			"Temperature sensor reading not valid\n");
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * Calculate temperature. According to Marvell internal
> +	 * documentation the formula for this is:
> +	 * Celsius = (322-reg)/1.3625
> +	 */
> +	reg = (reg >> KIRKWOOD_THERMAL_TEMP_OFFSET) &
> +		KIRKWOOD_THERMAL_TEMP_MASK;
> +	*temp = ((3220000000UL - (10000000UL * reg)) / 13625);
> +
> +	return 0;
> +}
> +
> +static struct thermal_zone_device_ops ops = {
> +	.get_temp = kirkwood_get_temp,
> +};
> +
> +static const struct of_device_id kirkwood_thermal_id_table[] = {
> +	{ .compatible = "marvell,kirkwood-thermal" },
> +	{}
> +};
> +
> +static int kirkwood_thermal_probe(struct platform_device *pdev)
> +{
> +	struct thermal_zone_device *thermal = NULL;
> +	struct kirkwood_thermal_priv *priv;
> +	struct resource *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Failed to get platform resource\n");
> +		return -ENODEV;
> +	}
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->sensor = devm_request_and_ioremap(&pdev->dev, res);
> +	if (!priv->sensor) {
> +		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
> +		return -EADDRNOTAVAIL;
> +	}
> +
> +	thermal = thermal_zone_device_register("kirkwood_thermal", 0, 0,
> +					       priv, &ops, NULL, 0, 0);
> +	if (IS_ERR(thermal)) {
> +		dev_err(&pdev->dev,
> +			"Failed to register thermal zone device\n");
> +		return PTR_ERR(thermal);
> +	}
> +
> +	platform_set_drvdata(pdev, thermal);
> +
> +	return 0;
> +}
> +
> +static int kirkwood_thermal_exit(struct platform_device *pdev)
> +{
> +	struct thermal_zone_device *kirkwood_thermal =
> +		platform_get_drvdata(pdev);
> +
> +	thermal_zone_device_unregister(kirkwood_thermal);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +
> +MODULE_DEVICE_TABLE(of, kirkwood_thermal_id_table);
> +
> +static struct platform_driver kirkwood_thermal_driver = {
> +	.probe = kirkwood_thermal_probe,
> +	.remove = kirkwood_thermal_exit,
> +	.driver = {
> +		.name = "kirkwood_thermal",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(kirkwood_thermal_id_table),
> +	},
> +};
> +
> +module_platform_driver(kirkwood_thermal_driver);
> +
> +MODULE_AUTHOR("Nobuhiro Iwamatsu <iwamatsu@nigauri.org>");
> +MODULE_DESCRIPTION("kirkwood thermal driver");
> +MODULE_LICENSE("GPL");
>
