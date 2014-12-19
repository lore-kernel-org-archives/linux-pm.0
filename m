From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH V3 05/11] power: charger-manager: Fix to use CHARGE_NOW/FULL
 property correctly.
Date: Fri, 19 Dec 2014 17:55:17 +0900
Message-ID: <1418979323-7188-6-git-send-email-jonghwa3.lee@samsung.com>
References: <1418979323-7188-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1418979323-7188-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, pavel@ucw.cz, myungjoo.ham@samsung.com, cw00.choi@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>
List-Id: linux-pm@vger.kernel.org

The POWER_SUPPLY_CHARGE_NOW/FULL property reflects battery's charges
in uAh unit, but charger-manager has been used it wrongly. This patch
makes it to use those propeties correctly and change to be optional.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
---
 drivers/power/charger-manager.c |   85 +++++++++++++--------------------------
 1 file changed, 28 insertions(+), 57 deletions(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 5482661..7bbaef6 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -796,35 +796,13 @@ static int charger_get_property(struct power_supply *psy,
 			val->intval = 0;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
-		if (is_full_charged(cm))
-			val->intval = 1;
-		else
-			val->intval = 0;
-		ret = 0;
-		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		if (is_charging(cm)) {
-			fuel_gauge = power_supply_get_by_name(
-					cm->desc->psy_fuel_gauge);
-			if (!fuel_gauge) {
-				ret = -ENODEV;
-				break;
-			}
-
-			ret = fuel_gauge->get_property(fuel_gauge,
-						POWER_SUPPLY_PROP_CHARGE_NOW,
-						val);
-			if (ret) {
-				val->intval = 1;
-				ret = 0;
-			} else {
-				/* If CHARGE_NOW is supplied, use it */
-				val->intval = (val->intval > 0) ?
-						val->intval : 1;
-			}
-		} else {
-			val->intval = 0;
+		fuel_gauge = power_supply_get_by_name(cm->desc->psy_fuel_gauge);
+		if (!fuel_gauge) {
+			ret = -ENODEV;
+			break;
 		}
+		ret = fuel_gauge->get_property(fuel_gauge, psp, val);
 		break;
 	default:
 		return -EINVAL;
@@ -832,8 +810,7 @@ static int charger_get_property(struct power_supply *psy,
 	return ret;
 }
 
-#define NUM_CHARGER_PSY_OPTIONAL	(4)
-static enum power_supply_property default_charger_props[] = {
+static enum power_supply_property cm_default_props[] = {
 	/* Guaranteed to provide */
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_HEALTH,
@@ -841,20 +818,21 @@ static enum power_supply_property default_charger_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_ONLINE,
-	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_TEMP,
-	/*
-	 * Optional properties are:
-	 * POWER_SUPPLY_PROP_CHARGE_NOW,
-	 * POWER_SUPPLY_PROP_CURRENT_NOW,
-	 */
 };
 
+static enum power_supply_property cm_optional_props[] = {
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+};
+
+#define CM_NUM_OF_PROPS	\
+	(ARRAY_SIZE(cm_default_props) + ARRAY_SIZE(cm_optional_props))
+
 static struct power_supply psy_default = {
 	.name = "battery",
 	.type = POWER_SUPPLY_TYPE_BATTERY,
-	.properties = default_charger_props,
-	.num_properties = ARRAY_SIZE(default_charger_props),
 	.get_property = charger_get_property,
 	.no_thermal = true,
 };
@@ -1484,29 +1462,22 @@ static int charger_manager_probe(struct platform_device *pdev)
 	/* Allocate for psy properties because they may vary */
 	cm->charger_psy.properties = devm_kzalloc(&pdev->dev,
 				sizeof(enum power_supply_property)
-				* (ARRAY_SIZE(default_charger_props) +
-				NUM_CHARGER_PSY_OPTIONAL), GFP_KERNEL);
+				* CM_NUM_OF_PROPS, GFP_KERNEL);
 	if (!cm->charger_psy.properties)
 		return -ENOMEM;
 
-	memcpy(cm->charger_psy.properties, default_charger_props,
-		sizeof(enum power_supply_property) *
-		ARRAY_SIZE(default_charger_props));
-	cm->charger_psy.num_properties = psy_default.num_properties;
-
-	/* Find which optional psy-properties are available */
-	if (!fuel_gauge->get_property(fuel_gauge,
-					  POWER_SUPPLY_PROP_CHARGE_NOW, &val)) {
-		cm->charger_psy.properties[cm->charger_psy.num_properties] =
-				POWER_SUPPLY_PROP_CHARGE_NOW;
-		cm->charger_psy.num_properties++;
-	}
-	if (!fuel_gauge->get_property(fuel_gauge,
-					  POWER_SUPPLY_PROP_CURRENT_NOW,
-					  &val)) {
-		cm->charger_psy.properties[cm->charger_psy.num_properties] =
-				POWER_SUPPLY_PROP_CURRENT_NOW;
-		cm->charger_psy.num_properties++;
+	memcpy(cm->charger_psy.properties, cm_default_props,
+			sizeof(enum power_supply_property) *
+			ARRAY_SIZE(cm_default_props));
+	cm->charger_psy.num_properties = ARRAY_SIZE(cm_default_props);
+
+	/* Add available optional properties */
+	for (i = 0; i < ARRAY_SIZE(cm_optional_props); i++) {
+		if (fuel_gauge->get_property(fuel_gauge,
+				cm_optional_props[i], &val))
+			continue;
+		cm->charger_psy.properties[cm->charger_psy.num_properties++] =
+				cm_optional_props[i];
 	}
 
 	if (desc->thermal_zone) {
-- 
1.7.9.5
