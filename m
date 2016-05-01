From: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
Subject: [PATCH v2 1/6] power: Add an axp20x-ac-power driver
Date: Sun,  1 May 2016 10:57:22 +0200
Message-ID: <1462093047-7885-2-git-send-email-haas@computerlinguist.org>
References: <1462093047-7885-1-git-send-email-haas@computerlinguist.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462093047-7885-1-git-send-email-haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: degoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This adds a driver for the ac power_supply bits of the axp20x
PMICs.

This submission is taken directly from Bruno Pr=C3=A9monts 2015 RFC [0]=
=2E
The original RFC contains drivers for AC, battery and backup
battery. This commit only adds the AC driver for now.

[0] http://permalink.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/17=
980

Signed-off-by: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
---
 drivers/power/Makefile          |   2 +-
 drivers/power/axp20x_ac_power.c | 169 ++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100644 drivers/power/axp20x_ac_power.c

diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index e46b75d..3a785cc 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_GENERIC_ADC_BATTERY)	+=3D generic-adc-batt=
ery.o
=20
 obj-$(CONFIG_PDA_POWER)		+=3D pda_power.o
 obj-$(CONFIG_APM_POWER)		+=3D apm_power.o
-obj-$(CONFIG_AXP20X_POWER)	+=3D axp20x_usb_power.o
+obj-$(CONFIG_AXP20X_POWER)	+=3D axp20x_usb_power.o axp20x_ac_power.o
 obj-$(CONFIG_MAX8925_POWER)	+=3D max8925_power.o
 obj-$(CONFIG_WM831X_BACKUP)	+=3D wm831x_backup.o
 obj-$(CONFIG_WM831X_POWER)	+=3D wm831x_power.o
diff --git a/drivers/power/axp20x_ac_power.c b/drivers/power/axp20x_ac_=
power.c
new file mode 100644
index 0000000..dcbb1da
--- /dev/null
+++ b/drivers/power/axp20x_ac_power.c
@@ -0,0 +1,169 @@
+/*
+ * AXP20x PMIC AC power driver
+ *
+ * Copyright 2014-2015 Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under  the terms of the GNU General  Public License as published by=
 the
+ * Free Software Foundation;  either version 2 of the License, or (at =
your
+ * option) any later version.
+ */
+
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/mfd/axp20x.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define DRVNAME "axp20x-ac-power"
+
+struct axp20x_ac_power {
+	struct regmap *regmap;
+	struct power_supply *supply;
+};
+
+static int axp20x_ac_power_get_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					union power_supply_propval *val)
+{
+	struct axp20x_ac_power *power =3D power_supply_get_drvdata(psy);
+	unsigned int input;
+	int r;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		r =3D axp20x_read_variable_width(power->regmap,
+					       AXP20X_ACIN_V_ADC_H, 12);
+		if (r < 0)
+			return r;
+
+		val->intval =3D r * 1700; /* 1 step =3D 1.7 mV */
+		return 0;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		r =3D axp20x_read_variable_width(power->regmap,
+					       AXP20X_ACIN_I_ADC_H, 12);
+		if (r < 0)
+			return r;
+
+		val->intval =3D r * 375; /* 1 step =3D 0.375 mA */
+		return 0;
+	default:
+		break;
+	}
+
+	/* All the properties below need the input-status reg value */
+	r =3D regmap_read(power->regmap, AXP20X_PWR_INPUT_STATUS, &input);
+	if (r)
+		return r;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval =3D !!(input & AXP20X_PWR_STATUS_AC_PRESENT);
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval =3D !!(input & AXP20X_PWR_STATUS_AC_AVAILABLE);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static enum power_supply_property axp20x_ac_power_properties[] =3D {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+};
+
+static const struct power_supply_desc axp20x_ac_power_desc =3D {
+	.name =3D "axp20x-ac",
+	.type =3D POWER_SUPPLY_TYPE_MAINS,
+	.properties =3D axp20x_ac_power_properties,
+	.num_properties =3D ARRAY_SIZE(axp20x_ac_power_properties),
+	.get_property =3D axp20x_ac_power_get_property,
+};
+
+static irqreturn_t axp20x_irq_ac_handler(int irq, void *devid)
+{
+	struct axp20x_ac_power *power =3D devid;
+
+	power_supply_changed(power->supply);
+
+	return IRQ_HANDLED;
+}
+
+static int axp20x_ac_power_probe(struct platform_device *pdev)
+{
+	struct axp20x_dev *axp20x =3D dev_get_drvdata(pdev->dev.parent);
+	struct power_supply_config psy_cfg =3D {};
+	struct axp20x_ac_power *power;
+	static const char * const irq_names[] =3D { "ACIN_PLUGIN",
+		"ACIN_REMOVAL", "ACIN_OVER_V" };
+	int i, irq, r;
+
+	power =3D devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
+	if (!power)
+		return -ENOMEM;
+
+	power->regmap =3D axp20x->regmap;
+
+	/* Enable ac voltage and current measurement */
+	r =3D regmap_update_bits(power->regmap, AXP20X_ADC_EN1,
+			AXP20X_ADC_EN1_ACIN_CURR | AXP20X_ADC_EN1_ACIN_VOLT,
+			AXP20X_ADC_EN1_ACIN_CURR | AXP20X_ADC_EN1_ACIN_VOLT);
+	if (r)
+		return r;
+
+	psy_cfg.of_node =3D pdev->dev.of_node;
+	psy_cfg.drv_data =3D power;
+
+	power->supply =3D devm_power_supply_register(&pdev->dev,
+					&axp20x_ac_power_desc, &psy_cfg);
+	if (IS_ERR(power->supply))
+		return PTR_ERR(power->supply);
+
+	/* Request irqs after registering, as irqs may trigger immediately */
+	for (i =3D 0; i < ARRAY_SIZE(irq_names); i++) {
+		irq =3D platform_get_irq_byname(pdev, irq_names[i]);
+		if (irq < 0) {
+			dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
+				 irq_names[i], irq);
+			continue;
+		}
+		irq =3D regmap_irq_get_virq(axp20x->regmap_irqc, irq);
+		r =3D devm_request_any_context_irq(&pdev->dev, irq,
+				axp20x_irq_ac_handler, 0, DRVNAME, power);
+		if (r < 0)
+			dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
+				 irq_names[i], r);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id axp20x_ac_power_match[] =3D {
+	{ .compatible =3D "x-powers,axp202-ac-power-supply" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, axp20x_ac_power_match);
+
+static struct platform_driver axp20x_ac_power_driver =3D {
+	.probe =3D axp20x_ac_power_probe,
+	.driver =3D {
+		.name =3D DRVNAME,
+		.of_match_table =3D axp20x_ac_power_match,
+	},
+};
+
+module_platform_driver(axp20x_ac_power_driver);
+
+MODULE_AUTHOR("Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>");
+MODULE_DESCRIPTION("AXP20x PMIC AC power supply status driver");
+MODULE_LICENSE("GPL");
--=20
2.8.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
