From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 3/3] power: supply: Add support MAX1721x battery monitor
Date: Thu, 8 Jun 2017 14:48:28 +0200
Message-ID: <20170608124827.tvgfbrnlaeavpqs7@earth>
References: <20170602070629.8210-1-minimumlaw@rambler.ru>
 <20170602070629.8210-4-minimumlaw@rambler.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nzpbqja5z5nicxpp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170602070629.8210-4-minimumlaw@rambler.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--nzpbqja5z5nicxpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Fri, Jun 02, 2017 at 10:06:29AM +0300, Alex A. Mihaylov wrote:
> Add support for battery monitor MAX1721x (power_supply class).
> Maxim Semiconductor MAX1721x Standalone Fuel Gauge battery monitor.
> MAX17211 used for singlecell, MAX17215 for multicell batteryes.
> ---
>  drivers/power/supply/Kconfig            |  14 ++
>  drivers/power/supply/Makefile           |   1 +
>  drivers/power/supply/max1721x_battery.c | 357 ++++++++++++++++++++++++++=
++++++
>  3 files changed, 372 insertions(+)
>  create mode 100644 drivers/power/supply/max1721x_battery.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index da54ac88f0..d431d6f8aa 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -268,6 +268,20 @@ config BATTERY_MAX17042
>  	  with MAX17042. This driver also supports max17047/50 chips which are
>  	  improved version of max17042.
> =20
> +config BATTERY_MAX1721X
> +	tristate "MAX17211/MAX17215 standalone gas-gauge"
> +	depends on W1
> +	select W1_SLAVE_MAX1721X
> +	select REGMAP_W1
> +	help
> +	  MAX1721x is fuel-gauge systems for lithium-ion (Li+) batteries
> +	  in handheld and portable equipment. MAX17211 used with single cell
> +	  battery. MAX17215 designed for muticell battery. Both them have
> +	  1-Wire (W1) host interface.
> +
> +	  Say Y here to enable support for the MAX17211/MAX17215 standalone
> +	  battery gas-gauge.
> +
>  config BATTERY_Z2
>  	tristate "Z2 battery driver"
>  	depends on I2C && MACH_ZIPIT2
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 3789a2c06f..c785d05e02 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_CHARGER_DA9150)	+=3D da9150-charger.o
>  obj-$(CONFIG_BATTERY_DA9150)	+=3D da9150-fg.o
>  obj-$(CONFIG_BATTERY_MAX17040)	+=3D max17040_battery.o
>  obj-$(CONFIG_BATTERY_MAX17042)	+=3D max17042_battery.o
> +obj-$(CONFIG_BATTERY_MAX1721X)	+=3D max1721x_battery.o
>  obj-$(CONFIG_BATTERY_Z2)	+=3D z2_battery.o
>  obj-$(CONFIG_BATTERY_RT5033)	+=3D rt5033_battery.o
>  obj-$(CONFIG_CHARGER_RT9455)	+=3D rt9455_charger.o
> diff --git a/drivers/power/supply/max1721x_battery.c b/drivers/power/supp=
ly/max1721x_battery.c
> new file mode 100644
> index 0000000000..aa0effec3d
> --- /dev/null
> +++ b/drivers/power/supply/max1721x_battery.c
> @@ -0,0 +1,357 @@
> +/*
> + * 1-wire client/driver for the Maxim Semicondactor
> + * MAX17211/MAX17215 Standalone Fuel Gauge IC
> + *
> + * Copyright (C) 2017 OAO Radioavionica
> + * Author: Alex A. Mihaylov <minimumlaw@rambler.ru>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/param.h>

param?

> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/idr.h>
> +
> +#include "../../w1/w1.h"

This will conflict with public w1 interface patch
https://www.spinics.net/lists/kernel/msg2524566.html

This patch should be on top of that patch.

> +#include "../../w1/slaves/w1_max1721x.h"

Let's merge those defines into the driver. They
are not used anywhere else.

> +#define DEF_DEV_NAME_MAX17211	"MAX17211"
> +#define DEF_DEV_NAME_MAX17215	"MAX17215"
> +#define DEF_DEV_NAME_UNKNOWN	"UNKNOWN"
> +#define DEF_MFG_NAME		"MAXIM"
> +
> +struct max17211_device_info {
> +	struct device *dev;
> +	struct power_supply *bat;
> +	struct power_supply_desc bat_desc;
> +	struct device *w1_dev;
> +	struct regmap *regmap;
> +	/* battery design format */
> +	unsigned int rsense; /* in tenths uOhm */
> +	char DeviceName[2 * MAX1721X_REG_DEV_NUMB + 1];
> +	char ManufacturerName[2 * MAX1721X_REG_MFG_NUMB + 1];
> +	char SerialNumber[13]; /* see get_sn_str() later for comment */
> +};
> +
> +static inline struct max17211_device_info *
> +to_device_info(struct power_supply *psy)
> +{
> +	return power_supply_get_drvdata(psy);
> +}
> +
> +static int max1721x_battery_get_property(struct power_supply *psy,
> +	enum power_supply_property psp,
> +	union power_supply_propval *val)
> +{
> +	struct max17211_device_info *info =3D to_device_info(psy);
> +	unsigned int reg =3D 0;
> +	int ret =3D 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		/*
> +		 * POWER_SUPPLY_PROP_PRESENT will always readable via
> +		 * sysfs interface. Value return 0 if battery not
> +		 * present or unaccesable via W1.
> +		 */
> +		val->intval =3D
> +			regmap_read(info->regmap, MAX172XX_REG_STATUS,
> +			&reg) ? 0 : !(reg & MAX172XX_BAT_PRESENT);
> +		break;
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		ret =3D regmap_read(info->regmap, MAX172XX_REG_REPSOC, &reg);
> +		val->intval =3D max172xx_percent_to_ps(reg);
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret =3D regmap_read(info->regmap, MAX172XX_REG_BATT, &reg);
> +		val->intval =3D max172xx_voltage_to_ps(reg);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +		ret =3D regmap_read(info->regmap, MAX172XX_REG_DESIGNCAP, &reg);
> +		val->intval =3D max172xx_capacity_to_ps(reg);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_AVG:
> +		ret =3D regmap_read(info->regmap, MAX172XX_REG_REPCAP, &reg);
> +		val->intval =3D max172xx_capacity_to_ps(reg);
> +		break;
> +	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
> +		ret =3D regmap_read(info->regmap, MAX172XX_REG_TTE, &reg);
> +		val->intval =3D max172xx_time_to_ps(reg);
> +		break;
> +	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
> +		ret =3D regmap_read(info->regmap, MAX172XX_REG_TTF, &reg);
> +		val->intval =3D max172xx_time_to_ps(reg);
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP:
> +		ret =3D regmap_read(info->regmap, MAX172XX_REG_TEMP, &reg);
> +		val->intval =3D max172xx_temperature_to_ps(reg);
> +		break;
> +	/* We need signed current, so must cast info->rsense to signed type */
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret =3D regmap_read(info->regmap, MAX172XX_REG_CURRENT, &reg);
> +		val->intval =3D
> +			max172xx_current_to_voltage(reg) / (int)info->rsense;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_AVG:
> +		ret =3D regmap_read(info->regmap, MAX172XX_REG_AVGCURRENT, &reg);
> +		val->intval =3D
> +			max172xx_current_to_voltage(reg) / (int)info->rsense;
> +		break;
> +	/*
> +	 * Strings already received and inited by probe.
> +	 * We do dummy read for check battery still available.
> +	 */
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		ret =3D regmap_read(info->regmap, MAX1721X_REG_DEV_STR, &reg);
> +		val->strval =3D info->DeviceName;
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		ret =3D regmap_read(info->regmap, MAX1721X_REG_MFG_STR, &reg);
> +		val->strval =3D info->ManufacturerName;
> +		break;
> +	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
> +		ret =3D regmap_read(info->regmap, MAX1721X_REG_SER_HEX, &reg);
> +		val->strval =3D info->SerialNumber;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static enum power_supply_property max1721x_battery_props[] =3D {
> +	/* int */
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_AVG,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
> +	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_AVG,
> +	/* strings */
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +	POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +};
> +
> +static int get_string(struct max17211_device_info *info,
> +			uint16_t reg, uint8_t nr, char *str)
> +{
> +	unsigned int val;
> +
> +	if (!str || !(reg =3D=3D MAX1721X_REG_MFG_STR ||
> +			reg =3D=3D MAX1721X_REG_DEV_STR))
> +		return -EFAULT;
> +
> +	while (nr--) {
> +		if (regmap_read(info->regmap, reg++, &val))
> +			return -EFAULT;
> +		*str++ =3D val>>8 & 0x00FF;
> +		*str++ =3D val & 0x00FF;
> +	}
> +	return 0;
> +}
> +
> +/* Maxim say: Serial number is a hex string up to 12 hex characters */
> +static int get_sn_string(struct max17211_device_info *info, char *str)
> +{
> +	unsigned int val[3];
> +
> +	if (!str)
> +		return -EFAULT;
> +
> +	if (regmap_read(info->regmap, MAX1721X_REG_SER_HEX, &val[0]))
> +		return -EFAULT;
> +	if (regmap_read(info->regmap, MAX1721X_REG_SER_HEX + 1, &val[1]))
> +		return -EFAULT;
> +	if (regmap_read(info->regmap, MAX1721X_REG_SER_HEX + 2, &val[2]))
> +		return -EFAULT;
> +
> +	snprintf(str, 13, "%04X%04X%04X", val[0], val[1], val[2]);
> +	return 0;
> +}
> +
> +/* Model Gauge M5 Register Memory Map access */
> +static const struct regmap_range max1721x_regs_allow[] =3D {
> +	/* M5 Model Gauge Algorithm area */
> +	regmap_reg_range(0x00, 0x23),
> +	regmap_reg_range(0x27, 0x2F),
> +	regmap_reg_range(0x32, 0x32),
> +	regmap_reg_range(0x35, 0x36),
> +	regmap_reg_range(0x38, 0x3A),
> +	regmap_reg_range(0x3D, 0x3F),
> +	regmap_reg_range(0x42, 0x42),
> +	regmap_reg_range(0x45, 0x46),
> +	regmap_reg_range(0x4A, 0x4A),
> +	regmap_reg_range(0x4D, 0x4D),
> +	regmap_reg_range(0xB0, 0xB0),
> +	regmap_reg_range(0xB4, 0xB4),
> +	regmap_reg_range(0xB8, 0xBE),
> +	regmap_reg_range(0xD1, 0xDA),
> +	regmap_reg_range(0xDC, 0xDF),
> +	/* Factory settins area */
> +	regmap_reg_range(0x180, 0x1DF),
> +	{ }
> +};
> +
> +static const struct regmap_range max1721x_regs_deny[] =3D {
> +	regmap_reg_range(0x24, 0x26),
> +	regmap_reg_range(0x30, 0x31),
> +	regmap_reg_range(0x33, 0x34),
> +	regmap_reg_range(0x37, 0x37),
> +	regmap_reg_range(0x3B, 0x3C),
> +	regmap_reg_range(0x40, 0x41),
> +	regmap_reg_range(0x43, 0x44),
> +	regmap_reg_range(0x47, 0x49),
> +	regmap_reg_range(0x4B, 0x4C),
> +	regmap_reg_range(0x4E, 0xAF),
> +	regmap_reg_range(0xB1, 0xB3),
> +	regmap_reg_range(0xB5, 0xB7),
> +	regmap_reg_range(0xBF, 0xD0),
> +	regmap_reg_range(0xDB, 0xDB),
> +	regmap_reg_range(0xE0, 0x17F),
> +	{ }
> +};
> +
> +static const struct regmap_access_table max1721x_regs =3D {
> +	.yes_ranges	=3D max1721x_regs_allow,
> +	.n_yes_ranges	=3D ARRAY_SIZE(max1721x_regs_allow),
> +	.no_ranges	=3D max1721x_regs_deny,
> +	.n_no_ranges	=3D ARRAY_SIZE(max1721x_regs_deny),
> +};

It should be enough to specify the yes_range. Unspecified
values will be no implicitly.

> +/* W1 regmap config */
> +static const struct regmap_config max1721x_regmap_w1_config =3D {
> +	.reg_bits =3D 16,
> +	.val_bits =3D 16,
> +	.volatile_table =3D &max1721x_regs,
> +	.max_register =3D MAX1721X_MAX_REG_NR,
> +};

Are the non-volatile registers missing? Then you probably also
want to specify .rd_table with the same access table, so that
dumping registers via debugfs work correctly. Did you try to
cat /sys/kernel/debug/regmap/<your-device>/registers?

> +static int max1721x_battery_probe(struct platform_device *pdev)
> +{
> +	struct power_supply_config psy_cfg =3D {};
> +	struct max17211_device_info *info;
> +
> +	info =3D devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, info);
> +
> +	info->dev =3D &pdev->dev;
> +	info->w1_dev =3D pdev->dev.parent;
> +	info->bat_desc.name =3D dev_name(&pdev->dev);
> +	info->bat_desc.type =3D POWER_SUPPLY_TYPE_BATTERY;
> +	info->bat_desc.properties =3D max1721x_battery_props;
> +	info->bat_desc.num_properties =3D ARRAY_SIZE(max1721x_battery_props);
> +	info->bat_desc.get_property =3D max1721x_battery_get_property;
> +	/*
> +	 * FixMe:
> +	 * Device without no_thermal =3D true not register (err -22)
> +	 * Len of platform device name "max17211-battery.X.auto"
> +	 * more than 20 chars limit in THERMAL_NAME_LENGTH from
> +	 * include/uapi/linux/thermal.h
> +	 */
> +	info->bat_desc.no_thermal =3D true;
> +	psy_cfg.drv_data =3D info;
> +
> +	/* regmap init */
> +	info->regmap =3D devm_regmap_init_w1(info->w1_dev,
> +					&max1721x_regmap_w1_config);
> +	if (IS_ERR(info->regmap)) {
> +		int err =3D PTR_ERR(info->regmap);
> +
> +		dev_err(info->dev, "Failed to allocate register map: %d\n",
> +			err);
> +		return err;
> +	}
> +
> +	/* rsense init */
> +	info->rsense =3D 0;
> +	if (regmap_read(info->regmap, MAX1721X_REG_NRSENSE, &info->rsense))
> +
> +	if (!info->rsense) {
> +		dev_warn(info->dev, "RSenese not calibrated, set 10 mOhms!\n");
> +		info->rsense =3D 1000; /* in regs in 10^-5 */
> +	}
> +	dev_info(info->dev, "RSense: %d mOhms.\n", info->rsense / 100);
> +
> +	if (get_string(info, MAX1721X_REG_MFG_STR,
> +			MAX1721X_REG_MFG_NUMB, info->ManufacturerName)) {
> +		dev_err(info->dev, "Can't read manufacturer. Hardware error.\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!info->ManufacturerName[0])
> +		strncpy(info->ManufacturerName, DEF_MFG_NAME,
> +			2 * MAX1721X_REG_MFG_NUMB);
> +
> +	if (get_string(info, MAX1721X_REG_DEV_STR,
> +			MAX1721X_REG_DEV_NUMB, info->DeviceName)) {
> +		dev_err(info->dev, "Can't read device. Hardware error.\n");
> +		return -ENODEV;
> +	}
> +	if (!info->DeviceName[0]) {
> +		unsigned int dev_name;
> +
> +		if (regmap_read(info->regmap,
> +				MAX172XX_REG_DEVNAME, &dev_name)) {
> +			dev_err(info->w1_dev, "Can't read device name reg.\n");
> +			return -ENODEV;
> +		}
> +
> +		switch (dev_name & MAX172XX_DEV_MASK) {
> +		case MAX172X1_DEV:
> +			strncpy(info->DeviceName, DEF_DEV_NAME_MAX17211,
> +				2 * MAX1721X_REG_DEV_NUMB);
> +			break;
> +		case MAX172X5_DEV:
> +			strncpy(info->DeviceName, DEF_DEV_NAME_MAX17215,
> +				2 * MAX1721X_REG_DEV_NUMB);
> +			break;
> +		default:
> +			strncpy(info->DeviceName, DEF_DEV_NAME_UNKNOWN,
> +				2 * MAX1721X_REG_DEV_NUMB);
> +		}
> +	}
> +
> +	if (get_sn_string(info, info->SerialNumber)) {
> +		dev_err(info->dev, "Can't read serial. Hardware error.\n");
> +		return -ENODEV;
> +	}
> +
> +	info->bat =3D devm_power_supply_register(&pdev->dev, &info->bat_desc,
> +						&psy_cfg);
> +	if (IS_ERR(info->bat)) {
> +		dev_err(info->dev, "failed to register battery\n");
> +		return PTR_ERR(info->bat);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver max1721x_battery_driver =3D {
> +	.driver =3D {
> +		.name =3D "max1721x-battery",
> +	},
> +	.probe	  =3D max1721x_battery_probe,
> +};
> +module_platform_driver(max1721x_battery_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Alex A. Mihaylov <minimumlaw@rambler.ru>");
> +MODULE_DESCRIPTION("Maxim MAX17211/MAX17215 Fuel Gauage IC driver");
> +MODULE_ALIAS("platform:max1721x-battery");

Otherwise looks good.

-- Sebastian

--nzpbqja5z5nicxpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk5R5kACgkQ2O7X88g7
+pqlUg/9HTy8Wt7Zc9nxC1Au0IiTERjzbE5jiC7iySP+qvUahyWrHLRY26L9NByr
95trblx3Zd0Y8kyy1hCT8Rh24wcBT7hZWghFdhizZ7wJdVr/aZuv4gdCm4jFEz3X
Ld8KS7AY6tyJVLo8Yo0uuIuhy0AX/H+AspIfXmz7jxCaDI1ItPSlW3GQm5EBrx6b
jk9CtM5e/xGYDNA0OGTiq3ZEJcbfin+3Bwv8eF8E76NSdppHHtFXf8pHI8Aw686D
PMypVY1iW7OZ99hG6jsqaKIrWT+U2f5YYSJ3QVvBA/zgJcN3yMuvGc5v+udCS/Yn
OfcqsSizze6xe67fQY/t29zSaW4pEEYnFE9M/xOHl8qqAj7EwkmZLU3SrS+MTB/g
/LwuA+Q5Ol8YLFBYESq8oeYp8qKzjpJ8vDHP4PLtMM3adKjUzQbILwj4UbVwfhB0
s8mhKzy94T0ZQSCbrbu+5WhLpz7y0i2eAC5p6dJ1izMZjyB8aCn2dAfnDiBI/W0q
wj+3Y54byegCGub3HIAqImnn737ON4rmzlRsNEmouONrKTcZs2u09KXHn3ZRDl1o
ECbvGEjwjbaiWZvQvoNV2ZV9SEwF/H8D3qTnqnlr2iroGzZPVWjqNo3v4a6S57xk
OgYF160YBhCFA1eV53vBOSMB4oqF6/a5HwVSswoZDWnwneQVlG4=
=AWaF
-----END PGP SIGNATURE-----

--nzpbqja5z5nicxpp--
