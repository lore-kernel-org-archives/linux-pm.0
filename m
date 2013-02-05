From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v4 1/4] thermal: Add support for the thermal sensor on
 Kirkwood SoCs
Date: Tue, 5 Feb 2013 14:10:23 -0300
Message-ID: <20130205171022.GB2525@localhost>
References: <1359946148.2250.47.camel@rzhang1-mobl4>
 <1360005560-21945-1-git-send-email-andrew@lunn.ch>
 <1360005560-21945-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47290 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925Ab3BERKX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Feb 2013 12:10:23 -0500
Content-Disposition: inline
In-Reply-To: <1360005560-21945-2-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: jason@lakedaemon.net, rui.zhang@intel.com, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

On Mon, Feb 04, 2013 at 08:19:17PM +0100, Andrew Lunn wrote:
> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>=20
> This patch adds support for Kirkwood 88F6282 and 88F6283 thermal sens=
or.
>=20
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  .../bindings/thermal/kirkwood-thermal.txt          |   15 +++
>  drivers/thermal/Kconfig                            |    8 ++
>  drivers/thermal/Makefile                           |    1 +
>  drivers/thermal/kirkwood_thermal.c                 |  136 ++++++++++=
++++++++++
>  4 files changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/kirkwoo=
d-thermal.txt
>  create mode 100644 drivers/thermal/kirkwood_thermal.c
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/kirkwood-therm=
al.txt b/Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
> new file mode 100644
> index 0000000..8c0f5eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
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
> +		compatible =3D "marvell,kirkwood-thermal";
> +		reg =3D <0x10078 0x4>;
> +	};
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index c2c77d1..ff34a0a 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -93,6 +93,14 @@ config RCAR_THERMAL
>  	  Enable this to plug the R-Car thermal sensor driver into the Linu=
x
>  	  thermal framework
> =20
> +config KIRKWOOD_THERMAL
> +	tristate "Temperature sensor on Marvell Kirkwood SoCs"
> +	depends on ARCH_KIRKWOOD
> +	depends on OF
> +	help
> +	  Support for the Kirkwood thermal sensor driver into the Linux the=
rmal
> +	  framework. Only kirkwood 88F6282 and 88F6283 have this sensor.
> +
>  config EXYNOS_THERMAL
>  	tristate "Temperature sensor on Samsung EXYNOS"
>  	depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5)
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index d8da683..99026b2 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_CPU_THERMAL)	+=3D cpu_cooling.o
>  # platform thermal drivers
>  obj-$(CONFIG_SPEAR_THERMAL)	+=3D spear_thermal.o
>  obj-$(CONFIG_RCAR_THERMAL)	+=3D rcar_thermal.o
> +obj-$(CONFIG_KIRKWOOD_THERMAL)  +=3D kirkwood_thermal.o
>  obj-$(CONFIG_EXYNOS_THERMAL)	+=3D exynos_thermal.o
>  obj-$(CONFIG_DB8500_THERMAL)	+=3D db8500_thermal.o
>  obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+=3D db8500_cpufreq_cooling.o
> diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kir=
kwood_thermal.c
> new file mode 100644
> index 0000000..000cfc9
> --- /dev/null
> +++ b/drivers/thermal/kirkwood_thermal.c
> @@ -0,0 +1,136 @@
> +/*
> + * Kirkwood thermal sensor driver
> + *
> + * Copyright (C) 2012 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
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
> +	struct kirkwood_thermal_priv *priv =3D thermal->devdata;
> +
> +	reg =3D readl_relaxed(priv->sensor);
> +
> +	/* Valid check */
> +	if (!(reg >> KIRKWOOD_THERMAL_VALID_OFFSET) &
> +	    KIRKWOOD_THERMAL_VALID_MASK) {
> +		dev_err(&thermal->device,
> +			"Temperature sensor reading not valid\n");
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * Calculate temperature. See Section 8.10.1 of the 88AP510,
> +	 * datasheet, which has the same sensor.
> +	 * Documentation/arm/Marvell/README
> +	 */
> +	reg =3D (reg >> KIRKWOOD_THERMAL_TEMP_OFFSET) &
> +		KIRKWOOD_THERMAL_TEMP_MASK;
> +	*temp =3D ((2281638UL - (7298*reg)) / 10);
> +
> +	return 0;
> +}
> +
> +static struct thermal_zone_device_ops ops =3D {
> +	.get_temp =3D kirkwood_get_temp,
> +};
> +
> +static const struct of_device_id kirkwood_thermal_id_table[] =3D {
> +	{ .compatible =3D "marvell,kirkwood-thermal" },
> +	{}
> +};
> +
> +static int kirkwood_thermal_probe(struct platform_device *pdev)
> +{
> +	struct thermal_zone_device *thermal =3D NULL;
> +	struct kirkwood_thermal_priv *priv;
> +	struct resource *res;
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

Not needed, see my answer to the Dove patch.

> +		return -ENOMEM;
> +	}
> +
> +	priv->sensor =3D devm_request_and_ioremap(&pdev->dev, res);
> +	if (!priv->sensor) {
> +		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
> +		return -EADDRNOTAVAIL;
> +	}
> +
> +	thermal =3D thermal_zone_device_register("kirkwood_thermal", 0, 0,
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
> +	struct thermal_zone_device *kirkwood_thermal =3D
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
> +static struct platform_driver kirkwood_thermal_driver =3D {
> +	.probe =3D kirkwood_thermal_probe,
> +	.remove =3D kirkwood_thermal_exit,
> +	.driver =3D {
> +		.name =3D "kirkwood_thermal",
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D of_match_ptr(kirkwood_thermal_id_table),
> +	},
> +};
> +
> +module_platform_driver(kirkwood_thermal_driver);
> +
> +MODULE_AUTHOR("Nobuhiro Iwamatsu <iwamatsu@nigauri.org>");
> +MODULE_DESCRIPTION("kirkwood thermal driver");
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
