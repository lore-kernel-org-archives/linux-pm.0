From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v7 6/7] power: act8945a_charger: Add max current property
Date: Mon, 22 Aug 2016 14:49:16 +0800
Message-ID: <1471848557-27278-7-git-send-email-wenyou.yang@atmel.com>
References: <1471848557-27278-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471848557-27278-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>
List-Id: linux-pm@vger.kernel.org

Add the power supply's current max property,
POWER_SUPPLY_PROP_CURRENT_MAX.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v7:
 - For "chglev-gpios", use gpiod_get() to fix devm_gpiod_get() wrong use
   with parent device as *dev argument.
 - Add the handle -EPROBE_DEFER returned from gpiod_get "chglev_gpio".
 - Remove unneeded semicolon.

Changes in v6:
 - For "chglev-gpios", use gpiod API instead of old gpio API to handle.

Changes in v5: None
Changes in v4:
 - Fix wrong gpio assignment for chglev_pin.

Changes in v3: None
Changes in v2: None

 drivers/power/supply/act8945a_charger.c | 93 +++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supply/act8945a_charger.c
index cc79abe..a40526c 100644
--- a/drivers/power/supply/act8945a_charger.c
+++ b/drivers/power/supply/act8945a_charger.c
@@ -13,7 +13,6 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
@@ -85,6 +84,7 @@ struct act8945a_charger {
 
 	bool init_done;
 	struct gpio_desc *lbo_gpio;
+	struct gpio_desc *chglev_gpio;
 };
 
 static int act8945a_get_charger_state(struct regmap *regmap, int *val)
@@ -265,12 +265,80 @@ static int act8945a_get_capacity_level(struct act8945a_charger *charger,
 	return 0;
 }
 
+#define MAX_CURRENT_USB_HIGH	450000
+#define MAX_CURRENT_USB_LOW	90000
+#define MAX_CURRENT_USB_PRE	45000
+/*
+ * Riset(K) = 2336 * (1V/Ichg(mA)) - 0.205
+ * Riset = 2.43K
+ */
+#define MAX_CURRENT_AC_HIGH		886527
+#define MAX_CURRENT_AC_LOW		117305
+#define MAX_CURRENT_AC_HIGH_PRE		88653
+#define MAX_CURRENT_AC_LOW_PRE		11731
+
+static int act8945a_get_current_max(struct act8945a_charger *charger,
+				    struct regmap *regmap, int *val)
+{
+	int ret;
+	unsigned int status, state;
+	unsigned int acin_state;
+	int chgin_level = gpiod_get_value(charger->chglev_gpio);
+
+	ret = regmap_read(regmap, ACT8945A_APCH_STATUS, &status);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(regmap, ACT8945A_APCH_STATE, &state);
+	if (ret < 0)
+		return ret;
+
+	acin_state = (state & APCH_STATE_ACINSTAT) >> 1;
+
+	state &= APCH_STATE_CSTATE;
+	state >>= APCH_STATE_CSTATE_SHIFT;
+
+	switch (state) {
+	case APCH_STATE_CSTATE_PRE:
+		if (acin_state) {
+			if (chgin_level)
+				*val = MAX_CURRENT_AC_HIGH_PRE;
+			else
+				*val = MAX_CURRENT_AC_LOW_PRE;
+		} else {
+			*val = MAX_CURRENT_USB_PRE;
+		}
+		break;
+	case APCH_STATE_CSTATE_FAST:
+		if (acin_state) {
+			if (chgin_level)
+				*val = MAX_CURRENT_AC_HIGH;
+			else
+				*val = MAX_CURRENT_AC_LOW;
+		} else {
+			if (chgin_level)
+				*val = MAX_CURRENT_USB_HIGH;
+			else
+				*val = MAX_CURRENT_USB_LOW;
+		}
+		break;
+	case APCH_STATE_CSTATE_EOC:
+	case APCH_STATE_CSTATE_DISABLED:
+	default:
+		*val = 0;
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
 	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER
 };
@@ -300,6 +368,10 @@ static int act8945a_charger_get_property(struct power_supply *psy,
 		ret = act8945a_get_capacity_level(charger,
 						  regmap, &val->intval);
 		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		ret = act8945a_get_current_max(charger,
+					       regmap, &val->intval);
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = act8945a_charger_model;
 		break;
@@ -390,13 +462,11 @@ static int act8945a_charger_config(struct device *dev,
 				   struct act8945a_charger *charger)
 {
 	struct device_node *np = dev->parent->of_node;
-	enum of_gpio_flags flags;
 	struct regmap *regmap = charger->regmap;
 
 	u32 total_time_out;
 	u32 pre_time_out;
 	u32 input_voltage_threshold;
-	int chglev_pin;
 	int ret;
 
 	unsigned int tmp;
@@ -431,12 +501,13 @@ static int act8945a_charger_config(struct device *dev,
 	if (ret)
 		dev_info(dev, "failed to request gpio \"lbo\" IRQ\n");
 
-	chglev_pin = of_get_named_gpio_flags(np,
-				"active-semi,chglev-gpios", 0, &flags);
-
-	if (gpio_is_valid(chglev_pin)) {
-		gpio_set_value(chglev_pin,
-			       ((flags == OF_GPIO_ACTIVE_LOW) ? 0 : 1));
+	charger->chglev_gpio = gpiod_get(dev->parent,
+					 "active-semi,chglev", GPIOD_IN);
+	if (PTR_ERR(charger->chglev_gpio) == -EPROBE_DEFER) {
+		dev_info(dev, "probe retry requested for gpio \"chglev\"\n");
+	} else if (IS_ERR(charger->chglev_gpio)) {
+		dev_err(dev, "unable to claim gpio \"chglev\"\n");
+		charger->chglev_gpio = NULL;
 	}
 
 	if (of_property_read_u32(np,
@@ -579,6 +650,8 @@ static int act8945a_charger_probe(struct platform_device *pdev)
 fail:
 	if (charger->lbo_gpio)
 		gpiod_put(charger->lbo_gpio);
+	if (charger->chglev_gpio)
+		gpiod_put(charger->chglev_gpio);
 
 	return ret;
 }
@@ -592,6 +665,8 @@ static int act8945a_charger_remove(struct platform_device *pdev)
 
 	if (charger->lbo_gpio)
 		gpiod_put(charger->lbo_gpio);
+	if (charger->chglev_gpio)
+		gpiod_put(charger->chglev_gpio);
 
 	return 0;
 }
-- 
2.7.4
