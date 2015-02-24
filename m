From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 3/5] power_supply: max14577: Properly handle error conditions
Date: Tue, 24 Feb 2015 10:54:45 +0100
Message-ID: <1424771687-7976-3-git-send-email-k.kozlowski@samsung.com>
References: <1424771687-7976-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1424771687-7976-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Re-work and fix handling of errors when retrieving power supply
properties:

1. Return errno values directly from get_property() instead of
   storing 'unknown' as intval for given property.

2. Handle regmap_read() errors and return errno code. Previously the
   regmap_read() return code was ignored so an uninitialized value from
   the stack could be used for calculating the property.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/max14577_charger.c | 109 ++++++++++++++++++++++++++-------------
 1 file changed, 73 insertions(+), 36 deletions(-)

diff --git a/drivers/power/max14577_charger.c b/drivers/power/max14577_charger.c
index c72238aa011b..4736dc478578 100644
--- a/drivers/power/max14577_charger.c
+++ b/drivers/power/max14577_charger.c
@@ -54,10 +54,10 @@ static enum max14577_muic_charger_type maxim_get_charger_type(
 	}
 }
 
-static int max14577_get_charger_state(struct max14577_charger *chg)
+static int max14577_get_charger_state(struct max14577_charger *chg, int *val)
 {
 	struct regmap *rmap = chg->max14577->regmap;
-	int state = POWER_SUPPLY_STATUS_DISCHARGING;
+	int ret;
 	u8 reg_data;
 
 	/*
@@ -71,22 +71,32 @@ static int max14577_get_charger_state(struct max14577_charger *chg)
 	 *  - handle properly dead-battery charging (respect timer)
 	 *  - handle timers (fast-charge and prequal) /MBCCHGERR/
 	 */
-	max14577_read_reg(rmap, MAX14577_CHG_REG_CHG_CTRL2, &reg_data);
-	if ((reg_data & CHGCTRL2_MBCHOSTEN_MASK) == 0)
-		goto state_set;
+	ret = max14577_read_reg(rmap, MAX14577_CHG_REG_CHG_CTRL2, &reg_data);
+	if (ret < 0)
+		goto out;
+
+	if ((reg_data & CHGCTRL2_MBCHOSTEN_MASK) == 0) {
+		*val = POWER_SUPPLY_STATUS_DISCHARGING;
+		goto out;
+	}
+
+	ret = max14577_read_reg(rmap, MAX14577_CHG_REG_STATUS3, &reg_data);
+	if (ret < 0)
+		goto out;
 
-	max14577_read_reg(rmap, MAX14577_CHG_REG_STATUS3, &reg_data);
 	if (reg_data & STATUS3_CGMBC_MASK) {
 		/* Charger or USB-cable is connected */
 		if (reg_data & STATUS3_EOC_MASK)
-			state = POWER_SUPPLY_STATUS_FULL;
+			*val = POWER_SUPPLY_STATUS_FULL;
 		else
-			state = POWER_SUPPLY_STATUS_CHARGING;
-		goto state_set;
+			*val = POWER_SUPPLY_STATUS_CHARGING;
+		goto out;
 	}
 
-state_set:
-	return state;
+	*val = POWER_SUPPLY_STATUS_DISCHARGING;
+
+out:
+	return ret;
 }
 
 /*
@@ -94,8 +104,10 @@ state_set:
  *  - POWER_SUPPLY_CHARGE_TYPE_NONE
  *  - POWER_SUPPLY_CHARGE_TYPE_FAST
  */
-static int max14577_get_charge_type(struct max14577_charger *chg)
+static int max14577_get_charge_type(struct max14577_charger *chg, int *val)
 {
+	int ret, charging;
+
 	/*
 	 * TODO: CHARGE_TYPE_TRICKLE (VCHGR_RC or EOC)?
 	 * As spec says:
@@ -104,18 +116,29 @@ static int max14577_get_charge_type(struct max14577_charger *chg)
 	 *  top-off timer starts. The device continues to trickle
 	 *  charge the battery until the top-off timer runs out."
 	 */
-	if (max14577_get_charger_state(chg) == POWER_SUPPLY_STATUS_CHARGING)
-		return POWER_SUPPLY_CHARGE_TYPE_FAST;
-	return POWER_SUPPLY_CHARGE_TYPE_NONE;
+	ret = max14577_get_charger_state(chg, &charging);
+	if (ret < 0)
+		return ret;
+
+	if (charging == POWER_SUPPLY_STATUS_CHARGING)
+		*val = POWER_SUPPLY_CHARGE_TYPE_FAST;
+	else
+		*val = POWER_SUPPLY_CHARGE_TYPE_NONE;
+
+	return 0;
 }
 
-static int max14577_get_online(struct max14577_charger *chg)
+static int max14577_get_online(struct max14577_charger *chg, int *val)
 {
 	struct regmap *rmap = chg->max14577->regmap;
 	u8 reg_data;
+	int ret;
 	enum max14577_muic_charger_type chg_type;
 
-	max14577_read_reg(rmap, MAX14577_MUIC_REG_STATUS2, &reg_data);
+	ret = max14577_read_reg(rmap, MAX14577_MUIC_REG_STATUS2, &reg_data);
+	if (ret < 0)
+		return ret;
+
 	reg_data = ((reg_data & STATUS2_CHGTYP_MASK) >> STATUS2_CHGTYP_SHIFT);
 	chg_type = maxim_get_charger_type(chg->max14577->dev_type, reg_data);
 	switch (chg_type) {
@@ -125,14 +148,17 @@ static int max14577_get_online(struct max14577_charger *chg)
 	case MAX14577_CHARGER_TYPE_SPECIAL_1A:
 	case MAX14577_CHARGER_TYPE_DEAD_BATTERY:
 	case MAX77836_CHARGER_TYPE_SPECIAL_BIAS:
-		return 1;
+		*val = 1;
+		break;
 	case MAX14577_CHARGER_TYPE_NONE:
 	case MAX14577_CHARGER_TYPE_DOWNSTREAM_PORT:
 	case MAX14577_CHARGER_TYPE_RESERVED:
 	case MAX77836_CHARGER_TYPE_RESERVED:
 	default:
-		return 0;
+		*val = 0;
 	}
+
+	return 0;
 }
 
 /*
@@ -141,29 +167,38 @@ static int max14577_get_online(struct max14577_charger *chg)
  *  - POWER_SUPPLY_HEALTH_OVERVOLTAGE
  *  - POWER_SUPPLY_HEALTH_GOOD
  */
-static int max14577_get_battery_health(struct max14577_charger *chg)
+static int max14577_get_battery_health(struct max14577_charger *chg, int *val)
 {
 	struct regmap *rmap = chg->max14577->regmap;
-	int state = POWER_SUPPLY_HEALTH_GOOD;
+	int ret;
 	u8 reg_data;
 	enum max14577_muic_charger_type chg_type;
 
-	max14577_read_reg(rmap, MAX14577_MUIC_REG_STATUS2, &reg_data);
+	ret = max14577_read_reg(rmap, MAX14577_MUIC_REG_STATUS2, &reg_data);
+	if (ret < 0)
+		goto out;
+
 	reg_data = ((reg_data & STATUS2_CHGTYP_MASK) >> STATUS2_CHGTYP_SHIFT);
 	chg_type = maxim_get_charger_type(chg->max14577->dev_type, reg_data);
 	if (chg_type == MAX14577_CHARGER_TYPE_DEAD_BATTERY) {
-		state = POWER_SUPPLY_HEALTH_DEAD;
-		goto state_set;
+		*val = POWER_SUPPLY_HEALTH_DEAD;
+		goto out;
 	}
 
-	max14577_read_reg(rmap, MAX14577_CHG_REG_STATUS3, &reg_data);
+	ret = max14577_read_reg(rmap, MAX14577_CHG_REG_STATUS3, &reg_data);
+	if (ret < 0)
+		goto out;
+
 	if (reg_data & STATUS3_OVP_MASK) {
-		state = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
-		goto state_set;
+		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+		goto out;
 	}
 
-state_set:
-	return state;
+	/* Not dead, not overvoltage */
+	*val = POWER_SUPPLY_HEALTH_GOOD;
+
+out:
+	return ret;
 }
 
 /*
@@ -171,9 +206,11 @@ state_set:
  * The max14577 chip doesn't report any status of battery presence.
  * Lets assume that it will always be used with some battery.
  */
-static int max14577_get_present(struct max14577_charger *chg)
+static int max14577_get_present(struct max14577_charger *chg, int *val)
 {
-	return 1;
+	*val = 1;
+
+	return 0;
 }
 
 static int max14577_set_fast_charge_timer(struct max14577_charger *chg,
@@ -391,19 +428,19 @@ static int max14577_charger_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		val->intval = max14577_get_charger_state(chg);
+		ret = max14577_get_charger_state(chg, &val->intval);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
-		val->intval = max14577_get_charge_type(chg);
+		ret = max14577_get_charge_type(chg, &val->intval);
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
-		val->intval = max14577_get_battery_health(chg);
+		ret = max14577_get_battery_health(chg, &val->intval);
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
-		val->intval = max14577_get_present(chg);
+		ret = max14577_get_present(chg, &val->intval);
 		break;
 	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = max14577_get_online(chg);
+		ret = max14577_get_online(chg, &val->intval);
 		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		BUILD_BUG_ON(ARRAY_SIZE(model_names) != MAXIM_DEVICE_TYPE_NUM);
-- 
1.9.1
