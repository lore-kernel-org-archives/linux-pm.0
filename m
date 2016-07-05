From: Michael Haas <michael.haas-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 2/4] power: add axp20x-battery driver
Date: Tue, 5 Jul 2016 07:26:21 +0200
Message-ID: <577B44FD.6040404@mailbox.org>
References: <20160701092926.32005-1-icenowy@aosc.xyz>
 <20160701092926.32005-2-icenowy@aosc.xyz>
Reply-To: michael.haas-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDQKZI7DR4PRBIEK5W5QKGQEWKJPWAI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160701092926.32005-2-icenowy-ymACFijhrKM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: icenowy-ymACFijhrKM@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

nice work! Is this in any way related to Bruno Pr=C3=A9monts driver for the=
=20
axp20x?

I've got a reworked version of that lying around, but it's not quite=20
ready for submission. Do you know what pieces are missing in your driver=20
for axp20x support - as opposed to axp22x, which is already working?

Michael

On 01.07.2016 11:29, Icenowy Zheng wrote:
> This driver is the battery power supply driver of axp20x PMIC. Currently
> it supports only AXP22x variants.
>
> Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
> ---
>   drivers/mfd/axp20x.c           |  14 +++
>   drivers/power/Makefile         |   1 +
>   drivers/power/axp20x_battery.c | 254 ++++++++++++++++++++++++++++++++++=
+++++++
>   3 files changed, 269 insertions(+)
>   create mode 100644 drivers/power/axp20x_battery.c
>
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index cee5288..064e5015 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -166,6 +166,15 @@ static struct resource axp22x_usb_power_supply_resou=
rces[] =3D {
>   	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
>   };
>  =20
> +static struct resource axp22x_battery_resources[] =3D {
> +	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_BATT_PLUGIN, "BATT_PLUGIN"),
> +	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_BATT_REMOVAL, "BATT_REMOVAL"),
> +	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_BATT_ENT_ACT_MODE, "BATT_ENT_ACT_MODE")=
,
> +	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_BATT_EXIT_ACT_MODE, "BATT_EXIT_ACT_MODE=
"),
> +	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_CHARG, "CHARG"),
> +	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_CHARG_DONE, "CHARG_DONE"),
> +};
> +
>   static struct resource axp22x_pek_resources[] =3D {
>   	{
>   		.name   =3D "PEK_DBR",
> @@ -538,6 +547,11 @@ static struct mfd_cell axp22x_cells[] =3D {
>   		.of_compatible	=3D "x-powers,axp202-usb-power-supply",
>   		.num_resources	=3D ARRAY_SIZE(axp22x_usb_power_supply_resources),
>   		.resources	=3D axp22x_usb_power_supply_resources,
> +	}, {
> +		.name		=3D "axp20x-battery",
> +		.of_compatible	=3D "x-powers,axp202-battery",
> +		.num_resources	=3D ARRAY_SIZE(axp22x_battery_resources),
> +		.resources	=3D axp22x_battery_resources,
>   	},
>   };
>  =20
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index e46b75d..1452d23 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_GENERIC_ADC_BATTERY)	+=3D generic-adc-batt=
ery.o
>   obj-$(CONFIG_PDA_POWER)		+=3D pda_power.o
>   obj-$(CONFIG_APM_POWER)		+=3D apm_power.o
>   obj-$(CONFIG_AXP20X_POWER)	+=3D axp20x_usb_power.o
> +obj-$(CONFIG_AXP20X_POWER)	+=3D axp20x_battery.o
>   obj-$(CONFIG_MAX8925_POWER)	+=3D max8925_power.o
>   obj-$(CONFIG_WM831X_BACKUP)	+=3D wm831x_backup.o
>   obj-$(CONFIG_WM831X_POWER)	+=3D wm831x_power.o
> diff --git a/drivers/power/axp20x_battery.c b/drivers/power/axp20x_batter=
y.c
> new file mode 100644
> index 0000000..8fac2cd
> --- /dev/null
> +++ b/drivers/power/axp20x_battery.c
> @@ -0,0 +1,254 @@
> +/*
> + * AXP20x PMIC battery status driver
> + *
> + * Copyright (C) 2016 Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
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
> +#define DRVNAME "axp20x-battery"
> +
> +#define AXP20X_PWR_STATUS_ACIN_USED BIT(6)
> +#define AXP20X_PWR_STATUS_VBUS_USED BIT(4)
> +#define AXP20X_PWR_STATUS_BAT_DIRECTION BIT(2)
> +
> +#define AXP20X_OP_MODE_CHARGING BIT(6)
> +#define AXP20X_OP_MODE_BATTERY_PRESENT BIT(5)
> +#define AXP20X_OP_MODE_BATTERY_ACTIVE BIT(3)
> +
> +#define AXP20X_CAPACITY_CORRECT BIT(7)
> +
> +struct axp20x_battery {
> +	struct axp20x_dev *axp20x;
> +	struct regmap *regmap;
> +	struct power_supply *supply;
> +};
> +
> +static irqreturn_t axp20x_battery_irq(int irq, void *devid)
> +{
> +	struct axp20x_battery *power =3D devid;
> +
> +	power_supply_changed(power->supply);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int axp20x_battery_get_property(struct power_supply *psy,
> +	enum power_supply_property psp, union power_supply_propval *val)
> +{
> +	struct axp20x_battery *power =3D power_supply_get_drvdata(psy);
> +	unsigned int input, op_mode, capacity, dh, dl;
> +	int ret, ext;
> +
> +	/* All the properties below need the input-status reg value */
> +	ret =3D regmap_read(power->regmap, AXP20X_PWR_INPUT_STATUS, &input);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(power->regmap, AXP20X_PWR_OP_MODE, &op_mode);
> +	if (ret)
> +		return ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		if (!(op_mode & AXP20X_OP_MODE_BATTERY_PRESENT)) {
> +			val->intval =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> +			break;
> +		}
> +
> +		val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
> +
> +		if (op_mode & AXP20X_OP_MODE_BATTERY_ACTIVE) {
> +			/* AXP20X is now trying to re-activate the battery */
> +			val->intval =3D POWER_SUPPLY_HEALTH_DEAD;
> +			break;
> +		}
> +		break;
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval =3D !!(op_mode & AXP20X_OP_MODE_BATTERY_PRESENT);
> +		break;
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		ret =3D regmap_read(power->regmap, AXP20X_FG_RES, &capacity);
> +		if (ret)
> +			return ret;
> +		if (capacity & AXP20X_CAPACITY_CORRECT)
> +			val->intval =3D capacity & (~AXP20X_CAPACITY_CORRECT);
> +		else
> +			return -EIO;
> +		/* from axp_capchange function of Allwinner 3.4 driver */
> +		if (val->intval =3D=3D 127)
> +			val->intval =3D 100;
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		if (!(op_mode & AXP20X_OP_MODE_BATTERY_PRESENT)) {
> +			val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +			break;
> +		}
> +
> +		ret =3D regmap_read(power->regmap, AXP20X_FG_RES, &capacity);
> +		if (ret)
> +			return ret;
> +
> +		ext =3D (input & AXP20X_PWR_STATUS_ACIN_USED) ||
> +		      (input & AXP20X_PWR_STATUS_VBUS_USED);
> +
> +		if (op_mode & AXP20X_OP_MODE_CHARGING)
> +			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +		else if (!(input & AXP20X_PWR_STATUS_BAT_DIRECTION) && !ext)
> +			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		else if (capacity =3D=3D (100 | AXP20X_CAPACITY_CORRECT) ||
> +			 capacity =3D=3D (127 | AXP20X_CAPACITY_CORRECT))
> +			val->intval =3D POWER_SUPPLY_STATUS_FULL;
> +		else
> +			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret =3D regmap_read(power->regmap, AXP20X_BATT_DISCHRG_I_H, &dh);
> +		if (ret)
> +			return ret;
> +		ret =3D regmap_read(power->regmap, AXP20X_BATT_DISCHRG_I_L, &dl);
> +		if (ret)
> +			return ret;
> +		/* it's a 12 bit integer, high 8-bit is stored in dh */
> +		val->intval =3D dh << 4 | dl >> 4;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret =3D regmap_read(power->regmap, AXP20X_BATT_V_H, &dh);
> +		if (ret)
> +			return ret;
> +		ret =3D regmap_read(power->regmap, AXP20X_BATT_V_L, &dl);
> +		if (ret)
> +			return ret;
> +		/* it's a 12 bit integer, high 8-bit is stored in dh */
> +		val->intval =3D dh << 4 | dl >> 4;
> +		/* The formula below is from axp22_vbat_to_mV function
> +		 * of Allwinner 3.4 kernel.
> +		 */
> +		val->intval =3D val->intval * 1100 / 1000;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static enum power_supply_property axp22x_battery_properties[] =3D {
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +};
> +
> +static const struct power_supply_desc axp22x_battery_desc =3D {
> +	.name =3D "axp20x-battery",
> +	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties =3D axp22x_battery_properties,
> +	.num_properties =3D ARRAY_SIZE(axp22x_battery_properties),
> +	.get_property =3D axp20x_battery_get_property,
> +};
> +
> +static int axp20x_battery_probe(struct platform_device *pdev)
> +{
> +	struct axp20x_dev *axp20x =3D dev_get_drvdata(pdev->dev.parent);
> +	struct power_supply_config psy_cfg =3D {};
> +	struct axp20x_battery *power;
> +	static const char * const axp22x_irq_names[] =3D {
> +		"BATT_PLUGIN", "BATT_REMOVAL", "BATT_ENT_ACT_MODE",
> +		"BATT_EXIT_ACT_MODE", "CHARG", "CHARG_DONE", NULL };
> +	static const char * const *irq_names;
> +	const struct power_supply_desc *battery_desc;
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
> +	power->axp20x =3D axp20x;
> +	power->regmap =3D axp20x->regmap;
> +
> +	switch (power->axp20x->variant) {
> +	case AXP221_ID:
> +	case AXP223_ID:
> +		battery_desc =3D &axp22x_battery_desc;
> +		irq_names =3D axp22x_irq_names;
> +		break;
> +	default:
> +		dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
> +			axp20x->variant);
> +		return -EINVAL;
> +	}
> +
> +	psy_cfg.of_node =3D pdev->dev.of_node;
> +	psy_cfg.drv_data =3D power;
> +
> +	power->supply =3D devm_power_supply_register(&pdev->dev, battery_desc,
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
> +				axp20x_battery_irq, 0, DRVNAME, power);
> +		if (ret < 0)
> +			dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
> +				 irq_names[i], ret);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id axp20x_battery_match[] =3D {
> +	{ .compatible =3D "x-powers,axp202-battery" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, axp20x_battery_match);
> +
> +static struct platform_driver axp20x_battery_driver =3D {
> +	.probe =3D axp20x_battery_probe,
> +	.driver =3D {
> +		.name =3D DRVNAME,
> +		.of_match_table =3D axp20x_battery_match,
> +	},
> +};
> +
> +module_platform_driver(axp20x_battery_driver);
> +
> +MODULE_AUTHOR("Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>");
> +MODULE_DESCRIPTION("AXP20x PMIC battery status driver");
> +MODULE_LICENSE("GPL");

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
