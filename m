From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v9 1/4] power: act8945a_charger: Add capacity level property
Date: Thu, 1 Sep 2016 17:29:58 +0800
Message-ID: <1472722201-31872-2-git-send-email-wenyou.yang@atmel.com>
References: <1472722201-31872-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472722201-31872-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, Wenyou Yang <wenyou.yang@microchip.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>
List-Id: linux-pm@vger.kernel.org

Add the power supply capacity level property, it corresponds to
POWER_SUPPLY_CAPACITY_LEVEL_*.

It also utilizes the precision voltage detector function module
to catch the low battery voltage.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v9:
 - For "lbo-gpios", use devm_gpiod_get_optional(), instead of
   devm_gpiod_get(), for simpler and more reasonable.
 - Remove unnecessary GPIOLIB dependency.

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

Changes in v4:
 - Change devname of devm_request_irq() from "lbo-detect" to
   "act8945a, lbo-detect".

 drivers/power/supply/act8945a_charger.c | 79 ++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supply/act8945a_charger.c
index 48775f8..2f87599 100644
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
@@ -335,7 +397,7 @@ static int act8945a_charger_config(struct device *dev,
 	u32 pre_time_out;
 	u32 input_voltage_threshold;
 	int chglev_pin;
-	int ret;
+	int err, ret;
 
 	unsigned int tmp;
 	unsigned int value = 0;
@@ -354,6 +416,21 @@ static int act8945a_charger_config(struct device *dev,
 		dev_info(dev, "have been suspended\n");
 	}
 
+	charger->lbo_gpio = devm_gpiod_get_optional(dev, "active-semi,lbo",
+						    GPIOD_IN);
+	if (IS_ERR(charger->lbo_gpio)) {
+		err = PTR_ERR(charger->lbo_gpio);
+		dev_err(dev, "unable to claim gpio \"lbo\": %d\n", err);
+		return err;
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
