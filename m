From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 2/3] charger-manager : Add default battery temperature checking
 funtion.
Date: Fri, 25 Oct 2013 11:47:32 +0900
Message-ID: <1382669253-23629-3-git-send-email-jonghwa3.lee@samsung.com>
References: <1382669253-23629-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:34870 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754392Ab3JYCrv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2013 22:47:51 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MV7008YHEDVL540@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 25 Oct 2013 11:47:50 +0900 (KST)
In-reply-to: <1382669253-23629-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: anton@enomsg.org, dwmw2@infradead.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

During the charger manager driver's probing time, it can't succeed
if there's no pre-defined .temperature_out_of_range callback function.
But if fuel gauge supports battery temperature measurement, we
can use it directly. That's what cm_default_get_temp() function does.

With flag measure_batter_temp ON, we normally use cm_default_get_temp()
for .temperature_out_of_range callback funtion.
The TEMP_AMBIENT property is only used for pre-defined one.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
---
 drivers/power/charger-manager.c       |   88 ++++++++++++++++++++++++++++-----
 include/linux/power/charger-manager.h |   11 ++++-
 2 files changed, 86 insertions(+), 13 deletions(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 7287c0e..959eace 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -550,7 +550,7 @@ static int check_charging_duration(struct charger_manager *cm)
 static bool _cm_monitor(struct charger_manager *cm)
 {
 	struct charger_desc *desc = cm->desc;
-	int temp = desc->temperature_out_of_range(&cm->last_temp_mC);
+	int temp = desc->temperature_out_of_range(cm);
 
 	dev_dbg(cm->dev, "monitoring (%2.2d.%3.3dC)\n",
 		cm->last_temp_mC / 1000, cm->last_temp_mC % 1000);
@@ -802,18 +802,16 @@ static int charger_get_property(struct power_supply *psy,
 				POWER_SUPPLY_PROP_CURRENT_NOW, val);
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
-		/* in thenth of centigrade */
 		if (cm->last_temp_mC == INT_MIN)
-			desc->temperature_out_of_range(&cm->last_temp_mC);
-		val->intval = cm->last_temp_mC / 100;
+			desc->temperature_out_of_range(cm);
+		val->intval = cm->last_temp_mC;
 		if (!desc->measure_battery_temp)
 			ret = -ENODEV;
 		break;
 	case POWER_SUPPLY_PROP_TEMP_AMBIENT:
-		/* in thenth of centigrade */
 		if (cm->last_temp_mC == INT_MIN)
-			desc->temperature_out_of_range(&cm->last_temp_mC);
-		val->intval = cm->last_temp_mC / 100;
+			desc->temperature_out_of_range(cm);
+		val->intval = cm->last_temp_mC;
 		if (desc->measure_battery_temp)
 			ret = -ENODEV;
 		break;
@@ -1439,6 +1437,70 @@ err:
 	return ret;
 }
 
+/* Every temperature units are in milli centigrade */
+#define CM_DEFAULT_TEMP_ALERT_DIFF	10000
+#define CM_DEFAULT_TEMP_ALERT_MAX	127000
+#define CM_DEFAULT_TEMP_ALERT_MIN	(-127000)
+
+static int cm_default_get_temp(struct charger_manager *cm)
+{
+	struct charger_desc *desc = cm->desc;
+	union power_supply_propval val;
+	static int temp_alert_min = 0;
+	static int temp_alert_max = 0;
+	static int temp_alert_diff = 0;
+	static int last_temp_status = 0;
+	int ret;
+
+	if (!temp_alert_min && !temp_alert_max) {
+		/* Initialize minimum temperature for alert */
+		ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
+					POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
+					&val);
+		temp_alert_min = ret ? desc->temp_alert_min :
+					min(desc->temp_alert_min, val.intval);
+		if (!temp_alert_min)
+			temp_alert_min = CM_DEFAULT_TEMP_ALERT_MIN;
+
+		/* Initialize maximum temperature for alert */
+		ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
+					POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
+					&val);
+		temp_alert_max = ret ? desc->temp_alert_max :
+					min(desc->temp_alert_max, val.intval);
+		if (!temp_alert_max)
+			temp_alert_max = CM_DEFAULT_TEMP_ALERT_MAX;
+
+		temp_alert_diff = desc->temp_alert_diff ?
+					: CM_DEFAULT_TEMP_ALERT_DIFF;
+	}
+
+	/* Get battery temperature */
+	ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
+					POWER_SUPPLY_PROP_TEMP,
+					&val);
+	if (ret) {
+		cm->last_temp_mC = INT_MIN;
+		return 0;
+	}
+
+	cm->last_temp_mC = val.intval;
+
+	if (cm->last_temp_mC > temp_alert_max || (last_temp_status &&
+			cm->last_temp_mC + temp_alert_diff > temp_alert_max)) {
+		/* OVERHEAT */
+		last_temp_status = 1;
+	} else if (cm->last_temp_mC < temp_alert_min ||	(last_temp_status &&
+			cm->last_temp_mC < temp_alert_min + temp_alert_diff)) {
+		/* Too COLD */
+		last_temp_status = -1;
+	} else {
+		last_temp_status = 0;
+	}
+
+	return last_temp_status;
+}
+
 static int charger_manager_probe(struct platform_device *pdev)
 {
 	struct charger_desc *desc = dev_get_platdata(&pdev->dev);
@@ -1533,11 +1595,6 @@ static int charger_manager_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (!desc->temperature_out_of_range) {
-		dev_err(&pdev->dev, "there is no temperature_out_of_range\n");
-		return -EINVAL;
-	}
-
 	if (!desc->charging_max_duration_ms ||
 			!desc->discharging_max_duration_ms) {
 		dev_info(&pdev->dev, "Cannot limit charging duration checking mechanism to prevent overcharge/overheat and control discharging duration\n");
@@ -1587,7 +1644,14 @@ static int charger_manager_probe(struct platform_device *pdev)
 		cm->charger_psy.properties[cm->charger_psy.num_properties] =
 				POWER_SUPPLY_PROP_TEMP;
 		cm->charger_psy.num_properties++;
+		desc->temperature_out_of_range = cm_default_get_temp;
 	} else {
+		if (!desc->temperature_out_of_range) {
+			dev_err(&pdev->dev,
+				"%s : No battery thermometer exists\n",
+				__func__);
+			return -EINVAL;
+		}
 		cm->charger_psy.properties[cm->charger_psy.num_properties] =
 				POWER_SUPPLY_PROP_TEMP_AMBIENT;
 		cm->charger_psy.num_properties++;
diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
index 0e86840..2088619 100644
--- a/include/linux/power/charger-manager.h
+++ b/include/linux/power/charger-manager.h
@@ -148,6 +148,8 @@ struct charger_regulator {
 	struct charger_manager *cm;
 };
 
+struct charger_manager;
+
 /**
  * struct charger_desc
  * @psy_name: the name of power-supply-class for charger manager
@@ -173,6 +175,9 @@ struct charger_regulator {
  * @num_charger_regulator: the number of entries in charger_regulators
  * @charger_regulators: array of charger regulators
  * @psy_fuel_gauge: the name of power-supply for fuel gauge
+ * @temp_alert_min : Minimum battery temperature to be allowed.
+ * @temp_alert_max : Maximum battery temperature to be allowed.
+ * @temp_alert_diff : Temperature diffential to restart charging. 
  * @temperature_out_of_range:
  *	Determine whether the status is overheat or cold or normal.
  *	return_value > 0: overheat
@@ -210,7 +215,11 @@ struct charger_desc {
 
 	char *psy_fuel_gauge;
 
-	int (*temperature_out_of_range)(int *mC);
+	int temp_alert_min;
+	int temp_alert_max;
+	int temp_alert_diff;
+
+	int (*temperature_out_of_range)(struct charger_manager *);
 	bool measure_battery_temp;
 
 	u64 charging_max_duration_ms;
-- 
1.7.9.5

