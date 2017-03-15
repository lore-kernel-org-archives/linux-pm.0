From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] power: Add support for the Toby Churchill SBS
 battery monitor driver.
Date: Wed, 15 Mar 2017 22:52:15 +0100
Message-ID: <20170315215215.6t7mterd2ujutnlv@earth>
References: <20170223173812.10740-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e64sbmmfqjdedhm7"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754267AbdCOVw2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Mar 2017 17:52:28 -0400
Content-Disposition: inline
In-Reply-To: <20170223173812.10740-1-enric.balletbo@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--e64sbmmfqjdedhm7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 23, 2017 at 06:38:11PM +0100, Enric Balletbo i Serra wrote:
> Some of the Toby Churchill devices come with a smart battery and one
> AVR XMEGA Microcontroller monitor its state. This patch adds the driver
> for this battery monitor.

Sorry for the delay. I'm mostly fine with the driver. You can find a
few notes below.

> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/power/supply/Kconfig             |  10 +
>  drivers/power/supply/Makefile            |   2 +
>  drivers/power/supply/xmega16d4_battery.c | 353 +++++++++++++++++++++++++=
++++++
>  3 files changed, 365 insertions(+)
>  create mode 100644 drivers/power/supply/xmega16d4_battery.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 76806a0..f95f8d5 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -511,4 +511,14 @@ config AXP20X_POWER
>  	  This driver provides support for the power supply features of
>  	  AXP20x PMIC.
> =20
> +config BATTERY_XMEGA16D4
> +	tristate "XMEGA16D4 Battery Gauge Driver"
> +	depends on SPI
> +	help
> +	  Say Y here to include support for XMEGA16D4 Battery Gauge. The
> +	  driver reports the charge count, and measures the voltage and
> +	  the current.
> +
> +	  This adds support for XMEGA16D4 battery.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 36c599d..abae887 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -72,3 +72,5 @@ obj-$(CONFIG_CHARGER_TPS65090)	+=3D tps65090-charger.o
>  obj-$(CONFIG_CHARGER_TPS65217)	+=3D tps65217_charger.o
>  obj-$(CONFIG_AXP288_FUEL_GAUGE) +=3D axp288_fuel_gauge.o
>  obj-$(CONFIG_AXP288_CHARGER)	+=3D axp288_charger.o
> +obj-$(CONFIG_BATTERY_XMEGA16D4)	+=3D xmega16d4_battery.o
> +
> diff --git a/drivers/power/supply/xmega16d4_battery.c b/drivers/power/sup=
ply/xmega16d4_battery.c
> new file mode 100644
> index 0000000..8c6b11a
> --- /dev/null
> +++ b/drivers/power/supply/xmega16d4_battery.c
> @@ -0,0 +1,353 @@
> +/*
> + * Battery monitor driver for SL50 Toby Churchill SBS Batteries
> + *
> + * Copyright (c) 2017, Collabora Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/spi/spi.h>
> +#include <linux/workqueue.h>
> +
> +#define SBS_MEMORY_MAP_SIZE		128
> +/* Charging voltage, 2 bytes */
> +#define SBS_CHARGING_VOLTAGE		0x0a
> +/* Design voltage, 2 bytes */
> +#define SBS_DESIGN_VOLTAGE		0x0c
> +/* Fast charging current, 2 bytes */
> +#define SBS_FAST_CHARGING_CURRENT	0x0e
> +/* Max T, Low T, 2 bytes */
> +#define SBS_MAX_LOW_TEMPERATURE		0x10
> +/* Pack capacity, 2 bytes */
> +#define SBS_PACK_CAPACITY		0x12
> +/* Serial number, 2 bytes */
> +#define SBS_SERIAL_NUMBER		0x18
> +/* Manufacturer name, 16 bytes */
> +#define SBS_MANUFACTURER_NAME		0x20
> +/* Model name, 16 bytes */
> +#define SBS_MODEL_NAME			0x30
> +/* Device chemistry, 5 bytes */
> +#define SBS_DEVICE_CHEMISTRY		0x40
> +/* Cycle count, 2 bytes */
> +#define SBS_CYCLE_COUNT			0x50
> +/* Voltage now, 2 bytes */
> +#define SBS_VOLTAGE_NOW			0x70
> +/* Current now, 2 bytes */
> +#define SBS_CURRENT_NOW			0x72
> +/* Battery Status, 2 bytes */
> +#define SBS_BATTERY_STATUS		0x74
> +# define BATTERY_STATUS_CHARGING	0
> +# define BATTERY_STATUS_DISCHARGING	BIT(6)
> +# define BATTERY_STATUS_FULLY_CHARGED	BIT(5)
> +/* State of charge in percentage, 1 byte */
> +#define SBS_STATE_OF_CHARGE		0x76
> +
> +/* MM SIZE + START(u16) + CHECKSUM(u16) */
> +#define SPI_MSG_LENGTH		(SBS_MEMORY_MAP_SIZE + 4)
> +#define SPI_MSG_DATA_BP		2
> +/* MSB checksum byte position */
> +#define SPI_MSG_CSUM_BP		(2 + SBS_MEMORY_MAP_SIZE)
> +#define SPI_MSG_START_TOKEN	0xb00b
> +
> +struct xmega16d4_battery_data {
> +	struct spi_device *spi;
> +	struct power_supply *bat;
> +
> +	struct mutex		work_lock; /* protect work data */
> +	struct delayed_work	bat_work;
> +
> +	u8 map[SBS_MEMORY_MAP_SIZE];
> +
> +	char model_name[16];
> +	char manufacturer_name[16];
> +	char serial_number[5];
> +
> +	int technology;
> +	int voltage_uV;			/* units of uV */
> +	int current_uA;			/* units of uA */
> +	int rated_capacity;		/* units of =B5Ah */
> +	int cycle_count;
> +	int rem_capacity;		/* percentage */
> +	int life_sec;			/* units of seconds */
> +	int status;			/* state of charge */
> +};
> +
> +#define MAX_KEYLENGTH 256
> +struct battery_property_map {
> +	int value;
> +	char const *key;
> +};
> +
> +static struct battery_property_map map_technology[] =3D {
> +	{ POWER_SUPPLY_TECHNOLOGY_NiMH, "NiMH" },
> +	{ POWER_SUPPLY_TECHNOLOGY_LION, "LION" },
> +	{ POWER_SUPPLY_TECHNOLOGY_LIPO, "LIPO" },
> +	{ POWER_SUPPLY_TECHNOLOGY_LiFe, "LiFe" },
> +	{ POWER_SUPPLY_TECHNOLOGY_NiCd, "NiCd" },
> +	{ POWER_SUPPLY_TECHNOLOGY_LiMn, "LiMn" },
> +	{ -1,				NULL   },
> +};
> +
> +static int map_get_value(struct battery_property_map *map, const char *k=
ey,
> +			 int def_val)
> +{
> +	char buf[MAX_KEYLENGTH];
> +	int cr;
> +
> +	strncpy(buf, key, MAX_KEYLENGTH);
> +	buf[MAX_KEYLENGTH - 1] =3D '\0';
> +
> +	cr =3D strnlen(buf, MAX_KEYLENGTH) - 1;
> +	if (buf[cr] =3D=3D '\n')
> +		buf[cr] =3D '\0';
> +
> +	while (map->key) {
> +		if (strncasecmp(map->key, buf, MAX_KEYLENGTH) =3D=3D 0)
> +			return map->value;
> +		map++;
> +	}
> +
> +	return def_val;
> +}
> +
> +static int xmega16d4_battery_read_status(struct xmega16d4_battery_data *=
data)
> +{
> +	int i;
> +	int csum =3D 0;
> +	u8 buf[SBS_MEMORY_MAP_SIZE], technology[5];
> +	unsigned int uval;
> +	int sval;
> +	struct spi_device *spi =3D data->spi;
> +
> +	for (i =3D 0; i < SBS_MEMORY_MAP_SIZE; i++) {
> +		spi_write(spi, &i, 1);
> +		spi_read(spi, &buf[i], 1);

spi_write_then_read(spi, &i, 1, &buf[i], 1)
if (err)
    complain

> +	}
> +
> +	print_hex_dump(KERN_DEBUG, ": ", DUMP_PREFIX_OFFSET, 16, 1,
> +		       buf, SBS_MEMORY_MAP_SIZE, false);
> +
> +	/* Calculate the data checksum */
> +	for (i =3D 0; i < SBS_MEMORY_MAP_SIZE - 2; i++)
> +		csum +=3D buf[i];
> +
> +	/* Verify the checksum */
> +	uval =3D (buf[SBS_MEMORY_MAP_SIZE - 2] << 8) |
> +		buf[SBS_MEMORY_MAP_SIZE - 1];
> +	if (csum !=3D uval) {
> +		dev_dbg(&spi->dev,
> +			"message received with invalid checksum (%d !=3D %d)\n",
> +			csum, uval);
> +		return -ENOMSG;

dev_dbg? So it happens regularly?

> +	}
> +
> +	/* Update memory map with the new data */
> +	memcpy(data->map, buf, SBS_MEMORY_MAP_SIZE);
> +
> +	strncpy(data->model_name, &data->map[SBS_MODEL_NAME], 16);
> +
> +	strncpy(data->manufacturer_name, &data->map[SBS_MANUFACTURER_NAME],
> +		16);
> +
> +	strncpy(technology, &data->map[SBS_DEVICE_CHEMISTRY], 5);
> +
> +	uval =3D (u16)((data->map[SBS_SERIAL_NUMBER + 1] << 8) |
> +		data->map[SBS_SERIAL_NUMBER]);
> +	snprintf(data->serial_number, ARRAY_SIZE(data->serial_number), "%04d",
> +		 uval);
> +
> +	data->technology =3D map_get_value(map_technology, technology,
> +					 POWER_SUPPLY_TECHNOLOGY_UNKNOWN);
> +
> +	data->voltage_uV =3D (u16)((data->map[SBS_VOLTAGE_NOW + 1] << 8) |
> +			    data->map[SBS_VOLTAGE_NOW]);
> +	data->voltage_uV *=3D 1000;	/* convert from mV to uV */
> +
> +	sval =3D (s16)((data->map[SBS_CURRENT_NOW + 1] << 8) |
> +		data->map[SBS_CURRENT_NOW]);
> +	data->current_uA =3D sval;
> +	data->current_uA *=3D 1000;	/* convert from mA to uA */
> +
> +	data->rated_capacity =3D (u16)((data->map[SBS_PACK_CAPACITY + 1] << 8) |
> +				data->map[SBS_PACK_CAPACITY]);
> +	data->rated_capacity *=3D 1000;	/* convert from mAh to uAh */
> +
> +	uval =3D (u16)((data->map[SBS_BATTERY_STATUS + 1] << 8) |
> +		data->map[SBS_BATTERY_STATUS]);
> +	if (uval =3D=3D BATTERY_STATUS_CHARGING)
> +		data->status =3D POWER_SUPPLY_STATUS_CHARGING;
> +	else if (uval =3D=3D BATTERY_STATUS_DISCHARGING)
> +		data->status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +	else if (uval =3D=3D BATTERY_STATUS_FULLY_CHARGED)
> +		data->status =3D POWER_SUPPLY_STATUS_FULL;
> +	else
> +		data->status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +
> +	data->cycle_count =3D (u16)((data->map[SBS_CYCLE_COUNT + 1] << 8) |
> +			     data->map[SBS_CYCLE_COUNT]);
> +
> +	data->rem_capacity =3D data->map[SBS_STATE_OF_CHARGE];
> +
> +	uval =3D (data->rem_capacity * (data->rated_capacity / 1000)) / 100;
> +	if (data->current_uA)
> +		data->life_sec =3D (3600l * uval) / (data->current_uA / 1000);

looks like the driver would benefit from regmap.

> +	return 0;
> +}
> +
> +static void xmega16d4_battery_work(struct work_struct *work)
> +{
> +	struct xmega16d4_battery_data *data =3D container_of(work,
> +		struct xmega16d4_battery_data, bat_work.work);
> +
> +	/* Update values */
> +	mutex_lock(&data->work_lock);
> +	xmega16d4_battery_read_status(data);
> +	mutex_unlock(&data->work_lock);
> +
> +	schedule_delayed_work(&data->bat_work, HZ * 60);
> +}
> +
> +static int xmega16d4_battery_get_property(struct power_supply *psy,
> +					  enum power_supply_property psp,
> +					  union power_supply_propval *val)
> +{
> +	struct xmega16d4_battery_data *data =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval =3D data->status;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval =3D data->voltage_uV;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		val->intval =3D data->current_uA;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +		val->intval =3D data->rated_capacity;
> +		break;
> +	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
> +		val->intval =3D data->life_sec;
> +		break;
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		val->intval =3D data->rem_capacity;
> +		break;
> +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> +		val->intval =3D data->technology;
> +		break;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval =3D data->model_name;
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval =3D data->manufacturer_name;
> +		break;
> +	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
> +		val->strval =3D data->serial_number;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static enum power_supply_property xmega16d4_battery_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	/* Properties of type `const char *' */
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +	POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +};
> +
> +static const struct power_supply_desc xmega16d4_battery_desc =3D {
> +	.name			=3D "battery-monitor",
> +	.type			=3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties		=3D xmega16d4_battery_props,
> +	.num_properties		=3D ARRAY_SIZE(xmega16d4_battery_props),
> +	.get_property		=3D xmega16d4_battery_get_property,
> +};
> +
> +static int xmega16d4_battery_probe(struct spi_device *spi)
> +{
> +	struct xmega16d4_battery_data *data;
> +	struct power_supply_config psy_cfg =3D {};
> +
> +	data =3D devm_kzalloc(&spi->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->spi =3D spi;
> +	psy_cfg.of_node =3D spi->dev.of_node;
> +	psy_cfg.drv_data =3D data;
> +
> +	mutex_init(&data->work_lock);
> +
> +	INIT_DELAYED_WORK(&data->bat_work, xmega16d4_battery_work);
> +
> +	spi_set_drvdata(spi, data);
> +
> +	/* Get initial status */
> +	if (xmega16d4_battery_read_status(data))
> +		return -ENODEV;
> +
> +	data->bat =3D devm_power_supply_register(&spi->dev,
> +					       &xmega16d4_battery_desc,
> +					       &psy_cfg);
> +	if (IS_ERR(data->bat))
> +		return PTR_ERR(data->bat);
> +
> +	schedule_delayed_work(&data->bat_work, 0);
> +
> +	return 0;
> +}
> +
> +static int xmega16d4_battery_remove(struct spi_device *spi)
> +{
> +	struct xmega16d4_battery_data *data =3D spi_get_drvdata(spi);
> +
> +	cancel_delayed_work_sync(&data->bat_work);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id xmega16d4_battery_of_match[] =3D {
> +	{ .compatible =3D "tcl,xmega16d4-battery", },
> +	{ /* sentinel */ },
> +};
> +
> +static struct spi_driver xmega16d4_battery_driver =3D {
> +	.driver =3D {
> +		.name		=3D "xmega16d4-battery",
> +		.owner		=3D THIS_MODULE,
> +		.of_match_table =3D of_match_ptr(xmega16d4_battery_of_match),

Either put xmega16d4_battery_of_match inside of #ifdef CONFIG_OF
or drop of_match_ptr. Otherwise there will be an unused warning
for the CONFIG_OF=3Dn case.

> +	},
> +	.probe	=3D xmega16d4_battery_probe,
> +	.remove	=3D xmega16d4_battery_remove,
> +};
> +module_spi_driver(xmega16d4_battery_driver);
> +
> +MODULE_ALIAS("spi:xmega16d4-battery");
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Enric Balletbo Serra <enric.balletbo@collabora.com>");
> +MODULE_DESCRIPTION("xmega16d4 battery monitor driver");

Otherwise the driver looks fine. I'm a bit worried about the name,
though. xmega16d4 is just a microcontroller. This driver is more
about its firmware. I think something like "toby-churchill-battery-monitor"
would be better.

-- Sebastian

--e64sbmmfqjdedhm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJt4wACgkQ2O7X88g7
+pqLzA/9EixgLSFLEkAbgYOnnVngDmT4iKvr/UOuOzFrSViM2GY8so5LEtc9v6Mk
ehMJSmIbssq7OPAsLD+canJywxvU23D0cITGj68JPvsYscfy3thJIUC0ru6lli1J
+fST8MrsMn+XlLnXmp+P2Cf7GHrwANGJ6/ao3ly3PzkHVwkn8PU1TOVbfp3bfCfd
ieklgu8YG5C2QhDBgT5Ng8YFAnoUb8P5jbKTeXjgWQU6n73dvP5C4kEZC02s7htr
mS+tzNgi6/8hfJiwg0kI9cayAs6G3/nKq9egqR+lTZSfG7aDWwEu3NqvLzZEuyQE
UGMZESoJs64ddNJ2kHCzxdug1jPel5Mkx/ygrGFOvFRt5VShgRluRBJmr4aGMk6E
AvmnwfptrEPiqGZZjLBmE/TH5HHmhx/xS5YesDILYLtpL9FAq8+uKQVNSEwitE3M
Ns2zwPEoS4CJUB2Ou4Ifc/31hzuK51/67uRjf+aO8Ws3qwVxfAFFSdpf8uxFazAE
P353AdQWHlJp/A4jX5OZDmtkt2v5AAntOKip0Aid6n0a23VOd8fsne46bMAbhTX4
Him0EapLZwnJLnvRfudUQJJEVxXr7GOX2orUeIyqcc1dXN1PGgn+K+rIQKmuOTDL
Vqj8VYkkIRpc0ZmOuAgddmszstsZHlQDMYSN0l1Yr2sGEd2DsSc=
=y3qx
-----END PGP SIGNATURE-----

--e64sbmmfqjdedhm7--
