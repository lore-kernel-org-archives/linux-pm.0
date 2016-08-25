From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v8 04/11] power: act8945a_charger: Improve
Date: Thu, 25 Aug 2016 15:19:52 +0800
Message-ID: <1472109599-21915-5-git-send-email-wenyou.yang@atmel.com>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:59531 "EHLO
        eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756052AbcHYHXU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Aug 2016 03:23:20 -0400
In-Reply-To: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>, Fengguang Wu <fengguang.wu@intel.com>

When get the property, first check the charger state machine,
then check the status bit to decide what value is assigned to
the corresponding property.

Retain the SUSCHG bit of REG 0x71 when configure the timers to
avoid losting the charger suspending info after boot.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---

Changes in v8: None
Changes in v7:
 - Add a prompt information if the charger suspended.

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3:
 - Remove unneeded semicolon to fix semicolon.cocci warning.

Changes in v2:
 - Add missing ret declaration.

 drivers/power/supply/act8945a_charger.c | 86 +++++++++++++++++++++++++++------
 1 file changed, 70 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supply/act8945a_charger.c
index af00668..a6bbaff 100644
--- a/drivers/power/supply/act8945a_charger.c
+++ b/drivers/power/supply/act8945a_charger.c
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
 
-	if (!(status & APCH_STATUS_TEMPDAT))
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
@@ -232,6 +277,15 @@ static int act8945a_charger_config(struct device *dev,
 		return -EINVAL;
 	}
 
+	ret = regmap_read(regmap, ACT8945A_APCH_CFG, &tmp);
+	if (ret)
+		return ret;
+
+	if (tmp & APCH_CFG_SUSCHG) {
+		value |= APCH_CFG_SUSCHG;
+		dev_info(dev, "have been suspended\n");
+	}
+
 	chglev_pin = of_get_named_gpio_flags(np,
 				"active-semi,chglev-gpios", 0, &flags);
 
-- 
2.7.4

