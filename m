From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] power: reset: Add MAX77620 support
Date: Thu, 12 Jan 2017 18:35:13 +0100
Message-ID: <20170112173513.GA22794@ulmo.ba.sec>
References: <20170112161507.23774-1-thierry.reding@gmail.com>
 <5877B088.5040007@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5877B088.5040007@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Sebastian Reichel <sre@kernel.org>, Martin Michlmayr <tbm@cyrius.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chaitanya Bandi <bandik@nvidia.com>
List-Id: linux-pm@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2017 at 10:06:24PM +0530, Laxman Dewangan wrote:
>=20
> On Thursday 12 January 2017 09:45 PM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > The Maxim MAX77620 PMIC has the ability to power off and restart the
> > system. Add a driver that supports power off (via pm_power_off()) and
> > restart (via arm_pm_restart() on 32-bit and 64-bit ARM).
> >=20
> > Based on work by Chaitanya Bandi <bandik@nvidia.com>.
> >=20
> > Cc: Chaitanya Bandi <bandik@nvidia.com>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >   drivers/power/reset/Kconfig             |   6 ++
> >   drivers/power/reset/Makefile            |   1 +
> >   drivers/power/reset/max77620-poweroff.c | 146 +++++++++++++++++++++++=
+++++++++
> >   3 files changed, 153 insertions(+)
> >   create mode 100644 drivers/power/reset/max77620-poweroff.c
> >=20
> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > index abeb77217a21..f0d0c20632f8 100644
> > --- a/drivers/power/reset/Kconfig
> > +++ b/drivers/power/reset/Kconfig
> > @@ -98,6 +98,12 @@ config POWER_RESET_IMX
> >   	  say N here or disable in dts to make sure pm_power_off never be
> >   	  overwrote wrongly by this driver.
> > +config POWER_RESET_MAX77620
> > +	bool "Maxim MAX77620 PMIC power-off driver"
> > +	depends on MFD_MAX77620
> > +	help
> > +	  Power off and restart support for Maxim MAX77620 PMICs.
> > +
> >   config POWER_RESET_MSM
> >   	bool "Qualcomm MSM power-off driver"
> >   	depends on ARCH_QCOM
> > diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> > index 11dae3b56ff9..74511d2f037a 100644
> > --- a/drivers/power/reset/Makefile
> > +++ b/drivers/power/reset/Makefile
> > @@ -9,6 +9,7 @@ obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
> >   obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restart.o
> >   obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
> >   obj-$(CONFIG_POWER_RESET_IMX) +=3D imx-snvs-poweroff.o
> > +obj-$(CONFIG_POWER_RESET_MAX77620) +=3D max77620-poweroff.o
> >   obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
> >   obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) +=3D piix4-poweroff.o
> >   obj-$(CONFIG_POWER_RESET_LTC2952) +=3D ltc2952-poweroff.o
> > diff --git a/drivers/power/reset/max77620-poweroff.c b/drivers/power/re=
set/max77620-poweroff.c
> > new file mode 100644
> > index 000000000000..4f2682d10925
> > --- /dev/null
> > +++ b/drivers/power/reset/max77620-poweroff.c
> > @@ -0,0 +1,146 @@
> > +/*
> > + * Power off driver for Maxim MAX77620 device.
> > + *
> > + * Copyright (c) 2014-2016, NVIDIA CORPORATION.  All rights reserved.
>=20
> Should we change year here?

Heh, indeed. It's probably okay to even leave out the range and make
this 2017 because the current driver is fairly far removed from the one
downstream.

> > + *
> > + * Based on work by Chaitanya Bandi <bandik@nvidia.com>.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation version 2.
> > + *
> > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any kin=
d,
> > + * whether express or implied; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> > + * General Public License for more details.
> > + */
> > +
> > +#include <linux/errno.h>
> > +#include <linux/mfd/max77620.h>
> > +#include <linux/module.h>
> > +#include <linux/notifier.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/reboot.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +
> > +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> > +#include <asm/system_misc.h>
> > +#endif
> > +
> > +struct max77620_power {
> > +	struct regmap *regmap;
> > +	struct device *dev;
> > +};
> > +
> > +static struct max77620_power *system_power_controller =3D NULL;
>=20
> As this is static and so already initialized as NULL. Hence we may not ne=
ed
> to explicitly NULL initialization.

Yes, I'll drop the explicit assignment.

> > +static void max77620_pm_power_off(void)
> > +{
> > +	struct max77620_power *power =3D system_power_controller;
> > +	unsigned int value;
> > +	int err;
> > +
> > +	if (!power)
> > +		return;
> > +
> > +	/* clear power key interrupts */
> > +	err =3D regmap_read(power->regmap, MAX77620_REG_ONOFFIRQ, &value);
> > +	if (err < 0)
> > +		dev_err(power->dev, "failed to clear power key interrupts: %d\n", er=
r);
> > +
> > +	/* clear RTC interrupts */
> > +	/*
> > +	err =3D regmap_read(power->regmap, MAX77620_REG_RTCINT, &value);
> > +	if (err < 0)
> > +		dev_err(power->dev, "failed to clear RTC interrupts: %d\n", err);
> > +	*/
> > +
> > +	/* clear TOP interrupts */
> > +	err =3D regmap_read(power->regmap, MAX77620_REG_IRQTOP, &value);
> > +	if (err < 0)
> > +		dev_err(power->dev, "failed to clear interrupts: %d\n", err);
> > +
> > +	err =3D regmap_update_bits(power->regmap, MAX77620_REG_ONOFFCNFG2,
> > +				 MAX77620_ONOFFCNFG2_SFT_RST_WK, 0);
> > +	if (err < 0)
> > +		dev_err(power->dev, "failed to clear SFT_RST_WK: %d\n", err);
> > +
> > +	err =3D regmap_update_bits(power->regmap, MAX77620_REG_ONOFFCNFG1,
> > +				 MAX77620_ONOFFCNFG1_SFT_RST,
> > +				 MAX77620_ONOFFCNFG1_SFT_RST);
> > +	if (err < 0)
> > +		dev_err(power->dev, "failed to set SFT_RST: %d\n", err);
> > +}
> > +
> > +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> > +static void max77620_pm_restart(enum reboot_mode mode, const char *cmd)
> > +{
> > +	struct max77620_power *power =3D system_power_controller;
> > +	int err;
> > +
> > +	if (!power)
> > +		return;
> > +
> > +	err =3D regmap_update_bits(power->regmap, MAX77620_REG_ONOFFCNFG2,
> > +				 MAX77620_ONOFFCNFG2_SFT_RST_WK,
> > +				 MAX77620_ONOFFCNFG2_SFT_RST_WK);
> > +	if (err < 0)
> > +		dev_err(power->dev, "failed to set SFT_RST_WK: %d\n", err);
> > +
> > +	err =3D regmap_update_bits(power->regmap, MAX77620_REG_ONOFFCNFG1,
> > +				 MAX77620_ONOFFCNFG1_SFT_RST,
> > +				 MAX77620_ONOFFCNFG1_SFT_RST);
> > +	if (err < 0)
> > +		dev_err(power->dev, "failed to set SFT_RST: %d\n", err);
> > +}
> > +#endif
> > +
> > +static int max77620_poweroff_probe(struct platform_device *pdev)
> > +{
> > +	struct max77620_chip *max77620 =3D dev_get_drvdata(pdev->dev.parent);
> > +	struct device_node *np =3D pdev->dev.parent->of_node;
> > +	struct max77620_power *power;
> > +	unsigned int value;
> > +	int err;
> > +
> > +	if (!of_property_read_bool(np, "system-power-controller"))
> > +		return 0;
> > +
> > +	power =3D devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
> > +	if (!power)
> > +		return -ENOMEM;
> > +
> > +	power->regmap =3D max77620->rmap;
>=20
> We can use the function info->regmap =3D dev_get_regmap(parent, NULL); to=
 get
> the regmap. This will make this driver independent of max77620 chip and
> extend same for other Maxim Chips.

Good point. I'll make that change.

> > +	power->dev =3D &pdev->dev;
> > +
> > +	err =3D regmap_read(power->regmap, MAX77620_REG_NVERC, &value);
> > +	if (err < 0) {
> > +		dev_err(power->dev, "failed to read event recorder: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	dev_dbg(&pdev->dev, "event recorder: %#x\n", value);
> > +
> > +	system_power_controller =3D power;
> > +	pm_power_off =3D max77620_pm_power_off;
> > +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> > +	arm_pm_restart =3D max77620_pm_restart;
>=20
> What if we want to reset via the Tegra and not through PMIC?

In that case I assume we either don't have a PMIC, or we should not add
the system-power-controller device tree property to the PMIC node. In
the latter case this driver won't install any power off or restart
callbacks.

Thierry

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh3vk4ACgkQ3SOs138+
s6FqIA/+POsJ4swVo73oierrM6w5Q1WuKxymT/nxFlDq7UUNTJu22VdMfBlmgYiA
GGCCnuCaFqdeqGFIrcT5CyFoGPzLXcQw+V8MiQQiQALQ1w3UbgjTjwv25nbpOu55
pu7tzzzw6Q0WvMaLCpI7jycBka5AxFrFoBv6A8X6HD/dIZS92hNbTkL9KbcMuXSP
EAeTOmUZrcpZQrewLeOYM4xc3T9yIwnaGNpf9R0kqsLZnCDIGdTXSIIv9xb98Lo/
tbX7cZ3K/WyBZSDa7n0gZtLbPvJro/bRlDyF35sv2oya0KVecUbRWgHz7k38IODr
ZpQDc2/wVi7QgUcfnlkVebBEGg9YjDNUibiKrTXRJwnEnV6fMX4WoNsNVOfB1mML
bc1YZ8tgh83jewxNQV8WHpATUS5KVCt7shepmh6dUs5+PtnXelOUruxLid+Ctf5X
euC1IVpMsp1b2/yec6nee0/UUMwQ3aDlTdEtROuoO1ZUkxddJtYFdXQ/voLG5NFg
/j408Rx4Gfk9WDkRRyKQKXFLyiGjTOl4Oz9uS+JK2hu4+U9VuCtwzHAPRMYSUwvf
C+Nnt1zEgOlQfFf/kIsIom53aHVwZgcVY71Av+T13B0j1bxwPZIAZx7PXlAQvo7C
m+yiH6A4fBkomFmHbHkXggmk6VJVQxZGqFjjAUd/xNamCRp/nME=
=lzNf
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
