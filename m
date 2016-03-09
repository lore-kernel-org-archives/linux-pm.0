From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V2 5/6] thermal: max77620: Add thermal driver for
 reporting junction temp
Date: Wed, 9 Mar 2016 11:27:53 -0800
Message-ID: <20160309192751.GB2422@localhost.localdomain>
References: <1457529010-6538-1-git-send-email-ldewangan@nvidia.com>
 <1457529010-6538-6-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34643 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932859AbcCIT15 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 14:27:57 -0500
Content-Disposition: inline
In-Reply-To: <1457529010-6538-6-git-send-email-ldewangan@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: rui.zhang@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, rklein@nvidia.com


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2016 at 06:40:09PM +0530, Laxman Dewangan wrote:
> Maxim Semiconductor Max77620 supports alarm interrupts when
> its die temperature crosses 120C and 140C. These threshold
> temperatures are not configurable.
>=20
> Add thermal driver to register PMIC die temperature as thermal
> zone sensor and capture the die temperature warning interrupts
> to notifying the client.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>=20
> ---
> Changes from V1:
> - checkpatch warning fix and simplifying the dev.of_node
>   initialisation.
>=20
>  drivers/thermal/Kconfig            |  10 +++
>  drivers/thermal/Makefile           |   1 +
>  drivers/thermal/thermal-max77620.c | 151 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 162 insertions(+)
>  create mode 100644 drivers/thermal/thermal-max77620.c
>=20
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 5e7c97a..fc856eb 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -194,6 +194,16 @@ config IMX_THERMAL
>  	  cpufreq is used as the cooling device to throttle CPUs when the
>  	  passive trip is crossed.
> =20
> +config MAX77620_THERMAL
> +	tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
> +	depends on MFD_MAX77620
> +	depends on OF

The previous question on compile test was more if we could add depends
on COMPILE_TEST flag. Sorry if I was not clear enough.=20


I am adding the flag here:

=20
  config MAX77620_THERMAL
          tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
	  -       depends on MFD_MAX77620
	  +       depends on MFD_MAX77620 || COMPILE_TEST
	  +       depends on HAS_IOMEM
	          depends on OF
		          help
			            Support for die junction temperature
				    warning alarm for Maxim


but I still cannot compile test the file because of the missing header.
drivers/thermal/thermal-max77620.c:16:32: fatal error:
linux/mfd/max77620.h: No such file or directory
 #include <linux/mfd/max77620.h>


I wont be able to merge this as it is. We need to sort out the
dependency first.

The patches with devm_ helpers could go, though.

> +	help
> +	  Support for die junction temperature warning alarm for Maxim
> +	  Semiconductor PMIC MAX77620 device. Device generates two alarm
> +	  interrupts when PMIC die temperature cross the threshold of
> +	  120 degC and 140 degC.
> +
>  config SPEAR_THERMAL
>  	tristate "SPEAr thermal sensor driver"
>  	depends on PLAT_SPEAR || COMPILE_TEST
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 8e9cbc3..c6bc2bd 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_DOVE_THERMAL)  	+=3D dove_thermal.o
>  obj-$(CONFIG_DB8500_THERMAL)	+=3D db8500_thermal.o
>  obj-$(CONFIG_ARMADA_THERMAL)	+=3D armada_thermal.o
>  obj-$(CONFIG_IMX_THERMAL)	+=3D imx_thermal.o
> +obj-$(CONFIG_MAX77620_THERMAL)	+=3D thermal-max77620.o
>  obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+=3D db8500_cpufreq_cooling.o
>  obj-$(CONFIG_INTEL_POWERCLAMP)	+=3D intel_powerclamp.o
>  obj-$(CONFIG_X86_PKG_TEMP_THERMAL)	+=3D x86_pkg_temp_thermal.o
> diff --git a/drivers/thermal/thermal-max77620.c b/drivers/thermal/thermal=
-max77620.c
> new file mode 100644
> index 0000000..5fba00f
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
> + * This program is free software; you can redistribute it and/or modify =
it
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
> +#define MAX77620_TJALARM2_TEMP		140000
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
> +	struct max77620_therm_info *mtherm =3D data;
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D regmap_read(mtherm->rmap, MAX77620_REG_STATLBT, &val);
> +	if (ret < 0) {
> +		dev_err(mtherm->dev, "Failed to read STATLBT, %d\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	if (val & MAX77620_IRQ_TJALRM2_MASK)
> +		*temp =3D MAX77620_TJALARM2_TEMP;
> +	else if (val & MAX77620_IRQ_TJALRM1_MASK)
> +		*temp =3D MAX77620_TJALARM1_TEMP;
> +	else
> +		*temp =3D MAX77620_NORMAL_OPERATING_TEMP;
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops max77620_thermal_ops =3D {
> +	.get_temp =3D max77620_thermal_read_temp,
> +};
> +
> +static irqreturn_t max77620_thermal_irq(int irq, void *data)
> +{
> +	struct max77620_therm_info *mtherm =3D data;
> +
> +	if (irq =3D=3D mtherm->irq_tjalarm1)
> +		dev_warn(mtherm->dev, "Junction Temp Alarm1(120C) occurred\n");
> +	else if (irq =3D=3D mtherm->irq_tjalarm2)
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
> +	pdev->dev.of_node =3D pdev->dev.parent->of_node;
> +
> +	mtherm =3D devm_kzalloc(&pdev->dev, sizeof(*mtherm), GFP_KERNEL);
> +	if (!mtherm)
> +		return -ENOMEM;
> +
> +	mtherm->irq_tjalarm1 =3D platform_get_irq(pdev, 0);
> +	mtherm->irq_tjalarm2 =3D platform_get_irq(pdev, 1);
> +	if ((mtherm->irq_tjalarm1 < 0) || (mtherm->irq_tjalarm2 < 0)) {
> +		dev_err(&pdev->dev, "Alarm irq number not available\n");
> +		return -EINVAL;
> +	}
> +
> +	mtherm->dev =3D &pdev->dev;
> +	mtherm->rmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!mtherm->rmap) {
> +		dev_err(&pdev->dev, "Failed to get parent regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	mtherm->tz_device =3D devm_thermal_zone_of_sensor_register(&pdev->dev, =
0,
> +				mtherm, &max77620_thermal_ops);
> +	if (IS_ERR(mtherm->tz_device)) {
> +		ret =3D PTR_ERR(mtherm->tz_device);
> +		dev_err(&pdev->dev, "Failed to register thermal zone, %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret =3D devm_request_threaded_irq(&pdev->dev, mtherm->irq_tjalarm1, NUL=
L,
> +					max77620_thermal_irq,
> +					IRQF_ONESHOT | IRQF_SHARED,
> +					dev_name(&pdev->dev), mtherm);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to request irq1, %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D devm_request_threaded_irq(&pdev->dev, mtherm->irq_tjalarm2, NUL=
L,
> +					max77620_thermal_irq,
> +					IRQF_ONESHOT | IRQF_SHARED,
> +					dev_name(&pdev->dev), mtherm);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to request irq2, %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, mtherm);
> +
> +	return 0;
> +}
> +
> +static struct platform_device_id max77620_thermal_devtype[] =3D {
> +	{ .name =3D "max77620-thermal", },
> +	{},
> +};
> +
> +static struct platform_driver max77620_thermal_driver =3D {
> +	.driver =3D {
> +		.name =3D "max77620-thermal",
> +	},
> +	.probe =3D max77620_thermal_probe,
> +	.id_table =3D max77620_thermal_devtype,
> +};
> +
> +module_platform_driver(max77620_thermal_driver);
> +
> +MODULE_DESCRIPTION("Max77620 Junction temperature Thermal driver");
> +MODULE_ALIAS("platform:max77620-thermal");
> +MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
> +MODULE_AUTHOR("Mallikarjun Kasoju <mkasoju@nvidia.com>");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.1.4
>=20

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW4HkoAAoJEMLUO4d9pOJWOTEH/1JHMD4PXIgAINBu9vY55ubL
QFhrVOHErdFAbj2w+yEBR2+JlJbudN13IUb6LuoINQSNRQYt0T10XVdjRWQWI2Oe
PmyZIGBremD8C0xOyxZQpiOn6mWPu2T5hY/T+/03sA+wyDKhp9WLSvA/h7EEgCck
iL3KwUwZpjjgzrkqxh4xPA6PUXLn2RyvceN1CQHMjCI3Ej1cB7tggpcxfJYLmTCH
xr8AAFXoz9Pn0AwwFfwLNVVLiHrDHhIWzijLIASBKswR0INr37slNCTuc1dUdTY1
hRFxFK3hZ2uGjdiGUNaghB88+dVeSC3ZHiBTD1BNw3zyC7IYUr81+YrEAzjaEHg=
=l+xw
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
