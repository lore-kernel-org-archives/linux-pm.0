From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power_supply: add max1721x_battery driver
Date: Mon, 3 Jul 2017 18:36:07 +0200
Message-ID: <20170703163607.dmdsvzcrk7gqfvzn@earth>
References: <20170608191726.dg3awuoiftundmi2@earth>
 <20170613162753.11709-1-minimumlaw@rambler.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="paa4s66capxiv5ve"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52957 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754534AbdGCQgM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2017 12:36:12 -0400
Content-Disposition: inline
In-Reply-To: <20170613162753.11709-1-minimumlaw@rambler.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--paa4s66capxiv5ve
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 13, 2017 at 07:27:53PM +0300, Alex A. Mihaylov wrote:
> Maxim Integrated MAX17211/MAX17215 Standalone Fuel Gauge IC with
> 1-Wire interface. MAX17215 sinle cell version, MAX17211 multicell
> with cell ballancing.
>=20
> This driver use regmap-w1 infrastucture. Waiting for other patches
> for 1-Wire. This time for review only.
>=20
> Signed-off-by: Alex A. Mihaylov <minimumlaw@rambler.ru>

This looks mostly fine now. I have a few more small change requests.

> ---
>  drivers/power/supply/Kconfig            |  13 ++
>  drivers/power/supply/Makefile           |   1 +
>  drivers/power/supply/max1721x_battery.c | 377 ++++++++++++++++++++++++++=
++++++
>  include/linux/power/max172xx-battery.h  | 100 +++++++++
>  4 files changed, 491 insertions(+)
>  create mode 100644 drivers/power/supply/max1721x_battery.c
>  create mode 100644 include/linux/power/max172xx-battery.h
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index da54ac8..deacd80 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -268,6 +268,19 @@ config BATTERY_MAX17042
>  	  with MAX17042. This driver also supports max17047/50 chips which are
>  	  improved version of max17042.
> =20
> +config BATTERY_MAX1721X
> +	tristate "MAX17211/MAX17215 standalone gas-gauge"
> +	depends on W1
> +	select REGMAP_W1
> +	help
> +	  MAX1721x is fuel-gauge systems for lithium-ion (Li+) batteries
> +	  in handheld and portable equipment. MAX17211 used with single cell
> +	  battery. MAX17215 designed for muticell battery. Both them have
> +	  OneWire (W1) host interface.
> +
> +	  Say Y here to enable support for the MAX17211/MAX17215 standalone
> +	  battery gas-gauge.
> +
>  config BATTERY_Z2
>  	tristate "Z2 battery driver"
>  	depends on I2C && MACH_ZIPIT2
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 3789a2c..c785d05 100644
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
> index 0000000..d3e7435
> --- /dev/null
> +++ b/drivers/power/supply/max1721x_battery.c
> @@ -0,0 +1,377 @@
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
> +#include <linux/regmap.h>
> +#include <linux/power_supply.h>
> +
> +#include "../../w1/w1.h"

Please base your next version on linux-next (or v4.13-rc1, if its
out before you sent it).

> +#include "linux/power/max172xx-battery.h"
> +
> +#define DEF_DEV_NAME_MAX17211	"MAX17211"
> +#define DEF_DEV_NAME_MAX17215	"MAX17215"
> +#define DEF_DEV_NAME_UNKNOWN	"UNKNOWN"
> +#define DEF_MFG_NAME		"MAXIM"
> +
> +#define PSY_MAX_NAME_LEN	32
> +
> +struct max17211_device_info {
> +	char name[PSY_MAX_NAME_LEN];
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
> +/*
> + * MAX1721x registers description for w1-regmap
> + */
> +static const struct regmap_range max1721x_allow_range[] =3D {
> +	regmap_reg_range(0, 0xDF),	/* volatile data */
> +	regmap_reg_range(0x180, 0x1DF),	/* non-volatile memory */
> +	regmap_reg_range(0x1E0, 0x1EF),	/* non-volatile history (unused) */
> +};
> +
> +static const struct regmap_range max1721x_deny_range[] =3D {
> +	/* volatile data unused registers */
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
> +	/* hole between volatile and non-volatile registers */
> +	regmap_reg_range(0xE0, 0x17F),
> +};
> +
> +static const struct regmap_access_table max1721x_regs =3D {
> +	.yes_ranges	=3D max1721x_allow_range,
> +	.n_yes_ranges	=3D ARRAY_SIZE(max1721x_allow_range),
> +	.no_ranges	=3D max1721x_deny_range,
> +	.n_no_ranges	=3D ARRAY_SIZE(max1721x_deny_range),
> +};
> +
> +/*
> + * Model Gauge M5 Algorithm output register
> + * Volatile data (must not be cached)
> + */
> +static const struct regmap_range max1721x_volatile_allow[] =3D {
> +	regmap_reg_range(0, 0xDF),
> +};
> +
> +static const struct regmap_access_table max1721x_volatile_regs =3D {
> +	.yes_ranges	=3D max1721x_volatile_allow,
> +	.n_yes_ranges	=3D ARRAY_SIZE(max1721x_volatile_allow),
> +};
> +
> +/*
> + * W1-regmap config
> + */
> +static const struct regmap_config max1721x_regmap_w1_config =3D {
> +	.reg_bits =3D 16,
> +	.val_bits =3D 16,
> +	.rd_table =3D &max1721x_regs,
> +	.volatile_table =3D &max1721x_volatile_regs,
> +	.max_register =3D MAX1721X_MAX_REG_NR,
> +};
> +
> +static int w1_max1721x_add_device(struct w1_slave *sl)
> +{
> +	struct power_supply_config psy_cfg =3D {};
> +	struct max17211_device_info *info;
> +
> +	info =3D devm_kzalloc(&sl->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	sl->family_data =3D (void *)info;
> +	info->w1_dev =3D &sl->dev;
> +
> +	/*
> +	 * power_supply class battery name translated from W1 slave device
> +	 * unical ID (look like 26-0123456789AB) to "max1721x-0123456789AB\0"
> +	 * so, 26 (device family) correcpondent to max1721x devices.
> +	 * Device name still unical for any numbers connected devices.
> +	 */
> +	snprintf(info->name, sizeof(info->name),
> +		"max1721x-%012X", (unsigned int)sl->reg_num.id);
> +	info->bat_desc.name =3D info->name;
> +
> +	/*
> +	 * FixMe: battery device name exceed max len for thermal_zone device
> +	 * name and translation to thermal_zone must be disabled.
> +	 */
> +	info->bat_desc.no_thermal =3D true;
> +	info->bat_desc.type =3D POWER_SUPPLY_TYPE_BATTERY;
> +	info->bat_desc.properties =3D max1721x_battery_props;
> +	info->bat_desc.num_properties =3D ARRAY_SIZE(max1721x_battery_props);
> +	info->bat_desc.get_property =3D max1721x_battery_get_property;
> +	psy_cfg.drv_data =3D info;
> +
> +	/* regmap init */
> +	info->regmap =3D regmap_init_w1(info->w1_dev,
> +					&max1721x_regmap_w1_config);
> +	if (IS_ERR(info->regmap)) {
> +		int err =3D PTR_ERR(info->regmap);
> +
> +		dev_err(info->w1_dev, "Failed to allocate register map: %d\n",
> +			err);
> +		return err;
> +	}

You also added devm_regmap_init_w1(), so use it! :)

> +	/* rsense init */
> +	info->rsense =3D 0;
> +	if (regmap_read(info->regmap, MAX1721X_REG_NRSENSE, &info->rsense))
> +
> +	if (!info->rsense) {
> +		dev_warn(info->w1_dev, "RSenese not calibrated, set 10 mOhms!\n");
> +		info->rsense =3D 1000; /* in regs in 10^-5 */
> +	}
> +	dev_info(info->w1_dev, "RSense: %d mOhms.\n", info->rsense / 100);
> +
> +	if (get_string(info, MAX1721X_REG_MFG_STR,
> +			MAX1721X_REG_MFG_NUMB, info->ManufacturerName)) {
> +		dev_err(info->w1_dev, "Can't read manufacturer. Hardware error.\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!info->ManufacturerName[0])
> +		strncpy(info->ManufacturerName, DEF_MFG_NAME,
> +			2 * MAX1721X_REG_MFG_NUMB);
> +
> +	if (get_string(info, MAX1721X_REG_DEV_STR,
> +			MAX1721X_REG_DEV_NUMB, info->DeviceName)) {
> +		dev_err(info->w1_dev, "Can't read device. Hardware error.\n");
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
> +		dev_err(info->w1_dev, "Can't read serial. Hardware error.\n");
> +		return -ENODEV;
> +	}
> +
> +	info->bat =3D power_supply_register(&sl->dev, &info->bat_desc,
> +						&psy_cfg);
> +	if (IS_ERR(info->bat)) {
> +		dev_err(info->w1_dev, "failed to register battery\n");
> +		return PTR_ERR(info->bat);
> +	}

There is devm_power_supply_register, that can be used once
you use devm_regmap_init_w1().

> +	return 0;
> +}
> +
> +static void w1_max1721x_remove_device(struct w1_slave *sl)
> +{
> +	struct max17211_device_info *info =3D
> +		(struct max17211_device_info *)sl->family_data;
> +
> +	power_supply_unregister(info->bat);
> +	regmap_exit(info->regmap);

Both of these can go once you use the devm_ based register
in probe().

> +	kfree(info);

This free is wrong. info will be free'd automatically, since
it has been requested with devm.

> +}
> +
> +static struct w1_family_ops w1_max1721x_fops =3D {
> +	.add_slave =3D w1_max1721x_add_device,
> +	.remove_slave =3D w1_max1721x_remove_device,

The remove function can be dropped completly once the devm_
conversion happened.

> +};
> +
> +static struct w1_family w1_max1721x_family =3D {
> +	.fid =3D W1_MAX1721X_FAMILY_ID,
> +	.fops =3D &w1_max1721x_fops,
> +};
> +
> +module_w1_family(w1_max1721x_family);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Alex A. Mihaylov <minimumlaw@rambler.ru>");
> +MODULE_DESCRIPTION("Maxim MAX17211/MAX17215 Fuel Gauage IC driver");
> +MODULE_ALIAS("w1-family-" __stringify(W1_MAX1721X_FAMILY_ID));
> diff --git a/include/linux/power/max172xx-battery.h b/include/linux/power=
/max172xx-battery.h
> new file mode 100644
> index 0000000..c46ac56
> --- /dev/null
> +++ b/include/linux/power/max172xx-battery.h
> [...]

Move the whole content of the header into the main driver file.

-- Sebastian

--paa4s66capxiv5ve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllacnEACgkQ2O7X88g7
+ppp3g//cuerdEENmx51jl73aXGnDF1Ok18OCVzNZuBu2+iaDv8SdPVx9gS35ol+
BuTM7NixvO+gMMicdG5cqfTUK9VPq2J24zW/6rqnC/Y2ZYQfLBkblue89XBJ1kw/
peg0nhI7GJE7m38oBoA+fS6daH79nhlsOTGoiTg4kih/3CaeU/Yhz6yIIjG20KBz
4chsNlcKXdfs5XDzUGPJpNfUdKCCIz+sH9kYGYVw4T71tHzjuoig327smkDW0PUr
go2saO6gQChqc3RSkB23Y+w6fdW9wgtFtE+eCsH6rkMBDxyiFe2fRi4qKezGwgjI
kIS5GNB/4FbtqfJRlyxtFKeDLyNyGTygp0GWBOtPXzkVsWp6OfnpUVCiC85jY44j
IdHx88Dhm7vQqBvy+8Tqg7JskmXDQkQnDVxIn+gzNUVILRHughgJjjyWZX8bZSAK
9y4BNJ30fkZqordfYphh9rf93wKcKu5vDo0SBs0/pBj3jSnRAkmh+pBEo1PXNcvz
fsWQMMLG6SJTzq7V1pehuPQDniWpez+sJR0B3JSwn/KpTC+rDZXNfoN+F4bJ/L42
CsFMayp7m0qet//N9PyPgN7J/BkycxQRkgpCqKNe1Gj4vKCrz7smfm9mlSU4Y3u7
hFLEt4yrwAluQN64BPZQCviYJVIGHqba3FC+uCUJ2DmWaEzJOfg=
=OG7E
-----END PGP SIGNATURE-----

--paa4s66capxiv5ve--
