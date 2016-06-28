From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v2 6/7] power: act8945a_charger: Add max current property
Date: Tue, 28 Jun 2016 09:22:49 +0800
Message-ID: <1467076970-12206-7-git-send-email-wenyou.yang@atmel.com>
References: <1467076970-12206-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467076970-12206-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>
List-Id: linux-pm@vger.kernel.org

Add the power supply's current max property,
POWER_SUPPLY_PROP_CURRENT_MAX.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v2: None

 drivers/power/act8945a_charger.c | 79 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/power/act8945a_charger.c b/drivers/power/act8945a_charger.c
index 9b79f5e..8d99bff 100644
--- a/drivers/power/act8945a_charger.c
+++ b/drivers/power/act8945a_charger.c
@@ -84,6 +84,7 @@ struct act8945a_charger {
 	bool init_done;
 	int irq_pin;
 	int lbo_pin;
+	int chgin_level;
 };
 
 static int act8945a_get_charger_state(struct regmap *regmap, int *val)
@@ -267,12 +268,79 @@ static int act8945a_get_capacity_level(struct act8945a_charger *charger,
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
+			if (charger->chgin_level)
+				*val = MAX_CURRENT_AC_HIGH_PRE;
+			else
+				*val = MAX_CURRENT_AC_LOW_PRE;
+		} else {
+			*val = MAX_CURRENT_USB_PRE;
+		}
+		break;
+	case APCH_STATE_CSTATE_FAST:
+		if (acin_state) {
+			if (charger->chgin_level)
+				*val = MAX_CURRENT_AC_HIGH;
+			else
+				*val = MAX_CURRENT_AC_LOW;
+		} else {
+			if (charger->chgin_level)
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
@@ -302,6 +370,10 @@ static int act8945a_charger_get_property(struct power_supply *psy,
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
@@ -446,8 +518,11 @@ static int act8945a_charger_config(struct device *dev,
 				"active-semi,chglev-gpios", 0, &flags);
 
 	if (gpio_is_valid(chglev_pin)) {
-		gpio_set_value(chglev_pin,
-			       ((flags == OF_GPIO_ACTIVE_LOW) ? 0 : 1));
+		if (!devm_gpio_request(dev, charger->irq_pin, "chglev-pin")) {
+			charger->chgin_level =
+					(flags == OF_GPIO_ACTIVE_LOW) ? 0 : 1;
+			gpio_set_value(chglev_pin, charger->chgin_level);
+		}
 	}
 
 	if (of_property_read_u32(np,
-- 
2.7.4
