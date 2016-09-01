From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v9 2/4] power: act8945a_charger: Add max current property
Date: Thu, 1 Sep 2016 17:29:59 +0800
Message-ID: <1472722201-31872-3-git-send-email-wenyou.yang@atmel.com>
References: <1472722201-31872-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nasmtp01.atmel.com ([192.199.1.246]:7570 "EHLO
        ussmtp01.atmel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932218AbcIAJca (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Sep 2016 05:32:30 -0400
In-Reply-To: <1472722201-31872-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, Wenyou Yang <wenyou.yang@microchip.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>

Add the power supply's current max property,
POWER_SUPPLY_PROP_CURRENT_MAX.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v9:
 - For "chglev-gpios", use devm_gpiod_get_optional(), instead of
   devm_gpiod_get(), for simper and more reasonable.

Changes in v8:
 - As the act8945a_charger is regarded as a sub-device, all
   properties can be achieved from its own device node,
   use devm_gpiod_get() properly as well to get "chglev-gpios".
 - Add missing return -EPROBE_DEFER  for "chglev-gpios".

Changes in v7:
 - For "chglev-gpios", use gpiod_get() to fix devm_gpiod_get() wrong use
   with parent device as *dev argument.
 - Add the handle -EPROBE_DEFER returned from gpiod_get "chglev-gpio".
 - Remove unneeded semicolon.

Changes in v6:
 - For "chglev-gpios", use gpiod API instead of old gpio API to handle.

Changes in v4:
 - Fix wrong gpio assignment for chglev_pin.

 drivers/power/supply/act8945a_charger.c | 89 +++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supply/act8945a_charger.c
index 2f87599..d1eb2e3 100644
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
 	struct device_node *np = dev->of_node;
-	enum of_gpio_flags flags;
 	struct regmap *regmap = charger->regmap;
 
 	u32 total_time_out;
 	u32 pre_time_out;
 	u32 input_voltage_threshold;
-	int chglev_pin;
 	int err, ret;
 
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
+	charger->chglev_gpio = devm_gpiod_get_optional(dev,
+						       "active-semi,chglev",
+						       GPIOD_IN);
+	if (IS_ERR(charger->chglev_gpio)) {
+		err = PTR_ERR(charger->chglev_gpio);
+		dev_err(dev, "unable to claim gpio \"chglev\": %d\n", err);
+		return err;
 	}
 
 	if (of_property_read_u32(np,
-- 
2.7.4

