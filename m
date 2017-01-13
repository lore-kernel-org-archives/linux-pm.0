From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: reset: Add MAX77620 support
Date: Fri, 13 Jan 2017 04:44:25 +0100
Message-ID: <20170113034425.7ttvc73aewtbitrk@earth>
References: <20170112161507.23774-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zhsptlnqeurdibyj"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750979AbdAMDob (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Jan 2017 22:44:31 -0500
Content-Disposition: inline
In-Reply-To: <20170112161507.23774-1-thierry.reding@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Martin Michlmayr <tbm@cyrius.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chaitanya Bandi <bandik@nvidia.com>


--zhsptlnqeurdibyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thierry,

I have a few comments inline.

On Thu, Jan 12, 2017 at 05:15:07PM +0100, Thierry Reding wrote:
> The Maxim MAX77620 PMIC has the ability to power off and restart the
> system. Add a driver that supports power off (via pm_power_off()) and
> restart (via arm_pm_restart() on 32-bit and 64-bit ARM).
>=20
> Based on work by Chaitanya Bandi <bandik@nvidia.com>.
>=20
> Cc: Chaitanya Bandi <bandik@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/power/reset/Kconfig             |   6 ++
>  drivers/power/reset/Makefile            |   1 +
>  drivers/power/reset/max77620-poweroff.c | 146 ++++++++++++++++++++++++++=
++++++
>  3 files changed, 153 insertions(+)
>  create mode 100644 drivers/power/reset/max77620-poweroff.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index abeb77217a21..f0d0c20632f8 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -98,6 +98,12 @@ config POWER_RESET_IMX
>  	  say N here or disable in dts to make sure pm_power_off never be
>  	  overwrote wrongly by this driver.
> =20
> +config POWER_RESET_MAX77620
> +	bool "Maxim MAX77620 PMIC power-off driver"
> +	depends on MFD_MAX77620
> +	help
> +	  Power off and restart support for Maxim MAX77620 PMICs.
> +
>  config POWER_RESET_MSM
>  	bool "Qualcomm MSM power-off driver"
>  	depends on ARCH_QCOM
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 11dae3b56ff9..74511d2f037a 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
>  obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restart.o
>  obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
>  obj-$(CONFIG_POWER_RESET_IMX) +=3D imx-snvs-poweroff.o
> +obj-$(CONFIG_POWER_RESET_MAX77620) +=3D max77620-poweroff.o
>  obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
>  obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) +=3D piix4-poweroff.o
>  obj-$(CONFIG_POWER_RESET_LTC2952) +=3D ltc2952-poweroff.o
> diff --git a/drivers/power/reset/max77620-poweroff.c b/drivers/power/rese=
t/max77620-poweroff.c
> new file mode 100644
> index 000000000000..4f2682d10925
> --- /dev/null
> +++ b/drivers/power/reset/max77620-poweroff.c
> @@ -0,0 +1,146 @@
> +/*
> + * Power off driver for Maxim MAX77620 device.
> + *
> + * Copyright (c) 2014-2016, NVIDIA CORPORATION.  All rights reserved.
> + *
> + * Based on work by Chaitanya Bandi <bandik@nvidia.com>.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
> + * whether express or implied; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * General Public License for more details.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/mfd/max77620.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> +#include <asm/system_misc.h>
> +#endif
> +
> +struct max77620_power {
> +	struct regmap *regmap;
> +	struct device *dev;
> +};
> +
> +static struct max77620_power *system_power_controller =3D NULL;
> +
> +static void max77620_pm_power_off(void)
> +{
> +	struct max77620_power *power =3D system_power_controller;
> +	unsigned int value;
> +	int err;
> +
> +	if (!power)
> +		return;
> +
> +	/* clear power key interrupts */
> +	err =3D regmap_read(power->regmap, MAX77620_REG_ONOFFIRQ, &value);
> +	if (err < 0)
> +		dev_err(power->dev, "failed to clear power key interrupts: %d\n", err);
> +
> +	/* clear RTC interrupts */
> +	/*
> +	err =3D regmap_read(power->regmap, MAX77620_REG_RTCINT, &value);
> +	if (err < 0)
> +		dev_err(power->dev, "failed to clear RTC interrupts: %d\n", err);
> +	*/
> +
> +	/* clear TOP interrupts */
> +	err =3D regmap_read(power->regmap, MAX77620_REG_IRQTOP, &value);
> +	if (err < 0)
> +		dev_err(power->dev, "failed to clear interrupts: %d\n", err);
> +
> +	err =3D regmap_update_bits(power->regmap, MAX77620_REG_ONOFFCNFG2,
> +				 MAX77620_ONOFFCNFG2_SFT_RST_WK, 0);
> +	if (err < 0)
> +		dev_err(power->dev, "failed to clear SFT_RST_WK: %d\n", err);
> +
> +	err =3D regmap_update_bits(power->regmap, MAX77620_REG_ONOFFCNFG1,
> +				 MAX77620_ONOFFCNFG1_SFT_RST,
> +				 MAX77620_ONOFFCNFG1_SFT_RST);
> +	if (err < 0)
> +		dev_err(power->dev, "failed to set SFT_RST: %d\n", err);
> +}
> +
> +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> +static void max77620_pm_restart(enum reboot_mode mode, const char *cmd)
> +{
> +	struct max77620_power *power =3D system_power_controller;
> +	int err;
> +
> +	if (!power)
> +		return;
> +
> +	err =3D regmap_update_bits(power->regmap, MAX77620_REG_ONOFFCNFG2,
> +				 MAX77620_ONOFFCNFG2_SFT_RST_WK,
> +				 MAX77620_ONOFFCNFG2_SFT_RST_WK);
> +	if (err < 0)
> +		dev_err(power->dev, "failed to set SFT_RST_WK: %d\n", err);
> +
> +	err =3D regmap_update_bits(power->regmap, MAX77620_REG_ONOFFCNFG1,
> +				 MAX77620_ONOFFCNFG1_SFT_RST,
> +				 MAX77620_ONOFFCNFG1_SFT_RST);
> +	if (err < 0)
> +		dev_err(power->dev, "failed to set SFT_RST: %d\n", err);
> +}
> +#endif
> +
> +static int max77620_poweroff_probe(struct platform_device *pdev)
> +{
> +	struct max77620_chip *max77620 =3D dev_get_drvdata(pdev->dev.parent);
> +	struct device_node *np =3D pdev->dev.parent->of_node;
> +	struct max77620_power *power;
> +	unsigned int value;
> +	int err;

if (system_power_controller)
    return -EINVAL;

> +	if (!of_property_read_bool(np, "system-power-controller"))
> +		return 0;
> +
> +	power =3D devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
> +	if (!power)
> +		return -ENOMEM;
> +
> +	power->regmap =3D max77620->rmap;
> +	power->dev =3D &pdev->dev;
> +
> +	err =3D regmap_read(power->regmap, MAX77620_REG_NVERC, &value);
> +	if (err < 0) {
> +		dev_err(power->dev, "failed to read event recorder: %d\n", err);
> +		return err;
> +	}
> +
> +	dev_dbg(&pdev->dev, "event recorder: %#x\n", value);
> +
> +	system_power_controller =3D power;
> +	pm_power_off =3D max77620_pm_power_off;

> +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> +	arm_pm_restart =3D max77620_pm_restart;
> +#endif

Please use register_restart_handler() instead. It has support for
priorities, is not arm specific and properly supports unregistering
(some handler with lower priority will take over). You can check
gpio-restart as an example for the API.

If you have some other arm_pm_restart handler (those are tried first)
I suggest to convert that to the restart handler framework. Actually
it may be a good idea to convert all of them and drop arm_pm_restart,
since there are only 4 left:

$ git grep "arm_pm_restart =3D"
drivers/firmware/psci.c:        arm_pm_restart =3D psci_sys_reset;
arch/arm/mach-prima2/rstc.c:    arm_pm_restart =3D sirfsoc_restart;
arch/arm/xen/enlighten.c:       arm_pm_restart =3D xen_restart;
arch/arm/kernel/setup.c:                arm_pm_restart =3D mdesc->restart;

The first 3 should be easy to update and the last one could
be solved by registering a wrapper function as restart handler,
which calls mdesc->restart().

> +	return 0;
> +}

This is missing a removal function, which should unregister the
restart handler and do something like this:

if (pm_power_off =3D=3D max77620_pm_power_off)
    pm_power_off =3D NULL;

> +static struct platform_driver max77620_poweroff_driver =3D {
> +	.driver =3D {
> +		.name =3D "max77620-power",
> +	},
> +	.probe =3D max77620_poweroff_probe,
> +};
> +module_platform_driver(max77620_poweroff_driver);
> +
> +MODULE_DESCRIPTION("Maxim MAX77620 PMIC power off and restart driver");
> +MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
> +MODULE_ALIAS("platform:max77620-power");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.11.0

-- Sebastian

--zhsptlnqeurdibyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh4TRcACgkQ2O7X88g7
+poctA/8C6CBF0e03LKRMKCqUDwhLJJ0av5PkG5IVlvIoOubQKIiAzXHItSRBpqd
hLHMJOGO3nO0aX2d1mTC1rJzsP2bMHbhEQZDI0856kQSntaHegIygJUPr1T8+EFA
Ib+Q9eKXve7+6WDdPAHsX/+Nhwp0ggzWgiX1naMmjFQoiV/4Pj6lhRFeikvGE5Zv
bDuDgBTXbb50vHw5QieDKVP5PZzvPw6Bl6tNqW1zndP3wesm1rQ5YImPF7NoFkDi
FcKRYKeno3znXCH7E9gdimxoeMkyrG41WWSuphX1UyP1kkuCq+Y3UPkBQ/ABb+j2
QlC446cZs8C6/KO6zqR+nO7aU9iRsMIAFp7IzRj9A/nPGmt6bqeyF5goos/OnofH
wwxtpSPaFlGG0buCtu1uCRi+NZxfQVYjIERN0e6BrqYn4cfwNiDazRF+e7qiH2Od
WqpecBjPUCLIu832TwgMkQlpMiN1PP2FDNUhOGIYuHL+dvPMD9V0JvXcqgLXlwqj
89FKixfrCYV8Hkb6dZOhmOyEzx8Mc0Bwj0tU0vz/Zkdf/F0oKPKi9OHP7ny/HZjJ
9p4+sVWxweVRYakd7OQ5a1gfYQYklGGbvYCCN7z1yIEZrrUIXLZjybbxzLGbuIm2
6Vrz6h16IZxMPY/JdTrY4MBHquugZdXue2aZEUZDupinNWrrDYs=
=T0b0
-----END PGP SIGNATURE-----

--zhsptlnqeurdibyj--
