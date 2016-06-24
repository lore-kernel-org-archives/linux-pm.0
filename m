From: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/7] power: act8945a_charger: Add max current property
Date: Fri, 24 Jun 2016 15:17:39 +0800
Message-ID: <1466752660-2922-7-git-send-email-wenyou.yang@atmel.com>
References: <1466752660-2922-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1466752660-2922-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add the power supply's current max property,
POWER_SUPPLY_PROP_CURRENT_MAX.

Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---

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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
