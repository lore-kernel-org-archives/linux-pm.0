From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 2/6] power: charger-manager: Monitoring temperature becomes
 mandatory option.
Date: Fri, 12 Sep 2014 20:11:23 +0900
Message-ID: <1410520287-24825-3-git-send-email-jonghwa3.lee@samsung.com>
References: <1410520287-24825-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35439 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbaILLLf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Sep 2014 07:11:35 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NBS00CK3CF9TN30@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 12 Sep 2014 20:11:33 +0900 (KST)
In-reply-to: <1410520287-24825-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

Monitoring battery temperature becomes mandatory for charger manager working.
If there is no way to measure temperature, it stops probing and won't work.
And also it will use thermal susbsystem inteface only to make driver simple.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
---
 drivers/power/Kconfig                 |    1 +
 drivers/power/charger-manager.c       |   75 +++++++--------------------------
 include/linux/power/charger-manager.h |    3 +-
 3 files changed, 18 insertions(+), 61 deletions(-)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index c2613fd..12bf79d 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -317,6 +317,7 @@ config CHARGER_MANAGER
 	bool "Battery charger manager for multiple chargers"
 	depends on REGULATOR
 	select EXTCON
+	select THERMAL
 	help
           Say Y to enable charger-manager support, which allows multiple
           chargers attached to a battery and multiple batteries attached to a
diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 88c2bc7..7ae2e94 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -548,19 +548,11 @@ static int cm_get_battery_temperature(struct charger_manager *cm,
 {
 	int ret;
 
-	if (!cm->desc->measure_battery_temp)
-		return -ENODEV;
-
-#ifdef CONFIG_THERMAL
 	ret = thermal_zone_get_temp(cm->tzd_batt, (unsigned long *)temp);
 	if (!ret)
 		/* Calibrate temperature unit */
 		*temp /= 100;
-#else
-	ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
-				POWER_SUPPLY_PROP_TEMP,
-				(union power_supply_propval *)temp);
-#endif
+
 	return ret;
 }
 
@@ -947,12 +939,11 @@ static enum power_supply_property default_charger_props[] = {
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_TEMP,
 	/*
 	 * Optional properties are:
 	 * POWER_SUPPLY_PROP_CHARGE_NOW,
 	 * POWER_SUPPLY_PROP_CURRENT_NOW,
-	 * POWER_SUPPLY_PROP_TEMP, and
-	 * POWER_SUPPLY_PROP_TEMP_AMBIENT,
 	 */
 };
 
@@ -1355,50 +1346,6 @@ err:
 	return ret;
 }
 
-static int cm_init_thermal_data(struct charger_manager *cm)
-{
-	struct charger_desc *desc = cm->desc;
-	union power_supply_propval val;
-	int ret;
-
-	/* Verify whether fuel gauge provides battery temperature */
-	ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
-					POWER_SUPPLY_PROP_TEMP, &val);
-
-	if (!ret) {
-		cm->charger_psy.properties[cm->charger_psy.num_properties] =
-				POWER_SUPPLY_PROP_TEMP;
-		cm->charger_psy.num_properties++;
-		cm->desc->measure_battery_temp = true;
-	}
-#ifdef CONFIG_THERMAL
-	cm->tzd_batt = cm->fuel_gauge->tzd;
-
-	if (ret && desc->thermal_zone) {
-		cm->tzd_batt =
-			thermal_zone_get_zone_by_name(desc->thermal_zone);
-		if (IS_ERR(cm->tzd_batt))
-			return PTR_ERR(cm->tzd_batt);
-
-		/* Use external thermometer */
-		cm->charger_psy.properties[cm->charger_psy.num_properties] =
-				POWER_SUPPLY_PROP_TEMP_AMBIENT;
-		cm->charger_psy.num_properties++;
-		cm->desc->measure_battery_temp = true;
-		ret = 0;
-	}
-#endif
-	if (cm->desc->measure_battery_temp) {
-		/* NOTICE : Default allowable minimum charge temperature is 0 */
-		if (!desc->temp_max)
-			desc->temp_max = CM_DEFAULT_CHARGE_TEMP_MAX;
-		if (!desc->temp_diff)
-			desc->temp_diff = CM_DEFAULT_RECHARGE_TEMP_DIFF;
-	}
-
-	return ret;
-}
-
 static struct of_device_id charger_manager_match[] = {
 	{
 		.compatible = "charger-manager",
@@ -1458,11 +1405,16 @@ static struct charger_desc *of_cm_parse_desc(struct device *dev)
 
 	of_property_read_string(np, "cm-thermal-zone", &desc->thermal_zone);
 
+	/* NOTICE : Default allowable minimum charge temperature is 0 */
 	of_property_read_u32(np, "cm-battery-cold", &desc->temp_min);
 	if (of_get_property(np, "cm-battery-cold-in-minus", NULL))
 		desc->temp_min *= -1;
 	of_property_read_u32(np, "cm-battery-hot", &desc->temp_max);
+	if (!desc->temp_max)
+		desc->temp_max = CM_DEFAULT_CHARGE_TEMP_MAX;
 	of_property_read_u32(np, "cm-battery-temp-diff", &desc->temp_diff);
+	if (!desc->temp_diff)
+		desc->temp_diff = CM_DEFAULT_RECHARGE_TEMP_DIFF;
 
 	of_property_read_u32(np, "cm-charging-max",
 				&desc->charging_max_duration_ms);
@@ -1669,10 +1621,15 @@ static int charger_manager_probe(struct platform_device *pdev)
 		cm->charger_psy.num_properties++;
 	}
 
-	ret = cm_init_thermal_data(cm);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to initialize thermal data\n");
-		cm->desc->measure_battery_temp = false;
+	if (desc->thermal_zone)
+		cm->tzd_batt =
+			thermal_zone_get_zone_by_name(desc->thermal_zone);
+	else
+		cm->tzd_batt = cm->fuel_gauge->tzd;
+
+	if (!cm->tzd_batt) {
+		pr_err("No way to monitor battery temperature.\n");
+		return -ENODEV;
 	}
 
 	INIT_DELAYED_WORK(&cm->fullbatt_vchk_work, fullbatt_vchk);
diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
index 8e111f3..e692674 100644
--- a/include/linux/power/charger-manager.h
+++ b/include/linux/power/charger-manager.h
@@ -234,9 +234,8 @@ struct charger_manager {
 	struct power_supply *fuel_gauge;
 	struct power_supply **charger_stat;
 
-#ifdef CONFIG_THERMAL
 	struct thermal_zone_device *tzd_batt;
-#endif
+
 	bool charger_enabled;
 
 	unsigned long fullbatt_vchk_jiffies_at;
-- 
1.7.9.5

