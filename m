From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 5/6] power: charger-manager: Fix to use CHARGE_NOW/FULL
 property correctly.
Date: Fri, 12 Sep 2014 20:11:26 +0900
Message-ID: <1410520287-24825-6-git-send-email-jonghwa3.lee@samsung.com>
References: <1410520287-24825-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:31529 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841AbaILLLi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Sep 2014 07:11:38 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NBS00GS6CF9K790@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 12 Sep 2014 20:11:33 +0900 (KST)
In-reply-to: <1410520287-24825-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

The POWER_SUPPLY_CHARGE_NOW/FULL property reflects battery's charges
in uAh unit, but charger-manager has been used it wrongly. This patch
makes it to use those propeties correctly and change to be optional.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
---
 drivers/power/charger-manager.c |   86 ++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 52 deletions(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 1917a26..dd128dd 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -764,28 +764,12 @@ static int charger_get_property(struct power_supply *psy,
 			val->intval = 0;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
-		if (is_full_charged(cm))
-			val->intval = 1;
-		else
-			val->intval = 0;
-		ret = 0;
+		ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
+				POWER_SUPPLY_PROP_CHARGE_FULL, val);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		if (is_charging(cm)) {
-			ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
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
-		}
+		ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
+				POWER_SUPPLY_PROP_CHARGE_NOW, val);
 		break;
 	default:
 		return -EINVAL;
@@ -793,8 +777,7 @@ static int charger_get_property(struct power_supply *psy,
 	return ret;
 }
 
-#define NUM_CHARGER_PSY_OPTIONAL	(4)
-static enum power_supply_property default_charger_props[] = {
+static enum power_supply_property cm_default_props[] = {
 	/* Guaranteed to provide */
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_HEALTH,
@@ -802,20 +785,21 @@ static enum power_supply_property default_charger_props[] = {
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
 };
 
@@ -1328,6 +1312,18 @@ static inline struct charger_desc *cm_get_drv_data(struct platform_device *pdev)
 	return (struct charger_desc *)dev_get_platdata(&pdev->dev);
 }
 
+static void cm_test_and_add_property(struct charger_manager *cm,
+					enum power_supply_property psp)
+{
+	union power_supply_propval val;
+
+	if (cm->fuel_gauge->get_property(cm->fuel_gauge, psp, &val))
+		return;
+
+	cm->charger_psy.properties[cm->charger_psy.num_properties] = psp;
+	cm->charger_psy.num_properties++;
+}
+
 static enum alarmtimer_restart cm_timer_func(struct alarm *alarm, ktime_t now)
 {
 	cm_timer_set = false;
@@ -1340,7 +1336,6 @@ static int charger_manager_probe(struct platform_device *pdev)
 	struct charger_manager *cm;
 	int ret = 0, i = 0;
 	int j = 0;
-	union power_supply_propval val;
 
 	if (!desc) {
 		dev_err(&pdev->dev, "No platform data (desc) found\n");
@@ -1442,30 +1437,17 @@ static int charger_manager_probe(struct platform_device *pdev)
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
-	if (!cm->fuel_gauge->get_property(cm->fuel_gauge,
-					  POWER_SUPPLY_PROP_CHARGE_NOW, &val)) {
-		cm->charger_psy.properties[cm->charger_psy.num_properties] =
-				POWER_SUPPLY_PROP_CHARGE_NOW;
-		cm->charger_psy.num_properties++;
-	}
-	if (!cm->fuel_gauge->get_property(cm->fuel_gauge,
-					  POWER_SUPPLY_PROP_CURRENT_NOW,
-					  &val)) {
-		cm->charger_psy.properties[cm->charger_psy.num_properties] =
-				POWER_SUPPLY_PROP_CURRENT_NOW;
-		cm->charger_psy.num_properties++;
-	}
+	memcpy(cm->charger_psy.properties, cm_default_props,
+			sizeof(enum power_supply_property) *
+			ARRAY_SIZE(cm_default_props));
+	cm->charger_psy.num_properties = ARRAY_SIZE(cm_default_props);
+
+	for (i = 0; i < ARRAY_SIZE(cm_optional_props); i++)
+		cm_test_and_add_property(cm, cm_optional_props[i]);
 
 	if (desc->thermal_zone)
 		cm->tzd_batt =
-- 
1.7.9.5

