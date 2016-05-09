From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v4 1/4] power: Add an axp20x-ac-power driver
Date: Tue, 10 May 2016 00:33:01 +0800
Message-ID: <CAGb2v674DpbHHx-ra6N4QMVDPfGbT30rn8hPt=X-f1no7jM4Xg@mail.gmail.com>
References: <1462511991-1911-1-git-send-email-haas@computerlinguist.org> <1462511991-1911-2-git-send-email-haas@computerlinguist.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:34466 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbcEIQd2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2016 12:33:28 -0400
In-Reply-To: <1462511991-1911-2-git-send-email-haas@computerlinguist.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Haas <haas@computerlinguist.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Hans De Goede <hdegoede@redhat.com>, =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, devicetree <devicetree@vger.kernel.org>, linux-pm@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-sunxi <linux-sunxi@googlegroups.com>

On Fri, May 6, 2016 at 1:19 PM, Michael Haas <haas@computerlinguist.org=
> wrote:
> This adds a driver for the ac power_supply bits of the axp20x
> PMICs.
>
> This submission is taken directly from Bruno Pr=C3=A9monts 2015 RFC [=
0].
> The original RFC contains drivers for AC, battery and backup
> battery. This commit only adds the AC driver for now.
>
> [0] http://permalink.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/=
17980
>
> Signed-off-by: Michael Haas <haas@computerlinguist.org>
> ---
>  drivers/power/Makefile          |   2 +-
>  drivers/power/axp20x_ac_power.c | 181 ++++++++++++++++++++++++++++++=
++++++++++
>  2 files changed, 182 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/power/axp20x_ac_power.c
>
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index e46b75d..3a785cc 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -9,7 +9,7 @@ obj-$(CONFIG_GENERIC_ADC_BATTERY)       +=3D generic-=
adc-battery.o
>
>  obj-$(CONFIG_PDA_POWER)                +=3D pda_power.o
>  obj-$(CONFIG_APM_POWER)                +=3D apm_power.o
> -obj-$(CONFIG_AXP20X_POWER)     +=3D axp20x_usb_power.o
> +obj-$(CONFIG_AXP20X_POWER)     +=3D axp20x_usb_power.o axp20x_ac_pow=
er.o

Sort the file names please.

>  obj-$(CONFIG_MAX8925_POWER)    +=3D max8925_power.o
>  obj-$(CONFIG_WM831X_BACKUP)    +=3D wm831x_backup.o
>  obj-$(CONFIG_WM831X_POWER)     +=3D wm831x_power.o
> diff --git a/drivers/power/axp20x_ac_power.c b/drivers/power/axp20x_a=
c_power.c
> new file mode 100644
> index 0000000..0d1ca0e
> --- /dev/null
> +++ b/drivers/power/axp20x_ac_power.c
> @@ -0,0 +1,181 @@
> +/*
> + * AXP20x PMIC AC power driver
> + *
> + * Copyright 2014-2015 Bruno Pr=C3=A9mont <bonbons@linux-vserver.org=
>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under  the terms of the GNU General  Public License as published =
by the
> + * Free Software Foundation;  either version 2 of the License, or (a=
t your
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
> +
> +
> +/* Fields of AXP20X_PWR_INPUT_STATUS */
> +#define AXP20X_PWR_STATUS_AC_PRESENT     BIT(7)
> +#define AXP20X_PWR_STATUS_AC_AVAILABLE   BIT(6)

> +#define AXP20X_PWR_STATUS_AC_VBUS_SHORT  BIT(1)
> +#define AXP20X_PWR_STATUS_AC_VBUS_SEL    BIT(0)

These 2 aren't used anymore. Please remove them.

> +
> +/* Fields of AXP20X_ADC_EN1 */
> +#define AXP20X_ADC_EN1_ACIN_VOLT BIT(5)
> +#define AXP20X_ADC_EN1_ACIN_CURR BIT(4)
> +
> +
> +struct axp20x_ac_power {
> +       struct regmap *regmap;
> +       struct power_supply *supply;
> +};
> +
> +static int axp20x_ac_power_get_property(struct power_supply *psy,
> +                                       enum power_supply_property ps=
p,
> +                                       union power_supply_propval *v=
al)
> +{
> +       struct axp20x_ac_power *power =3D power_supply_get_drvdata(ps=
y);
> +       unsigned int input;
> +       int r;
> +
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +               r =3D axp20x_read_variable_width(power->regmap,
> +                                              AXP20X_ACIN_V_ADC_H, 1=
2);
> +               if (r < 0)
> +                       return r;
> +
> +               val->intval =3D r * 1700; /* 1 step =3D 1.7 mV */
> +               return 0;
> +       case POWER_SUPPLY_PROP_CURRENT_NOW:
> +               r =3D axp20x_read_variable_width(power->regmap,
> +                                              AXP20X_ACIN_I_ADC_H, 1=
2);
> +               if (r < 0)
> +                       return r;
> +
> +               val->intval =3D r * 375; /* 1 step =3D 0.375 mA */

The step for ACIN is 0.625 mA. 0.375 is for VBUS.

> +               return 0;
> +       default:
> +               break;
> +       }
> +
> +       /* All the properties below need the input-status reg value *=
/
> +       r =3D regmap_read(power->regmap, AXP20X_PWR_INPUT_STATUS, &in=
put);
> +       if (r)
> +               return r;
> +
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_PRESENT:
> +               val->intval =3D !!(input & AXP20X_PWR_STATUS_AC_PRESE=
NT);
> +               break;
> +       case POWER_SUPPLY_PROP_ONLINE:
> +               val->intval =3D !!(input & AXP20X_PWR_STATUS_AC_AVAIL=
ABLE);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static enum power_supply_property axp20x_ac_power_properties[] =3D {
> +       POWER_SUPPLY_PROP_PRESENT,
> +       POWER_SUPPLY_PROP_ONLINE,
> +       POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +       POWER_SUPPLY_PROP_CURRENT_NOW,
> +};
> +
> +static const struct power_supply_desc axp20x_ac_power_desc =3D {
> +       .name =3D "axp20x-ac",
> +       .type =3D POWER_SUPPLY_TYPE_MAINS,
> +       .properties =3D axp20x_ac_power_properties,
> +       .num_properties =3D ARRAY_SIZE(axp20x_ac_power_properties),
> +       .get_property =3D axp20x_ac_power_get_property,
> +};
> +
> +static irqreturn_t axp20x_irq_ac_handler(int irq, void *devid)
> +{
> +       struct axp20x_ac_power *power =3D devid;
> +
> +       power_supply_changed(power->supply);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int axp20x_ac_power_probe(struct platform_device *pdev)
> +{
> +       struct axp20x_dev *axp20x =3D dev_get_drvdata(pdev->dev.paren=
t);
> +       struct power_supply_config psy_cfg =3D {};
> +       struct axp20x_ac_power *power;
> +       static const char * const irq_names[] =3D { "ACIN_PLUGIN",
> +               "ACIN_REMOVAL", "ACIN_OVER_V" };
> +       int i, irq, r;
> +
> +       power =3D devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL=
);
> +       if (!power)
> +               return -ENOMEM;
> +
> +       power->regmap =3D axp20x->regmap;
> +
> +       /* Enable ac voltage and current measurement */
> +       r =3D regmap_update_bits(power->regmap, AXP20X_ADC_EN1,
> +                       AXP20X_ADC_EN1_ACIN_CURR | AXP20X_ADC_EN1_ACI=
N_VOLT,
> +                       AXP20X_ADC_EN1_ACIN_CURR | AXP20X_ADC_EN1_ACI=
N_VOLT);
> +       if (r)
> +               return r;
> +
> +       psy_cfg.of_node =3D pdev->dev.of_node;
> +       psy_cfg.drv_data =3D power;
> +
> +       power->supply =3D devm_power_supply_register(&pdev->dev,
> +                                       &axp20x_ac_power_desc, &psy_c=
fg);
> +       if (IS_ERR(power->supply))
> +               return PTR_ERR(power->supply);
> +
> +       /* Request irqs after registering, as irqs may trigger immedi=
ately */
> +       for (i =3D 0; i < ARRAY_SIZE(irq_names); i++) {
> +               irq =3D platform_get_irq_byname(pdev, irq_names[i]);
> +               if (irq < 0) {
> +                       dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
> +                                irq_names[i], irq);
> +                       continue;
> +               }
> +               irq =3D regmap_irq_get_virq(axp20x->regmap_irqc, irq)=
;
> +               r =3D devm_request_any_context_irq(&pdev->dev, irq,
> +                               axp20x_irq_ac_handler, 0, DRVNAME, po=
wer);
> +               if (r < 0)
> +                       dev_warn(&pdev->dev, "Error requesting %s IRQ=
: %d\n",
> +                                irq_names[i], r);

Won't missing IRQs hinder the usage of this driver / hardware?
A power supply isn't much use if the system isn't told when
it's gone.


Regards
ChenYu

> +       }
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id axp20x_ac_power_match[] =3D {
> +       { .compatible =3D "x-powers,axp202-ac-power-supply" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, axp20x_ac_power_match);
> +
> +static struct platform_driver axp20x_ac_power_driver =3D {
> +       .probe =3D axp20x_ac_power_probe,
> +       .driver =3D {
> +               .name =3D DRVNAME,
> +               .of_match_table =3D axp20x_ac_power_match,
> +       },
> +};
> +
> +module_platform_driver(axp20x_ac_power_driver);
> +
> +MODULE_AUTHOR("Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>");
> +MODULE_DESCRIPTION("AXP20x PMIC AC power supply status driver");
> +MODULE_LICENSE("GPL");
> --
> 2.8.2
>
