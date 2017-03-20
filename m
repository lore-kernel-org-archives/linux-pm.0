From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 14/15] power: supply: Add driver for Cherry Trail Whiskey
 Cove PMIC Fuel Gauge
Date: Mon, 20 Mar 2017 06:07:22 +0100
Message-ID: <20170320050722.3ot5ckhqn3sn7w6a@earth>
References: <20170317095527.10487-1-hdegoede@redhat.com>
 <20170317095527.10487-15-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="my22qcqtn2laiytu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317095527.10487-15-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--my22qcqtn2laiytu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 17, 2017 at 10:55:26AM +0100, Hans de Goede wrote:
> Add a driver for the Cherry Trail Whiskey Cove PMIC Fuel Gauge, note
> the Cherry Trail Whiskey Cove PMIC Fuel Gauge block is purely a fuel gauge
> and not a full battery controller. As such it offers a platform_data
> callback for extra power_supply properties for the actual external-charger
> ic driver and does not register a power_supply itself.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I think this should become a normal battery-type power-supply
driver. bq24190_charger driver should only expose a charger-type
power-supply device on your system (and probably most others, its
very rare, that systems have a programmable charger and no
fuel-gauge).

-- Sebastian

> ---
>  drivers/power/supply/Kconfig             |   9 ++
>  drivers/power/supply/Makefile            |   1 +
>  drivers/power/supply/cht_wc_fuel_gauge.c | 209 +++++++++++++++++++++++++=
++++++
>  include/linux/power/cht_wc_fuel_gauge.h  |  21 ++++
>  4 files changed, 240 insertions(+)
>  create mode 100644 drivers/power/supply/cht_wc_fuel_gauge.c
>  create mode 100644 include/linux/power/cht_wc_fuel_gauge.h
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index fd93110..34ebfca 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -538,4 +538,13 @@ config AXP20X_POWER
>  	  This driver provides support for the power supply features of
>  	  AXP20x PMIC.
> =20
> +config CHT_WC_FUEL_GAUGE
> +	tristate "Intel Cherry Trail Whiskey Cove PMIC Fuel Gauge"
> +	depends on INTEL_SOC_PMIC_CHTWC
> +	help
> +	  This adds support for the battery fuel gauge found in the Intel
> +	  Cherry Trail Whiskey Cove PMIC. This driver allows monitoring
> +	  of the charge level of the battery on Intel Cherry Trail systems
> +	  with a Whiskey Cove PMIC.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 3789a2c..702e28a 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -74,3 +74,4 @@ obj-$(CONFIG_CHARGER_TPS65090)	+=3D tps65090-charger.o
>  obj-$(CONFIG_CHARGER_TPS65217)	+=3D tps65217_charger.o
>  obj-$(CONFIG_AXP288_FUEL_GAUGE) +=3D axp288_fuel_gauge.o
>  obj-$(CONFIG_AXP288_CHARGER)	+=3D axp288_charger.o
> +obj-$(CONFIG_CHT_WC_FUEL_GAUGE)	+=3D cht_wc_fuel_gauge.o
> diff --git a/drivers/power/supply/cht_wc_fuel_gauge.c b/drivers/power/sup=
ply/cht_wc_fuel_gauge.c
> new file mode 100644
> index 0000000..56f6e5a
> --- /dev/null
> +++ b/drivers/power/supply/cht_wc_fuel_gauge.c
> @@ -0,0 +1,209 @@
> +/*
> + * Intel CHT Whiskey Cove Fuel Gauge driver
> + * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version
> + * 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * Cherrytrail Whiskey Cove devices have 2 functional blocks which inter=
act
> + * with the battery.
> + *
> + * 1) The fuel-gauge which is build into the Whiskey Cove PMIC, but has =
its
> + * own i2c bus and i2c client addresses separately from the rest of the =
PMIC.
> + * That block is what this driver is for.
> + *
> + * 2) An external charger IC, which is connected to the SMBUS controller
> + * which is part of the rest of the Whiskey Cove PMIC, mfd/intel_cht_wc.c
> + * registers a platform device for the SMBUS controller and
> + * i2c/busses/i2c-cht-wc.c contains the i2c-adapter driver for this.
> + *
> + * However we want to present this as a single power_supply device to
> + * userspace. So this driver offers a callback to get the fuel-gauge
> + * power_supply properties, which gets passed to the external charger
> + * driver via i2c_board_info when i2c-cht-wc.c calls i2c_new_device().
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/intel_soc_pmic.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/power/cht_wc_fuel_gauge.h>
> +#include <linux/slab.h>
> +
> +#define REG_CHARGE_NOW		0x05
> +#define REG_VOLTAGE_NOW		0x09
> +#define REG_CURRENT_NOW		0x0a
> +#define REG_CURRENT_AVG		0x0b
> +#define REG_CHARGE_FULL		0x10
> +#define REG_CHARGE_DESIGN	0x18
> +#define REG_VOLTAGE_AVG		0x19
> +#define REG_VOLTAGE_OCV		0x1b /* Only updated during charging */
> +
> +#define CHT_WC_FG_PTYPE		4
> +
> +struct cht_wc_fg_data {
> +	struct device *dev;
> +	struct i2c_client *client;
> +};
> +
> +static DEFINE_MUTEX(cht_wc_fg_mutex);
> +static struct cht_wc_fg_data *cht_wc_fg;
> +
> +static int cht_wc_fg_read(struct cht_wc_fg_data *fg, u8 reg,
> +			  union power_supply_propval *val, int scale,
> +			  int sign_extend)
> +{
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_word_data(fg->client, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (sign_extend)
> +		ret =3D sign_extend32(ret, 15);
> +
> +	val->intval =3D ret * scale;
> +
> +	return 0;
> +}
> +
> +int cht_wc_fg_get_property(enum power_supply_property prop,
> +			   union power_supply_propval *val)
> +{
> +	int ret =3D 0;
> +
> +	mutex_lock(&cht_wc_fg_mutex);
> +
> +	if (!cht_wc_fg) {
> +		ret =3D -ENXIO;
> +		goto out_unlock;
> +	}
> +
> +	switch (prop) {
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret =3D cht_wc_fg_read(cht_wc_fg, REG_VOLTAGE_NOW, val, 75, 0);
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
> +		ret =3D cht_wc_fg_read(cht_wc_fg, REG_VOLTAGE_AVG, val, 75, 0);
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
> +		ret =3D cht_wc_fg_read(cht_wc_fg, REG_VOLTAGE_OCV, val, 75, 0);
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret =3D cht_wc_fg_read(cht_wc_fg, REG_CURRENT_NOW, val, 150, 1);
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_AVG:
> +		ret =3D cht_wc_fg_read(cht_wc_fg, REG_CURRENT_AVG, val, 150, 1);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +		ret =3D cht_wc_fg_read(cht_wc_fg, REG_CHARGE_DESIGN, val, 500, 0);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL:
> +		ret =3D cht_wc_fg_read(cht_wc_fg, REG_CHARGE_FULL, val, 500, 0);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +		ret =3D cht_wc_fg_read(cht_wc_fg, REG_CHARGE_NOW, val, 500, 0);
> +		break;
> +	default:
> +		ret =3D -ENODATA;
> +	}
> +out_unlock:
> +	mutex_unlock(&cht_wc_fg_mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cht_wc_fg_get_property);
> +
> +static int cht_wc_fg_probe(struct i2c_client *client,
> +			const struct i2c_device_id *i2c_id)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct cht_wc_fg_data *fg;
> +	acpi_status status;
> +	unsigned long long ptyp;
> +
> +	fg =3D devm_kzalloc(dev, sizeof(*fg), GFP_KERNEL);
> +	if (!fg)
> +		return -ENOMEM;
> +
> +	status =3D acpi_evaluate_integer(ACPI_HANDLE(dev), "PTYP", NULL, &ptyp);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(dev, "Failed to get PTYPE\n");
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * The same ACPI HID is used with different PMICs check PTYP to
> +	 * ensure that we are dealing with a Whiskey Cove PMIC.
> +	 */
> +	if (ptyp !=3D CHT_WC_FG_PTYPE)
> +		return -ENODEV;
> +
> +	fg->dev =3D dev;
> +	/*
> +	 * The current resource settings table for the fuel gauge contains
> +	 * multiple i2c devices on 2 different i2c-busses. The one we actually
> +	 * want is the second resource (index 1).
> +	 */
> +	fg->client =3D i2c_acpi_new_device(dev, 1);
> +	if (!fg->client)
> +		return -EPROBE_DEFER;
> +
> +	i2c_set_clientdata(client, fg);
> +
> +	mutex_lock(&cht_wc_fg_mutex);
> +	cht_wc_fg =3D fg;
> +	mutex_unlock(&cht_wc_fg_mutex);
> +
> +	return 0;
> +}
> +
> +static int cht_wc_fg_remove(struct i2c_client *i2c)
> +{
> +	struct cht_wc_fg_data *fg =3D i2c_get_clientdata(i2c);
> +
> +	mutex_lock(&cht_wc_fg_mutex);
> +	cht_wc_fg =3D NULL;
> +	mutex_unlock(&cht_wc_fg_mutex);
> +
> +	i2c_unregister_device(fg->client);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id cht_wc_fg_i2c_id[] =3D {
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, cht_wc_fg_i2c_id);
> +
> +static const struct acpi_device_id cht_wc_fg_acpi_ids[] =3D {
> +	{ "INT33FE", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, cht_wc_fg_acpi_ids);
> +
> +static struct i2c_driver cht_wc_fg_driver =3D {
> +	.driver	=3D {
> +		.name	=3D "CHT Whiskey Cove PMIC Fuel Gauge",
> +		.acpi_match_table =3D ACPI_PTR(cht_wc_fg_acpi_ids),
> +	},
> +	.probe =3D cht_wc_fg_probe,
> +	.remove =3D cht_wc_fg_remove,
> +	.id_table =3D cht_wc_fg_i2c_id,
> +	.irq_index =3D 1,
> +};
> +
> +module_i2c_driver(cht_wc_fg_driver);
> +
> +MODULE_DESCRIPTION("Intel CHT Whiskey Cove PMIC Fuel Gauge driver");
> +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/power/cht_wc_fuel_gauge.h b/include/linux/powe=
r/cht_wc_fuel_gauge.h
> new file mode 100644
> index 0000000..4b4e051
> --- /dev/null
> +++ b/include/linux/power/cht_wc_fuel_gauge.h
> @@ -0,0 +1,21 @@
> +/*
> + * Intel CHT Whiskey Cove Fuel Gauge driver
> + * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version
> + * 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __CHT_WC_FUEL_GAUGE_H
> +#define __CHT_WC_FUEL_GAUGE_H
> +
> +int cht_wc_fg_get_property(enum power_supply_property prop,
> +			   union power_supply_propval *val);
> +
> +#endif
> --=20
> 2.9.3
>=20

--my22qcqtn2laiytu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljPY4cACgkQ2O7X88g7
+ppIPg//a3pIljza6TQKmV2HewKq+Gm/EnEQrwdIZyqjyj4SR3aSG4/YUcy70JGf
yqRzbu9GFzCKTf3L+a3BWF4BqY4Om2Y5CZxNjeKXmko+aRpDcr3brQDhPtl8JNJP
xZgO790LfETL4iJmgSjV5uYOFrSJSGqJr4z+xJPRgqFyNKjzlLDU47d7oPjsRF0/
UfBCJcxwUF1d8QNnU4eS2t5j+ljhKbWwUFC25xaNy3tG1szhBE3ClBBllWNBYb85
+Sm726zbd+imE2YlrcxJm2C/0edTfcL+4W1YZlUoJ1JmaWEjjm3MLlf6hVfMwhR+
T4vEDkpAgXL/71R9LUP1KZPwRQlXIJuJDEftLvKsL3tisOKMIDsJzRJnKbV5siFk
yOg49afA2iQ56VQUVBuraQ3ai61tn5wX/1ixwegL3WsctoGLc+oux2Pd5IfHnTBd
Xp3hm0urHzBzceqR5RBvO6LJvVkMr7QHMFlm/GcVjMQkkLISH+/YtwxJcO7S9GU1
6cSAslLzo4i4IgL/svYidA0CdeOVK+fbnERQ6ORFY7MAw/haV5vDXphvq4zj67ed
ZFGQWjp28TnHRwF9R9H2Xb66Pzy3Aw5NXFzeAqgiUwpBWCgGiyoNnCrZYRZHNh2c
QWY2rOJ01P4ZlicFCm2gbR6afbRMgAyDcka+Hgp1OvNtMxdPzsY=
=WJJA
-----END PGP SIGNATURE-----

--my22qcqtn2laiytu--
