From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v5] thermal: add temperature sensor support for tango SoC
Date: Mon, 28 Mar 2016 19:00:52 -0700
Message-ID: <20160329020050.GA15721@localhost.localdomain>
References: <56D5C7FE.7010807@free.fr>
 <56D9AF4F.1010304@free.fr>
 <20160308214846.GA10950@localhost.localdomain>
 <56F84427.1000507@free.fr>
 <56F91A47.9060901@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33722 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755626AbcC2CA5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Mar 2016 22:00:57 -0400
Received: by mail-pf0-f177.google.com with SMTP id 4so2007963pfd.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Mar 2016 19:00:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56F91A47.9060901@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: linux-pm <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Rob Herring <robh@kernel.org>

Marc,

Again, only minor comments, as follows.


On Mon, Mar 28, 2016 at 01:49:27PM +0200, Mason wrote:
> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> 
> Since the SMP8758, Tango SoCs include several instances of a rudimentary
> bandgap temperature sensor.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  Documentation/devicetree/bindings/thermal/tango-thermal.txt |  17 ++++
>  drivers/thermal/Kconfig                                     |   7 ++
>  drivers/thermal/Makefile                                    |   1 +
>  drivers/thermal/tango_thermal.c                             | 114 +++++++++++++++++++++++++++
>  4 files changed, 139 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/tango-thermal.txt b/Documentation/devicetree/bindings/thermal/tango-thermal.txt
> new file mode 100644
> index 000000000000..a203f7d60d35
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/tango-thermal.txt
> @@ -0,0 +1,17 @@
> +* Tango Thermal
> +
> +The SMP8758 SoC includes 3 instances of this temperature sensor
> +(in the CPU, video decoder, and PCIe controller).

Would you be able to add a link to sensor documentation?

> +
> +Required properties:
> +- compatible: "sigma,smp8758-thermal"
> +- #thermal-sensor-cells: Should be 0 (see thermal.txt)
> +- reg: Address range of the thermal registers
> +
> +Example:
> +
> +	cpu_temp: thermal@920100 {
> +		compatible = "sigma,smp8758-thermal";
> +		#thermal-sensor-cells = <0>;
> +		reg = <0x920100 12>;

I believe you have to put #thermal-sensor-cells as last entry.

> +	};
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index c37eedc35a24..b6bf563f05dc 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -260,6 +260,13 @@ config ARMADA_THERMAL
>  	  Enable this option if you want to have support for thermal management
>  	  controller present in Armada 370 and Armada XP SoC.
>  
> +config TANGO_THERMAL
> +	tristate "Tango thermal management"
> +	depends on ARCH_TANGO || COMPILE_TEST
> +	help
> +	  Enable the Tango temperature sensor driver, which provides support
> +	  for the sensors used since the SMP8758.

Please add a better description, e.g. which sensors are supported,
locations, accuracy, and more meaningful info an engineer could read out
of the help section.

> +
>  config TEGRA_SOCTHERM
>  	tristate "Tegra SOCTHERM thermal management"
>  	depends on ARCH_TEGRA
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 8e9cbc3b5679..06387279883d 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -35,6 +35,7 @@ obj-y				+= samsung/
>  obj-$(CONFIG_DOVE_THERMAL)  	+= dove_thermal.o
>  obj-$(CONFIG_DB8500_THERMAL)	+= db8500_thermal.o
>  obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
> +obj-$(CONFIG_TANGO_THERMAL)	+= tango_thermal.o
>  obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
>  obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+= db8500_cpufreq_cooling.o
>  obj-$(CONFIG_INTEL_POWERCLAMP)	+= intel_powerclamp.o
> diff --git a/drivers/thermal/tango_thermal.c b/drivers/thermal/tango_thermal.c
> new file mode 100644
> index 000000000000..8c9abdf6a507
> --- /dev/null
> +++ b/drivers/thermal/tango_thermal.c
> @@ -0,0 +1,114 @@

No license/author/contact section here?

> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/thermal.h>
> +#include <linux/platform_device.h>
> +
> +#define TEMPSI_CMD	0
> +#define TEMPSI_RES	4
> +#define TEMPSI_CFG	8
> +
> +#define CMD_OFF		0
> +#define CMD_ON		1
> +#define CMD_READ	2
> +
> +#define IDX_MIN		0
> +#define IDX_MAX		40
> +#define CYCLE_COUNT	5000 /* Time to wait before sampling the result */
> +
> +struct tango_thermal_priv {
> +	struct thermal_zone_device *zone;
> +	void __iomem *base;
> +	int thresh_idx;
> +};
> +
> +static bool temp_above_thresh(void __iomem *base, int thresh_idx)
> +{
> +	writel(thresh_idx << 8 | CMD_READ, base + TEMPSI_CMD);
> +	usleep_range(100, 200);
nip: blank line here.

> +	return readl(base + TEMPSI_RES);
> +}
> +
> +static int tango_get_temp(void *arg, int *res)
> +{
> +	struct tango_thermal_priv *priv = arg;
> +	void __iomem *base = priv->base;
> +	int idx = priv->thresh_idx;
> +
> +	if (temp_above_thresh(base, idx)) {
> +		/* Upward linear search, increment thresh */
> +		while (idx < IDX_MAX && temp_above_thresh(base, ++idx))
> +			cpu_relax();
> +		idx = idx - 1; /* always return lower bound */
> +	} else {
> +		/* Downward linear search, decrement thresh */
> +		while (idx > IDX_MIN && !temp_above_thresh(base, --idx))
> +			cpu_relax();
> +	}

Did I understand this right? We can only read if the temperature is
above an index or not, right? and we spin for 100-200us after every 
attempt to check if temperature is above and index. So, worst case,
if we start from IDX_MIN, and temp is at IDX_MAX, we spin for
40 * (100 .. 200) us (with cpu_relax in between).

Does the  chip support different temperature read strategy? 

How does this perform in average case?

How about a local search within +-2 indexes of thresh_idx?

> +
> +	*res = (idx * 9 / 2 - 38) * 1000; /* millidegrees Celsius */
> +	priv->thresh_idx = idx;
nip: blank line here.
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops ops = {
> +	.get_temp	= tango_get_temp,
> +};
> +
> +static int tango_thermal_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct tango_thermal_priv *priv;
> +	struct device *dev = &pdev->dev;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	writel(CMD_ON, priv->base + TEMPSI_CMD);
> +	writel(CYCLE_COUNT, priv->base + TEMPSI_CFG);
> +
> +	priv->zone = thermal_zone_of_sensor_register(dev, 0, priv, &ops);

Would it make sense to use the devm_thermal_zone_of_sensor_register
version instead?

> +	if (IS_ERR(priv->zone))
> +		return PTR_ERR(priv->zone);
> +
> +	priv->thresh_idx = 15; /* arbitrary starting point */
> +	platform_set_drvdata(pdev, priv);
nip: blank line here.
> +	return 0;
> +}
> +
> +static int tango_thermal_remove(struct platform_device *pdev)
> +{
> +	struct tango_thermal_priv *priv = platform_get_drvdata(pdev);
> +
> +	thermal_zone_of_sensor_unregister(&pdev->dev, priv->zone);
> +	writel(CMD_OFF, priv->base + TEMPSI_CMD);
nip: blank line here.
> +	return 0;
> +}
> +
> +static const struct of_device_id tango_sensor_ids[] = {
> +	{
> +		.compatible = "sigma,smp8758-thermal",
> +	},
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver tango_thermal_driver = {
> +	.probe	= tango_thermal_probe,
> +	.remove	= tango_thermal_remove,
> +	.driver	= {
> +		.name		= "tango-thermal",
> +		.of_match_table	= tango_sensor_ids,
> +	},
> +};
> +
> +module_platform_driver(tango_thermal_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Sigma Designs");
> +MODULE_DESCRIPTION("Tango temperature sensor");
> -- 
> 2.7.4
