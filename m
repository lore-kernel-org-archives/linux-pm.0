From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] power: axp20x_ac: Add support for ac
 power-supply on axp20x and axp22x pmics
Date: Wed, 26 Oct 2016 10:27:20 +0100
Message-ID: <20161026092720.GN8574@dell>
References: <1474129243-10873-1-git-send-email-lyu@micile.com>
Reply-To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDA7X7F2WUEBBXXMYHAAKGQEHFR3ABI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1474129243-10873-1-git-send-email-lyu-U6IdCoVonM7QT0dZR+AlfA@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Lawrence Yu <lyu-U6IdCoVonM7QT0dZR+AlfA@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Sat, 17 Sep 2016, Lawrence Yu wrote:

> Add support for monitoring of ac power supply input.  axp22x is the same
> as axp20x except it can not monitor voltage or current, only presence of
> power.
>=20
> This is mainly a copy of the existing axp20x_usb_power driver modified to
> use the ac power supply registers instead of the usb registers.
>=20
> axp20x tested on a generic A20 tablet.
> axp22x tested on an a33 ga10h-v1.1 tablet.
>=20
> Signed-off-by: Lawrence Yu <lyu-U6IdCoVonM7QT0dZR+AlfA@public.gmane.org>
> ---
>  .../bindings/power_supply/axp20x_ac_power.txt      |  35 ++++
>  arch/arm/boot/dts/axp209.dtsi                      |   5 +
>  arch/arm/boot/dts/axp22x.dtsi                      |   5 +
>  drivers/mfd/axp20x.c                               |  11 ++
>  drivers/power/Makefile                             |   1 +
>  drivers/power/axp20x_ac_power.c                    | 219 +++++++++++++++=
++++++

Please split this patch up per-subsystem.

>  6 files changed, 276 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power_supply/axp20x=
_ac_power.txt
>  create mode 100644 drivers/power/axp20x_ac_power.c
>=20
> diff --git a/Documentation/devicetree/bindings/power_supply/axp20x_ac_pow=
er.txt b/Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt
> new file mode 100644
> index 0000000..d751cdc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt
> @@ -0,0 +1,35 @@
> +AXP20x AC power supply
> +
> +Required Properties:
> +-compatible: One of: "x-powers,axp202-ac-power-supply"
> +                     "x-powers,axp221-ac-power-supply"
> +
> +This node is a subnode of the axp20x PMIC.
> +
> +Example:
> +
> +axp209: pmic@34 {
> +	compatible =3D "x-powers,axp209";
> +	reg =3D <0x34>;
> +	interrupt-parent =3D <&nmi_intc>;
> +	interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> +	interrupt-controller;
> +	#interrupt-cells =3D <1>;
> +
> +	regulators {
> +		x-powers,dcdc-freq =3D <1500>;
> +
> +		vdd_cpu: dcdc2 {
> +			regulator-always-on;
> +			regulator-min-microvolt =3D <1000000>;
> +			regulator-max-microvolt =3D <1450000>;
> +			regulator-name =3D "vdd-cpu";
> +		};
> +
> +		...
> +	};
> +
> +	ac-power-supply: ac-power-supply {
> +		compatible =3D "x-powers,axp202-ac-power-supply";
> +	};
> +};
> diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dts=
i
> index 675bb0f..54e23c6 100644
> --- a/arch/arm/boot/dts/axp209.dtsi
> +++ b/arch/arm/boot/dts/axp209.dtsi
> @@ -97,6 +97,11 @@
>  		};
>  	};
> =20
> +	ac_power_supply: ac_power_supply {
> +		compatible =3D "x-powers,axp202-ac-power-supply";
> +		status =3D "disabled";
> +	};
> +
>  	usb_power_supply: usb_power_supply {
>  		compatible =3D "x-powers,axp202-usb-power-supply";
>  		status =3D "disabled";
> diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dts=
i
> index 458b668..cdd5d4f 100644
> --- a/arch/arm/boot/dts/axp22x.dtsi
> +++ b/arch/arm/boot/dts/axp22x.dtsi
> @@ -148,6 +148,11 @@
>  		};
>  	};
> =20
> +	ac_power_supply: ac_power_supply {
> +		compatible =3D "x-powers,axp221-ac-power-supply";
> +		status =3D "disabled";
> +	};
> +
>  	usb_power_supply: usb_power_supply {
>  		compatible =3D "x-powers,axp221-usb-power-supply";
>  		status =3D "disabled";
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index ba130be..450d1a0 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -162,6 +162,12 @@ static struct resource axp20x_ac_power_supply_resour=
ces[] =3D {
>  	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_OVER_V, "ACIN_OVER_V"),
>  };
> =20
> +static struct resource axp22x_ac_power_supply_resources[] =3D {
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_PLUGIN, "ACIN_PLUGIN"),
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_REMOVAL, "ACIN_REMOVAL"),
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_OVER_V, "ACIN_OVER_V"),
> +};
> +
>  static struct resource axp20x_pek_resources[] =3D {
>  	{
>  		.name	=3D "PEK_DBR",
> @@ -595,6 +601,11 @@ static struct mfd_cell axp22x_cells[] =3D {
>  	}, {
>  		.name			=3D "axp20x-regulator",
>  	}, {
> +		.name		=3D "axp20x-ac-power-supply",
> +		.of_compatible	=3D "x-powers,axp221-ac-power-supply",
> +		.num_resources	=3D ARRAY_SIZE(axp22x_ac_power_supply_resources),
> +		.resources	=3D axp22x_ac_power_supply_resources,
> +	}, {
>  		.name		=3D "axp20x-usb-power-supply",
>  		.of_compatible	=3D "x-powers,axp221-usb-power-supply",
>  		.num_resources	=3D ARRAY_SIZE(axp22x_usb_power_supply_resources),
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index e46b75d..295ec0f 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_GENERIC_ADC_BATTERY)	+=3D generic-adc-batter=
y.o
> =20
>  obj-$(CONFIG_PDA_POWER)		+=3D pda_power.o
>  obj-$(CONFIG_APM_POWER)		+=3D apm_power.o
> +obj-$(CONFIG_AXP20X_POWER)	+=3D axp20x_ac_power.o
>  obj-$(CONFIG_AXP20X_POWER)	+=3D axp20x_usb_power.o
>  obj-$(CONFIG_MAX8925_POWER)	+=3D max8925_power.o
>  obj-$(CONFIG_WM831X_BACKUP)	+=3D wm831x_backup.o
> diff --git a/drivers/power/axp20x_ac_power.c b/drivers/power/axp20x_ac_po=
wer.c
> new file mode 100644
> index 0000000..13bb093
> --- /dev/null
> +++ b/drivers/power/axp20x_ac_power.c
> @@ -0,0 +1,219 @@
> +/*
> + * AXP20x PMIC AC power supply status driver
> + *
> + * Copyright (C) 2015 Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> + * Copyright (C) 2014 Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
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
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/axp20x.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define DRVNAME "axp20x-ac-power-supply"
> +
> +#define AXP20X_PWR_STATUS_ACIN_PRESENT	BIT(7)
> +#define AXP20X_PWR_STATUS_ACIN_USED	BIT(6)
> +#define AXP20X_ADC_EN1_ACIN_CURR	BIT(4)
> +#define AXP20X_ADC_EN1_ACIN_VOLT	BIT(5)
> +
> +struct axp20x_ac_power {
> +	struct device_node *np;
> +	struct regmap *regmap;
> +	struct power_supply *supply;
> +};
> +
> +static irqreturn_t axp20x_ac_power_irq(int irq, void *devid)
> +{
> +	struct axp20x_ac_power *power =3D devid;
> +
> +	power_supply_changed(power->supply);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int axp20x_ac_power_get_property(struct power_supply *psy,
> +	enum power_supply_property psp, union power_supply_propval *val)
> +{
> +	struct axp20x_ac_power *power =3D power_supply_get_drvdata(psy);
> +	unsigned int input;
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret =3D axp20x_read_variable_width(power->regmap,
> +					 AXP20X_ACIN_V_ADC_H, 12);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret * 1700; /* 1 step =3D 1.7 mV */
> +		return 0;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret =3D axp20x_read_variable_width(power->regmap,
> +						 AXP20X_ACIN_I_ADC_H, 12);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret * 625; /* 1 step =3D 0.375 mA */
> +		return 0;
> +	default:
> +		break;
> +	}
> +
> +	/* All the properties below need the input-status reg value */
> +	ret =3D regmap_read(power->regmap, AXP20X_PWR_INPUT_STATUS, &input);
> +	if (ret)
> +		return ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval =3D !!(input & AXP20X_PWR_STATUS_ACIN_PRESENT);
> +		break;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D !!(input & AXP20X_PWR_STATUS_ACIN_USED);
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
> +static enum power_supply_property axp22x_ac_power_properties[] =3D {
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_ONLINE,
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
> +static const struct power_supply_desc axp22x_ac_power_desc =3D {
> +	.name =3D "axp20x-ac",
> +	.type =3D POWER_SUPPLY_TYPE_MAINS,
> +	.properties =3D axp22x_ac_power_properties,
> +	.num_properties =3D ARRAY_SIZE(axp22x_ac_power_properties),
> +	.get_property =3D axp20x_ac_power_get_property,
> +};
> +
> +static int axp20x_ac_power_probe(struct platform_device *pdev)
> +{
> +	struct axp20x_dev *axp20x =3D dev_get_drvdata(pdev->dev.parent);
> +	struct power_supply_config psy_cfg =3D {};
> +	struct axp20x_ac_power *power;
> +	static const char * const axp20x_irq_names[] =3D {
> +		"ACIN_PLUGIN", "ACIN_REMOVAL", NULL };
> +	static const char * const axp22x_irq_names[] =3D {
> +		"ACIN_PLUGIN", "ACIN_REMOVAL", NULL };
> +	static const char * const *irq_names;
> +	const struct power_supply_desc *ac_power_desc;
> +	int i, irq, ret;
> +
> +	if (!of_device_is_available(pdev->dev.of_node))
> +		return -ENODEV;
> +
> +	if (!axp20x) {
> +		dev_err(&pdev->dev, "Parent drvdata not set\n");
> +		return -EINVAL;
> +	}
> +
> +	power =3D devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
> +	if (!power)
> +		return -ENOMEM;
> +
> +	power->np =3D pdev->dev.of_node;
> +	power->regmap =3D axp20x->regmap;
> +
> +	if (of_device_is_compatible(power->np,
> +			"x-powers,axp202-ac-power-supply")) {
> +
> +		/* Enable acin voltage and current measurement */
> +		ret =3D regmap_update_bits(power->regmap, AXP20X_ADC_EN1,
> +			AXP20X_ADC_EN1_ACIN_CURR | AXP20X_ADC_EN1_ACIN_VOLT,
> +			AXP20X_ADC_EN1_ACIN_CURR | AXP20X_ADC_EN1_ACIN_VOLT);
> +		if (ret)
> +			return ret;
> +
> +		ac_power_desc =3D &axp20x_ac_power_desc;
> +		irq_names =3D axp20x_irq_names;
> +	} else if (of_device_is_compatible(power->np,
> +			"x-powers,axp221-ac-power-supply")) {
> +		ac_power_desc =3D &axp22x_ac_power_desc;
> +		irq_names =3D axp22x_irq_names;
> +	} else {
> +		dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
> +			axp20x->variant);
> +		return -EINVAL;
> +	}
> +
> +	psy_cfg.of_node =3D pdev->dev.of_node;
> +	psy_cfg.drv_data =3D power;
> +
> +	power->supply =3D devm_power_supply_register(&pdev->dev, ac_power_desc,
> +						   &psy_cfg);
> +	if (IS_ERR(power->supply))
> +		return PTR_ERR(power->supply);
> +
> +	/* Request irqs after registering, as irqs may trigger immediately */
> +	for (i =3D 0; irq_names[i]; i++) {
> +		irq =3D platform_get_irq_byname(pdev, irq_names[i]);
> +		if (irq < 0) {
> +			dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
> +				 irq_names[i], irq);
> +			continue;
> +		}
> +		irq =3D regmap_irq_get_virq(axp20x->regmap_irqc, irq);
> +		ret =3D devm_request_any_context_irq(&pdev->dev, irq,
> +				axp20x_ac_power_irq, 0, DRVNAME, power);
> +		if (ret < 0)
> +			dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
> +				 irq_names[i], ret);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id axp20x_ac_power_match[] =3D {
> +	{ .compatible =3D "x-powers,axp202-ac-power-supply" },
> +	{ .compatible =3D "x-powers,axp221-ac-power-supply" },
> +	{ }
> +};
> +
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
> +MODULE_AUTHOR("Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>");
> +MODULE_DESCRIPTION("AXP20x PMIC AC power supply status driver");
> +MODULE_LICENSE("GPL");

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
