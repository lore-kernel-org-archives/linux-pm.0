From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 08/13] power: reset: Add a driver for the Microsemi
 Ocelot reset
Date: Fri, 8 Dec 2017 18:07:55 +0100
Message-ID: <20171208170755.n6eqgn2jkjh4rbo5@earth>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
 <20171208154618.20105-9-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="he4uuaf73s5d6do6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44632 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbdLHRIA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Dec 2017 12:08:00 -0500
Content-Disposition: inline
In-Reply-To: <20171208154618.20105-9-alexandre.belloni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--he4uuaf73s5d6do6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 08, 2017 at 04:46:13PM +0100, Alexandre Belloni wrote:
> The Microsemi Ocelot SoC has a register allowing to reset the MIPS core.
> Unfortunately, the syscon-reboot driver can't be used directly (but almos=
t)
> as the reset control may be disabled using another register.
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Is it safe to apply this and the DT binding patch (once it has Rob's
Ack-by) via the power-supply tree?

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  drivers/power/reset/Kconfig        |  7 ++++
>  drivers/power/reset/Makefile       |  1 +
>  drivers/power/reset/ocelot-reset.c | 86 ++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 94 insertions(+)
>  create mode 100644 drivers/power/reset/ocelot-reset.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index ca0de1a78e85..2372f8e1040d 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -113,6 +113,13 @@ config POWER_RESET_MSM
>  	help
>  	  Power off and restart support for Qualcomm boards.
> =20
> +config POWER_RESET_OCELOT_RESET
> +	bool "Microsemi Ocelot reset driver"
> +	depends on MSCC_OCELOT || COMPILE_TEST
> +	select MFD_SYSCON
> +	help
> +	  This driver supports restart for Microsemi Ocelot SoC.
> +
>  config POWER_RESET_PIIX4_POWEROFF
>  	tristate "Intel PIIX4 power-off driver"
>  	depends on PCI
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index aeb65edb17b7..df9d92291c67 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restar=
t.o
>  obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
>  obj-$(CONFIG_POWER_RESET_IMX) +=3D imx-snvs-poweroff.o
>  obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
> +obj-$(CONFIG_POWER_RESET_OCELOT_RESET) +=3D ocelot-reset.o
>  obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) +=3D piix4-poweroff.o
>  obj-$(CONFIG_POWER_RESET_LTC2952) +=3D ltc2952-poweroff.o
>  obj-$(CONFIG_POWER_RESET_QNAP) +=3D qnap-poweroff.o
> diff --git a/drivers/power/reset/ocelot-reset.c b/drivers/power/reset/oce=
lot-reset.c
> new file mode 100644
> index 000000000000..1fb14bf17191
> --- /dev/null
> +++ b/drivers/power/reset/ocelot-reset.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Microsemi MIPS SoC reset driver
> + *
> + * License: Dual MIT/GPL
> + * Copyright (c) 2017 Microsemi Corporation
> + */
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/notifier.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/regmap.h>
> +
> +struct ocelot_reset_context {
> +	struct regmap *chip_regs;
> +	struct regmap *cpu_ctrl;
> +	struct notifier_block restart_handler;
> +};
> +
> +#define ICPU_CFG_CPU_SYSTEM_CTRL_RESET 0x20
> +#define CORE_RST_PROTECT BIT(2)
> +
> +#define CHIP_REGS_SOFT_RST 0x8
> +#define SOFT_CHIP_RST BIT(0)
> +
> +static int ocelot_restart_handle(struct notifier_block *this,
> +				 unsigned long mode, void *cmd)
> +{
> +	struct ocelot_reset_context *ctx =3D container_of(this, struct
> +							ocelot_reset_context,
> +							restart_handler);
> +
> +	/* Make sure the core is not protected from reset */
> +	regmap_update_bits(ctx->cpu_ctrl, ICPU_CFG_CPU_SYSTEM_CTRL_RESET,
> +			   CORE_RST_PROTECT, 0);
> +
> +	regmap_write(ctx->chip_regs, CHIP_REGS_SOFT_RST, SOFT_CHIP_RST);
> +
> +	pr_emerg("Unable to restart system\n");
> +	return NOTIFY_DONE;
> +}
> +
> +static int ocelot_reset_probe(struct platform_device *pdev)
> +{
> +	struct ocelot_reset_context *ctx;
> +	struct device *dev =3D &pdev->dev;
> +	int err;
> +
> +	ctx =3D devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->chip_regs =3D syscon_node_to_regmap(of_get_parent(dev->of_node));
> +	if (IS_ERR(ctx->chip_regs))
> +		return PTR_ERR(ctx->chip_regs);
> +
> +	ctx->cpu_ctrl =3D syscon_regmap_lookup_by_compatible("mscc,ocelot-cpu-s=
yscon");
> +	if (IS_ERR(ctx->cpu_ctrl))
> +		return PTR_ERR(ctx->cpu_ctrl);
> +
> +	ctx->restart_handler.notifier_call =3D ocelot_restart_handle;
> +	ctx->restart_handler.priority =3D 192;
> +	err =3D register_restart_handler(&ctx->restart_handler);
> +	if (err)
> +		dev_err(dev, "can't register restart notifier (err=3D%d)\n", err);
> +
> +	return err;
> +}
> +
> +static const struct of_device_id ocelot_reset_of_match[] =3D {
> +	{ .compatible =3D "mscc,ocelot-chip-reset" },
> +	{}
> +};
> +
> +static struct platform_driver ocelot_reset_driver =3D {
> +	.probe =3D ocelot_reset_probe,
> +	.driver =3D {
> +		.name =3D "ocelot-chip-reset",
> +		.of_match_table =3D ocelot_reset_of_match,
> +	},
> +};
> +builtin_platform_driver(ocelot_reset_driver);
> --=20
> 2.15.1
>=20

--he4uuaf73s5d6do6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloqxuoACgkQ2O7X88g7
+poQrBAAg1jPlzymdt0xW9C0sKXlqJHr0DaUXSdQ4zbRSjH55WQR9VJvYGUHKV7v
zAG4qqbWnwBOxKDHzLShvfgHiKoOCGy83su+eiNwCnUCMDuKnlVNYgorLXwCwwwK
omCq7qfCD/YrL9kFlJoaV4/JrndpSvSVIbV5YKNVvxXr5o/eVLkpg5KS99CMCFSI
ESlW5+KmRzQx8YpaJTbmjK2vYhb38Bkj37NfqPS9lN1bL+o59cix9YqN/VDjz0hf
oX9BaE8CwsFZ6kBge1RP/DhSCoDNDpeUA2d7KW+Ccrwr5kZJ8phcvTaSa7NctYPw
LR43EzLDm+qBmtqsnStAFEnbkKVwknjV3c+bL2ro0Q6WO5HcBoNJUA/El5IXnOUQ
oqSRZuTq5hahPL2kqJuZ7jilnIO36792MH+PQBc94pNXSsy0+IGAbc8c3mTh6RDN
UUGch4IaFDn5kddW0m5z9epSjPfpj9DaXa4wxUOYI6jEfC6e+6cyg6gzNnV6Y8oE
OUX4dfbrhvzc1xOuuV4okfDuvbaw8kLswHi0y8SenKB+qTZAdbdFuCkpW3UV+4sp
mf9ysqUOCgCRY5U95RR+HV5rUsa0VlL0Dsd3RHrzo030WavJ0KLaitdBgzJGjGH3
MQvQ0HGjg0rLrkoHznql6fJDuM+wuWD3dyKcvf7zS6ojeSV/1z4=
=LdCR
-----END PGP SIGNATURE-----

--he4uuaf73s5d6do6--
