From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] power: reset: add driver for Hardkernel's Odroid
 boards
Date: Thu, 22 Jan 2015 02:06:31 +0100
Message-ID: <20150122010631.GL13715@earth.universe>
References: <1414588409-8065-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yaPAUYI/0vT2YKpA"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414588409-8065-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Tobias Jakobi <Liquid.Acid@gmx.net>, Daniel Drake <drake@endlessm.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org


--yaPAUYI/0vT2YKpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 29, 2014 at 02:13:28PM +0100, Marek Szyprowski wrote:
> This patch adds a driver implementing correct reboot and poweroff
> procedures for Exynos4412-based Hardkernel's Odroid X/X2/U2/U3/U3+
> boards.

Sorry it took so long. I have a couple of small requests before
applying this (comments inline).

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/power/reset/odroid-reset.txt          |  18 ++++
>  drivers/power/reset/Kconfig                        |   6 ++
>  drivers/power/reset/Makefile                       |   1 +
>  drivers/power/reset/odroid-reboot.c                | 119 +++++++++++++++=
++++++
>  4 files changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/odroid-=
reset.txt
>  create mode 100644 drivers/power/reset/odroid-reboot.c
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/odroid-reset.t=
xt b/Documentation/devicetree/bindings/power/reset/odroid-reset.txt
> new file mode 100644
> index 000000000000..86471a463518
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/odroid-reset.txt
> @@ -0,0 +1,18 @@
> +* Device tree bindings for Hardkernel's Exynos4412 based Odroid boards
> +
> +This node is intended to allow proper system reboot and power off of
> +Odroid X/X2/U2/U3/U3+ boards with eMMC storage. Without this node, board
> +hangs during standard reset procedure.
> +
> +Required properties:
> +- compatible:			hardkernel,odroid-reboot
> +- samsung,pmureg-phandle:	phandle to Exynos PMU node
> +- reset-gpios:			phandle and gpio-specifier to the GPIO pin
> +				connected to the eMMC_nDET
> +
> +Example:
> +odroid_reboot {
> +	compatible =3D "hardkernel,odroid-reboot";
> +	samsung,pmureg-phandle =3D <&pmu_system_controller>;
> +	reset-gpio =3D <&gpk1 2 0>;
> +};
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index f65ff49bb275..f02b13d5344f 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -84,6 +84,12 @@ config POWER_RESET_LTC2952
>  	  This driver supports an external powerdown trigger and board power
>  	  down via the LTC2952. Bindings are made in the device tree.
> =20
> +config POWER_RESET_ODROID
> +	bool "Hardkernel's Exynos4412 based Odroid reboot driver"
> +	depends on POWER_RESET && ARCH_EXYNOS

once the arm specific restart handler is gone you can add ||
COMPILE_TEST

> +	help
> +	  Power off and restart support for Odroid boards.
> +
>  config POWER_RESET_QNAP
>  	bool "QNAP power-off driver"
>  	depends on OF_GPIO && PLAT_ORION
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 76ce1c59469b..178ee86eb813 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restart.o
>  obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
>  obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
>  obj-$(CONFIG_POWER_RESET_LTC2952) +=3D ltc2952-poweroff.o
> +obj-$(CONFIG_POWER_RESET_ODROID) +=3D odroid-reboot.o
>  obj-$(CONFIG_POWER_RESET_QNAP) +=3D qnap-poweroff.o
>  obj-$(CONFIG_POWER_RESET_RESTART) +=3D restart-poweroff.o
>  obj-$(CONFIG_POWER_RESET_SUN6I) +=3D sun6i-reboot.o
> diff --git a/drivers/power/reset/odroid-reboot.c b/drivers/power/reset/od=
roid-reboot.c
> new file mode 100644
> index 000000000000..823e93539220
> --- /dev/null
> +++ b/drivers/power/reset/odroid-reboot.c
> @@ -0,0 +1,119 @@
> +/*
> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_gpio.h>
> +#include <linux/reboot.h>
> +#include <linux/regmap.h>
> +
> +#include <asm/system_misc.h>
> +
> +#define PS_HOLD_CONTROL	0x330C
> +
> +struct odroid_reboot_data {
> +	struct device *dev;
> +	int power_gpio;
> +	struct regmap *reg_pmu;
> +	void (*reboot_func)(enum reboot_mode mode, const char *cmd);
> +};
> +
> +static struct odroid_reboot_data *reboot_data;
> +
> +static void odroid_reboot(enum reboot_mode mode, const char *cmd)
> +{
> +	local_irq_disable();
> +
> +	gpio_set_value(reboot_data->power_gpio, 0);
> +	mdelay(150);
> +	gpio_set_value(reboot_data->power_gpio, 1);
> +
> +	reboot_data->reboot_func(mode, cmd);
> +
> +	pr_emerg("%s: waiting for reboot\n", __func__);
> +	while (1)
> +		;
> +}
> +
> +static void odroid_power_off(void)
> +{
> +	regmap_update_bits(reboot_data->reg_pmu, PS_HOLD_CONTROL, 0xffffffff, 0=
x5200);
> +	while (1) {
> +		pr_emerg("%s: should not reach here!\n", __func__);
> +		msleep(1000);
> +	}
> +}
> +
> +static struct odroid_reboot_data *odroid_reboot_parse_dt(struct device *=
dev)
> +{
> +	struct device_node *np =3D dev->of_node;
> +	struct odroid_reboot_data *data;
> +
> +	data =3D devm_kzalloc(dev, sizeof(struct odroid_reboot_data), GFP_KERNE=
L);
> +	if (!data)
> +		return NULL;
> +
> +	data->power_gpio =3D of_get_named_gpio(np, "reset-gpios", 0);
> +	if (!gpio_is_valid(data->power_gpio)) {
> +		dev_err(dev, "invalid reset gpio pin\n");
> +		return NULL;
> +	}
> +	devm_gpio_request(dev, data->power_gpio, "reset");

please use gpiod interface.

> +
> +	data->reg_pmu =3D syscon_regmap_lookup_by_phandle(np,
> +						"samsung,pmureg-phandle");
> +	if (IS_ERR(data->reg_pmu)) {
> +		dev_err(dev, "failed to map PMU registers\n");
> +		return NULL;
> +	}
> +
> +	return data;
> +}
> +
> +static int odroid_reboot_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +
> +	if (pdev->dev.of_node)
> +		reboot_data =3D odroid_reboot_parse_dt(dev);
> +
> +	if (!reboot_data)
> +		return -EINVAL;
> +
> +	reboot_data->dev =3D &pdev->dev;
> +	reboot_data->reboot_func =3D arm_pm_restart;
> +
> +	/* grab reboot arm specific hook */
> +	arm_pm_restart =3D odroid_reboot;

please use register_restart_handler() and
unregister_restart_handler() in remove function.

> +	/* register power off function */
> +	pm_power_off =3D odroid_power_off;
> +
> +	return 0;
> +}
> +
> +static struct of_device_id odroid_reboot_of_match[] =3D {
> +	{ .compatible =3D "hardkernel,odroid-reboot", },
> +	{ },
> +};
> +
> +static struct platform_driver odroid_reboot_driver =3D {
> +	.probe		=3D odroid_reboot_probe,
> +	.driver		=3D {
> +		.name	=3D "odroid-reboot",
> +		.owner	=3D THIS_MODULE,

Please remove .owner line (not needed, will trigger a coccinelle
warning).

> +		.of_match_table =3D of_match_ptr(odroid_reboot_of_match),
> +	}
> +};
> +module_platform_driver(odroid_reboot_driver);

-- Sebastian

--yaPAUYI/0vT2YKpA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUwE0UAAoJENju1/PIO/qavGQP/08JFnt61qIaJs+VoPPl2nQE
rWzSbnVMmT+m23mYEXB6LPgTIbJuxP8c7bKQIPlzcFS0kx8nRDRdO+Ckev1bHdUZ
Smr8HFvbKGvGTOXQJvZWby9QbTgMtOGra4lk1+zPKZjKm40/vZ7q8UcuhjeK/gKe
ES540mO7qI4dKHTv016bd+YrgqpcesTpnwbHC4jT5X8zennVJobt6IStFjgfK65Q
I7aVsYcfv1qteKRFbEWbOihr3bbD+yYvB5qqMumqFgdyDYFbVsDRQBVQ3ovbSDge
6SgMVsmnVv9O3fFSXiK4m6Ayenu9lB7JfrV5I9UAaXpcLvNp+6IBf7zxxv2/e5i0
CTc7R7TXqex0MK3rYzCWzIoPZojSLENt/qE1jeN5qsCnyPl1w/J0+fjWGln+CUZ3
XUXpursQNY7AeFHRdK7wfncD3zryRHFUPvazVz9z79TaqrxMz1VOUP9Rqi++6zhv
3pGI1nn8dl9h3wy4AkehSSrY564mNeGIgYvOH22hA5mS5FklsiqmDr9/Ul9VIYCH
eQm6HLR1DM3q9SkyayOpaZ5rBQLPpvJDWjI/JfCkMXfz3S50/7+HwzwnvI6W+J9o
OH5RlZ6I/q9WMUuMscPBm67loOmRxjBRkPxAsyXQWy1idNPnoLnq1fHipfbyDBlD
i8i+28oMhtNpWz1Nz9o+
=wvka
-----END PGP SIGNATURE-----

--yaPAUYI/0vT2YKpA--
