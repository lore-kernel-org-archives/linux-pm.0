From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 3/5] power: supply: gpio-charger: generic gpio algo
Date: Wed, 17 Jan 2018 21:32:13 +0100
Message-ID: <20180117203213.GD8774@lenoch>
References: <20180117202701.GA8774@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:33078 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbeAQUcP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jan 2018 15:32:15 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23994710AbeAQUcOPrKbE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jan 2018 21:32:14 +0100
Content-Disposition: inline
In-Reply-To: <20180117202701.GA8774@lenoch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>

Just a proof of concept...

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/power/supply/gpio-charger.c | 323 ++++++++++++++++++++++++++----------
 1 file changed, 231 insertions(+), 92 deletions(-)

diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 8660a886162b..11ce5fab27d5 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -23,20 +23,62 @@
 #include <linux/power_supply.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/gpio/consumer.h>
 
 #include <linux/power/gpio-charger.h>
 
-struct gpio_charger {
-	const struct gpio_charger_platform_data *pdata;
-	unsigned int irq;
+struct gpio_charger_pin_map {
+	int val;
+	int res;
+};
+
+#define _VA_NARGS(_1, _2, _3, _4, _5, _6, _7, _8, N, ...) N
+#define VA_NARGS(...)	_VA_NARGS(__VA_ARGS__, 8, 7, 6, 5, 4, 3, 2, 1) / 2
+#define MAP(mask, ...)	mask, VA_NARGS(__VA_ARGS__), \
+			(struct gpio_charger_pin_map[VA_NARGS(__VA_ARGS__)]) \
+			{__VA_ARGS__}
+
+struct gpio_charger_mapping {
+	enum power_supply_property psp;
+	int defres;
+	int mask;
+	int nmaps;
+	struct gpio_charger_pin_map *map;
+};
+
+#define FLAG_PIN_OPTIONAL	0x01
+#define MAPPING(map)		ARRAY_SIZE(map), map
+
+struct gpio_charger_config {
+	int nmaps;
+	struct gpio_charger_mapping *mapping;
+	struct {
+		char *label;
+		int flags;
+	} gpios[];
+};
+
+struct gpio_charger_pin {
+	struct gpio_desc *gpiod;
+	int irq;
 	bool wakeup_enabled;
+};
+
+struct gpio_charger {
+	int gpio_active_low;
 
 	struct power_supply *charger;
 	struct power_supply_desc charger_desc;
-	struct gpio_desc *gpiod;
+
+	int nmaps;
+	struct gpio_charger_mapping *mapping;
+
+	int npins;
+	struct gpio_charger_pin pin[];
 };
 
+
 static irqreturn_t gpio_charger_irq(int irq, void *devid)
 {
 	struct power_supply *charger = devid;
@@ -51,108 +93,124 @@ static inline struct gpio_charger *psy_to_gpio_charger(struct power_supply *psy)
 	return power_supply_get_drvdata(psy);
 }
 
+static inline int gpio_charger_pins_available(struct gpio_charger *charger,
+					struct gpio_charger_mapping *mapping)
+{
+	int i;
+
+	for (i = 0; i < charger->npins; i++)
+		if (!charger->pin[i].gpiod && ((1 << i) & mapping->mask))
+			return 0;
+	return 1;
+}
+
 static int gpio_charger_get_property(struct power_supply *psy,
 		enum power_supply_property psp, union power_supply_propval *val)
 {
+	int i, v, res;
+	struct gpio_charger_pin *pin;
+	struct gpio_charger_mapping *mapping = NULL;
 	struct gpio_charger *gpio_charger = psy_to_gpio_charger(psy);
-	const struct gpio_charger_platform_data *pdata = gpio_charger->pdata;
-
-	switch (psp) {
-	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = gpiod_get_value_cansleep(gpio_charger->gpiod);
-		/* This xor is only ever used with legacy pdata GPIO */
-		val->intval ^= pdata->gpio_active_low;
-		break;
-	default:
+
+	for (i = 0; i < gpio_charger->nmaps; i++) {
+		if (gpio_charger->mapping[i].psp == psp) {
+			mapping = &gpio_charger->mapping[i];
+			break;
+		}
+	}
+
+	if (!mapping)
 		return -EINVAL;
+
+	if (gpio_charger_pins_available(gpio_charger, mapping)) {
+		res = 0;
+		for (i = 0; i < gpio_charger->npins; i++) {
+			pin = &gpio_charger->pin[i];
+			if (((1 << i) & mapping->mask) == 0)
+				continue;
+			v = gpiod_get_value_cansleep(pin->gpiod);
+			if (v < 0)
+				return v;
+			res |= v << i;
+		}
+
+		val->intval = mapping->defres;
+		for (i = 0; i < mapping->nmaps; i++) {
+			if (mapping->map[i].val == res) {
+				val->intval = mapping->map[i].res;
+				break;
+			}
+		}
+	} else {
+			val->intval = mapping->defres;
 	}
 
+	/* Special hack for legacy pdata GPIO */
+	if (psp == POWER_SUPPLY_PROP_ONLINE && gpio_charger->gpio_active_low)
+		val->intval ^= 1;
+
 	return 0;
 }
 
-static enum power_supply_property gpio_charger_properties[] = {
-	POWER_SUPPLY_PROP_ONLINE,
-};
-
-static
-struct gpio_charger_platform_data *gpio_charger_parse_dt(struct device *dev)
+static enum power_supply_type gpio_charger_get_type(struct device *dev)
 {
-	struct device_node *np = dev->of_node;
-	struct gpio_charger_platform_data *pdata;
-	const char *chargetype;
 	int ret;
+	const char *chargetype;
+	enum power_supply_type type = POWER_SUPPLY_TYPE_UNKNOWN;
 
-	if (!np)
-		return ERR_PTR(-ENOENT);
-
-	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return ERR_PTR(-ENOMEM);
-
-	pdata->name = np->name;
-	pdata->type = POWER_SUPPLY_TYPE_UNKNOWN;
-	ret = of_property_read_string(np, "charger-type", &chargetype);
+	ret = of_property_read_string(dev->of_node, "charger-type", &chargetype);
 	if (ret >= 0) {
 		if (!strncmp("unknown", chargetype, 7))
-			pdata->type = POWER_SUPPLY_TYPE_UNKNOWN;
+			type = POWER_SUPPLY_TYPE_UNKNOWN;
 		else if (!strncmp("battery", chargetype, 7))
-			pdata->type = POWER_SUPPLY_TYPE_BATTERY;
+			type = POWER_SUPPLY_TYPE_BATTERY;
 		else if (!strncmp("ups", chargetype, 3))
-			pdata->type = POWER_SUPPLY_TYPE_UPS;
+			type = POWER_SUPPLY_TYPE_UPS;
 		else if (!strncmp("mains", chargetype, 5))
-			pdata->type = POWER_SUPPLY_TYPE_MAINS;
+			type = POWER_SUPPLY_TYPE_MAINS;
 		else if (!strncmp("usb-sdp", chargetype, 7))
-			pdata->type = POWER_SUPPLY_TYPE_USB;
+			type = POWER_SUPPLY_TYPE_USB;
 		else if (!strncmp("usb-dcp", chargetype, 7))
-			pdata->type = POWER_SUPPLY_TYPE_USB_DCP;
+			type = POWER_SUPPLY_TYPE_USB_DCP;
 		else if (!strncmp("usb-cdp", chargetype, 7))
-			pdata->type = POWER_SUPPLY_TYPE_USB_CDP;
+			type = POWER_SUPPLY_TYPE_USB_CDP;
 		else if (!strncmp("usb-aca", chargetype, 7))
-			pdata->type = POWER_SUPPLY_TYPE_USB_ACA;
+			type = POWER_SUPPLY_TYPE_USB_ACA;
 		else
 			dev_warn(dev, "unknown charger type %s\n", chargetype);
 	}
 
-	return pdata;
+	return type;
 }
 
-static int gpio_charger_probe(struct platform_device *pdev)
+static struct gpio_charger_mapping simple_mapping = {
+	POWER_SUPPLY_PROP_ONLINE,
+	0,
+	MAP(0x01, { 0x01, 1 }),
+};
+
+static int gpio_charger_simple_init(struct device *dev,
+			struct gpio_charger *gpio_charger,
+			const struct gpio_charger_platform_data *pdata)
 {
-	struct device *dev = &pdev->dev;
-	const struct gpio_charger_platform_data *pdata = dev->platform_data;
-	struct power_supply_config psy_cfg = {};
-	struct gpio_charger *gpio_charger;
+	int err;
+	struct gpio_desc *gpiod;
 	struct power_supply_desc *charger_desc;
-	int ret;
-	int irq;
-
-	if (!pdata) {
-		pdata = gpio_charger_parse_dt(dev);
-		if (IS_ERR(pdata)) {
-			ret = PTR_ERR(pdata);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "No platform data\n");
-			return ret;
-		}
-	}
-
-	gpio_charger = devm_kzalloc(dev, sizeof(*gpio_charger), GFP_KERNEL);
-	if (!gpio_charger) {
-		dev_err(dev, "Failed to alloc driver structure\n");
-		return -ENOMEM;
-	}
+	static enum power_supply_property properties[] = {
+		POWER_SUPPLY_PROP_ONLINE,
+	};
 
 	/*
 	 * This will fetch a GPIO descriptor from device tree, ACPI or
 	 * boardfile descriptor tables. It's good to try this first.
 	 */
-	gpio_charger->gpiod = devm_gpiod_get(dev, NULL, GPIOD_IN);
+	gpiod = devm_gpiod_get(dev, NULL, GPIOD_IN);
 
 	/*
 	 * If this fails and we're not using device tree, try the
 	 * legacy platform data method.
 	 */
-	if (IS_ERR(gpio_charger->gpiod) && !dev->of_node) {
+	if (IS_ERR(gpiod) && !dev->of_node && pdata) {
 		/* Non-DT: use legacy GPIO numbers */
 		if (!gpio_is_valid(pdata->gpio)) {
 			dev_err(dev, "Invalid gpio pin in pdata\n");
@@ -161,32 +219,97 @@ static int gpio_charger_probe(struct platform_device *pdev)
 		err = devm_gpio_request_one(dev, pdata->gpio, GPIOF_IN,
 						dev_name(dev));
 		if (err) {
-			dev_err(&pdev->dev, "Failed to request gpio pin: %d\n",
-				err);
+			dev_err(dev, "Failed to request gpio pin: %d\n", err);
 			return err;
 		}
 		/* Then convert this to gpiod for now */
-		gpio_charger->gpiod = gpio_to_desc(pdata->gpio);
-	} else if (IS_ERR(gpio_charger->gpiod)) {
+		gpiod = gpio_to_desc(pdata->gpio);
+	} else if (IS_ERR(gpiod)) {
 		/* Just try again if this happens */
-		if (PTR_ERR(gpio_charger->gpiod) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		dev_err(dev, "error getting GPIO descriptor\n");
-		return PTR_ERR(gpio_charger->gpiod);
+		if (PTR_ERR(gpiod) != -EPROBE_DEFER)
+			dev_err(dev, "error getting GPIO descriptor\n");
+		return PTR_ERR(gpiod);
 	}
 
+	gpio_charger->nmaps = 1;
+	gpio_charger->mapping = &simple_mapping;
+	gpio_charger->npins = 1;
+	gpio_charger->pin[0].gpiod = gpiod;
+
 	charger_desc = &gpio_charger->charger_desc;
+	charger_desc->type = POWER_SUPPLY_TYPE_UNKNOWN;
+	charger_desc->properties = properties;
+	charger_desc->num_properties = ARRAY_SIZE(properties);
+
+	if (pdata) {
+		charger_desc->name = pdata->name;
+		charger_desc->type = pdata->type;
+		gpio_charger->gpio_active_low = pdata->gpio_active_low;
+	}
+
+	return 0;
+}
+
+static int gpio_charger_cfg_init(struct device *dev,
+			struct gpio_charger *gpio_charger,
+			struct gpio_charger_config *cfg)
+{
+	return -EINVAL;
+}
+
+static int gpio_charger_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct gpio_charger_platform_data *pdata = dev->platform_data;
+	struct power_supply_config psy_cfg = {};
+	struct gpio_charger_pin *pin;
+	struct gpio_charger *gpio_charger;
+	struct power_supply_desc *charger_desc;
+	struct gpio_charger_config *cfg;
+	int i, ret;
+
+	if (!pdata && !dev->of_node) {
+		dev_err(dev, "No platform data\n");
+		return -ENOENT;
+	}
+
+	i = 1;
+	cfg = (struct gpio_charger_config *)of_device_get_match_data(dev);
+	if (cfg)
+		while (cfg->gpios[i].label)
+			i++;
+
+	gpio_charger = devm_kzalloc(dev, sizeof(struct gpio_charger) +
+					i * sizeof(struct gpio_charger_pin),
+					GFP_KERNEL);
+	if (!gpio_charger) {
+		dev_err(dev, "Failed to alloc driver structure\n");
+		return -ENOMEM;
+	}
+
+	if (cfg)
+		ret = gpio_charger_cfg_init(dev, gpio_charger, cfg);
+	else
+		ret = gpio_charger_simple_init(dev, gpio_charger, pdata);
 
-	charger_desc->name = pdata->name ? pdata->name : "gpio-charger";
-	charger_desc->type = pdata->type;
-	charger_desc->properties = gpio_charger_properties;
-	charger_desc->num_properties = ARRAY_SIZE(gpio_charger_properties);
+	if (ret)
+		return ret;
+
+	charger_desc = &gpio_charger->charger_desc;
 	charger_desc->get_property = gpio_charger_get_property;
+	if (charger_desc->type == POWER_SUPPLY_TYPE_UNKNOWN)
+		charger_desc->type = gpio_charger_get_type(&pdev->dev);
+	if (!charger_desc->name && pdev->dev.of_node)
+		charger_desc->name = pdev->dev.of_node->name;
+	if (!charger_desc->name)
+		charger_desc->name = "gpio-charger";
 
-	psy_cfg.supplied_to = pdata->supplied_to;
-	psy_cfg.num_supplicants = pdata->num_supplicants;
 	psy_cfg.of_node = dev->of_node;
 	psy_cfg.drv_data = gpio_charger;
+	if (pdata) {
+		psy_cfg.supplied_to = pdata->supplied_to;
+		psy_cfg.num_supplicants = pdata->num_supplicants;
+	}
 
 	gpio_charger->charger = devm_power_supply_register(dev, charger_desc,
 							   &psy_cfg);
@@ -196,15 +319,17 @@ static int gpio_charger_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	irq = gpiod_to_irq(gpio_charger->gpiod);
-	if (irq > 0) {
-		ret = devm_request_any_context_irq(dev, irq, gpio_charger_irq,
+	for (i = 0; i < gpio_charger->npins; i++) {
+		pin = &gpio_charger->pin[i];
+		pin->irq = gpiod_to_irq(pin->gpiod);
+		if (pin->irq < 0)
+			continue;
+		ret = devm_request_any_context_irq(dev, pin->irq,
+				gpio_charger_irq,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 				dev_name(dev), gpio_charger->charger);
 		if (ret < 0)
 			dev_warn(dev, "Failed to request irq: %d\n", ret);
-		else
-			gpio_charger->irq = irq;
 	}
 
 	platform_set_drvdata(pdev, gpio_charger);
@@ -217,22 +342,36 @@ static int gpio_charger_probe(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int gpio_charger_suspend(struct device *dev)
 {
+	int i;
+	struct gpio_charger_pin *pin;
 	struct gpio_charger *gpio_charger = dev_get_drvdata(dev);
 
-	if (device_may_wakeup(dev))
-		gpio_charger->wakeup_enabled =
-			!enable_irq_wake(gpio_charger->irq);
+	if (device_may_wakeup(dev)) {
+		for (i = 0; i < gpio_charger->npins; i++) {
+			pin = &gpio_charger->pin[i];
+			if (pin->irq < 0)
+				continue;
+			pin->wakeup_enabled = !enable_irq_wake(pin->irq);
+		}
+	}
 
 	return 0;
 }
 
 static int gpio_charger_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_charger *gpio_charger = platform_get_drvdata(pdev);
+	int i;
+	struct gpio_charger_pin *pin;
+	struct gpio_charger *gpio_charger = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev)) {
+		for (i = 0; i < gpio_charger->npins; i++) {
+			pin = &gpio_charger->pin[i];
+			if (pin->wakeup_enabled)
+				disable_irq_wake(pin->irq);
+		}
+	}
 
-	if (device_may_wakeup(dev) && gpio_charger->wakeup_enabled)
-		disable_irq_wake(gpio_charger->irq);
 	power_supply_changed(gpio_charger->charger);
 
 	return 0;
-- 
2.15.1
