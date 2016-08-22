From: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 5/7] power: act8945a_charger: Add capacity level property
Date: Mon, 22 Aug 2016 14:49:15 +0800
Message-ID: <1471848557-27278-6-git-send-email-wenyou.yang@atmel.com>
References: <1471848557-27278-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471848557-27278-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add the power supply capacity level property, it corresponds to
POWER_SUPPLY_CAPACITY_LEVEL_*.

It also utilizes the precision voltage detector function module
to catch the low battery voltage.

Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---

Changes in v7:
 - For "lbo-gpios", use gpiod_get() to fix devm_gpiod_get() wrong use
   with parent device as *dev argument.
 - Add the handle -EPROBE_DEFER returned from gpiod_get "lbo-gpios".
 - Use dev_info() to print log if the lbo irq request failed.
 - Remove unneeded semicolon.
 - Add depends on GPIOLIB for use gpiod.

Changes in v6:
 - For "lbo-gpios", use gpiod API instead of old gpio API to handle.

Changes in v5: None
Changes in v4:
 - Change devname of devm_request_irq() from "lbo-detect" to
   "act8945a, lbo-detect".

Changes in v3: None
Changes in v2: None

 drivers/power/supply/Kconfig            |   2 +-
 drivers/power/supply/act8945a_charger.c | 110 +++++++++++++++++++++++++++++---
 2 files changed, 102 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 76806a0..a983de2 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -77,7 +77,7 @@ config BATTERY_88PM860X
 
 config BATTERY_ACT8945A
 	tristate "Active-semi ACT8945A charger driver"
-	depends on MFD_ACT8945A || COMPILE_TEST
+	depends on MFD_ACT8945A || GPIOLIB || COMPILE_TEST
 	help
 	  Say Y here to enable support for power supply provided by
 	  Active-semi ActivePath ACT8945A charger.
diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supply/act8945a_charger.c
index 3536b67..cc79abe 100644
--- a/drivers/power/supply/act8945a_charger.c
+++ b/drivers/power/supply/act8945a_charger.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
+#include <linux/gpio/consumer.h>
 
 static const char *act8945a_charger_model = "ACT8945A";
 static const char *act8945a_charger_manufacturer = "Active-semi";
@@ -83,6 +84,7 @@ struct act8945a_charger {
 	struct work_struct work;
 
 	bool init_done;
+	struct gpio_desc *lbo_gpio;
 };
 
 static int act8945a_get_charger_state(struct regmap *regmap, int *val)
@@ -208,11 +210,67 @@ static int act8945a_get_battery_health(struct regmap *regmap, int *val)
 	return 0;
 }
 
+static int act8945a_get_capacity_level(struct act8945a_charger *charger,
+				       struct regmap *regmap, int *val)
+{
+	int ret;
+	unsigned int status, state, config;
+	int lbo_level = gpiod_get_value(charger->lbo_gpio);
+
+	ret = regmap_read(regmap, ACT8945A_APCH_STATUS, &status);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(regmap, ACT8945A_APCH_CFG, &config);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(regmap, ACT8945A_APCH_STATE, &state);
+	if (ret < 0)
+		return ret;
+
+	state &= APCH_STATE_CSTATE;
+	state >>= APCH_STATE_CSTATE_SHIFT;
+
+	switch (state) {
+	case APCH_STATE_CSTATE_PRE:
+		*val = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
+		break;
+	case APCH_STATE_CSTATE_FAST:
+		if (lbo_level)
+			*val = POWER_SUPPLY_CAPACITY_LEVEL_HIGH;
+		else
+			*val = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
+		break;
+	case APCH_STATE_CSTATE_EOC:
+		if (status & APCH_STATUS_CHGDAT)
+			*val = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
+		else
+			*val = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
+		break;
+	case APCH_STATE_CSTATE_DISABLED:
+	default:
+		if (config & APCH_CFG_SUSCHG) {
+			*val = POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
+		} else {
+			*val = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
+			if (!(status & APCH_STATUS_INDAT)) {
+				if (!lbo_level)
+					*val = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
+			}
+		}
+		break;
+	}
+
+	return 0;
+}
+
 static enum power_supply_property act8945a_charger_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
 	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER
 };
@@ -238,6 +296,10 @@ static int act8945a_charger_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_HEALTH:
 		ret = act8945a_get_battery_health(regmap, &val->intval);
 		break;
+	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
+		ret = act8945a_get_capacity_level(charger,
+						  regmap, &val->intval);
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = act8945a_charger_model;
 		break;
@@ -327,7 +389,7 @@ static irqreturn_t act8945a_status_changed(int irq, void *dev_id)
 static int act8945a_charger_config(struct device *dev,
 				   struct act8945a_charger *charger)
 {
-	struct device_node *np = dev->of_node;
+	struct device_node *np = dev->parent->of_node;
 	enum of_gpio_flags flags;
 	struct regmap *regmap = charger->regmap;
 
@@ -354,6 +416,21 @@ static int act8945a_charger_config(struct device *dev,
 		dev_info(dev, "have been suspended\n");
 	}
 
+	charger->lbo_gpio = gpiod_get(dev->parent, "active-semi,lbo", GPIOD_IN);
+	if (PTR_ERR(charger->lbo_gpio) == -EPROBE_DEFER) {
+		dev_info(dev, "probe retry requested for gpio \"lbo\"\n");
+	} else if (IS_ERR(charger->lbo_gpio)) {
+		dev_err(dev, "unable to claim gpio \"lbo\"\n");
+		charger->lbo_gpio = NULL;
+	}
+
+	ret = devm_request_irq(dev, gpiod_to_irq(charger->lbo_gpio),
+			       act8945a_status_changed,
+			       (IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING),
+			       "act8945a_lbo_detect", charger);
+	if (ret)
+		dev_info(dev, "failed to request gpio \"lbo\" IRQ\n");
+
 	chglev_pin = of_get_named_gpio_flags(np,
 				"active-semi,chglev-gpios", 0, &flags);
 
@@ -443,14 +520,15 @@ static int act8945a_charger_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = act8945a_charger_config(pdev->dev.parent, charger);
+	ret = act8945a_charger_config(&pdev->dev, charger);
 	if (ret)
 		return ret;
 
 	irq = of_irq_get(pdev->dev.parent->of_node, 0);
 	if (irq == -EPROBE_DEFER) {
 		dev_err(&pdev->dev, "failed to find IRQ number\n");
-		return -EPROBE_DEFER;
+		ret = -EPROBE_DEFER;
+		goto fail;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, act8945a_status_changed,
@@ -458,7 +536,7 @@ static int act8945a_charger_probe(struct platform_device *pdev)
 			       charger);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request nIRQ pin IRQ\n");
-		return ret;
+		goto fail;
 	}
 
 	charger->desc.name = "act8945a-charger";
@@ -467,8 +545,10 @@ static int act8945a_charger_probe(struct platform_device *pdev)
 	charger->desc.num_properties = ARRAY_SIZE(act8945a_charger_props);
 
 	ret = act8945a_set_supply_type(charger, &charger->desc.type);
-	if (ret)
-		return -EINVAL;
+	if (ret) {
+		ret = -EINVAL;
+		goto fail;
+	}
 
 	psy_cfg.of_node	= pdev->dev.parent->of_node;
 	psy_cfg.drv_data = charger;
@@ -478,7 +558,8 @@ static int act8945a_charger_probe(struct platform_device *pdev)
 						  &psy_cfg);
 	if (IS_ERR(charger->psy)) {
 		dev_err(&pdev->dev, "failed to register power supply\n");
-		return PTR_ERR(charger->psy);
+		ret = PTR_ERR(charger->psy);
+		goto fail;
 	}
 
 	platform_set_drvdata(pdev, charger);
@@ -486,12 +567,20 @@ static int act8945a_charger_probe(struct platform_device *pdev)
 	INIT_WORK(&charger->work, act8945a_work);
 
 	ret = act8945a_enable_interrupt(charger);
-	if (ret)
-		return -EIO;
+	if (ret) {
+		ret = -EIO;
+		goto fail;
+	}
 
 	charger->init_done = true;
 
 	return 0;
+
+fail:
+	if (charger->lbo_gpio)
+		gpiod_put(charger->lbo_gpio);
+
+	return ret;
 }
 
 static int act8945a_charger_remove(struct platform_device *pdev)
@@ -501,6 +590,9 @@ static int act8945a_charger_remove(struct platform_device *pdev)
 	charger->init_done = false;
 	cancel_work_sync(&charger->work);
 
+	if (charger->lbo_gpio)
+		gpiod_put(charger->lbo_gpio);
+
 	return 0;
 }
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
