From: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 2/7] power: act8945a_charger: Improve
Date: Fri, 29 Jul 2016 09:25:23 +0800
Message-ID: <1469755528-8413-3-git-send-email-wenyou.yang@atmel.com>
References: <1469755528-8413-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1469755528-8413-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

When get the property, first check the charger state machine,
then check the status bit to decide what value is assigned to
the corresponding property.

Retain the SUSCHG bit of REG 0x71 when configure the timers to
avoid losting the charger suspending info after boot.

Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

Changes in v3:
 - Remove unneeded semicolon to fix semicolon.cocci warning.

Changes in v2:
 - Add missing ret declaration.

 drivers/power/act8945a_charger.c | 84 ++++++++++++++++++++++++++++++++--------
 1 file changed, 68 insertions(+), 16 deletions(-)

diff --git a/drivers/power/act8945a_charger.c b/drivers/power/act8945a_charger.c
index 72d39ba..6ddfc1d 100644
--- a/drivers/power/act8945a_charger.c
+++ b/drivers/power/act8945a_charger.c
@@ -94,16 +94,24 @@ static int act8945a_get_charger_state(struct regmap *regmap, int *val)
 	state &= APCH_STATE_CSTATE;
 	state >>= APCH_STATE_CSTATE_SHIFT;
 
-	if (state == APCH_STATE_CSTATE_EOC) {
+	switch (state) {
+	case APCH_STATE_CSTATE_PRE:
+	case APCH_STATE_CSTATE_FAST:
+		*val = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case APCH_STATE_CSTATE_EOC:
 		if (status & APCH_STATUS_CHGDAT)
 			*val = POWER_SUPPLY_STATUS_FULL;
 		else
+			*val = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case APCH_STATE_CSTATE_DISABLED:
+	default:
+		if (!(status & APCH_STATUS_INDAT))
+			*val = POWER_SUPPLY_STATUS_DISCHARGING;
+		else
 			*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
-	} else if ((state == APCH_STATE_CSTATE_FAST) ||
-		   (state == APCH_STATE_CSTATE_PRE)) {
-		*val = POWER_SUPPLY_STATUS_CHARGING;
-	} else {
-		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
 	}
 
 	return 0;
@@ -112,7 +120,11 @@ static int act8945a_get_charger_state(struct regmap *regmap, int *val)
 static int act8945a_get_charge_type(struct regmap *regmap, int *val)
 {
 	int ret;
-	unsigned int state;
+	unsigned int status, state;
+
+	ret = regmap_read(regmap, ACT8945A_APCH_STATUS, &status);
+	if (ret < 0)
+		return ret;
 
 	ret = regmap_read(regmap, ACT8945A_APCH_STATE, &state);
 	if (ret < 0)
@@ -129,9 +141,15 @@ static int act8945a_get_charge_type(struct regmap *regmap, int *val)
 		*val = POWER_SUPPLY_CHARGE_TYPE_FAST;
 		break;
 	case APCH_STATE_CSTATE_EOC:
+		*val = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		break;
 	case APCH_STATE_CSTATE_DISABLED:
 	default:
-		*val = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		if (!(status & APCH_STATUS_INDAT))
+			*val = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		else
+			*val = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+		break;
 	}
 
 	return 0;
@@ -140,20 +158,45 @@ static int act8945a_get_charge_type(struct regmap *regmap, int *val)
 static int act8945a_get_battery_health(struct regmap *regmap, int *val)
 {
 	int ret;
-	unsigned int status;
+	unsigned int status, state, config;
 
 	ret = regmap_read(regmap, ACT8945A_APCH_STATUS, &status);
 	if (ret < 0)
 		return ret;
 
-	if (status & APCH_STATUS_TEMPDAT)
-		*val = POWER_SUPPLY_HEALTH_OVERHEAT;
-	else if (!(status & APCH_STATUS_INDAT))
-		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
-	else if (status & APCH_STATUS_TIMRDAT)
-		*val = POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
-	else
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
+	case APCH_STATE_CSTATE_DISABLED:
+		if (config & APCH_CFG_SUSCHG) {
+			*val = POWER_SUPPLY_HEALTH_UNKNOWN;
+		} else if (status & APCH_STATUS_INDAT) {
+			if (!(status & APCH_STATUS_TEMPDAT))
+				*val = POWER_SUPPLY_HEALTH_OVERHEAT;
+			else if (status & APCH_STATUS_TIMRDAT)
+				*val = POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
+			else
+				*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+		} else {
+			*val = POWER_SUPPLY_HEALTH_GOOD;
+		}
+		break;
+	case APCH_STATE_CSTATE_PRE:
+	case APCH_STATE_CSTATE_FAST:
+	case APCH_STATE_CSTATE_EOC:
+	default:
 		*val = POWER_SUPPLY_HEALTH_GOOD;
+		break;
+	}
 
 	return 0;
 }
@@ -224,7 +267,9 @@ static int act8945a_charger_config(struct device *dev,
 	u32 pre_time_out;
 	u32 input_voltage_threshold;
 	int chglev_pin;
+	int ret;
 
+	unsigned int tmp;
 	unsigned int value = 0;
 
 	if (!np) {
@@ -232,6 +277,13 @@ static int act8945a_charger_config(struct device *dev,
 		return -EINVAL;
 	}
 
+	ret = regmap_read(regmap, ACT8945A_APCH_CFG, &tmp);
+	if (ret)
+		return ret;
+
+	if (tmp & APCH_CFG_SUSCHG)
+		value |= APCH_CFG_SUSCHG;
+
 	chglev_pin = of_get_named_gpio_flags(np,
 				"active-semi,chglev-gpios", 0, &flags);
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
