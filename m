From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 1/5] power_supply: max77693: Properly handle error conditions
Date: Tue, 24 Feb 2015 10:54:43 +0100
Message-ID: <1424771687-7976-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Re-work and fix handling of errors when retrieving power supply
properties:

1. Return errno values directly from get_property() instead of storing
   'unknown' as intval for given property.

2. Handle regmap_read() errors when getting 'online' and 'present'
   proprties and return errno code. Previously the regmap_read() return
   code was ignored so an uninitialized value from the stack could be
   used for calculating the property.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/max77693_charger.c | 99 ++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 44 deletions(-)

diff --git a/drivers/power/max77693_charger.c b/drivers/power/max77693_charger.c
index b042970fdeaf..ca52e7d15b95 100644
--- a/drivers/power/max77693_charger.c
+++ b/drivers/power/max77693_charger.c
@@ -38,13 +38,14 @@ struct max77693_charger {
 	u32 charge_input_threshold_volt;
 };
 
-static int max77693_get_charger_state(struct regmap *regmap)
+static int max77693_get_charger_state(struct regmap *regmap, int *val)
 {
-	int state;
+	int ret;
 	unsigned int data;
 
-	if (regmap_read(regmap, MAX77693_CHG_REG_CHG_DETAILS_01, &data) < 0)
-		return POWER_SUPPLY_STATUS_UNKNOWN;
+	ret = regmap_read(regmap, MAX77693_CHG_REG_CHG_DETAILS_01, &data);
+	if (ret < 0)
+		return ret;
 
 	data &= CHG_DETAILS_01_CHG_MASK;
 	data >>= CHG_DETAILS_01_CHG_SHIFT;
@@ -56,35 +57,36 @@ static int max77693_get_charger_state(struct regmap *regmap)
 	case MAX77693_CHARGING_TOP_OFF:
 	/* In high temp the charging current is reduced, but still charging */
 	case MAX77693_CHARGING_HIGH_TEMP:
-		state = POWER_SUPPLY_STATUS_CHARGING;
+		*val = POWER_SUPPLY_STATUS_CHARGING;
 		break;
 	case MAX77693_CHARGING_DONE:
-		state = POWER_SUPPLY_STATUS_FULL;
+		*val = POWER_SUPPLY_STATUS_FULL;
 		break;
 	case MAX77693_CHARGING_TIMER_EXPIRED:
 	case MAX77693_CHARGING_THERMISTOR_SUSPEND:
-		state = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		break;
 	case MAX77693_CHARGING_OFF:
 	case MAX77693_CHARGING_OVER_TEMP:
 	case MAX77693_CHARGING_WATCHDOG_EXPIRED:
-		state = POWER_SUPPLY_STATUS_DISCHARGING;
+		*val = POWER_SUPPLY_STATUS_DISCHARGING;
 		break;
 	case MAX77693_CHARGING_RESERVED:
 	default:
-		state = POWER_SUPPLY_STATUS_UNKNOWN;
+		*val = POWER_SUPPLY_STATUS_UNKNOWN;
 	}
 
-	return state;
+	return 0;
 }
 
-static int max77693_get_charge_type(struct regmap *regmap)
+static int max77693_get_charge_type(struct regmap *regmap, int *val)
 {
-	int state;
+	int ret;
 	unsigned int data;
 
-	if (regmap_read(regmap, MAX77693_CHG_REG_CHG_DETAILS_01, &data) < 0)
-		return POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+	ret = regmap_read(regmap, MAX77693_CHG_REG_CHG_DETAILS_01, &data);
+	if (ret < 0)
+		return ret;
 
 	data &= CHG_DETAILS_01_CHG_MASK;
 	data >>= CHG_DETAILS_01_CHG_SHIFT;
@@ -96,13 +98,13 @@ static int max77693_get_charge_type(struct regmap *regmap)
 	 * 100 and 250 mA. It is higher than prequalification current.
 	 */
 	case MAX77693_CHARGING_TOP_OFF:
-		state = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+		*val = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
 		break;
 	case MAX77693_CHARGING_FAST_CONST_CURRENT:
 	case MAX77693_CHARGING_FAST_CONST_VOLTAGE:
 	/* In high temp the charging current is reduced, but still charging */
 	case MAX77693_CHARGING_HIGH_TEMP:
-		state = POWER_SUPPLY_CHARGE_TYPE_FAST;
+		*val = POWER_SUPPLY_CHARGE_TYPE_FAST;
 		break;
 	case MAX77693_CHARGING_DONE:
 	case MAX77693_CHARGING_TIMER_EXPIRED:
@@ -110,14 +112,14 @@ static int max77693_get_charge_type(struct regmap *regmap)
 	case MAX77693_CHARGING_OFF:
 	case MAX77693_CHARGING_OVER_TEMP:
 	case MAX77693_CHARGING_WATCHDOG_EXPIRED:
-		state = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		*val = POWER_SUPPLY_CHARGE_TYPE_NONE;
 		break;
 	case MAX77693_CHARGING_RESERVED:
 	default:
-		state = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+		*val = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
 	}
 
-	return state;
+	return 0;
 }
 
 /*
@@ -129,69 +131,78 @@ static int max77693_get_charge_type(struct regmap *regmap)
  *  - POWER_SUPPLY_HEALTH_UNKNOWN
  *  - POWER_SUPPLY_HEALTH_UNSPEC_FAILURE
  */
-static int max77693_get_battery_health(struct regmap *regmap)
+static int max77693_get_battery_health(struct regmap *regmap, int *val)
 {
-	int state;
+	int ret;
 	unsigned int data;
 
-	if (regmap_read(regmap, MAX77693_CHG_REG_CHG_DETAILS_01, &data) < 0)
-		return POWER_SUPPLY_HEALTH_UNKNOWN;
+	ret = regmap_read(regmap, MAX77693_CHG_REG_CHG_DETAILS_01, &data);
+	if (ret < 0)
+		return ret;
 
 	data &= CHG_DETAILS_01_BAT_MASK;
 	data >>= CHG_DETAILS_01_BAT_SHIFT;
 
 	switch (data) {
 	case MAX77693_BATTERY_NOBAT:
-		state = POWER_SUPPLY_HEALTH_DEAD;
+		*val = POWER_SUPPLY_HEALTH_DEAD;
 		break;
 	case MAX77693_BATTERY_PREQUALIFICATION:
 	case MAX77693_BATTERY_GOOD:
 	case MAX77693_BATTERY_LOWVOLTAGE:
-		state = POWER_SUPPLY_HEALTH_GOOD;
+		*val = POWER_SUPPLY_HEALTH_GOOD;
 		break;
 	case MAX77693_BATTERY_TIMER_EXPIRED:
 		/*
 		 * Took longer to charge than expected, charging suspended.
 		 * Damaged battery?
 		 */
-		state = POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
+		*val = POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
 		break;
 	case MAX77693_BATTERY_OVERVOLTAGE:
-		state = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 		break;
 	case MAX77693_BATTERY_OVERCURRENT:
-		state = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+		*val = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
 		break;
 	case MAX77693_BATTERY_RESERVED:
 	default:
-		state = POWER_SUPPLY_HEALTH_UNKNOWN;
+		*val = POWER_SUPPLY_HEALTH_UNKNOWN;
 		break;
 	}
 
-	return state;
+	return 0;
 }
 
-static int max77693_get_present(struct regmap *regmap)
+static int max77693_get_present(struct regmap *regmap, int *val)
 {
 	unsigned int data;
+	int ret;
 
 	/*
 	 * Read CHG_INT_OK register. High DETBAT bit here should be
 	 * equal to value 0x0 in CHG_DETAILS_01/BAT field.
 	 */
-	regmap_read(regmap, MAX77693_CHG_REG_CHG_INT_OK, &data);
-	if (data & CHG_INT_OK_DETBAT_MASK)
-		return 0;
-	return 1;
+	ret = regmap_read(regmap, MAX77693_CHG_REG_CHG_INT_OK, &data);
+	if (ret < 0)
+		return ret;
+
+	*val = (data & CHG_INT_OK_DETBAT_MASK) ? 0 : 1;
+
+	return 0;
 }
 
-static int max77693_get_online(struct regmap *regmap)
+static int max77693_get_online(struct regmap *regmap, int *val)
 {
 	unsigned int data;
+	int ret;
+
+	ret = regmap_read(regmap, MAX77693_CHG_REG_CHG_INT_OK, &data);
+	if (ret < 0)
+		return ret;
+
+	*val = (data & CHG_INT_OK_CHGIN_MASK) ? 1 : 0;
 
-	regmap_read(regmap, MAX77693_CHG_REG_CHG_INT_OK, &data);
-	if (data & CHG_INT_OK_CHGIN_MASK)
-		return 1;
 	return 0;
 }
 
@@ -217,19 +228,19 @@ static int max77693_charger_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		val->intval = max77693_get_charger_state(regmap);
+		ret = max77693_get_charger_state(regmap, &val->intval);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
-		val->intval = max77693_get_charge_type(regmap);
+		ret = max77693_get_charge_type(regmap, &val->intval);
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
-		val->intval = max77693_get_battery_health(regmap);
+		ret = max77693_get_battery_health(regmap, &val->intval);
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
-		val->intval = max77693_get_present(regmap);
+		ret = max77693_get_present(regmap, &val->intval);
 		break;
 	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = max77693_get_online(regmap);
+		ret = max77693_get_online(regmap, &val->intval);
 		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = max77693_charger_model;
-- 
1.9.1
