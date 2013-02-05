From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v4 3/4] Thermal: Dove: Add Themal sensor support for Dove.
Date: Tue, 5 Feb 2013 14:09:09 -0300
Message-ID: <20130205170908.GA2525@localhost>
References: <1359946148.2250.47.camel@rzhang1-mobl4>
 <1360005560-21945-1-git-send-email-andrew@lunn.ch>
 <1360005560-21945-4-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47277 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925Ab3BERJL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Feb 2013 12:09:11 -0500
Content-Disposition: inline
In-Reply-To: <1360005560-21945-4-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: jason@lakedaemon.net, rui.zhang@intel.com, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

Hi Andrew,

Nice work!

Do you also intend to work
on thermal support for Armada family?

I have a minor comment, see below.

On Mon, Feb 04, 2013 at 08:19:19PM +0100, Andrew Lunn wrote:
> The Marvell Dove SoC has a thermal sensor. Add a driver using the
> thermal framework.
>=20
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com=
>
> ---
>  .../devicetree/bindings/thermal/dove-thermal.txt   |   18 ++
>  drivers/thermal/Kconfig                            |    8 +
>  drivers/thermal/Makefile                           |    1 +
>  drivers/thermal/dove_thermal.c                     |  211 ++++++++++=
++++++++++
>  4 files changed, 238 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/dove-th=
ermal.txt
>  create mode 100644 drivers/thermal/dove_thermal.c
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/dove-thermal.t=
xt b/Documentation/devicetree/bindings/thermal/dove-thermal.txt
> new file mode 100644
> index 0000000..6f47467
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/dove-thermal.txt
> @@ -0,0 +1,18 @@
> +* Dove Thermal
> +
> +This driver is for Dove SoCs which contain a thermal sensor.
> +
> +Required properties:
> +- compatible : "marvell,dove-thermal"
> +- reg : Address range of the thermal registers
> +
> +The reg properties should contain two ranges. The first is for the
> +three Thermal Manager registers, while the second range contains the
> +Thermal Diode Control Registers.
> +
> +Example:
> +
> +	thermal@10078 {
> +		compatible =3D "marvell,dove-thermal";
> +		reg =3D <0xd001c 0x0c>, <0xd005c 0x08>;
> +	};
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index ff34a0a..342fd81 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -109,6 +109,14 @@ config EXYNOS_THERMAL
>  	  If you say yes here you get support for TMU (Thermal Management
>  	  Unit) on SAMSUNG EXYNOS series of SoC.
> =20
> +config DOVE_THERMAL
> +	tristate "Temperature sensor on Marvell Dove SoCs"
> +	depends on ARCH_DOVE
> +	depends on OF
> +	help
> +	  Support for the Dove thermal sensor driver in the Linux thermal
> +	  framework.
> +
>  config DB8500_THERMAL
>  	bool "DB8500 thermal management"
>  	depends on ARCH_U8500
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 99026b2..5ed357e 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -17,5 +17,6 @@ obj-$(CONFIG_SPEAR_THERMAL)	+=3D spear_thermal.o
>  obj-$(CONFIG_RCAR_THERMAL)	+=3D rcar_thermal.o
>  obj-$(CONFIG_KIRKWOOD_THERMAL)  +=3D kirkwood_thermal.o
>  obj-$(CONFIG_EXYNOS_THERMAL)	+=3D exynos_thermal.o
> +obj-$(CONFIG_DOVE_THERMAL)  	+=3D dove_thermal.o
>  obj-$(CONFIG_DB8500_THERMAL)	+=3D db8500_thermal.o
>  obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+=3D db8500_cpufreq_cooling.o
> diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_th=
ermal.c
> new file mode 100644
> index 0000000..3a92b55
> --- /dev/null
> +++ b/drivers/thermal/dove_thermal.c
> @@ -0,0 +1,211 @@
> +/*
> + * Dove thermal sensor driver
> + *
> + * Copyright (C) 2013 Andrew Lunn <andrew@lunn.ch>
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
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
> +#define DOVE_THERMAL_TEMP_OFFSET	1
> +#define DOVE_THERMAL_TEMP_MASK		0x1FF
> +
> +/* Dove Thermal Manager Control and Status Register */
> +#define PMU_TM_DISABLE_OFFS		0
> +#define PMU_TM_DISABLE_MASK		(0x1 << PMU_TM_DISABLE_OFFS)
> +
> +/* Dove Theraml Diode Control 0 Register */
> +#define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
> +#define PMU_TDC0_SEL_VCAL_OFFS		5
> +#define PMU_TDC0_SEL_VCAL_MASK		(0x3 << PMU_TDC0_SEL_VCAL_OFFS)
> +#define PMU_TDC0_REF_CAL_CNT_OFFS	11
> +#define PMU_TDC0_REF_CAL_CNT_MASK	(0x1FF << PMU_TDC0_REF_CAL_CNT_OFF=
S)
> +#define PMU_TDC0_AVG_NUM_OFFS		25
> +#define PMU_TDC0_AVG_NUM_MASK		(0x7 << PMU_TDC0_AVG_NUM_OFFS)
> +
> +/* Dove Thermal Diode Control 1 Register */
> +#define PMU_TEMP_DIOD_CTRL1_REG		0x04
> +#define PMU_TDC1_TEMP_VALID_MASK	(0x1 << 10)
> +
> +/* Dove Thermal Sensor Dev Structure */
> +struct dove_thermal_priv {
> +	void __iomem *sensor;
> +	void __iomem *control;
> +};
> +
> +static int dove_init_sensor(const struct dove_thermal_priv *priv)
> +{
> +	u32 reg;
> +	u32 i;
> +
> +	/* Configure the Diode Control Register #0 */
> +	reg =3D readl_relaxed(priv->control);
> +
> +	/* Use average of 2 */
> +	reg &=3D ~PMU_TDC0_AVG_NUM_MASK;
> +	reg |=3D (0x1 << PMU_TDC0_AVG_NUM_OFFS);
> +
> +	/* Reference calibration value */
> +	reg &=3D ~PMU_TDC0_REF_CAL_CNT_MASK;
> +	reg |=3D (0x0F1 << PMU_TDC0_REF_CAL_CNT_OFFS);
> +
> +	/* Set the high level reference for calibration */
> +	reg &=3D ~PMU_TDC0_SEL_VCAL_MASK;
> +	reg |=3D (0x2 << PMU_TDC0_SEL_VCAL_OFFS);
> +	writel(reg, priv->control);
> +
> +	/* Reset the sensor */
> +	reg =3D readl_relaxed(priv->control);
> +	writel((reg | PMU_TDC0_SW_RST_MASK), priv->control);
> +	writel(reg, priv->control);
> +
> +	/* Enable the sensor */
> +	reg =3D readl_relaxed(priv->sensor);
> +	reg &=3D ~PMU_TM_DISABLE_MASK;
> +	writel(reg, priv->sensor);
> +
> +	/* Poll the sensor for the first reading */
> +	for (i =3D 0; i < 1000000; i++) {
> +		reg =3D readl_relaxed(priv->sensor);
> +		if (reg & DOVE_THERMAL_TEMP_MASK)
> +			break;
> +	}
> +
> +	if (i =3D=3D 1000000)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int dove_get_temp(struct thermal_zone_device *thermal,
> +			  unsigned long *temp)
> +{
> +	unsigned long reg;
> +	struct dove_thermal_priv *priv =3D thermal->devdata;
> +
> +	/* Valid check */
> +	reg =3D readl_relaxed(priv->control + PMU_TEMP_DIOD_CTRL1_REG);
> +	if ((reg & PMU_TDC1_TEMP_VALID_MASK) =3D=3D 0x0) {
> +		dev_err(&thermal->device,
> +			"Temperature sensor reading not valid\n");
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * Calculate temperature. See Section 8.10.1 of 88AP510,
> +	 * Documentation/arm/Marvell/README
> +	 */
> +	reg =3D readl_relaxed(priv->sensor);
> +	reg =3D (reg >> DOVE_THERMAL_TEMP_OFFSET) & DOVE_THERMAL_TEMP_MASK;
> +	*temp =3D ((2281638UL - (7298*reg)) / 10);
> +
> +	return 0;
> +}
> +
> +static struct thermal_zone_device_ops ops =3D {
> +	.get_temp =3D dove_get_temp,
> +};
> +
> +static const struct of_device_id dove_thermal_id_table[] =3D {
> +	{ .compatible =3D "marvell,dove-thermal" },
> +	{}
> +};
> +
> +static int dove_thermal_probe(struct platform_device *pdev)
> +{
> +	struct thermal_zone_device *thermal =3D NULL;
> +	struct dove_thermal_priv *priv;
> +	struct resource *res;
> +	int ret;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Failed to get platform resource\n");
> +		return -ENODEV;
> +	}
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		dev_err(&pdev->dev, "kzalloc fail\n");

You don't need this to print an error here (and same goes to the
Kirkwood patch).

It just bloats the kernel and it doesn't really add anything relevant.
If this allocation fails you'll get a stack dump from=20
warn_alloc_failed().

Note that many many drivers still do this kind of printking,
and that Joe Perches has some fun removing them :-)

https://lkml.org/lkml/2013/2/3/393


> +		return -ENOMEM;
> +	}
> +
> +	priv->sensor =3D devm_request_and_ioremap(&pdev->dev, res);
> +	if (!priv->sensor) {
> +		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
> +		return -EADDRNOTAVAIL;
> +	}
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Failed to get platform resource\n");
> +		return -ENODEV;
> +	}
> +	priv->control =3D devm_request_and_ioremap(&pdev->dev, res);
> +	if (!priv->control) {
> +		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
> +		return -EADDRNOTAVAIL;
> +	}
> +
> +	ret =3D dove_init_sensor(priv);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to initialize sensor\n");
> +		return ret;
> +	}
> +
> +	thermal =3D thermal_zone_device_register("dove_thermal", 0, 0,
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
> +static int dove_thermal_exit(struct platform_device *pdev)
> +{
> +	struct thermal_zone_device *dove_thermal =3D
> +		platform_get_drvdata(pdev);
> +
> +	thermal_zone_device_unregister(dove_thermal);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +
> +MODULE_DEVICE_TABLE(of, dove_thermal_id_table);
> +
> +static struct platform_driver dove_thermal_driver =3D {
> +	.probe =3D dove_thermal_probe,
> +	.remove =3D dove_thermal_exit,
> +	.driver =3D {
> +		.name =3D "dove_thermal",
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D of_match_ptr(dove_thermal_id_table),
> +	},
> +};
> +
> +module_platform_driver(dove_thermal_driver);
> +
> +MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
> +MODULE_DESCRIPTION("Dove thermal driver");
> +MODULE_LICENSE("GPL");
> --=20
> 1.7.10.4
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
