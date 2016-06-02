From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/4] power: axp20x_usb: Add support for usb power-supply on axp22x pmics
Date: Thu,  2 Jun 2016 19:18:53 +0200
Message-ID: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41411 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932088AbcFBRTC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 2 Jun 2016 13:19:02 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

The usb power-supply on the axp22x pmics is mostly identical to the
one on the axp20x pmics. One significant difference is that it cannot
measure / monitor the usb voltage / current.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Use compatible instead of axp20x->variant to detect pmic type
---
 .../bindings/power_supply/axp20x_usb_power.txt     |  3 +-
 drivers/power/axp20x_usb_power.c                   | 92 ++++++++++++++++------
 2 files changed, 71 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt b/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt
index 862f4a4..f1d7bee 100644
--- a/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt
+++ b/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt
@@ -1,7 +1,8 @@
 AXP20x USB power supply
 
 Required Properties:
--compatible: "x-powers,axp202-usb-power-supply"
+-compatible: One of: "x-powers,axp202-usb-power-supply"
+                     "x-powers,axp221-usb-power-supply"
 
 This node is a subnode of the axp20x PMIC.
 
diff --git a/drivers/power/axp20x_usb_power.c b/drivers/power/axp20x_usb_power.c
index 421a90b..6af6feb 100644
--- a/drivers/power/axp20x_usb_power.c
+++ b/drivers/power/axp20x_usb_power.c
@@ -42,6 +42,7 @@
 #define AXP20X_VBUS_MON_VBUS_VALID	BIT(3)
 
 struct axp20x_usb_power {
+	struct device_node *np;
 	struct regmap *regmap;
 	struct power_supply *supply;
 };
@@ -85,7 +86,12 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 
 		switch (v & AXP20X_VBUS_CLIMIT_MASK) {
 		case AXP20X_VBUC_CLIMIT_100mA:
-			val->intval = 100000;
+			if (of_device_is_compatible(power->np,
+					"x-powers,axp202-usb-power-supply")) {
+				val->intval = 100000;
+			} else {
+				val->intval = -1; /* No 100mA limit */
+			}
 			break;
 		case AXP20X_VBUC_CLIMIT_500mA:
 			val->intval = 500000;
@@ -122,16 +128,19 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 			break;
 		}
 
-		ret = regmap_read(power->regmap, AXP20X_USB_OTG_STATUS, &v);
-		if (ret)
-			return ret;
+		val->intval = POWER_SUPPLY_HEALTH_GOOD;
 
-		if (!(v & AXP20X_USB_STATUS_VBUS_VALID)) {
-			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
-			break;
-		}
+		if (of_device_is_compatible(power->np,
+				"x-powers,axp202-usb-power-supply")) {
+			ret = regmap_read(power->regmap,
+					  AXP20X_USB_OTG_STATUS, &v);
+			if (ret)
+				return ret;
 
-		val->intval = POWER_SUPPLY_HEALTH_GOOD;
+			if (!(v & AXP20X_USB_STATUS_VBUS_VALID))
+				val->intval =
+					POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+		}
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval = !!(input & AXP20X_PWR_STATUS_VBUS_PRESENT);
@@ -156,6 +165,14 @@ static enum power_supply_property axp20x_usb_power_properties[] = {
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
 
+static enum power_supply_property axp22x_usb_power_properties[] = {
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+};
+
 static const struct power_supply_desc axp20x_usb_power_desc = {
 	.name = "axp20x-usb",
 	.type = POWER_SUPPLY_TYPE_USB,
@@ -164,13 +181,25 @@ static const struct power_supply_desc axp20x_usb_power_desc = {
 	.get_property = axp20x_usb_power_get_property,
 };
 
+static const struct power_supply_desc axp22x_usb_power_desc = {
+	.name = "axp20x-usb",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.properties = axp22x_usb_power_properties,
+	.num_properties = ARRAY_SIZE(axp22x_usb_power_properties),
+	.get_property = axp20x_usb_power_get_property,
+};
+
 static int axp20x_usb_power_probe(struct platform_device *pdev)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
 	struct power_supply_config psy_cfg = {};
 	struct axp20x_usb_power *power;
-	static const char * const irq_names[] = { "VBUS_PLUGIN",
-		"VBUS_REMOVAL", "VBUS_VALID", "VBUS_NOT_VALID" };
+	static const char * const axp20x_irq_names[] = { "VBUS_PLUGIN",
+		"VBUS_REMOVAL", "VBUS_VALID", "VBUS_NOT_VALID", NULL };
+	static const char * const axp22x_irq_names[] = {
+		"VBUS_PLUGIN", "VBUS_REMOVAL", NULL };
+	static const char * const *irq_names;
+	const struct power_supply_desc *usb_power_desc;
 	int i, irq, ret;
 
 	if (!of_device_is_available(pdev->dev.of_node))
@@ -185,31 +214,47 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (!power)
 		return -ENOMEM;
 
+	power->np = pdev->dev.of_node;
 	power->regmap = axp20x->regmap;
 
-	/* Enable vbus valid checking */
-	ret = regmap_update_bits(power->regmap, AXP20X_VBUS_MON,
-		    AXP20X_VBUS_MON_VBUS_VALID, AXP20X_VBUS_MON_VBUS_VALID);
-	if (ret)
-		return ret;
+	if (of_device_is_compatible(power->np,
+			"x-powers,axp202-usb-power-supply")) {
+		/* Enable vbus valid checking */
+		ret = regmap_update_bits(power->regmap, AXP20X_VBUS_MON,
+					 AXP20X_VBUS_MON_VBUS_VALID,
+					 AXP20X_VBUS_MON_VBUS_VALID);
+		if (ret)
+			return ret;
 
-	/* Enable vbus voltage and current measurement */
-	ret = regmap_update_bits(power->regmap, AXP20X_ADC_EN1,
+		/* Enable vbus voltage and current measurement */
+		ret = regmap_update_bits(power->regmap, AXP20X_ADC_EN1,
 			AXP20X_ADC_EN1_VBUS_CURR | AXP20X_ADC_EN1_VBUS_VOLT,
 			AXP20X_ADC_EN1_VBUS_CURR | AXP20X_ADC_EN1_VBUS_VOLT);
-	if (ret)
-		return ret;
+		if (ret)
+			return ret;
+
+		usb_power_desc = &axp20x_usb_power_desc;
+		irq_names = axp20x_irq_names;
+	} else if (of_device_is_compatible(power->np,
+			"x-powers,axp221-usb-power-supply")) {
+		usb_power_desc = &axp22x_usb_power_desc;
+		irq_names = axp22x_irq_names;
+	} else {
+		dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
+			axp20x->variant);
+		return -EINVAL;
+	}
 
 	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = power;
 
-	power->supply = devm_power_supply_register(&pdev->dev,
-					&axp20x_usb_power_desc, &psy_cfg);
+	power->supply = devm_power_supply_register(&pdev->dev, usb_power_desc,
+						   &psy_cfg);
 	if (IS_ERR(power->supply))
 		return PTR_ERR(power->supply);
 
 	/* Request irqs after registering, as irqs may trigger immediately */
-	for (i = 0; i < ARRAY_SIZE(irq_names); i++) {
+	for (i = 0; irq_names[i]; i++) {
 		irq = platform_get_irq_byname(pdev, irq_names[i]);
 		if (irq < 0) {
 			dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
@@ -229,6 +274,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 
 static const struct of_device_id axp20x_usb_power_match[] = {
 	{ .compatible = "x-powers,axp202-usb-power-supply" },
+	{ .compatible = "x-powers,axp221-usb-power-supply" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, axp20x_usb_power_match);
-- 
2.7.4

