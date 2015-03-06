From: Jenny TC <jenny.tc@intel.com>
Subject: [RFC 4/4] charger-manager: Enable psy based charge control
Date: Fri,  6 Mar 2015 16:03:27 +0530
Message-ID: <1425638007-9411-5-git-send-email-jenny.tc@intel.com>
References: <1425638007-9411-1-git-send-email-jenny.tc@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425638007-9411-1-git-send-email-jenny.tc@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: Anton Vorontsov <anton.vorontsov@linaro.org>, David Woodhouse <dwmw2@infradead.org>, jonghwa3.lee@samsung.com, myungjoo.ham@gmail.com, Pallala Ramakrishna <ramakrishna.pallala@intel.com>, Jenny TC <jenny.tc@intel.com>
List-Id: linux-pm@vger.kernel.org

At present charger manager support only regulator based charging
control. But most of the charger drivers are registered with power
supply subsystem. This patch adds support for power supply based
charging control along with the regulator based control. With the
patch, charging control can be done either using power supply
interface or with regulator interface. The charging is setup
based on battery parameters received through the battery info
handlers.

Signed-off-by: Jenny TC <jenny.tc@intel.com>
---
 drivers/power/charger-manager.c       |  486 +++++++++++++++++++++++++--------
 include/linux/power/charger-manager.h |   30 +-
 2 files changed, 399 insertions(+), 117 deletions(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 14b0d85..b455ac2 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -42,6 +42,7 @@ static const char * const default_event_names[] = {
 	[CM_EVENT_BATT_OUT] = "Battery Pulled Out",
 	[CM_EVENT_BATT_OVERHEAT] = "Battery Overheat",
 	[CM_EVENT_BATT_COLD] = "Battery Cold",
+	[CM_EVENT_BATT_TZONE_CHANGE] = "Battery Temp Zone Change",
 	[CM_EVENT_EXT_PWR_IN_OUT] = "External Power Attach/Detach",
 	[CM_EVENT_CHG_START_STOP] = "Charging Start/Stop",
 	[CM_EVENT_OTHERS] = "Other battery events"
@@ -81,6 +82,97 @@ static unsigned long next_polling; /* Next appointed polling time */
 static struct workqueue_struct *cm_wq; /* init at driver add */
 static struct delayed_work cm_monitor_work; /* init at driver add */
 
+static inline int psy_set_charger_contol_prop(struct power_supply *psy,
+			    enum psy_charger_control_property pscp,
+			    const union power_supply_propval *val)
+{
+	struct power_supply_charger *psyc;
+
+	psyc = psy->psy_charger;
+
+	if (psyc && psyc->set_property)
+		return psyc->set_property(psyc, pscp, val);
+
+	return -EINVAL;
+}
+
+static inline int psy_get_charger_contol_prop(struct power_supply *psy,
+			    enum psy_charger_control_property pscp,
+			    union power_supply_propval *val)
+{
+	struct power_supply_charger *psyc;
+
+	psyc = psy->psy_charger;
+
+	if (psyc && psyc->get_property)
+		return psyc->get_property(psyc, pscp, val);
+
+	return -EINVAL;
+}
+
+static inline int psy_enable_charger(struct power_supply *psy, bool enable)
+{
+	union power_supply_propval prop_val;
+
+	prop_val.intval = enable;
+	return psy_set_charger_contol_prop(psy,
+				PSY_CHARGER_PROP_ENABLE_CHARGER, &prop_val);
+}
+
+static inline int psy_is_charger_enabled(struct power_supply *psy)
+{
+	union power_supply_propval prop_val;
+	int ret;
+
+	ret = psy_get_charger_contol_prop(psy,
+				PSY_CHARGER_PROP_ENABLE_CHARGER, &prop_val);
+	if (ret)
+		return ret;
+
+	return prop_val.intval;
+}
+
+static inline int psy_set_inlimit(struct power_supply *psy, int inlimit)
+{
+	union power_supply_propval prop_val;
+
+	prop_val.intval = inlimit;
+	return power_supply_set_property(psy,
+				POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+				&prop_val);
+}
+
+static int enable_charger(struct charger_controller *charger, bool enable)
+{
+	if (charger->regulator_control) {
+		if (enable)
+			return regulator_enable(charger->regulator_control);
+		else
+			return regulator_disable(charger->regulator_control);
+	}
+
+	return psy_enable_charger(charger->psy_control, enable);
+}
+
+static int is_charger_enabled(struct charger_controller *charger)
+{
+	if (charger->regulator_control)
+		return regulator_is_enabled(charger->regulator_control);
+
+	return psy_is_charger_enabled(charger->psy_control);
+}
+
+static int set_input_current(struct charger_cable *cable)
+{
+	if (cable->charger->regulator_control)
+		return regulator_set_current_limit(
+					cable->charger->regulator_control,
+					cable->min_uA, cable->max_uA);
+
+	return psy_set_inlimit(cable->charger->psy_control,
+					cable->max_uA / 1000);
+}
+
 /**
  * is_batt_present - See if the battery presents in place.
  * @cm: the Charger Manager representing the battery.
@@ -328,6 +420,140 @@ static bool is_polling_required(struct charger_manager *cm)
 	return false;
 }
 
+static int get_temp_zone_index(struct psy_charging_obj *cobj, int temp)
+{
+	int i, tzone_count;
+
+	tzone_count = cobj->temp_mon_count > PSY_MAX_TEMP_ZONE ?
+				PSY_MAX_TEMP_ZONE : cobj->temp_mon_count;
+
+	for (i = 0; i < tzone_count; i++) {
+		if (temp <=  cobj->temp_mon_table[i].temp_max &&
+				temp > cobj->temp_mon_table[i].temp_min)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int cm_get_battery_temperature_by_psy(struct charger_manager *cm,
+					int *temp)
+{
+	struct power_supply *fuel_gauge;
+
+	fuel_gauge = power_supply_get_by_name(cm->desc->psy_fuel_gauge);
+	if (!fuel_gauge)
+		return -ENODEV;
+
+	return fuel_gauge->get_property(fuel_gauge,
+				POWER_SUPPLY_PROP_TEMP,
+				(union power_supply_propval *)temp);
+}
+
+static int cm_get_battery_temperature(struct charger_manager *cm,
+					int *temp)
+{
+	int ret;
+
+	if (!cm->desc->measure_battery_temp)
+		return -ENODEV;
+
+#ifdef CONFIG_THERMAL
+	if (cm->tzd_batt) {
+		ret = thermal_zone_get_temp(cm->tzd_batt,
+					(unsigned long *)temp);
+		if (!ret)
+			/* Calibrate temperature unit */
+			*temp /= 100;
+	} else
+#endif
+	{
+		/* if-else continued from CONFIG_THERMAL */
+		ret = cm_get_battery_temperature_by_psy(cm, temp);
+	}
+
+	return ret;
+}
+
+
+
+static inline int get_cc_cv(struct charger_manager *cm,
+		int *cc, int *cv)
+
+{
+	int temp, ret, tzone_index;
+	struct psy_charging_obj *cobj;
+
+	ret = cm_get_battery_temperature(cm, &temp);
+	if (ret < 0)
+		return ret;
+
+	cobj = cm->battery_info;
+	tzone_index = get_temp_zone_index(cobj, temp);
+
+	if (tzone_index < 0)
+		return tzone_index;
+
+	*cc = cobj->temp_mon_table[tzone_index].charging_current;
+	*cv = cobj->temp_mon_table[tzone_index].charging_voltage;
+
+	return 0;
+}
+
+static inline int configure_charger_params(struct charger_manager *cm,
+	struct charger_controller *charger)
+{
+	int ret = 0, cc = 0, cv = 0;
+	union power_supply_propval val;
+
+	if (charger->regulator_control)
+		return 0;
+
+	if (charger->psy_control && cm->battery_info) {
+		ret = get_cc_cv(cm, &cc, &cv);
+		if (ret < 0)
+			return ret;
+
+		val.intval = cc;
+		ret = power_supply_set_property(charger->psy_control,
+				POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+				&val);
+
+		if (ret)
+			return ret;
+
+		val.intval = cv;
+		ret = power_supply_set_property(charger->psy_control,
+				POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+				&val);
+		if (ret)
+			return ret;
+
+		val.intval = cm->battery_info->iterm;
+		ret = power_supply_set_property(charger->psy_control,
+				POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+				&val);
+
+		if (ret)
+			return ret;
+
+		val.intval = cm->battery_info->temp_max;
+		ret = power_supply_set_property(charger->psy_control,
+				POWER_SUPPLY_PROP_TEMP_MAX,
+				&val);
+		if (ret)
+			return ret;
+
+		val.intval = cm->battery_info->temp_min;
+		ret = power_supply_set_property(charger->psy_control,
+				POWER_SUPPLY_PROP_TEMP_MIN,
+				&val);
+	}
+
+	return ret;
+}
+
+
 /**
  * try_charger_enable - Enable/Disable chargers altogether
  * @cm: the Charger Manager representing the battery.
@@ -341,7 +567,10 @@ static bool is_polling_required(struct charger_manager *cm)
 static int try_charger_enable(struct charger_manager *cm, bool enable)
 {
 	int err = 0, i;
+	const char *charger_name;
 	struct charger_desc *desc = cm->desc;
+	struct charger_controller *charger;
+	struct regulator *reg_ctrl;
 
 	/* Ignore if it's redundent command */
 	if (enable == cm->charger_enabled)
@@ -358,14 +587,24 @@ static int try_charger_enable(struct charger_manager *cm, bool enable)
 		cm->charging_start_time = ktime_to_ms(ktime_get());
 		cm->charging_end_time = 0;
 
-		for (i = 0 ; i < desc->num_charger_regulators ; i++) {
-			if (desc->charger_regulators[i].externally_control)
+		for (i = 0 ; i < desc->num_charger_controllers ; i++) {
+
+			charger =  &desc->charger_controllers[i];
+
+			if (charger->externally_control)
 				continue;
 
-			err = regulator_enable(desc->charger_regulators[i].consumer);
+			err = enable_charger(charger, true);
+			charger_name = charger->regulator_control ?
+					charger->regulator_name :
+					charger->psy_name;
 			if (err < 0) {
 				dev_warn(cm->dev, "Cannot enable %s regulator\n",
-					 desc->charger_regulators[i].regulator_name);
+						charger_name);
+			} else if (configure_charger_params(cm, charger) < 0) {
+				err = enable_charger(charger, false);
+				dev_warn(cm->dev, "Failed to configure %s\n",
+						charger_name);
 			}
 		}
 	} else {
@@ -376,14 +615,19 @@ static int try_charger_enable(struct charger_manager *cm, bool enable)
 		cm->charging_start_time = 0;
 		cm->charging_end_time = ktime_to_ms(ktime_get());
 
-		for (i = 0 ; i < desc->num_charger_regulators ; i++) {
-			if (desc->charger_regulators[i].externally_control)
+		for (i = 0 ; i < desc->num_charger_controllers ; i++) {
+
+			charger =  &desc->charger_controllers[i];
+			if (charger->externally_control)
 				continue;
 
-			err = regulator_disable(desc->charger_regulators[i].consumer);
+			err = enable_charger(charger, false);
 			if (err < 0) {
+				charger_name = charger->regulator_control ?
+						charger->regulator_name :
+						charger->psy_name;
 				dev_warn(cm->dev, "Cannot disable %s regulator\n",
-					 desc->charger_regulators[i].regulator_name);
+						charger_name);
 			}
 		}
 
@@ -391,13 +635,15 @@ static int try_charger_enable(struct charger_manager *cm, bool enable)
 		 * Abnormal battery state - Stop charging forcibly,
 		 * even if charger was enabled at the other places
 		 */
-		for (i = 0; i < desc->num_charger_regulators; i++) {
-			if (regulator_is_enabled(
-				    desc->charger_regulators[i].consumer)) {
-				regulator_force_disable(
-					desc->charger_regulators[i].consumer);
+		for (i = 0; i < desc->num_charger_controllers; i++) {
+			if (!desc->charger_controllers[i].regulator_control)
+				continue;
+			reg_ctrl =
+				desc->charger_controllers[i].regulator_control;
+			if (regulator_is_enabled(reg_ctrl)) {
+				regulator_force_disable(reg_ctrl);
 				dev_warn(cm->dev, "Disable regulator(%s) forcibly\n",
-					 desc->charger_regulators[i].regulator_name);
+				  desc->charger_controllers[i].regulator_name);
 			}
 		}
 	}
@@ -571,48 +817,11 @@ static int check_charging_duration(struct charger_manager *cm)
 	return ret;
 }
 
-static int cm_get_battery_temperature_by_psy(struct charger_manager *cm,
-					int *temp)
-{
-	struct power_supply *fuel_gauge;
-
-	fuel_gauge = power_supply_get_by_name(cm->desc->psy_fuel_gauge);
-	if (!fuel_gauge)
-		return -ENODEV;
-
-	return fuel_gauge->get_property(fuel_gauge,
-				POWER_SUPPLY_PROP_TEMP,
-				(union power_supply_propval *)temp);
-}
-
-static int cm_get_battery_temperature(struct charger_manager *cm,
-					int *temp)
-{
-	int ret;
-
-	if (!cm->desc->measure_battery_temp)
-		return -ENODEV;
-
-#ifdef CONFIG_THERMAL
-	if (cm->tzd_batt) {
-		ret = thermal_zone_get_temp(cm->tzd_batt, (unsigned long *)temp);
-		if (!ret)
-			/* Calibrate temperature unit */
-			*temp /= 100;
-	} else
-#endif
-	{
-		/* if-else continued from CONFIG_THERMAL */
-		ret = cm_get_battery_temperature_by_psy(cm, temp);
-	}
-
-	return ret;
-}
 
 static int cm_check_thermal_status(struct charger_manager *cm)
 {
 	struct charger_desc *desc = cm->desc;
-	int temp, upper_limit, lower_limit;
+	int temp, upper_limit, lower_limit, tzone_index = -1;
 	int ret = 0;
 
 	ret = cm_get_battery_temperature(cm, &temp);
@@ -638,6 +847,13 @@ static int cm_check_thermal_status(struct charger_manager *cm)
 		ret = CM_EVENT_BATT_OVERHEAT;
 	else if (temp < lower_limit)
 		ret = CM_EVENT_BATT_COLD;
+	else if (cm->battery_info)
+		tzone_index = get_temp_zone_index(cm->battery_info, temp);
+
+	if (tzone_index > 0 && cm->temp_zone != tzone_index) {
+		ret = CM_EVENT_BATT_TZONE_CHANGE;
+		cm->temp_zone = tzone_index;
+	}
 
 	return ret;
 }
@@ -656,14 +872,15 @@ static bool _cm_monitor(struct charger_manager *cm)
 	temp_alrt = cm_check_thermal_status(cm);
 
 	/* It has been stopped already */
-	if (temp_alrt && cm->emergency_stop)
+	if (temp_alrt &&  temp_alrt != CM_EVENT_BATT_TZONE_CHANGE
+			&& cm->emergency_stop)
 		return false;
 
 	/*
 	 * Check temperature whether overheat or cold.
 	 * If temperature is out of range normal state, stop charging.
 	 */
-	if (temp_alrt) {
+	 if (temp_alrt && temp_alrt != CM_EVENT_BATT_TZONE_CHANGE) {
 		cm->emergency_stop = temp_alrt;
 		if (!try_charger_enable(cm, false))
 			uevent_notify(cm, default_event_names[temp_alrt]);
@@ -698,6 +915,16 @@ static bool _cm_monitor(struct charger_manager *cm)
 		fullbatt_vchk(&cm->fullbatt_vchk_work.work);
 	} else {
 		cm->emergency_stop = 0;
+		/*
+		 * Check temperature zone changed or not
+		 */
+		if (temp_alrt == CM_EVENT_BATT_TZONE_CHANGE) {
+			/*
+			 * Set charger_enabled = false to force charger enable
+			 * and configure charger with new params
+			 */
+			cm->charger_enabled = false;
+		}
 		if (is_ext_pwr_online(cm)) {
 			if (!try_charger_enable(cm, true))
 				uevent_notify(cm, "CHARGING");
@@ -1107,18 +1334,22 @@ static void charger_extcon_work(struct work_struct *work)
 	struct charger_cable *cable =
 			container_of(work, struct charger_cable, wq);
 	int ret;
+	const char *charger_name;
+
+	charger_name = cable->charger->regulator_name ?
+				cable->charger->regulator_name :
+				cable->charger->psy_name;
 
 	if (cable->attached && cable->min_uA != 0 && cable->max_uA != 0) {
-		ret = regulator_set_current_limit(cable->charger->consumer,
-					cable->min_uA, cable->max_uA);
+		ret = set_input_current(cable);
 		if (ret < 0) {
 			pr_err("Cannot set current limit of %s (%s)\n",
-			       cable->charger->regulator_name, cable->name);
+				charger_name, cable->name);
 			return;
 		}
 
 		pr_info("Set current limit of %s : %duA ~ %duA\n",
-			cable->charger->regulator_name,
+			charger_name,
 			cable->min_uA, cable->max_uA);
 	}
 
@@ -1206,21 +1437,32 @@ static int charger_extcon_init(struct charger_manager *cm,
 static int charger_manager_register_extcon(struct charger_manager *cm)
 {
 	struct charger_desc *desc = cm->desc;
-	struct charger_regulator *charger;
+	struct charger_controller *charger;
 	int ret = 0;
 	int i;
 	int j;
 
-	for (i = 0; i < desc->num_charger_regulators; i++) {
-		charger = &desc->charger_regulators[i];
+	for (i = 0; i < desc->num_charger_controllers; i++) {
+		charger = &desc->charger_controllers[i];
 
-		charger->consumer = regulator_get(cm->dev,
+		if (charger->regulator_name) {
+			charger->regulator_control = regulator_get(cm->dev,
+						charger->regulator_name);
+			if (IS_ERR(charger->regulator_control)) {
+				dev_err(cm->dev, "Cannot find charger control(%s)\n",
 					charger->regulator_name);
-		if (IS_ERR(charger->consumer)) {
-			dev_err(cm->dev, "Cannot find charger(%s)\n",
-				charger->regulator_name);
-			return PTR_ERR(charger->consumer);
+				return PTR_ERR(charger->regulator_control);
+			}
+		} else if (charger->psy_name) {
+			charger->psy_control = power_supply_get_by_name(
+							charger->psy_name);
+			if (IS_ERR_OR_NULL(charger->psy_control)) {
+				dev_err(cm->dev, "Cannot find charger control(%s)\n",
+					charger->psy_name);
+				return -EINVAL;
+			}
 		}
+
 		charger->cm = cm;
 
 		for (j = 0; j < charger->num_cables; j++) {
@@ -1245,8 +1487,8 @@ err:
 static ssize_t charger_name_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct charger_regulator *charger
-		= container_of(attr, struct charger_regulator, attr_name);
+	struct charger_controller *charger
+		= container_of(attr, struct charger_controller, attr_name);
 
 	return sprintf(buf, "%s\n", charger->regulator_name);
 }
@@ -1254,12 +1496,12 @@ static ssize_t charger_name_show(struct device *dev,
 static ssize_t charger_state_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct charger_regulator *charger
-		= container_of(attr, struct charger_regulator, attr_state);
+	struct charger_controller *charger
+		= container_of(attr, struct charger_controller, attr_state);
 	int state = 0;
 
 	if (!charger->externally_control)
-		state = regulator_is_enabled(charger->consumer);
+		state = is_charger_enabled(charger);
 
 	return sprintf(buf, "%s\n", state ? "enabled" : "disabled");
 }
@@ -1267,8 +1509,8 @@ static ssize_t charger_state_show(struct device *dev,
 static ssize_t charger_externally_control_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct charger_regulator *charger = container_of(attr,
-			struct charger_regulator, attr_externally_control);
+	struct charger_controller *charger = container_of(attr,
+			struct charger_controller, attr_externally_control);
 
 	return sprintf(buf, "%d\n", charger->externally_control);
 }
@@ -1277,8 +1519,8 @@ static ssize_t charger_externally_control_store(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
 {
-	struct charger_regulator *charger
-		= container_of(attr, struct charger_regulator,
+	struct charger_controller *charger
+		= container_of(attr, struct charger_controller,
 					attr_externally_control);
 	struct charger_manager *cm = charger->cm;
 	struct charger_desc *desc = cm->desc;
@@ -1298,9 +1540,9 @@ static ssize_t charger_externally_control_store(struct device *dev,
 		return count;
 	}
 
-	for (i = 0; i < desc->num_charger_regulators; i++) {
-		if (&desc->charger_regulators[i] != charger &&
-			!desc->charger_regulators[i].externally_control) {
+	for (i = 0; i < desc->num_charger_controllers; i++) {
+		if (&desc->charger_controllers[i] != charger &&
+			!desc->charger_controllers[i].externally_control) {
 			/*
 			 * At least, one charger is controlled by
 			 * charger-manager
@@ -1343,7 +1585,7 @@ static ssize_t charger_externally_control_store(struct device *dev,
 static int charger_manager_register_sysfs(struct charger_manager *cm)
 {
 	struct charger_desc *desc = cm->desc;
-	struct charger_regulator *charger;
+	struct charger_controller *charger;
 	int chargers_externally_control = 1;
 	char buf[11];
 	char *str;
@@ -1351,8 +1593,8 @@ static int charger_manager_register_sysfs(struct charger_manager *cm)
 	int i;
 
 	/* Create sysfs entry to control charger(regulator) */
-	for (i = 0; i < desc->num_charger_regulators; i++) {
-		charger = &desc->charger_regulators[i];
+	for (i = 0; i < desc->num_charger_controllers; i++) {
+		charger = &desc->charger_controllers[i];
 
 		snprintf(buf, 10, "charger.%d", i);
 		str = devm_kzalloc(cm->dev,
@@ -1389,7 +1631,7 @@ static int charger_manager_register_sysfs(struct charger_manager *cm)
 		charger->attr_externally_control.store
 				= charger_externally_control_store;
 
-		if (!desc->charger_regulators[i].externally_control ||
+		if (!desc->charger_controllers[i].externally_control ||
 				!chargers_externally_control)
 			chargers_externally_control = 0;
 
@@ -1449,11 +1691,19 @@ static int cm_init_thermal_data(struct charger_manager *cm,
 	}
 #endif
 	if (cm->desc->measure_battery_temp) {
-		/* NOTICE : Default allowable minimum charge temperature is 0 */
-		if (!desc->temp_max)
-			desc->temp_max = CM_DEFAULT_CHARGE_TEMP_MAX;
-		if (!desc->temp_diff)
+
+		if (!cm->battery_info) {
+			if (!desc->temp_max)
+				desc->temp_max = CM_DEFAULT_CHARGE_TEMP_MAX;
+			if (!desc->temp_diff)
+				desc->temp_diff = CM_DEFAULT_RECHARGE_TEMP_DIFF;
+		} else {
+			desc->temp_max = cm->battery_info->temp_max;
+			desc->temp_min = cm->battery_info->temp_min;
 			desc->temp_diff = CM_DEFAULT_RECHARGE_TEMP_DIFF;
+		}
+
+		/* NOTICE : Default allowable minimum charge temperature is 0 */
 	}
 
 	return ret;
@@ -1530,18 +1780,18 @@ static struct charger_desc *of_cm_parse_desc(struct device *dev)
 				&desc->discharging_max_duration_ms);
 
 	/* battery charger regualtors */
-	desc->num_charger_regulators = of_get_child_count(np);
-	if (desc->num_charger_regulators) {
-		struct charger_regulator *chg_regs;
+	desc->num_charger_controllers = of_get_child_count(np);
+	if (desc->num_charger_controllers) {
+		struct charger_controller *chg_regs;
 		struct device_node *child;
 
 		chg_regs = devm_kzalloc(dev, sizeof(*chg_regs)
-					* desc->num_charger_regulators,
+					* desc->num_charger_controllers,
 					GFP_KERNEL);
 		if (!chg_regs)
 			return ERR_PTR(-ENOMEM);
 
-		desc->charger_regulators = chg_regs;
+		desc->charger_controllers = chg_regs;
 
 		for_each_child_of_node(np, child) {
 			struct charger_cable *cables;
@@ -1582,6 +1832,20 @@ static struct charger_desc *of_cm_parse_desc(struct device *dev)
 	return desc;
 }
 
+static int battery_info_handler(struct notifier_block *self,
+				   unsigned long event, void *info)
+{
+	struct charger_manager *cm =
+		container_of(self, struct charger_manager, batt_info_nb);
+
+	if (event == PSY_BATT_INFO_UNREGISTERED)
+		cm->battery_info = NULL;
+	else if (event == PSY_BATT_INFO_REGISTERED)
+		cm->battery_info = (struct psy_charging_obj *) info;
+
+	return NOTIFY_OK;
+}
+
 static inline struct charger_desc *cm_get_drv_data(struct platform_device *pdev)
 {
 	if (pdev->dev.of_node)
@@ -1643,8 +1907,8 @@ static int charger_manager_probe(struct platform_device *pdev)
 		dev_info(&pdev->dev, "Ignoring full-battery full capacity threshold as it is not supplied\n");
 	}
 
-	if (!desc->charger_regulators || desc->num_charger_regulators < 1) {
-		dev_err(&pdev->dev, "charger_regulators undefined\n");
+	if (!desc->charger_controllers || desc->num_charger_controllers < 1) {
+		dev_err(&pdev->dev, "charger_controllers undefined\n");
 		return -EINVAL;
 	}
 
@@ -1704,6 +1968,10 @@ static int charger_manager_probe(struct platform_device *pdev)
 		strncpy(cm->psy_name_buf, desc->psy_name, PSY_NAME_MAX);
 	cm->charger_psy.name = cm->psy_name_buf;
 
+	if (!power_supply_get_property(fuel_gauge, POWER_SUPPLY_PROP_MODEL_NAME,
+						&val))
+		cm->battery_info = psy_get_battery_info(val.strval);
+
 	/* Allocate for psy properties because they may vary */
 	cm->charger_psy.properties = devm_kzalloc(&pdev->dev,
 				sizeof(enum power_supply_property)
@@ -1753,7 +2021,6 @@ static int charger_manager_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Cannot initialize extcon device\n");
 		goto err_reg_extcon;
 	}
-
 	/* Register sysfs entry for charger(regulator) */
 	ret = charger_manager_register_sysfs(cm);
 	if (ret < 0) {
@@ -1773,6 +2040,8 @@ static int charger_manager_probe(struct platform_device *pdev)
 	 */
 	device_init_wakeup(&pdev->dev, true);
 	device_set_wakeup_capable(&pdev->dev, false);
+	cm->batt_info_nb.notifier_call = battery_info_handler;
+	power_supply_reg_notifier(&cm->batt_info_nb);
 
 	/*
 	 * Charger-manager have to check the charging state right after
@@ -1786,26 +2055,27 @@ static int charger_manager_probe(struct platform_device *pdev)
 	return 0;
 
 err_reg_sysfs:
-	for (i = 0; i < desc->num_charger_regulators; i++) {
-		struct charger_regulator *charger;
+	for (i = 0; i < desc->num_charger_controllers; i++) {
+		struct charger_controller *charger;
 
-		charger = &desc->charger_regulators[i];
+		charger = &desc->charger_controllers[i];
 		sysfs_remove_group(&cm->charger_psy.dev->kobj,
 				&charger->attr_g);
 	}
 err_reg_extcon:
-	for (i = 0; i < desc->num_charger_regulators; i++) {
-		struct charger_regulator *charger;
+	for (i = 0; i < desc->num_charger_controllers; i++) {
+		struct charger_controller *charger;
 
-		charger = &desc->charger_regulators[i];
+		charger = &desc->charger_controllers[i];
 		for (j = 0; j < charger->num_cables; j++) {
 			struct charger_cable *cable = &charger->cables[j];
 			/* Remove notifier block if only edev exists */
 			if (cable->extcon_dev.edev)
 				extcon_unregister_interest(&cable->extcon_dev);
 		}
-
-		regulator_put(desc->charger_regulators[i].consumer);
+		if (desc->charger_controllers[i].regulator_control)
+			regulator_put(
+			   desc->charger_controllers[i].regulator_control);
 	}
 
 	power_supply_unregister(&cm->charger_psy);
@@ -1828,17 +2098,19 @@ static int charger_manager_remove(struct platform_device *pdev)
 	cancel_work_sync(&setup_polling);
 	cancel_delayed_work_sync(&cm_monitor_work);
 
-	for (i = 0 ; i < desc->num_charger_regulators ; i++) {
-		struct charger_regulator *charger
-				= &desc->charger_regulators[i];
+	for (i = 0 ; i < desc->num_charger_controllers ; i++) {
+		struct charger_controller *charger
+				= &desc->charger_controllers[i];
 		for (j = 0 ; j < charger->num_cables ; j++) {
 			struct charger_cable *cable = &charger->cables[j];
 			extcon_unregister_interest(&cable->extcon_dev);
 		}
 	}
 
-	for (i = 0 ; i < desc->num_charger_regulators ; i++)
-		regulator_put(desc->charger_regulators[i].consumer);
+	for (i = 0 ; i < desc->num_charger_controllers ; i++)
+		if (desc->charger_controllers[i].regulator_control)
+			regulator_put(
+			   desc->charger_controllers[i].regulator_control);
 
 	power_supply_unregister(&cm->charger_psy);
 
diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
index 416ebeb..928cb2d 100644
--- a/include/linux/power/charger-manager.h
+++ b/include/linux/power/charger-manager.h
@@ -40,6 +40,7 @@ enum cm_event_types {
 	CM_EVENT_BATT_OUT,
 	CM_EVENT_BATT_OVERHEAT,
 	CM_EVENT_BATT_COLD,
+	CM_EVENT_BATT_TZONE_CHANGE,
 	CM_EVENT_EXT_PWR_IN_OUT,
 	CM_EVENT_CHG_START_STOP,
 	CM_EVENT_OTHERS,
@@ -58,7 +59,7 @@ enum cm_event_types {
  * @attached: the state of charger cable.
  *	true: the charger cable is attached
  *	false: the charger cable is detached
- * @charger: the instance of struct charger_regulator.
+ * @charger: the instance of struct charger_controller.
  * @cm: the Charger Manager representing the battery.
  */
 struct charger_cable {
@@ -73,7 +74,7 @@ struct charger_cable {
 	/* The state of charger cable */
 	bool attached;
 
-	struct charger_regulator *charger;
+	struct charger_controller *charger;
 
 	/*
 	 * Set min/max current of regulator to protect over-current issue
@@ -86,9 +87,9 @@ struct charger_cable {
 };
 
 /**
- * struct charger_regulator
+ * struct charger_controller
  * @regulator_name: the name of regulator for using charger.
- * @consumer: the regulator consumer for the charger.
+ * @regulator_control: the regulator regulator_control for the charger.
  * @externally_control:
  *	Set if the charger-manager cannot control charger,
  *	the charger will be maintained with disabled state.
@@ -104,10 +105,12 @@ struct charger_cable {
  * @attr_externally_control: "externally_control" sysfs entry
  * @attrs: Arrays pointing to attr_name/state/externally_control for attr_g
  */
-struct charger_regulator {
+struct charger_controller {
 	/* The name of regulator for charging */
 	const char *regulator_name;
-	struct regulator *consumer;
+	struct regulator *regulator_control;
+	const char *psy_name;
+	struct power_supply *psy_control;
 
 	/* charger never on when system is on */
 	int externally_control;
@@ -150,8 +153,8 @@ struct charger_regulator {
  * @battery_present:
  *	Specify where information for existance of battery can be obtained
  * @psy_charger_stat: the names of power-supply for chargers
- * @num_charger_regulator: the number of entries in charger_regulators
- * @charger_regulators: array of charger regulators
+ * @num_charger_controller: the number of entries in charger_controllers
+ * @charger_controllers: array of charger regulators
  * @psy_fuel_gauge: the name of power-supply for fuel gauge
  * @thermal_zone : the name of thermal zone for battery
  * @temp_min : Minimum battery temperature for charging.
@@ -184,8 +187,8 @@ struct charger_desc {
 
 	const char **psy_charger_stat;
 
-	int num_charger_regulators;
-	struct charger_regulator *charger_regulators;
+	int num_charger_controllers;
+	struct charger_controller *charger_controllers;
 
 	const char *psy_fuel_gauge;
 
@@ -217,6 +220,8 @@ struct charger_desc {
  * @fullbatt_vchk_work: work queue for full battery check
  * @emergency_stop:
  *	When setting true, stop charging
+ * @temp_zone: Current battery Temperature zone as defined in
+ *	charging object
  * @psy_name_buf: the name of power-supply-class for charger manager
  * @charger_psy: power_supply for charger manager
  * @status_save_ext_pwr_inserted:
@@ -240,10 +245,15 @@ struct charger_manager {
 	struct delayed_work fullbatt_vchk_work;
 
 	int emergency_stop;
+	int temp_zone;
 
 	char psy_name_buf[PSY_NAME_MAX + 1];
 	struct power_supply charger_psy;
 
+	struct psy_charging_obj *battery_info;
+
+	struct notifier_block batt_info_nb;
+
 	u64 charging_start_time;
 	u64 charging_end_time;
 };
-- 
1.7.9.5
