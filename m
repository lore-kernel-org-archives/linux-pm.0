From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 1/2] charger-manager : Modify the way of checking battery's
 temperature.
Date: Wed, 18 Dec 2013 11:14:12 +0900
Message-ID: <1387332853-5923-2-git-send-email-jonghwa3.lee@samsung.com>
References: <1387332853-5923-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:63372 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab3LRCOY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2013 21:14:24 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXZ00CQMCVZIWA0@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 18 Dec 2013 11:14:23 +0900 (KST)
In-reply-to: <1387332853-5923-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: anton@enomsg.org, dwmw2@infradead.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

Charger-manager driver used to check battery temperature through the
callback function passed by platform data. Unfortunatley, without that
pre-defined callback function, charger-manager can't get battery's
temperature at all. Also passing callback function through platform data
ruins DT support for charger-manager.

This patch mondifies charger-manager driver to get temperature of battery
without pre-defined callback function. Now, charger-manager can use either
of battery thermometer in fuel-gauge and ouside of battery.
It uses thermal framework interface for outer thermometer if thermal fw is
enabled. Otherwise, it tries to use fuel-gauge's through the power supply
interface.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
---
 drivers/power/charger-manager.c       |  161 ++++++++++++++++++++++++---------
 include/linux/power/charger-manager.h |   24 +++--
 2 files changed, 136 insertions(+), 49 deletions(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 7287c0e..6b68d15 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -25,12 +25,22 @@
 #include <linux/power/charger-manager.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sysfs.h>
+#include <linux/thermal.h>
+
+/*
+ * Default termperature threshold for charging.
+ * Every temperature units are in tenth of centigrade.
+ */
+#define CM_DEFAULT_RECHARGE_TEMP_DIFF	50
+#define CM_DEFAULT_CHARGE_TEMP_MAX	500
 
 static const char * const default_event_names[] = {
 	[CM_EVENT_UNKNOWN] = "Unknown",
 	[CM_EVENT_BATT_FULL] = "Battery Full",
 	[CM_EVENT_BATT_IN] = "Battery Inserted",
 	[CM_EVENT_BATT_OUT] = "Battery Pulled Out",
+	[CM_EVENT_BATT_OVERHEAT] = "Battery Overheat",
+	[CM_EVENT_BATT_COLD] = "Battery Cold",
 	[CM_EVENT_EXT_PWR_IN_OUT] = "External Power Attach/Detach",
 	[CM_EVENT_CHG_START_STOP] = "Charging Start/Stop",
 	[CM_EVENT_OTHERS] = "Other battery events"
@@ -540,6 +550,60 @@ static int check_charging_duration(struct charger_manager *cm)
 	return ret;
 }
 
+static int cm_get_battery_temperature(struct charger_manager *cm,
+					int *temp)
+{
+	int ret;
+
+	if (!cm->desc->measure_battery_temp)
+		return -ENODEV;
+
+#ifdef CONFIG_THERMAL
+	ret = thermal_zone_get_temp(cm->tzd_batt, (unsigned long *)temp);
+	if (!ret)
+		/* Calibrate temperature unit */
+		*temp /= 100;
+#else
+	ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
+				POWER_SUPPLY_PROP_TEMP,
+				(union power_supply_propval *)temp);
+#endif
+	return ret;
+}
+
+static int cm_check_thermal_status(struct charger_manager *cm)
+{
+	struct charger_desc *desc = cm->desc;
+	int temp, upper_limit, lower_limit;
+	int ret = 0;
+
+	ret = cm_get_battery_temperature(cm, &temp);
+	if (ret) {
+		/* FIXME:
+		 * No information of battery temperature might
+		 * occur hazadous result. We have to handle it
+		 * depending on battery type.
+		 */
+		dev_err(cm->dev, "Failed to get battery temperature\n");
+		return 0;
+	}
+
+	upper_limit = desc->temp_max;
+	lower_limit = desc->temp_min;
+
+	if (cm->emergency_stop) {
+		upper_limit -= desc->temp_diff;
+		lower_limit += desc->temp_diff;
+	}
+
+	if (temp > upper_limit)
+		ret = CM_EVENT_BATT_OVERHEAT;
+	else if (temp < lower_limit)
+		ret = CM_EVENT_BATT_COLD;
+
+	return ret;
+}
+
 /**
  * _cm_monitor - Monitor the temperature and return true for exceptions.
  * @cm: the Charger Manager representing the battery.
@@ -549,28 +613,22 @@ static int check_charging_duration(struct charger_manager *cm)
  */
 static bool _cm_monitor(struct charger_manager *cm)
 {
-	struct charger_desc *desc = cm->desc;
-	int temp = desc->temperature_out_of_range(&cm->last_temp_mC);
+	int temp_alrt;
 
-	dev_dbg(cm->dev, "monitoring (%2.2d.%3.3dC)\n",
-		cm->last_temp_mC / 1000, cm->last_temp_mC % 1000);
+	temp_alrt = cm_check_thermal_status(cm);
 
 	/* It has been stopped already */
-	if (temp && cm->emergency_stop)
+	if (temp_alrt && cm->emergency_stop)
 		return false;
 
 	/*
 	 * Check temperature whether overheat or cold.
 	 * If temperature is out of range normal state, stop charging.
 	 */
-	if (temp) {
-		cm->emergency_stop = temp;
-		if (!try_charger_enable(cm, false)) {
-			if (temp > 0)
-				uevent_notify(cm, "OVERHEAT");
-			else
-				uevent_notify(cm, "COLD");
-		}
+	if (temp_alrt) {
+		cm->emergency_stop = temp_alrt;
+		if (!try_charger_enable(cm, false))
+			uevent_notify(cm, default_event_names[temp_alrt]);
 
 	/*
 	 * Check whole charging duration and discharing duration
@@ -802,21 +860,8 @@ static int charger_get_property(struct power_supply *psy,
 				POWER_SUPPLY_PROP_CURRENT_NOW, val);
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
-		/* in thenth of centigrade */
-		if (cm->last_temp_mC == INT_MIN)
-			desc->temperature_out_of_range(&cm->last_temp_mC);
-		val->intval = cm->last_temp_mC / 100;
-		if (!desc->measure_battery_temp)
-			ret = -ENODEV;
-		break;
 	case POWER_SUPPLY_PROP_TEMP_AMBIENT:
-		/* in thenth of centigrade */
-		if (cm->last_temp_mC == INT_MIN)
-			desc->temperature_out_of_range(&cm->last_temp_mC);
-		val->intval = cm->last_temp_mC / 100;
-		if (desc->measure_battery_temp)
-			ret = -ENODEV;
-		break;
+		return cm_get_battery_temperature(cm, &val->intval);
 	case POWER_SUPPLY_PROP_CAPACITY:
 		if (!cm->fuel_gauge) {
 			ret = -ENODEV;
@@ -1439,6 +1484,50 @@ err:
 	return ret;
 }
 
+static int cm_init_thermal_data(struct charger_manager *cm)
+{
+	struct charger_desc *desc = cm->desc;
+	union power_supply_propval val;
+	int ret;
+
+	/* Verify whether fuel gauge provides battery temperature */
+	ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
+					POWER_SUPPLY_PROP_TEMP, &val);
+
+	if (!ret) {
+		cm->charger_psy.properties[cm->charger_psy.num_properties] =
+				POWER_SUPPLY_PROP_TEMP;
+		cm->charger_psy.num_properties++;
+		cm->desc->measure_battery_temp = true;
+	}
+#ifdef CONFIG_THERMAL
+	cm->tzd_batt = cm->fuel_gauge->tzd;
+
+	if (ret && desc->thermal_zone) {
+		cm->tzd_batt =
+			thermal_zone_get_zone_by_name(desc->thermal_zone);
+		if (IS_ERR(cm->tzd_batt))
+			return PTR_ERR(cm->tzd_batt);
+
+		/* Use external thermometer */
+		cm->charger_psy.properties[cm->charger_psy.num_properties] =
+				POWER_SUPPLY_PROP_TEMP_AMBIENT;
+		cm->charger_psy.num_properties++;
+		cm->desc->measure_battery_temp = true;
+		ret = 0;
+	}
+#endif
+	if (cm->desc->measure_battery_temp) {
+		/* NOTICE : Default allowable minimum charge temperature is 0 */
+		if (!desc->temp_max)
+			desc->temp_max = CM_DEFAULT_CHARGE_TEMP_MAX;
+		if (!desc->temp_diff)
+			desc->temp_diff = CM_DEFAULT_RECHARGE_TEMP_DIFF;
+	}
+
+	return ret;
+}
+
 static int charger_manager_probe(struct platform_device *pdev)
 {
 	struct charger_desc *desc = dev_get_platdata(&pdev->dev);
@@ -1470,7 +1559,6 @@ static int charger_manager_probe(struct platform_device *pdev)
 	/* Basic Values. Unspecified are Null or 0 */
 	cm->dev = &pdev->dev;
 	cm->desc = desc;
-	cm->last_temp_mC = INT_MIN; /* denotes "unmeasured, yet" */
 
 	/*
 	 * The following two do not need to be errors.
@@ -1533,11 +1621,6 @@ static int charger_manager_probe(struct platform_device *pdev)
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
@@ -1583,14 +1666,10 @@ static int charger_manager_probe(struct platform_device *pdev)
 		cm->charger_psy.num_properties++;
 	}
 
-	if (desc->measure_battery_temp) {
-		cm->charger_psy.properties[cm->charger_psy.num_properties] =
-				POWER_SUPPLY_PROP_TEMP;
-		cm->charger_psy.num_properties++;
-	} else {
-		cm->charger_psy.properties[cm->charger_psy.num_properties] =
-				POWER_SUPPLY_PROP_TEMP_AMBIENT;
-		cm->charger_psy.num_properties++;
+	ret = cm_init_thermal_data(cm);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to initialize thermal data\n");
+		cm->desc->measure_battery_temp = false;
 	}
 
 	INIT_DELAYED_WORK(&cm->fullbatt_vchk_work, fullbatt_vchk);
diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
index 0e86840..9aec029 100644
--- a/include/linux/power/charger-manager.h
+++ b/include/linux/power/charger-manager.h
@@ -37,6 +37,8 @@ enum cm_event_types {
 	CM_EVENT_BATT_FULL,
 	CM_EVENT_BATT_IN,
 	CM_EVENT_BATT_OUT,
+	CM_EVENT_BATT_OVERHEAT,
+	CM_EVENT_BATT_COLD,
 	CM_EVENT_EXT_PWR_IN_OUT,
 	CM_EVENT_CHG_START_STOP,
 	CM_EVENT_OTHERS,
@@ -173,11 +175,10 @@ struct charger_regulator {
  * @num_charger_regulator: the number of entries in charger_regulators
  * @charger_regulators: array of charger regulators
  * @psy_fuel_gauge: the name of power-supply for fuel gauge
- * @temperature_out_of_range:
- *	Determine whether the status is overheat or cold or normal.
- *	return_value > 0: overheat
- *	return_value == 0: normal
- *	return_value < 0: cold
+ * @thermal_zone : the name of thermal zone for battery
+ * @temp_min : Minimum battery temperature for charging.
+ * @temp_max : Maximum battery temperature for charging.
+ * @temp_diff : Temperature diffential to restart charging.
  * @measure_battery_temp:
  *	true: measure battery temperature
  *	false: measure ambient temperature
@@ -210,7 +211,12 @@ struct charger_desc {
 
 	char *psy_fuel_gauge;
 
-	int (*temperature_out_of_range)(int *mC);
+	char *thermal_zone;
+
+	int temp_min;
+	int temp_max;
+	int temp_diff;
+
 	bool measure_battery_temp;
 
 	u64 charging_max_duration_ms;
@@ -226,13 +232,13 @@ struct charger_desc {
  * @desc: instance of charger_desc
  * @fuel_gauge: power_supply for fuel gauge
  * @charger_stat: array of power_supply for chargers
+ * @tzd_batt : thermal zone device for battery
  * @charger_enabled: the state of charger
  * @fullbatt_vchk_jiffies_at:
  *	jiffies at the time full battery check will occur.
  * @fullbatt_vchk_work: work queue for full battery check
  * @emergency_stop:
  *	When setting true, stop charging
- * @last_temp_mC: the measured temperature in milli-Celsius
  * @psy_name_buf: the name of power-supply-class for charger manager
  * @charger_psy: power_supply for charger manager
  * @status_save_ext_pwr_inserted:
@@ -250,13 +256,15 @@ struct charger_manager {
 	struct power_supply *fuel_gauge;
 	struct power_supply **charger_stat;
 
+#ifdef CONFIG_THERMAL
+	struct thermal_zone_device *tzd_batt;
+#endif
 	bool charger_enabled;
 
 	unsigned long fullbatt_vchk_jiffies_at;
 	struct delayed_work fullbatt_vchk_work;
 
 	int emergency_stop;
-	int last_temp_mC;
 
 	char psy_name_buf[PSY_NAME_MAX + 1];
 	struct power_supply charger_psy;
-- 
1.7.9.5

