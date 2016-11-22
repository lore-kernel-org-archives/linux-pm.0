From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] power: supply: add sbs-charger driver
Date: Tue, 22 Nov 2016 17:11:11 +0100
Message-ID: <20161122161110.y3k2uinqdghw6aaj@earth>
References: <1479751491-8849-1-git-send-email-nicolas.saenz@prodys.net>
 <1479751491-8849-3-git-send-email-nicolas.saenz@prodys.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s7rbxwzkhgiioqxi"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755274AbcKVQMn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Nov 2016 11:12:43 -0500
Content-Disposition: inline
In-Reply-To: <1479751491-8849-3-git-send-email-nicolas.saenz@prodys.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicola Saenz Julienne <nicolas.saenz@prodys.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--s7rbxwzkhgiioqxi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicola,

I have a couple of comments.

On Mon, Nov 21, 2016 at 07:04:51PM +0100, Nicola Saenz Julienne wrote:
> This adds support for sbs-charger compilant chips as defined here:
> http://sbs-forum.org/specs/sbc110.pdf

Please add that link in the header of the driver.

>=20
> This was tested on a arm board connected to an LTC41000 battery charger
> chip.
>=20
> Signed-off-by: Nicola Saenz Julienne <nicolas.saenz@prodys.net>
> ---
>  drivers/power/supply/Kconfig       |   6 +
>  drivers/power/supply/Makefile      |   1 +
>  drivers/power/supply/sbs-charger.c | 312 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 319 insertions(+)
>  create mode 100644 drivers/power/supply/sbs-charger.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 76806a0..42877ff 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -164,6 +164,12 @@ config BATTERY_SBS
>  	  Say Y to include support for SBS battery driver for SBS-compliant
>  	  gas gauges.
> =20
> +config CHARGER_SBS
> +        tristate "SBS Compliant charger"
> +        depends on I2C
> +        help
> +	  Say Y to include support for SBS compilant battery chargers.
> +
>  config BATTERY_BQ27XXX
>  	tristate "BQ27xxx battery driver"
>  	help
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 36c599d..06d9ef5 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_BATTERY_COLLIE)	+=3D collie_battery.o
>  obj-$(CONFIG_BATTERY_IPAQ_MICRO) +=3D ipaq_micro_battery.o
>  obj-$(CONFIG_BATTERY_WM97XX)	+=3D wm97xx_battery.o
>  obj-$(CONFIG_BATTERY_SBS)	+=3D sbs-battery.o
> +obj-$(CONFIG_CHARGER_SBS)	+=3D sbs-charger.o
>  obj-$(CONFIG_BATTERY_BQ27XXX)	+=3D bq27xxx_battery.o
>  obj-$(CONFIG_BATTERY_BQ27XXX_I2C) +=3D bq27xxx_battery_i2c.o
>  obj-$(CONFIG_BATTERY_DA9030)	+=3D da9030_battery.o
> diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sb=
s-charger.c
> new file mode 100644
> index 0000000..a0088b0
> --- /dev/null
> +++ b/drivers/power/supply/sbs-charger.c
> @@ -0,0 +1,312 @@
> +/*
> + * Copyright (c) 2016, Prodys S.L.
> + *
> + * Author: Nicolas Saenz Julienne <nicolas.saenz@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * based on sbs-battery.c
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/power_supply.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/gpio.h>
> +#include <linux/regmap.h>
> +#include <linux/of_gpio.h>
> +#include <linux/bitops.h>
> +
> +#define SBS_CHARGER_REG_STATUS			0x13
> +
> +#define SBS_CHARGER_STATUS_CHARGE_INHIBITED	BIT(1)
> +#define SBS_CHARGER_STATUS_RES_COLD		BIT(9)
> +#define SBS_CHARGER_STATUS_RES_HOT		BIT(10)
> +#define SBS_CHARGER_STATUS_BATTERY_PRESENT	BIT(14)
> +#define SBS_CHARGER_STATUS_AC_PRESENT		BIT(15)
> +
> +#define SBS_CHARGER_POLL_TIME			500
> +
> +struct sbs_info {
> +	struct i2c_client		*client;
> +	struct power_supply		*power_supply;
> +	struct regmap			*regmap;
> +	struct delayed_work		work;
> +	unsigned int			last_state;
> +
> +	int				gpio;
> +	int				irq;
> +};
> +
> +static int sbs_get_property(struct power_supply *psy,
> +			    enum power_supply_property psp,
> +			    union power_supply_propval *val)
> +{
> +	struct sbs_info *chip =3D power_supply_get_drvdata(psy);
> +	unsigned int reg;
> +
> +	reg =3D chip->last_state;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval =3D !!(reg & SBS_CHARGER_STATUS_BATTERY_PRESENT);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D !!(reg & SBS_CHARGER_STATUS_AC_PRESENT);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +
> +		if (!(reg & SBS_CHARGER_STATUS_BATTERY_PRESENT))
> +			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		else if (reg & SBS_CHARGER_STATUS_AC_PRESENT &&
> +			 !(reg & SBS_CHARGER_STATUS_CHARGE_INHIBITED))
> +			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +		else
> +			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +
> +		break;
> +
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		if (reg & SBS_CHARGER_STATUS_RES_COLD)
> +			val->intval =3D POWER_SUPPLY_HEALTH_COLD;
> +		if (reg & SBS_CHARGER_STATUS_RES_HOT)
> +			val->intval =3D POWER_SUPPLY_HEALTH_OVERHEAT;
> +		else
> +			val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
> +
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sbs_check_state(struct sbs_info *chip)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret =3D regmap_read(chip->regmap, SBS_CHARGER_REG_STATUS, &reg);
> +	if (!ret && reg !=3D chip->last_state) {
> +		chip->last_state =3D reg;
> +		power_supply_changed(chip->power_supply);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void sbs_delayed_work(struct work_struct *work)
> +{
> +	struct sbs_info *chip =3D container_of(work, struct sbs_info, work.work=
);
> +
> +	sbs_check_state(chip);
> +
> +	schedule_delayed_work(&chip->work,
> +			      msecs_to_jiffies(SBS_CHARGER_POLL_TIME));
> +}
> +
> +static irqreturn_t sbs_irq_thread(int irq, void *data)
> +{
> +	struct sbs_info *chip =3D data;
> +	int ret;
> +
> +	ret =3D sbs_check_state(chip);
> +
> +	return ret ? IRQ_HANDLED : IRQ_NONE;
> +}
> +
> +static int sbs_parse_of(struct i2c_client *client, struct sbs_info *chip)
> +{
> +	struct device_node *np =3D client->dev.of_node;
> +	int ret;
> +
> +	chip->gpio =3D of_get_gpio(np, 0);
> +	if (chip->gpio < 0) {
> +		dev_warn(&client->dev,
> +			 "Failed to get gpio line, will default to polling\n");
> +		/*
> +		 * We don't consider this an error since sbs-charger spec states
> +		 * irq usage is optional, in this case we'll poll for the status
> +		 * changes.
> +		 */
> +		return 0;
> +	}
> +
> +	ret =3D gpio_direction_input(chip->gpio);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to set gpio as input: %d\n", ret);
> +		goto exit_gpio;
> +	}
> +
> +	chip->irq =3D gpio_to_irq(chip->gpio);
> +	if (chip->irq < 0) {
> +		ret =3D chip->irq;
> +		chip->irq =3D 0;
> +		dev_err(&client->dev, "Failed to get irq from gpio, %d\n", ret);
> +		goto exit_gpio;
> +	}
> +
> +	ret =3D devm_request_threaded_irq(&client->dev, chip->irq, NULL,
> +					sbs_irq_thread,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					dev_name(&client->dev), chip);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to request irq, %d\n", ret);
> +		chip->irq =3D 0;
> +		goto exit_gpio;
> +	}
> +
> +	return 0;
> +
> +exit_gpio:
> +	gpio_free(chip->gpio);
> +	return ret;
> +}

Instead of specifying the irq as gpio please use the interrupts
property in DT:

    some-i2c {
        sbs-charger@42 {
            /* ... */
            interrupt-parent =3D <&gpio_controller>;
            interrupts =3D <23 IRQ_TYPE_LEVEL_XXX>;
        }
    }

The frameworks will do all of the gpio handling for you for free
and the i2c framework will provide the irq number in client->irq,
so you can just do this:

	if (client->irq) {
		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
				NULL, sbs_irq_thread,
				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
				di->name, chip);
		if (ret) {
			dev_err(&client->dev, "Failed to request irq, %d\n", ret);
			return ret;
		}
	}

> +
> +static enum power_supply_property sbs_properties[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_HEALTH,
> +};
> +
> +static bool sbs_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case SBS_CHARGER_REG_STATUS:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static const struct regmap_config sbs_regmap =3D {
> +	.reg_bits	=3D 8,
> +	.val_bits	=3D 16,
> +	.max_register	=3D SBS_CHARGER_REG_STATUS,

As far as I can see it in the spec there should be

0x11 - r - ChargerSpecInfo
0x12 - w - ChargerMode
0x13 - r - ChargerStatus            <=3D your max reg
0x14 - w - ChargingCurrent
0x15 - w - ChargingVoltage
0x16 - w - AlarmWarning             <=3D actual max reg

Also it may make sense to provide readable_reg/writable_reg
to disable the range from 0x00 - 0x10.

> +	.volatile_reg	=3D sbs_volatile_reg,
> +	.val_format_endian =3D REGMAP_ENDIAN_NATIVE,

I think this should be REGMAP_ENDIAN_LITTLE, since sbs is
based on smbus specs.

> +};
> +
> +static const struct power_supply_desc sbs_desc =3D {
> +	.name =3D "sbs-charger",
> +	.type =3D POWER_SUPPLY_TYPE_MAINS,
> +	.properties =3D sbs_properties,
> +	.num_properties =3D ARRAY_SIZE(sbs_properties),
> +	.get_property =3D sbs_get_property,
> +};
> +
> +static char *sbs_battery[] =3D {
> +	"sbs-battery",
> +};

Just drop this and depend on the "power-supplies" DT property
described in
Documentation/devicetree/bindings/power/supply/power_supply.txt

> +static int sbs_probe(struct i2c_client *client,
> +		     const struct i2c_device_id *id)
> +{
> +	struct power_supply_config psy_cfg =3D {};
> +	struct sbs_info *chip;
> +	int ret, val;
> +
> +	chip =3D devm_kzalloc(&client->dev, sizeof(struct sbs_info), GFP_KERNEL=
);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->client =3D client;
> +	psy_cfg.of_node =3D client->dev.of_node;
> +	psy_cfg.drv_data =3D chip;
> +	psy_cfg.supplied_to =3D sbs_battery;
> +	psy_cfg.num_supplicants =3D ARRAY_SIZE(sbs_battery);
> +
> +	i2c_set_clientdata(client, chip);
> +
> +	chip->regmap =3D devm_regmap_init_i2c(client, &sbs_regmap);
> +	if (IS_ERR(chip->regmap))
> +		return PTR_ERR(chip->regmap);
> +
> +	ret =3D sbs_parse_of(client, chip);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to get platform data\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Before we register, we need to make sure we can actually talk
> +	 * to the battery.
> +	 */
> +	ret =3D regmap_read(chip->regmap, SBS_CHARGER_REG_STATUS, &val);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to get device status\n");
> +		return ret;
> +	}
> +	chip->last_state =3D val;
> +
> +	chip->power_supply =3D power_supply_register(&client->dev, &sbs_desc,
> +						   &psy_cfg);
> +	if (IS_ERR(chip->power_supply)) {
> +		dev_err(&client->dev, "Failed to register power supply\n");
> +		return PTR_ERR(chip->power_supply);
> +	}
> +
> +	if (!chip->irq) {
> +		INIT_DELAYED_WORK(&chip->work, sbs_delayed_work);
> +		schedule_delayed_work(&chip->work,
> +				      msecs_to_jiffies(SBS_CHARGER_POLL_TIME));
> +	}
> +
> +	dev_info(&client->dev,
> +		 "%s: smart charger device registered\n", client->name);
> +
> +	return 0;
> +}
> +
> +static int sbs_remove(struct i2c_client *client)
> +{
> +	struct sbs_info *chip =3D i2c_get_clientdata(client);
> +
> +	cancel_delayed_work_sync(&chip->work);
> +	power_supply_unregister(chip->power_supply);

Use devm_power_supply_register().

> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id sbs_dt_ids[] =3D {
> +	{ .compatible =3D "sbs,sbs-charger" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, sbs_dt_ids);
> +#endif

You need to create a DT binding document. Have a look at
the files in Documentation/devicetree/bindings/power/supply/

Please put it into its own patch and CC the devicetree
mailinglist.

> +static const struct i2c_device_id sbs_id[] =3D {
> +	{ "sbs-charger", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, sbs_id);
> +
> +static struct i2c_driver sbs_driver =3D {
> +	.probe		=3D sbs_probe,
> +	.remove		=3D sbs_remove,
> +	.id_table	=3D sbs_id,
> +	.driver =3D {
> +		.name	=3D "sbs-charger",
> +		.of_match_table =3D of_match_ptr(sbs_dt_ids),
> +	},
> +};
> +module_i2c_driver(sbs_driver);
> +
> +MODULE_AUTHOR("Nicolas Saenz Julienne <nicolassaenzj@gmail.com>");
> +MODULE_DESCRIPTION("SBS smart charger driver");
> +MODULE_LICENSE("GPL v2");

-- Sebastian

--s7rbxwzkhgiioqxi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlg0bhwACgkQ2O7X88g7
+ppJpA/+K/0DkbSjMgpLE+DPgJMNUUCscIzQ8uvAgVW+DrMfvOViEutqeB7GuBr0
T3dGEj+2enMhpFkbGZGZYs6CCzavn5hf12nWIyern3h0wnN+YB+yctRfjWNPZYLF
uDzNJaBR0atAcbfDwaxu1FVffY6tEXtezdBMw+FN/n21J2IawA6urYziC78Kqq/Z
YDgaDnbPZclSeXv1NjHWjpdBRJ3ryFnOhGhMqx41zeF+31hgpiTY2pCvrqGCY6HE
SwDym3kiUyDJ9yRIjchQ1ZqF9wYLXxf+Vg4RmwjHmQ8TQ/6u339HrGNLvnovWQrO
ZpL3DC/fa69kurttyczcXuafbMWKMK42PHxQH8/WJZBjoOIcmbUIF783OQgw5JCv
0pV5JUg2+CO98jrW1fTr2KEBh3jLKJCxU7X4vXj0uSTn5lTGAaRJhEEbNEucucCa
EJoZ/w6+iiia+lefHye65VQwZins1L9wXY/GGlIjT14E+yWTaI8DQ6wbjk2VNNWU
4IjwHd9jZvV27aEnlq76i/Ue84aKBC53Ys4J/rsny60wxTblYnzDE3cpbSi7JSvk
d+hm74j1pMUjHnqrNFwRgwDR6j8U0cYL1E5L91dW9J69kBZN5pPiNB5z486cyR7b
+tixGa3L/N1IgzDLwRa5YmP9yD8tf+wgM4u8SasMyWcM4FqMtdc=
=8JEE
-----END PGP SIGNATURE-----

--s7rbxwzkhgiioqxi--
