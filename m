From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/4] power: Add an axp20x-ac-power driver
Date: Mon, 4 Apr 2016 14:38:51 -0700
Message-ID: <20160404213851.GQ4227@lukather>
References: <1459689307-8501-1-git-send-email-haas@computerlinguist.org>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqN4RWvJTb9VNux/"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB7F5RO4AKGQEKODFXEA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1459689307-8501-1-git-send-email-haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--tqN4RWvJTb9VNux/
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 03, 2016 at 03:15:04PM +0200, Michael Haas wrote:
> This adds a driver for the ac power_supply bits of the axp20x
> PMICs.
>=20
> This submission is taken directly from Bruno Pr=C3=A9monts 2015 RFC [0].
> The original RFC contains drivers for AC, battery and backup
> battery. This commit only adds the AC driver for now.
>=20
> My only change to Bruno's axp20x_ac_power.c is the additional
> check on a possible short-circuit between ACIN and VBUS. In this
> case, axp20x-ac-power-supply refuses to attach itself to the device
> and axp20x-usb-power-supply must be used.
>=20
> [0] http://permalink.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/1798=
0
>=20
> Signed-off-by: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
> ---
>  drivers/mfd/axp20x.c            |  11 +++
>  drivers/power/Makefile          |   2 +-
>  drivers/power/axp20x_ac_power.c | 212 ++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 224 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/power/axp20x_ac_power.c
>=20
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index a57d6e9..9351c0e 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -178,6 +178,12 @@ static struct resource axp288_power_button_resources=
[] =3D {
>  	},
>  };
> =20
> +static struct resource axp20x_ac_power_supply_resources[] =3D {
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_PLUGIN, "ACIN_PLUGIN"),
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_REMOVAL, "ACIN_REMOVAL"),
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_OVER_V, "ACIN_OVER_V"),
> +};
> +
>  static struct resource axp288_fuel_gauge_resources[] =3D {
>  	{
>  		.start =3D AXP288_IRQ_QWBTU,
> @@ -440,6 +446,11 @@ static struct mfd_cell axp20x_cells[] =3D {
>  		.of_compatible	=3D "x-powers,axp202-usb-power-supply",
>  		.num_resources	=3D ARRAY_SIZE(axp20x_usb_power_supply_resources),
>  		.resources	=3D axp20x_usb_power_supply_resources,
> +	}, {
> +		.name		=3D "axp20x-ac-power-supply",
> +		.of_compatible	=3D "x-powers,axp202-ac-power-supply",
> +		.num_resources	=3D ARRAY_SIZE(axp20x_ac_power_supply_resources),
> +		.resources	=3D axp20x_ac_power_supply_resources,
>  	},
>  };
>

These changes should be in a separate patch.

> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index e46b75d..3a785cc 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -9,7 +9,7 @@ obj-$(CONFIG_GENERIC_ADC_BATTERY)	+=3D generic-adc-batter=
y.o
> =20
>  obj-$(CONFIG_PDA_POWER)		+=3D pda_power.o
>  obj-$(CONFIG_APM_POWER)		+=3D apm_power.o
> -obj-$(CONFIG_AXP20X_POWER)	+=3D axp20x_usb_power.o
> +obj-$(CONFIG_AXP20X_POWER)	+=3D axp20x_usb_power.o axp20x_ac_power.o
>  obj-$(CONFIG_MAX8925_POWER)	+=3D max8925_power.o
>  obj-$(CONFIG_WM831X_BACKUP)	+=3D wm831x_backup.o
>  obj-$(CONFIG_WM831X_POWER)	+=3D wm831x_power.o
> diff --git a/drivers/power/axp20x_ac_power.c b/drivers/power/axp20x_ac_po=
wer.c
> new file mode 100644
> index 0000000..c5bcbeb
> --- /dev/null
> +++ b/drivers/power/axp20x_ac_power.c
> @@ -0,0 +1,212 @@
> +/*
> + * AXP20x PMIC AC power driver
> + *
> + * Copyright 2014-2015 Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under  the terms of the GNU General  Public License as published by t=
he
> + * Free Software Foundation;  either version 2 of the License, or (at yo=
ur
> + * option) any later version.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/mfd/axp20x.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define DRVNAME "axp20x-ac-power"
> +/* Fields of AXP20X_PWR_INPUT_STATUS */
> +#define AXP20X_PWR_STATUS_AC_PRESENT     BIT(7)
> +#define AXP20X_PWR_STATUS_AC_AVAILABLE   BIT(6)
> +#define AXP20X_PWR_STATUS_AC_VBUS_SHORT  BIT(1)
> +#define AXP20X_PWR_STATUS_AC_VBUS_SEL    BIT(0)
> +
> +/* Fields of AXP20X_ADC_EN1 */
> +#define AXP20X_ADC_EN1_ACIN_VOLT BIT(5)
> +#define AXP20X_ADC_EN1_ACIN_CURR BIT(4)

That should probably be defined in the global header, next to the
registers.

> +struct axp20x_ac_power {
> +	struct regmap *regmap;
> +	struct power_supply *supply;
> +};
> +
> +static int axp20x_ac_power_get_property(struct power_supply *psy,
> +	enum power_supply_property psp, union power_supply_propval *val)

The alignment is supposed to be on the opening parentheses

> +{
> +	struct axp20x_ac_power *power =3D power_supply_get_drvdata(psy);
> +	unsigned int input;
> +	int r;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		r =3D axp20x_read_variable_width(power->regmap,
> +					       AXP20X_ACIN_V_ADC_H, 12);
> +		if (r < 0)
> +			return r;
> +
> +		val->intval =3D r * 1700; /* 1 step =3D 1.7 mV */
> +		return 0;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		r =3D axp20x_read_variable_width(power->regmap,
> +					       AXP20X_ACIN_I_ADC_H, 12);
> +		if (r < 0)
> +			return r;
> +
> +		val->intval =3D r * 375; /* 1 step =3D 0.375 mA */
> +		return 0;
> +	default:
> +		break;
> +	}
> +
> +	/* All the properties below need the input-status reg value */
> +	r =3D regmap_read(power->regmap, AXP20X_PWR_INPUT_STATUS, &input);
> +	if (r)
> +		return r;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval =3D !!(input & AXP20X_PWR_STATUS_AC_PRESENT);
> +		break;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D !!(input & AXP20X_PWR_STATUS_AC_AVAILABLE);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static enum power_supply_property axp20x_ac_power_properties[] =3D {
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +};
> +
> +static const struct power_supply_desc axp20x_ac_power_desc =3D {
> +	.name =3D "axp20x-ac",
> +	.type =3D POWER_SUPPLY_TYPE_MAINS,
> +	.properties =3D axp20x_ac_power_properties,
> +	.num_properties =3D ARRAY_SIZE(axp20x_ac_power_properties),
> +	.get_property =3D axp20x_ac_power_get_property,
> +};
> +
> +static irqreturn_t axp20x_irq_ac_over_v(int irq, void *devid)
> +{
> +	struct axp20x_ac_power *power =3D devid;
> +
> +	dev_warn(&power->supply->dev, "IRQ#%d AC over voltage\n", irq);
> +	power_supply_changed(power->supply);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t axp20x_irq_ac_plugin(int irq, void *devid)
> +{
> +	struct axp20x_ac_power *power =3D devid;
> +
> +	dev_info(&power->supply->dev, "IRQ#%d AC connected\n", irq);
> +	power_supply_changed(power->supply);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t axp20x_irq_ac_removal(int irq, void *devid)
> +{
> +	struct axp20x_ac_power *power =3D devid;
> +
> +	dev_info(&power->supply->dev, "IRQ#%d AC disconnected\n", irq);
> +	power_supply_changed(power->supply);
> +
> +	return IRQ_HANDLED;
> +}

Logging in the interrupt handler is usually a bad idea, for several
reasons:
   - If you have a console, it's going to be output on the console,
     which might take quite some time. And you don't want to take
     quite some time in the interrupt handler.
   - printk might not even work in the interrupt context in some
     scenarios.

Removing that handler, you can register the same interrupt handler on
all the interrupts.

> +static int axp20x_ac_power_probe(struct platform_device *pdev)
> +{
> +	struct axp20x_dev *axp20x =3D dev_get_drvdata(pdev->dev.parent);
> +	struct power_supply_config psy_cfg =3D {};
> +	struct axp20x_ac_power *power;
> +	static const char * const irq_names[] =3D { "ACIN_PLUGIN",
> +		"ACIN_REMOVAL", "ACIN_OVER_V" };
> +	irqreturn_t (*irq_funcs[])(int, void *) =3D { axp20x_irq_ac_plugin,
> +		axp20x_irq_ac_removal, axp20x_irq_ac_over_v };
> +	int i, irq, r, input;
> +
> +	if (!of_device_is_available(pdev->dev.of_node))
> +		return -ENODEV;

That's useless. If the device is not available, you're not going to be
probed in the first place.

> +	power =3D devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
> +	if (!power)
> +		return -ENOMEM;
> +
> +	power->regmap =3D axp20x->regmap;
> +
> +	r =3D regmap_read(power->regmap, AXP20X_PWR_INPUT_STATUS, &input);
> +	if (r < 0)
> +		return r;
> +
> +	if (!!(input & AXP20X_PWR_STATUS_AC_VBUS_SHORT)) {
> +		dev_err(&pdev->dev, "AC is connected to VBUS. Use axp20x_usb_power-sup=
ply driver instead!");
> +		return -ENODEV;
> +	}

Can't that change over time? Can't we support both drivers at the same time=
?

> +	/* Enable ac voltage and current measurement */
> +	r =3D regmap_update_bits(power->regmap, AXP20X_ADC_EN1,
> +			AXP20X_ADC_EN1_ACIN_CURR | AXP20X_ADC_EN1_ACIN_VOLT,
> +			AXP20X_ADC_EN1_ACIN_CURR | AXP20X_ADC_EN1_ACIN_VOLT);
> +	if (r)
> +		return r;
> +
> +	psy_cfg.of_node =3D pdev->dev.of_node;
> +	psy_cfg.drv_data =3D power;
> +
> +	power->supply =3D devm_power_supply_register(&pdev->dev,
> +					&axp20x_ac_power_desc, &psy_cfg);
> +	if (IS_ERR(power->supply))
> +		return PTR_ERR(power->supply);
> +
> +	/* Request irqs after registering, as irqs may trigger immediately */
> +	for (i =3D 0; i < ARRAY_SIZE(irq_names); i++) {
> +		irq =3D platform_get_irq_byname(pdev, irq_names[i]);
> +		if (irq < 0) {
> +			dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
> +				 irq_names[i], irq);
> +			continue;
> +		}
> +		irq =3D regmap_irq_get_virq(axp20x->regmap_irqc, irq);
> +		r =3D devm_request_any_context_irq(&pdev->dev, irq,
> +				irq_funcs[i], 0, DRVNAME, power);
> +		if (r < 0)
> +			dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
> +				 irq_names[i], r);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id axp20x_ac_power_match[] =3D {
> +	{ .compatible =3D "x-powers,axp202-ac-power-supply" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, axp20x_ac_power_match);
> +
> +static struct platform_driver axp20x_ac_power_driver =3D {
> +	.probe =3D axp20x_ac_power_probe,
> +	.driver =3D {
> +		.name =3D DRVNAME,
> +		.of_match_table =3D axp20x_ac_power_match,
> +	},
> +};
> +
> +module_platform_driver(axp20x_ac_power_driver);
> +
> +MODULE_AUTHOR("Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>");
> +MODULE_DESCRIPTION("AXP20x PMIC AC power supply status driver");
> +MODULE_LICENSE("GPL");
> --=20
> 2.8.0

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--tqN4RWvJTb9VNux/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXAt7rAAoJEBx+YmzsjxAgs9AP/2/mKuan0kFbK6DhiLZeyocK
CJ0cz4nrpqbE7ZGiG+Ab+WwqGgqtAjPcX4ipViBXBI64EdKyYGg/pTS4hc91DPmu
EgdGV579NwQo34S1YQ2cCD421MTw0Iq1Kw4yHPYjCQm7JlBXiLoFsKJ8mz7Z34+f
Yzafi7uVfjIbBULWv7gYt+K0NusTMdvk6Iu3TbABYCrNSJt8hah/FJabHynUz9Vu
SaZ+/0H3ciioGn7Eqrq1+2S2aEi9IhGHYHI814BTtgyPKEqBI6/X1oqgcG/mmyvC
dyjEgELhcG0cjbLbiaUa4W0Fs/kbfah/hnlo478RCStP44Kxo8y0GgbzXqIXLRsi
RpJUORKJMzdKLdx7t+zW2hmWgCfpgulWh38K6mBL2uXReNUYw4WYckPefFLQo1aM
2QcoMqmvak08z/NoWXcgqvwtfHvyBJZ/QqIYqKOMUUzKjeogVjsJ/8f88dnQyKDO
uVQoUyUL+qqHY9ZO/+swDIFPI48v/4GAq2OtGV5bfgMaFJX+3T1mfcvgQwPTpeTb
9jTTiVIqgOmLvwps2e8T+PsOOP2QbMPzthNX4LIuvaJ6T89/6ECD+HrHLiQ0s8of
okNzc8deEAw011f31x6lV3FfjlgtjIVNmNUxoI4RfXXTG4aik9crXGJcS+dmEKxx
8WI3pwrOVTU6edHixmRH
=PsO/
-----END PGP SIGNATURE-----

--tqN4RWvJTb9VNux/--
