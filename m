From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power: Add ltc3651-charger driver
Date: Thu, 4 May 2017 17:36:39 +0200
Message-ID: <20170504153639.ubpemqn6pp7go2nt@earth>
References: <1493732913-19025-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lmhne7eoobbg3ca5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493732913-19025-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--lmhne7eoobbg3ca5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 02, 2017 at 03:48:33PM +0200, Mike Looijmans wrote:
> The LTC3651 reports its status via GPIO lines. This driver translates
> the GPIO levels to battery charger status information via sysfs.
> It relies on devicetree to supply the IO configuration.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> I'll send the devicetree binding documentation in a separate patch.

FYI: I will not merge the driver without the docs.

>  drivers/power/supply/Kconfig           |   7 ++
>  drivers/power/supply/Makefile          |   1 +
>  drivers/power/supply/ltc3651-charger.c | 224 +++++++++++++++++++++++++++=
++++++
>  3 files changed, 232 insertions(+)
>  create mode 100644 drivers/power/supply/ltc3651-charger.c
> [...]
> diff --git a/drivers/power/supply/ltc3651-charger.c b/drivers/power/suppl=
y/ltc3651-charger.c
> new file mode 100644
> index 0000000..cf73640
> --- /dev/null
> +++ b/drivers/power/supply/ltc3651-charger.c
> @@ -0,0 +1,224 @@
> +/*
> + *  Copyright (C) 2017, Topic Embedded Products
> + *  Driver for LTC3651 charger IC.
> + *
> + *  This program is free software; you can redistribute it and/or modify=
 it
> + *  under  the terms of the GNU General  Public License as published by =
the
> + *  Free Software Foundation;  either version 2 of the License, or (at y=
our
> + *  option) any later version.
> + *
> + *  You should have received a copy of the GNU General Public License al=
ong
> + *  with this program; if not, write to the Free Software Foundation, In=
c.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.

Can you drop the second paragraph? That way we do not need to update
their address every now and then.

> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>

Do you really need of_gpio.h?

> +struct ltc3651_charger {
> +	struct power_supply *charger;
> +	struct power_supply_desc charger_desc;
> +	struct gpio_desc *acpr_gpio;
> +	struct gpio_desc *fault_gpio;
> +	struct gpio_desc *chrg_gpio;
> +};

[...]

> +static int ltc3651_charger_get_property(struct power_supply *psy,
> +		enum power_supply_property psp, union power_supply_propval *val)
> +{
> +	struct ltc3651_charger *ltc3651_charger =3D psy_to_ltc3651_charger(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		if (!ltc3651_charger->chrg_gpio) {
> +			val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +			break;
> +		}
> +		if (gpiod_get_value(ltc3651_charger->chrg_gpio))
> +			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +		else
> +			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		break;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D gpiod_get_value(ltc3651_charger->acpr_gpio);
> +		break;
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		if (!ltc3651_charger->fault_gpio) {
> +			val->intval =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> +			break;
> +		}
> +		if (!gpiod_get_value(ltc3651_charger->fault_gpio)) {
> +			val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
> +			break;
> +		}
> +		/*
> +		 * If the fault pin is active, the chrg pin explains the type
> +		 * of failure.
> +		 */
> +		if (!ltc3651_charger->chrg_gpio) {
> +			val->intval =3D POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
> +			break;
> +		}
> +		val->intval =3D gpiod_get_value(ltc3651_charger->chrg_gpio) ?
> +				POWER_SUPPLY_HEALTH_OVERHEAT :
> +				POWER_SUPPLY_HEALTH_DEAD;
> +		break;

So reporting of status is incorrect with fault_gpio being set?

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static enum power_supply_property ltc3651_charger_properties[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_HEALTH,
> +};
> +
> +static int ltc3651_charger_probe(struct platform_device *pdev)
> +{
> +	struct power_supply_config psy_cfg =3D {};
> +	struct ltc3651_charger *ltc3651_charger;
> +	struct power_supply_desc *charger_desc;
> +	int ret;
> +
> +	ltc3651_charger =3D devm_kzalloc(&pdev->dev, sizeof(*ltc3651_charger),
> +					GFP_KERNEL);
> +	if (!ltc3651_charger) {
> +		dev_err(&pdev->dev, "Failed to alloc driver structure\n");

Drop this. It won't happen on real systems and the memory allocation
will print warnings itself.

> +		return -ENOMEM;
> +	}
> +
> +	ltc3651_charger->acpr_gpio =3D devm_gpiod_get(&pdev->dev,
> +					"acpr", GPIOD_IN);
> +	if (IS_ERR(ltc3651_charger->acpr_gpio)) {
> +		ret =3D PTR_ERR(ltc3651_charger->charger);
> +		dev_err(&pdev->dev, "Failed to acquire acpr GPIO: %d\n", ret);
> +		return ret;
> +	}
> +	ltc3651_charger->fault_gpio =3D devm_gpiod_get_optional(&pdev->dev,
> +					"fault", GPIOD_IN);
> +	if (IS_ERR(ltc3651_charger->fault_gpio)) {
> +		ret =3D PTR_ERR(ltc3651_charger->charger);
> +		dev_err(&pdev->dev, "Failed to acquire fault GPIO: %d\n", ret);
> +		return ret;
> +	}
> +	ltc3651_charger->chrg_gpio =3D devm_gpiod_get_optional(&pdev->dev,
> +					"chrg", GPIOD_IN);
> +	if (IS_ERR(ltc3651_charger->chrg_gpio)) {
> +		ret =3D PTR_ERR(ltc3651_charger->charger);
> +		dev_err(&pdev->dev, "Failed to acquire chrg GPIO: %d\n", ret);
> +		return ret;
> +	}
> +
> +	charger_desc =3D &ltc3651_charger->charger_desc;
> +	charger_desc->name =3D pdev->dev.of_node->name;
> +	charger_desc->type =3D POWER_SUPPLY_TYPE_MAINS;
> +	charger_desc->properties =3D ltc3651_charger_properties;
> +	charger_desc->num_properties =3D ARRAY_SIZE(ltc3651_charger_properties);
> +	charger_desc->get_property =3D ltc3651_charger_get_property;
> +	psy_cfg.of_node =3D pdev->dev.of_node;
> +	psy_cfg.drv_data =3D ltc3651_charger;
> +
> +	ltc3651_charger->charger =3D power_supply_register(&pdev->dev,
> +						      charger_desc, &psy_cfg);
> +	if (IS_ERR(ltc3651_charger->charger)) {
> +		ret =3D PTR_ERR(ltc3651_charger->charger);
> +		dev_err(&pdev->dev, "Failed to register power supply: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/* Acquire IRQs for the GPIO pins if possible */
> +	if (ltc3651_charger->acpr_gpio) {
> +		ret =3D gpiod_to_irq(ltc3651_charger->acpr_gpio);
> +		if (ret >=3D 0)
> +			ret =3D devm_request_any_context_irq(&pdev->dev, ret,
> +				ltc3651_charger_irq,
> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				dev_name(&pdev->dev), ltc3651_charger->charger);
> +		if (ret < 0)
> +			dev_warn(&pdev->dev, "Failed to request acpr irq\n");
> +	}
> +	if (ltc3651_charger->fault_gpio) {
> +		ret =3D gpiod_to_irq(ltc3651_charger->fault_gpio);
> +		if (ret >=3D 0)
> +			ret =3D devm_request_any_context_irq(&pdev->dev, ret,
> +				ltc3651_charger_irq,
> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				dev_name(&pdev->dev), ltc3651_charger->charger);
> +		if (ret < 0)
> +			dev_warn(&pdev->dev, "Failed to request fault irq\n");
> +	}
> +	if (ltc3651_charger->chrg_gpio) {
> +		ret =3D gpiod_to_irq(ltc3651_charger->chrg_gpio);
> +		if (ret >=3D 0)
> +			ret =3D devm_request_any_context_irq(&pdev->dev, ret,
> +				ltc3651_charger_irq,
> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				dev_name(&pdev->dev), ltc3651_charger->charger);
> +		if (ret < 0)
> +			dev_warn(&pdev->dev, "Failed to request chrg irq\n");
> +	}

I think we should either require irq support or provide
some kind of polling fallback.

> +	platform_set_drvdata(pdev, ltc3651_charger);
> +
> +	return 0;
> +}
> +
> +static int ltc3651_charger_remove(struct platform_device *pdev)
> +{
> +	struct ltc3651_charger *ltc3651_charger =3D platform_get_drvdata(pdev);
> +
> +	power_supply_unregister(ltc3651_charger->charger);
> +
> +	return 0;
> +}

Use devm_power_supply_register() and kill remove function :)

> +static const struct of_device_id ltc3651_charger_match[] =3D {
> +	{ .compatible =3D "ltc3651-charger" },

Missing vendor prefix.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ltc3651_charger_match);
> +
> +static struct platform_driver ltc3651_charger_driver =3D {
> +	.probe =3D ltc3651_charger_probe,
> +	.remove =3D ltc3651_charger_remove,
> +	.driver =3D {
> +		.name =3D "ltc3651-charger",
> +		.of_match_table =3D ltc3651_charger_match,
> +	},
> +};
> +
> +module_platform_driver(ltc3651_charger_driver);
> +
> +MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
> +MODULE_DESCRIPTION("Driver for LTC3651 charger");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:ltc3651-charger");

-- Sebastian

--lmhne7eoobbg3ca5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkLSoQACgkQ2O7X88g7
+pq2nQ//UHWhYOrzaCv4EPuu9vYzJht0kkzvP3OAErBfKzBQJ/eOmAZIUhdND4ut
gjiLvflCgJhSgYvkKkOYbQjQ1/mKe6V/Ah/XqYV+dz6PVZ48Oz+Mho9IRwFqDhqP
hncGMoEPLfAbyEXm48HsKPZinf3t/cE8L18mRm0pdK6phHnP7+R1BLhoh7CWknjR
3qGYC7423VENG84uSJhUAi8ejd3uSA2U2WCGNjHnrIqoWjRtuAoCAgWfF0KL0U9H
Cb4+nljbpO83ebm2NrhZgn+gTYYwu7wQgh8hEnRhjQQt79XTS/a8MVYiMIrGkSRg
pSCGxR4evFc4DZlLug1lgDf8DbKF3bcHOddwsRndeKAUb/24qNh0q2aQP3HzLThj
fIAQ1tcI1QLyMXS6my5cGmrDWvpNul34+vzbg6IkhENIc78gpDOtI6EXsyxZcyWL
MrUUHpz5mKmWqG9dOodwtZQaKcpDyOyoj7wygG47uooQSznzYWw26Rnlbqnih+lA
Y2UXFTSUh7HuURdHJmkdnqIx3OHtA4d9xsOrAuInbD8PZVuRkaY6ZuDLy1r2jArl
cOXG0IDEfqPKTdZWW29xpTwWvpjGVIPJczGPL6cpIp0btJ2Q96rFRTpPyze4G6fp
6Wn2wCm6L5/GmxO5a2y2jhRlZGbPgezzKeDZvlqdYlt/PT77kPU=
=6R+A
-----END PGP SIGNATURE-----

--lmhne7eoobbg3ca5--
