From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v3] power: Add ltc3651-charger driver
Date: Mon, 15 May 2017 15:17:01 +0200
Message-ID: <20170515131701.2hu5aowidjzvpvkq@earth>
References: <1493732913-19025-1-git-send-email-mike.looijmans@topic.nl>
 <20170504153639.ubpemqn6pp7go2nt@earth>
 <1494308657-3762-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="saxzttkukk3lm2kh"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60421 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933822AbdEONRF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 May 2017 09:17:05 -0400
Content-Disposition: inline
In-Reply-To: <1494308657-3762-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--saxzttkukk3lm2kh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Tue, May 09, 2017 at 07:44:17AM +0200, Mike Looijmans wrote:
> The LTC3651 reports its status via GPIO lines. This driver translates
> the GPIO levels to battery charger status information via sysfs.
> It relies on devicetree to supply the IO configuration.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> v3: Add "lltc" vendor prefix to DT gpios properties
> v2: Remove unused include
>     Remove last part of license text
>     Use devm_power_supply_register
>     Use "lltc" vendor prefix

Thanks, queued.

-- Sebastian

>  drivers/power/supply/Kconfig           |   7 ++
>  drivers/power/supply/Makefile          |   1 +
>  drivers/power/supply/ltc3651-charger.c | 210 +++++++++++++++++++++++++++=
++++++
>  3 files changed, 218 insertions(+)
>  create mode 100644 drivers/power/supply/ltc3651-charger.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index da92275..77b34e7 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -388,6 +388,13 @@ config CHARGER_MANAGER
>            runtime and in suspend-to-RAM by waking up the system periodic=
ally
>            with help of suspend_again support.
> =20
> +config CHARGER_LTC3651
> +	tristate "LTC3651 charger"
> +	depends on GPIOLIB
> +	help
> +	  Say Y to include support for the LTC3651 battery charger which reports
> +	  its status via GPIO lines.
> +
>  config CHARGER_MAX14577
>  	tristate "Maxim MAX14577/77836 battery charger driver"
>  	depends on MFD_MAX14577
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 39fc733..973c386 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_CHARGER_LP8727)	+=3D lp8727_charger.o
>  obj-$(CONFIG_CHARGER_LP8788)	+=3D lp8788-charger.o
>  obj-$(CONFIG_CHARGER_GPIO)	+=3D gpio-charger.o
>  obj-$(CONFIG_CHARGER_MANAGER)	+=3D charger-manager.o
> +obj-$(CONFIG_CHARGER_LTC3651)	+=3D ltc3651-charger.o
>  obj-$(CONFIG_CHARGER_MAX14577)	+=3D max14577_charger.o
>  obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+=3D max14656_charger_detector.o
>  obj-$(CONFIG_CHARGER_MAX77693)	+=3D max77693_charger.o
> diff --git a/drivers/power/supply/ltc3651-charger.c b/drivers/power/suppl=
y/ltc3651-charger.c
> new file mode 100644
> index 0000000..5f8d5c0
> --- /dev/null
> +++ b/drivers/power/supply/ltc3651-charger.c
> @@ -0,0 +1,210 @@
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
> + */
> +
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
> +
> +struct ltc3651_charger {
> +	struct power_supply *charger;
> +	struct power_supply_desc charger_desc;
> +	struct gpio_desc *acpr_gpio;
> +	struct gpio_desc *fault_gpio;
> +	struct gpio_desc *chrg_gpio;
> +};
> +
> +static irqreturn_t ltc3651_charger_irq(int irq, void *devid)
> +{
> +	struct power_supply *charger =3D devid;
> +
> +	power_supply_changed(charger);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static inline struct ltc3651_charger *psy_to_ltc3651_charger(
> +	struct power_supply *psy)
> +{
> +	return power_supply_get_drvdata(psy);
> +}
> +
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
> +	if (!ltc3651_charger)
> +		return -ENOMEM;
> +
> +	ltc3651_charger->acpr_gpio =3D devm_gpiod_get(&pdev->dev,
> +					"lltc,acpr", GPIOD_IN);
> +	if (IS_ERR(ltc3651_charger->acpr_gpio)) {
> +		ret =3D PTR_ERR(ltc3651_charger->charger);
> +		dev_err(&pdev->dev, "Failed to acquire acpr GPIO: %d\n", ret);
> +		return ret;
> +	}
> +	ltc3651_charger->fault_gpio =3D devm_gpiod_get_optional(&pdev->dev,
> +					"lltc,fault", GPIOD_IN);
> +	if (IS_ERR(ltc3651_charger->fault_gpio)) {
> +		ret =3D PTR_ERR(ltc3651_charger->charger);
> +		dev_err(&pdev->dev, "Failed to acquire fault GPIO: %d\n", ret);
> +		return ret;
> +	}
> +	ltc3651_charger->chrg_gpio =3D devm_gpiod_get_optional(&pdev->dev,
> +					"lltc,chrg", GPIOD_IN);
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
> +	ltc3651_charger->charger =3D devm_power_supply_register(&pdev->dev,
> +						      charger_desc, &psy_cfg);
> +	if (IS_ERR(ltc3651_charger->charger)) {
> +		ret =3D PTR_ERR(ltc3651_charger->charger);
> +		dev_err(&pdev->dev, "Failed to register power supply: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Acquire IRQs for the GPIO pins if possible. If the system does not
> +	 * support IRQs on these pins, userspace will have to poll the sysfs
> +	 * files manually.
> +	 */
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
> +
> +	platform_set_drvdata(pdev, ltc3651_charger);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ltc3651_charger_match[] =3D {
> +	{ .compatible =3D "lltc,ltc3651-charger" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ltc3651_charger_match);
> +
> +static struct platform_driver ltc3651_charger_driver =3D {
> +	.probe =3D ltc3651_charger_probe,
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
> --=20
> 1.9.1
>=20

--saxzttkukk3lm2kh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkZqkoACgkQ2O7X88g7
+pphcxAAmHKje30oc8Yh957B0G2ZB2Shco68OZHzrvZqjSyQ0k1xa8HfJnNealkE
zVCrTHuCf36qOOHZpCO+UYXnP4uKsOCXLpfES6t/UITXNzon2TcLL1p/yyAEkgFH
f+LHQEtYoMx0cVWV32ZjZKFSsKJ5+d10nECfHcS59TVLitxsJXlkPsQRoPXS+l0+
q3WkdfqwGD8efiTwY9H/Q2Cs3pBZx3Mw+di5AuYkFIDpYgqtPchMJdOzqhS/uIBO
Qi3s7dvnoWML26XWl3fSATK1wTL6NabWyHgTwvhWQxzPRVObImkp7nspXWKb2XSc
I3v504s2YpPcV+0GltF+nC3evfgXyvMx8g/P3kUflaTLC+//PX1ShCju1OJjLu2+
VMC4lcjbsC5TY2fya5KJzdNUn836rSXroyAV3ZFWU1t2pChgWPQ2Rjxxqgv2lBqx
13ACvbArBL9dV9AY8gahrcak/3s8H0ZTUBu8lZFZNBSQ7WQA/+Mjci+LsLGSsRBh
Ztm0zbGe2TlZldTr5aHSyKDwawU2tDVGScImGltaRDPlVO+/8nNJ9m4ocXUAi1gc
IrrDUI6b/rUaOv6E0/0uBFGGSh9JoV7Bs0zCPY++J8325Cw0ApXeUdulMfZpBC99
0VfbubjvsOgezo/xG7KWidfIytrSuSQIw4r7PGSGyUTiiDMPamg=
=s6Y9
-----END PGP SIGNATURE-----

--saxzttkukk3lm2kh--
