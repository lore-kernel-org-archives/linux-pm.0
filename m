From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 4/4] power: supply: Add driver for Cherry Trail
 Whiskey Cove PMIC Fuel Gauge
Date: Sat, 25 Mar 2017 19:42:55 +0100
Message-ID: <20170325184254.4fshbjbcailqxen2@earth>
References: <20170325135550.22509-1-hdegoede@redhat.com>
 <20170325135550.22509-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bzzvny7ote43szgd"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbdCYSnE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 25 Mar 2017 14:43:04 -0400
Content-Disposition: inline
In-Reply-To: <20170325135550.22509-5-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org


--bzzvny7ote43szgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Sat, Mar 25, 2017 at 02:55:50PM +0100, Hans de Goede wrote:
> Add a driver for the Cherry Trail Whiskey Cove PMIC Fuel Gauge.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

The driver looks fine to me. I think it would be nice to use
regmap for accessing the device, though. Its capability to
dump registers in debugfs is often useful, especially for
reverse engineered drivers.

Also I assume, that you made sure the reported values are correctly
scaled to uV/uA and not mV/mA? Just asking, since people regularly
get this wrong and your scaling looks suspiciously small.

-- Sebastian

> ---
> Changes in v2:
> -There was no v2, it is skipped to the version in sync with the rest of
>  the patch-set
> Changes in v3:
> -Change into a stand-alone power_supply battery driver instead of being a
>  provider of extra properties for another battery driver
> -Rename Kconfig symbol from CHT_WC_FUEL_GAUGE to BATTERY_INTEL_CHT_WC
> ---
>  drivers/power/supply/Kconfig             |   9 +
>  drivers/power/supply/Makefile            |   1 +
>  drivers/power/supply/cht_wc_fuel_gauge.c | 319 +++++++++++++++++++++++++=
++++++
>  3 files changed, 329 insertions(+)
>  create mode 100644 drivers/power/supply/cht_wc_fuel_gauge.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index fd93110..350d86a 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -538,4 +538,13 @@ config AXP20X_POWER
>  	  This driver provides support for the power supply features of
>  	  AXP20x PMIC.
> =20
> +config BATTERY_INTEL_CHT_WC
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
> index 3789a2c..46dca5c 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -74,3 +74,4 @@ obj-$(CONFIG_CHARGER_TPS65090)	+=3D tps65090-charger.o
>  obj-$(CONFIG_CHARGER_TPS65217)	+=3D tps65217_charger.o
>  obj-$(CONFIG_AXP288_FUEL_GAUGE) +=3D axp288_fuel_gauge.o
>  obj-$(CONFIG_AXP288_CHARGER)	+=3D axp288_charger.o
> +obj-$(CONFIG_BATTERY_INTEL_CHT_WC) +=3D cht_wc_fuel_gauge.o
> diff --git a/drivers/power/supply/cht_wc_fuel_gauge.c b/drivers/power/sup=
ply/cht_wc_fuel_gauge.c
> new file mode 100644
> index 0000000..0db83ad
> --- /dev/null
> +++ b/drivers/power/supply/cht_wc_fuel_gauge.c
> @@ -0,0 +1,319 @@
> +/*
> + * Intel Cherry Trail Whiskey Cove Fuel Gauge driver
> + * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/extcon.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/intel_soc_pmic.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +
> +#define FG_CHARGE_NOW			0x05
> +#define FG_VOLTAGE_NOW			0x09
> +#define FG_CURRENT_NOW			0x0a
> +#define FG_CURRENT_AVG			0x0b
> +#define FG_CHARGE_FULL			0x10
> +#define FG_CHARGE_DESIGN		0x18
> +#define FG_VOLTAGE_AVG			0x19
> +#define FG_VOLTAGE_OCV			0x1b /* Only updated during charging */
> +
> +#define PMIC_CHGRSTATUS			0x1a
> +#define PMIC_CHGRSTATUS_NOT_CHARGING	BIT(0)
> +
> +#define CHT_WC_FG_PTYPE		4
> +
> +static const unsigned int charger_cable_ids[] =3D {
> +	EXTCON_CHG_USB_SDP, EXTCON_CHG_USB_CDP,
> +	EXTCON_CHG_USB_DCP, EXTCON_CHG_USB_ACA
> +};
> +
> +struct cht_wc_fg_data {
> +	struct device *dev;
> +	/*
> +	 * The ACPI _CRS table contains info for 4 clients, 1 for the charger-
> +	 * manager part of the pmic and 3 for the actual fuel-gauge (which has
> +	 * 3 i2c addresses) note we use only 1 fg address/client.
> +	 */
> +	struct i2c_client *pmic_client;
> +	struct i2c_client *fg_client;
> +	struct extcon_dev *extcon;
> +	struct power_supply *battery;
> +	struct work_struct changed_work;
> +	struct notifier_block extcon_nb;
> +};
> +
> +static int cht_wc_fg_read(struct cht_wc_fg_data *fg, u8 reg,
> +			  union power_supply_propval *val, int scale,
> +			  int sign_extend)
> +{
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_word_data(fg->fg_client, reg);
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
> +static int cht_wc_fg_get_status(struct cht_wc_fg_data *fg,
> +				union power_supply_propval *val)
> +{
> +	int i, ret;
> +	bool vbus_present =3D false;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(charger_cable_ids); i++) {
> +		if (extcon_get_state(fg->extcon, charger_cable_ids[i]) > 0) {
> +			vbus_present =3D true;
> +			break;
> +		}
> +	}
> +
> +	if (!vbus_present) {
> +		val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		return 0;
> +	}
> +
> +	ret =3D i2c_smbus_read_byte_data(fg->pmic_client, PMIC_CHGRSTATUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Not charging while we have Vbus means the battery is full */
> +	if (ret & PMIC_CHGRSTATUS_NOT_CHARGING)
> +		val->intval =3D POWER_SUPPLY_STATUS_FULL;
> +	else
> +		val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +
> +	return 0;
> +}
> +
> +static int cht_wc_fg_get_property(struct power_supply *psy,
> +	enum power_supply_property prop, union power_supply_propval *val)
> +{
> +	struct cht_wc_fg_data *fg =3D power_supply_get_drvdata(psy);
> +	int ret =3D 0;
> +
> +	switch (prop) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		ret =3D cht_wc_fg_get_status(fg, val);
> +		break;
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval =3D 1;
> +		break;
> +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> +		val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret =3D cht_wc_fg_read(fg, FG_VOLTAGE_NOW, val, 75, 0);
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
> +		ret =3D cht_wc_fg_read(fg, FG_VOLTAGE_AVG, val, 75, 0);
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
> +		ret =3D cht_wc_fg_read(fg, FG_VOLTAGE_OCV, val, 75, 0);
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret =3D cht_wc_fg_read(fg, FG_CURRENT_NOW, val, 150, 1);
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_AVG:
> +		ret =3D cht_wc_fg_read(fg, FG_CURRENT_AVG, val, 150, 1);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +		ret =3D cht_wc_fg_read(fg, FG_CHARGE_DESIGN, val, 500, 0);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL:
> +		ret =3D cht_wc_fg_read(fg, FG_CHARGE_FULL, val, 500, 0);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +		ret =3D cht_wc_fg_read(fg, FG_CHARGE_NOW, val, 500, 0);
> +		break;
> +	case POWER_SUPPLY_PROP_SCOPE:
> +		val->intval =3D POWER_SUPPLY_SCOPE_SYSTEM;
> +		break;
> +	default:
> +		ret =3D -ENODATA;
> +	}
> +
> +	return ret;
> +}
> +
> +static void cht_wc_fg_external_power_changed(struct power_supply *psy)
> +{
> +	struct cht_wc_fg_data *fg =3D power_supply_get_drvdata(psy);
> +
> +	schedule_work(&fg->changed_work);
> +}
> +
> +static enum power_supply_property cht_wc_fg_properties[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_AVG,
> +	POWER_SUPPLY_PROP_VOLTAGE_OCV,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_AVG,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_SCOPE,
> +};
> +
> +static const struct power_supply_desc bat_desc =3D {
> +	/* Matches charger.supplied_to for external_power_changed callback */
> +	.name			=3D "main-battery",
> +	.type			=3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties		=3D cht_wc_fg_properties,
> +	.num_properties		=3D ARRAY_SIZE(cht_wc_fg_properties),
> +	.get_property		=3D cht_wc_fg_get_property,
> +	.external_power_changed =3D cht_wc_fg_external_power_changed,
> +};
> +
> +static void cht_wc_fg_changed_work(struct work_struct *work)
> +{
> +	struct cht_wc_fg_data *fg =3D
> +		container_of(work, struct cht_wc_fg_data, changed_work);
> +
> +	/* Wait a bit to allow the fuel-gauge to also detect the new status */
> +	msleep(200);
> +
> +	power_supply_changed(fg->battery);
> +}
> +
> +static int cht_wc_fg_extcon_event(struct notifier_block *nb,
> +				  unsigned long event, void *param)
> +{
> +	struct cht_wc_fg_data *fg =3D
> +		container_of(nb, struct cht_wc_fg_data, extcon_nb);
> +
> +	schedule_work(&fg->changed_work);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int cht_wc_fg_probe(struct i2c_client *client,
> +			const struct i2c_device_id *i2c_id)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct power_supply_config bat_cfg =3D {};
> +	struct cht_wc_fg_data *fg;
> +	acpi_status status;
> +	unsigned long long ptyp;
> +	int ret;
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
> +	fg =3D devm_kzalloc(dev, sizeof(*fg), GFP_KERNEL);
> +	if (!fg)
> +		return -ENOMEM;
> +
> +	fg->dev =3D dev;
> +	fg->pmic_client =3D client;
> +	INIT_WORK(&fg->changed_work, cht_wc_fg_changed_work);
> +
> +	/*
> +	 * We use the Whiskey Cove PMIC's pwrsrc detection block to see
> +	 * if we are charging or not. We could access the pwrsrc regs
> +	 * ourselves, but that requires re-implementing the extcon code,
> +	 * so we just use the extcon interface.
> +	 */
> +	fg->extcon =3D extcon_get_extcon_dev("cht_wcove_pwrsrc");
> +	if (!fg->extcon)
> +		return -EPROBE_DEFER;
> +
> +	/*
> +	 * The current resource settings table for the fuel gauge contains
> +	 * multiple i2c devices on 2 different i2c-busses.
> +	 */
> +	fg->fg_client =3D i2c_acpi_new_device(dev, 1);
> +	if (!fg->fg_client)
> +		return -EPROBE_DEFER;
> +
> +	bat_cfg.drv_data =3D fg;
> +	fg->battery =3D devm_power_supply_register(dev, &bat_desc, &bat_cfg);
> +	if (IS_ERR(fg->battery)) {
> +		i2c_unregister_device(fg->fg_client);
> +		return PTR_ERR(fg->battery);
> +	}
> +
> +	fg->extcon_nb.notifier_call =3D cht_wc_fg_extcon_event;
> +	ret =3D devm_extcon_register_notifier(dev, fg->extcon, -1,
> +					    &fg->extcon_nb);
> +	if (ret) {
> +		i2c_unregister_device(fg->fg_client);
> +		return ret;
> +	}
> +
> +	i2c_set_clientdata(client, fg);
> +
> +	return 0;
> +}
> +
> +static int cht_wc_fg_remove(struct i2c_client *i2c)
> +{
> +	struct cht_wc_fg_data *fg =3D i2c_get_clientdata(i2c);
> +
> +	i2c_unregister_device(fg->fg_client);
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
> --=20
> 2.9.3
>=20

--bzzvny7ote43szgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljWuisACgkQ2O7X88g7
+pr/Ow/+Kqy7Tgy6RCrlah7n/Bpk32GkgzlrRGVcZ4VzUbRQvvD+E17miOAsKR2n
Ydu+2qMIiTzQn7eK8uY1k6YgtLoyok+7pqATaOB89uULuifFnm6HOk52sabdmusX
FA9sKz2fUEOKUOY/3dnM+dLFfvM6OTRxsfHxRU0y4OCvB/CqtR7daLHzE+tuepo2
ikL0Ojc/MPyh/v4UwloOqfFuhyL0BJ+r2s+4Tkfx6Xd0Dfh5Z3AZ36+O9w+NPA47
uj3BMEuG+iW3xZ5RxhIUlgtDitMj+bBQ+jg/aFP3oaMXZGWvad7XvW/4Caiv9iLr
qvTt0ZLGzbJ9t/++jd+3L3axTQJuKYD798w1CMYCuDvYIDxB36ZBwbXJ+LLfKH72
tDEVvqSZgugx/3X4HQRp8rXiPSJmpCk3PbEvUOU71cbci1/AfcI92Bp0PqmRcBMV
2X4aB6i37mos3MfP3whFeGagSxmqMB7K/Vz9KcwZqraJ2Y3Bo8Niz+DfC1gvmRiQ
/aaL61pCpLwMUc8vJ0oo89Ez3k8woGS8rULLY2jI8fuwYosBSKqWf6uP8B19x+bR
PnYnaoK0/yTCzrQa5Lme05ogLzKVdVuKLYjX+zHrSCWTIbx/nhPfTLyNGYpdl27N
JgO0itR0hdbvXsBUTKmBIxssDR8acEe3EtUlpuGlCRI7l+Pt7cs=
=ICW+
-----END PGP SIGNATURE-----

--bzzvny7ote43szgd--
