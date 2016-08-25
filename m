From: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v8 07/11] power: act8945a_charger: Add capacity level property
Date: Thu, 25 Aug 2016 15:19:55 +0800
Message-ID: <1472109599-21915-8-git-send-email-wenyou.yang@atmel.com>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1472109599-21915-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add the power supply capacity level property, it corresponds to
POWER_SUPPLY_CAPACITY_LEVEL_*.

It also utilizes the precision voltage detector function module
to catch the low battery voltage.

Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---

Changes in v8:
 - As the act8945a_charger is regarded as a sub-device, all
   properties can be achieved from its own device node,
   use devm_gpiod_get() properly as well to get "lbo-gpios".
 - Add missing return -EPROBE_DEFER  for "lbo-gpios".

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

 drivers/power/supply/Kconfig            |  2 +-
 drivers/power/supply/act8945a_charger.c | 78 +++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)

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
index 48775f8..b66b023 100644
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
@@ -354,6 +416,22 @@ static int act8945a_charger_config(struct device *dev,
 		dev_info(dev, "have been suspended\n");
 	}
 
+	charger->lbo_gpio = devm_gpiod_get(dev, "active-semi,lbo", GPIOD_IN);
+	if (PTR_ERR(charger->lbo_gpio) == -EPROBE_DEFER) {
+		dev_info(dev, "probe retry requested for gpio \"lbo\"\n");
+		return -EPROBE_DEFER;
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
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
