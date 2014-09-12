From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 6/6] power: charger-manager: Rearrange data and monitor
 focusing battery status.
Date: Fri, 12 Sep 2014 20:11:27 +0900
Message-ID: <1410520287-24825-7-git-send-email-jonghwa3.lee@samsung.com>
References: <1410520287-24825-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35439 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbaILLLi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Sep 2014 07:11:38 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NBS00CK5CFATN30@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 12 Sep 2014 20:11:34 +0900 (KST)
In-reply-to: <1410520287-24825-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

It rearrages data up to its charateristic, and separates into individual
instances. Now, charger manager deals different entities which represent
each of 'charger device', 'battery', 'charing constraints'.
With this modification, charger manager can be focusing on battery status and
optimize decision procedure.

The main role of charger manager is that guerantee safety charging in boundary
of thermal limitation. Updated version of drvier satisfies the requirement and
also supports more rapid responsiveness with changing of battery status.

As a result, it reduces decision time about three time less than former driver.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
---
 .../bindings/power_supply/charger-manager.txt      |   84 +-
 drivers/power/Kconfig                              |    2 +-
 drivers/power/charger-manager.c                    | 1532 +++++++++-----------
 include/linux/power/charger-manager.h              |  264 ++--
 4 files changed, 813 insertions(+), 1069 deletions(-)

diff --git a/Documentation/devicetree/bindings/power_supply/charger-manager.txt b/Documentation/devicetree/bindings/power_supply/charger-manager.txt
index 827576e..4722e4c 100644
--- a/Documentation/devicetree/bindings/power_supply/charger-manager.txt
+++ b/Documentation/devicetree/bindings/power_supply/charger-manager.txt
@@ -3,31 +3,38 @@ charger-manager bindings
 
 Required properties :
  - compatible : "charger-manager"
- - <>-supply : for regulator consumer
- - cm-num-chargers : number of chargers
- - cm-chargers : name of chargers
- - cm-fuel-gauge : name of battery fuel gauge
- - subnode <regulator> :
+ - subnode <constraints> :
+	- cm-charging-duration : limits of charging duration
+	- cm-temp-* : threshold battery temperature for charging
+		-cold : critical cold temperature of battery for charging
+		-cold-in-minus : flag that cold temperature is in minus degrees
+		-hot : critical hot temperature of battery for charging
+		-diff : temperature difference to allow recharging
+	- cm-fullbatt/recharging-* : full battery / recharging conditions
+		-soc : full battery state-of-charge (%)
+		-voltage : full battery voltage (uV)
+		-capacity : full battery capacity (mAh)
+		-status : charger status
+		-count : number of trials for checking full battery
+	- cm-top-off-time : top off mode duration
+ - subnode <battery> :
+	- cm-fuel-gauge : name of battery fuel gauge
+	- cm-thermal-zone : name of battery thermal zone
+	(It will try to use fuelgauge's unless it is defined.)
+ - subnode <charger> :
+	- cm-charger : name of charger
 	- cm-regulator-name : name of charger regulator
+	- cm-charger-max-cc : maximum charging current allowed
 	- subnode <cable> :
 		- cm-cable-name : name of charger cable
 		- cm-cable-extcon : name of extcon dev
-(optional)	- cm-cable-min : minimum current of cable
-(optional)	- cm-cable-max : maximum current of cable
+		- cm-cable-max : maximum current of cable
 
 Optional properties :
  - cm-name : charger manager's name (default : "battery")
  - cm-poll-mode : polling mode (enum polling_modes)
  - cm-poll-interval : polling interval
  - cm-battery-stat : battery status (enum data_source)
- - cm-fullbatt-* : data for full battery checking
- - cm-thermal-zone : name of external thermometer's thermal zone
- - cm-battery-* : threshold battery temperature for charging
-	-cold : critical cold temperature of battery for charging
-	-cold-in-minus : flag that cold temperature is in minus degrees
-	-hot : critical hot temperature of battery for charging
-	-temp-diff : temperature difference to allow recharging
- - cm-dis/charging-max = limits of charging duration
 
 Example :
 	charger-manager@0 {
@@ -38,42 +45,37 @@ Example :
 		/* Always polling ON : 30s */
 		cm-poll-mode = <1>;
 		cm-poll-interval = <30000>;
-
-		cm-fullbatt-vchkdrop-volt = <150000>;
-		cm-fullbatt-soc = <100>;
-
 		cm-battery-stat = <3>;
 
-		cm-num-chargers = <3>;
-		cm-chargers = "charger0", "charger1", "charger2";
-
-		cm-fuel-gauge = "fuelgauge0";
+		constraints {
+			cm-charging-duration = <21600000>; /* 6 hours */
+			cm-temp-cold = <0>;
+			cm-temp-hot = <600>;
+			cm-temp-diff = <150>;
 
-		cm-thermal-zone = "thermal_zone.1"
-		/* in deci centigrade */
-		cm-battery-cold = <50>;
-		cm-battery-cold-in-minus;
-		cm-battery-hot = <800>;
-		cm-battery-temp-diff = <100>;
+			cm-fullbatt-soc = <99>;
+			cm-fullbatt-status;
+			cm-top-off-time = <10000>; /* 10 secs */
+			cm-recharging-voltage = <4300000>;
+		};
 
-		/* Allow charging for 5hr */
-		cm-charging-max = <18000000>;
-		/* Allow discharging for 2hr */
-		cm-discharging-max = <7200000>;
+		battery {
+			cm-fuelgauge = <&fuelgauge>;
+			cm-thermal-zone = "battery-thermal";
+		};
 
-		regulator@0 {
-			cm-regulator-name = "chg-reg";
+		charger@0 {
+			cm-charger = <&charger>;
+			cm-regulator-name = "CHARGER";
 			cable@0 {
 				cm-cable-name = "USB";
-				cm-cable-extcon = "extcon-dev.0";
-				cm-cable-min = <475000>;
-				cm-cable-max = <500000>;
+				cm-cable-extcon = "extcon_dev";
+				cm-cable-max = <450000>;
 			};
 			cable@1 {
 				cm-cable-name = "TA";
-				cm-cable-extcon = "extcon-dev.0";
-				cm-cable-min = <650000>;
-				cm-cable-max = <675000>;
+				cm-cable-extcon = "extcon_dev";
+				cm-cable-max = <2000000>;
 			};
 		};
 
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 12bf79d..b8b7d86 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -315,7 +315,7 @@ config CHARGER_GPIO
 
 config CHARGER_MANAGER
 	bool "Battery charger manager for multiple chargers"
-	depends on REGULATOR
+	depends on OF
 	select EXTCON
 	select THERMAL
 	help
diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index dd128dd..c1dcf12 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -70,30 +70,31 @@ static struct delayed_work cm_monitor_work; /* init at driver add */
 
 /**
  * is_batt_present - See if the battery presents in place.
- * @cm: the Charger Manager representing the battery.
+ * @cm: charger manager instance.
  */
 static bool is_batt_present(struct charger_manager *cm)
 {
+	struct power_supply *psy;
 	union power_supply_propval val;
 	bool present = false;
 	int i, ret;
 
-	switch (cm->desc->battery_present) {
+	switch (cm->battery_present) {
 	case CM_BATTERY_PRESENT:
 		present = true;
 		break;
 	case CM_NO_BATTERY:
 		break;
 	case CM_FUEL_GAUGE:
-		ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
-				POWER_SUPPLY_PROP_PRESENT, &val);
+		psy = cm->battery.psy;
+		ret = psy->get_property(psy, POWER_SUPPLY_PROP_PRESENT, &val);
 		if (ret == 0 && val.intval)
 			present = true;
 		break;
 	case CM_CHARGER_STAT:
-		for (i = 0; cm->charger_stat[i]; i++) {
-			ret = cm->charger_stat[i]->get_property(
-					cm->charger_stat[i],
+		for (i = 0; i < cm->num_chargers; i++) {
+			psy = cm->chargers[i]->psy;
+			ret = psy->get_property(psy,
 					POWER_SUPPLY_PROP_PRESENT, &val);
 			if (ret == 0 && val.intval) {
 				present = true;
@@ -108,7 +109,7 @@ static bool is_batt_present(struct charger_manager *cm)
 
 /**
  * is_ext_pwr_online - See if an external power source is attached to charge
- * @cm: the Charger Manager representing the battery.
+ * @cm: charger manager instance.
  *
  * Returns true if at least one of the chargers of the battery has an external
  * power source attached to charge the battery regardless of whether it is
@@ -116,160 +117,40 @@ static bool is_batt_present(struct charger_manager *cm)
  */
 static bool is_ext_pwr_online(struct charger_manager *cm)
 {
-	union power_supply_propval val;
-	bool online = false;
-	int i, ret;
+	struct charger_dev *charger;
+	int i;
 
 	/* If at least one of them has one, it's yes. */
-	for (i = 0; cm->charger_stat[i]; i++) {
-		ret = cm->charger_stat[i]->get_property(
-				cm->charger_stat[i],
-				POWER_SUPPLY_PROP_ONLINE, &val);
-		if (ret == 0 && val.intval) {
-			online = true;
-			break;
-		}
+	for (i = 0; i < cm->num_chargers; i++) {
+		charger = cm->chargers[i];
+		if (charger->aggr_cc)
+			return true;
 	}
-
-	return online;
-}
-
-/**
- * get_batt_uV - Get the voltage level of the battery
- * @cm: the Charger Manager representing the battery.
- * @uV: the voltage level returned.
- *
- * Returns 0 if there is no error.
- * Returns a negative value on error.
- */
-static int get_batt_uV(struct charger_manager *cm, int *uV)
-{
-	union power_supply_propval val;
-	int ret;
-
-	if (!cm->fuel_gauge)
-		return -ENODEV;
-
-	ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
-				POWER_SUPPLY_PROP_VOLTAGE_NOW, &val);
-	if (ret)
-		return ret;
-
-	*uV = val.intval;
-	return 0;
+	return false;
 }
 
 /**
  * is_charging - Returns true if the battery is being charged.
- * @cm: the Charger Manager representing the battery.
+ * @cm: charger manager instance.
  */
 static bool is_charging(struct charger_manager *cm)
 {
-	int i, ret;
-	bool charging = false;
-	union power_supply_propval val;
+	struct battery_entity *battery = &cm->battery;
 
 	/* If there is no battery, it cannot be charged */
 	if (!is_batt_present(cm))
 		return false;
 
-	/* If at least one of the charger is charging, return yes */
-	for (i = 0; cm->charger_stat[i]; i++) {
-		/* 1. The charger sholuld not be DISABLED */
-		if (cm->emergency_stop)
-			continue;
-		if (!cm->charger_enabled)
-			continue;
-
-		/* 2. The charger should be online (ext-power) */
-		ret = cm->charger_stat[i]->get_property(
-				cm->charger_stat[i],
-				POWER_SUPPLY_PROP_ONLINE, &val);
-		if (ret) {
-			dev_warn(cm->dev, "Cannot read ONLINE value from %s\n",
-				 cm->desc->psy_charger_stat[i]);
-			continue;
-		}
-		if (val.intval == 0)
-			continue;
-
-		/*
-		 * 3. The charger should not be FULL, DISCHARGING,
-		 * or NOT_CHARGING.
-		 */
-		ret = cm->charger_stat[i]->get_property(
-				cm->charger_stat[i],
-				POWER_SUPPLY_PROP_STATUS, &val);
-		if (ret) {
-			dev_warn(cm->dev, "Cannot read STATUS value from %s\n",
-				 cm->desc->psy_charger_stat[i]);
-			continue;
-		}
-		if (val.intval == POWER_SUPPLY_STATUS_FULL ||
-				val.intval == POWER_SUPPLY_STATUS_DISCHARGING ||
-				val.intval == POWER_SUPPLY_STATUS_NOT_CHARGING)
-			continue;
-
-		/* Then, this is charging. */
-		charging = true;
-		break;
-	}
-
-	return charging;
-}
-
-/**
- * is_full_charged - Returns true if the battery is fully charged.
- * @cm: the Charger Manager representing the battery.
- */
-static bool is_full_charged(struct charger_manager *cm)
-{
-	struct charger_desc *desc = cm->desc;
-	union power_supply_propval val;
-	int ret = 0;
-	int uV;
-
-	/* If there is no battery, it cannot be charged */
-	if (!is_batt_present(cm))
-		return false;
-
-	if (cm->fuel_gauge && desc->fullbatt_full_capacity > 0) {
-		val.intval = 0;
-
-		/* Not full if capacity of fuel gauge isn't full */
-		ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
-				POWER_SUPPLY_PROP_CHARGE_FULL, &val);
-		if (!ret && val.intval > desc->fullbatt_full_capacity)
-			return true;
-	}
-
-	/* Full, if it's over the fullbatt voltage */
-	if (desc->fullbatt_uV > 0) {
-		ret = get_batt_uV(cm, &uV);
-		if (!ret && uV >= desc->fullbatt_uV)
-			return true;
-	}
-
-	/* Full, if the capacity is more than fullbatt_soc */
-	if (cm->fuel_gauge && desc->fullbatt_soc > 0) {
-		val.intval = 0;
-
-		ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
-				POWER_SUPPLY_PROP_CAPACITY, &val);
-		if (!ret && val.intval >= desc->fullbatt_soc)
-			return true;
-	}
-
-	return false;
+	return battery->status == POWER_SUPPLY_STATUS_CHARGING;
 }
 
 /**
  * is_polling_required - Return true if need to continue polling for this CM.
- * @cm: the Charger Manager representing the battery.
+ * @cm: charger manager instance.
  */
 static bool is_polling_required(struct charger_manager *cm)
 {
-	switch (cm->desc->polling_mode) {
+	switch (cm->polling_mode) {
 	case CM_POLL_DISABLE:
 		return false;
 	case CM_POLL_ALWAYS:
@@ -280,309 +161,444 @@ static bool is_polling_required(struct charger_manager *cm)
 		return is_charging(cm);
 	default:
 		dev_warn(cm->dev, "Incorrect polling_mode (%d)\n",
-			 cm->desc->polling_mode);
+			 cm->polling_mode);
 	}
 
 	return false;
 }
 
 /**
- * try_charger_enable - Enable/Disable chargers altogether
- * @cm: the Charger Manager representing the battery.
- * @enable: true: enable / false: disable
+ * cm_charger_set_cc - Set charging current.
+ * @charger: A charger device instance
+ * @cc: Target charging current
  *
- * Note that Charger Manager keeps the charger enabled regardless whether
- * the charger is charging or not (because battery is full or no external
- * power source exists) except when CM needs to disable chargers forcibly
- * bacause of emergency causes; when the battery is overheated or too cold.
+ * Whether charging is enabled or not, this will set charging current to given.
  */
-static int try_charger_enable(struct charger_manager *cm, bool enable)
+static int cm_charger_set_cc(struct charger_dev *charger, int cc)
 {
-	int err = 0, i;
-	struct charger_desc *desc = cm->desc;
+	int ret;
+
+	if (cc < 0)
+		return -EINVAL;
 
-	/* Ignore if it's redundent command */
-	if (enable == cm->charger_enabled)
+	if (cc == charger->curr_cc)
 		return 0;
 
-	if (enable) {
-		if (cm->emergency_stop)
-			return -EAGAIN;
+	if (charger->max_cc && cc > charger->max_cc)
+		cc = charger->max_cc;
 
-		/*
-		 * Save start time of charging to limit
-		 * maximum possible charging time.
-		 */
-		cm->charging_start_time = ktime_to_ms(ktime_get());
-		cm->charging_end_time = 0;
+	if (charger->regulator) {
+		ret = regulator_set_current_limit(charger->regulator,
+						cc, cc);
+		if (ret)
+			return ret;
+	} else {
+		if (!charger->psy->set_property)
+			return -ENODEV;
 
-		for (i = 0 ; i < desc->num_charger_regulators ; i++) {
-			if (desc->charger_regulators[i].externally_control)
-				continue;
+		ret = charger->psy->set_property(charger->psy,
+				POWER_SUPPLY_PROP_CHARGE_NOW,
+				(union power_supply_propval *)&cc);
+		if (ret)
+			return ret;
+	}
+	charger->curr_cc = cc;
 
-			err = regulator_enable(desc->charger_regulators[i].consumer);
-			if (err < 0) {
-				dev_warn(cm->dev, "Cannot enable %s regulator\n",
-					 desc->charger_regulators[i].regulator_name);
-			}
-		}
-	} else {
-		/*
-		 * Save end time of charging to maintain fully charged state
-		 * of battery after full-batt.
-		 */
-		cm->charging_start_time = 0;
-		cm->charging_end_time = ktime_to_ms(ktime_get());
+	return 0;
+}
 
-		for (i = 0 ; i < desc->num_charger_regulators ; i++) {
-			if (desc->charger_regulators[i].externally_control)
-				continue;
+/**
+ * cm_charger_enable - Enable the charger to charge.
+ * @charger: charger device instance
+ */
+static int cm_charger_enable(struct charger_dev *charger)
+{
+	union power_supply_propval val;
+	int ret;
 
-			err = regulator_disable(desc->charger_regulators[i].consumer);
-			if (err < 0) {
-				dev_warn(cm->dev, "Cannot disable %s regulator\n",
-					 desc->charger_regulators[i].regulator_name);
-			}
-		}
+	/* Skip enabling if charger's already enabled */
+	if (charger->enabled)
+		return 0;
 
-		/*
-		 * Abnormal battery state - Stop charging forcibly,
-		 * even if charger was enabled at the other places
-		 */
-		for (i = 0; i < desc->num_charger_regulators; i++) {
-			if (regulator_is_enabled(
-				    desc->charger_regulators[i].consumer)) {
-				regulator_force_disable(
-					desc->charger_regulators[i].consumer);
-				dev_warn(cm->dev, "Disable regulator(%s) forcibly\n",
-					 desc->charger_regulators[i].regulator_name);
-			}
-		}
+	if (charger->regulator) {
+		ret = regulator_enable(charger->regulator);
+		if (ret)
+			return ret;
+	} else {
+		val.intval = POWER_SUPPLY_STATUS_CHARGING;
+
+		ret = charger->psy->set_property(charger->psy,
+					POWER_SUPPLY_PROP_STATUS, &val);
+		if (ret)
+			return ret;
 	}
 
-	if (!err)
-		cm->charger_enabled = enable;
+	charger->charging_start = ktime_to_ms(ktime_get());
+	charger->charging_stop = 0;
+	charger->enabled = true;
 
-	return err;
+	return 0;
 }
 
 /**
- * try_charger_restart - Restart charging.
- * @cm: the Charger Manager representing the battery.
- *
- * Restart charging by turning off and on the charger.
+ * cm_charger_disable - Disable the charger to charge.
+ * @charger: charger device instance
  */
-static int try_charger_restart(struct charger_manager *cm)
+static int cm_charger_disable(struct charger_dev *charger)
 {
-	int err;
+	union power_supply_propval val;
+	int ret;
+
+	/* Skip enabling if charger's already disabled */
+	if (!charger->enabled)
+		return 0;
 
-	if (cm->emergency_stop)
-		return -EAGAIN;
+	if (charger->regulator) {
+		ret = regulator_disable(charger->regulator);
+		if (ret)
+			return ret;
 
-	err = try_charger_enable(cm, false);
-	if (err)
-		return err;
+		if (regulator_is_enabled(charger->regulator))
+			regulator_force_disable(charger->regulator);
+	} else {
+		val.intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		ret = charger->psy->set_property(charger->psy,
+					POWER_SUPPLY_PROP_STATUS, &val);
+		if (ret)
+			return ret;
+	}
+	charger->charging_stop = ktime_to_ms(ktime_get());
+	charger->enabled = false;
 
-	return try_charger_enable(cm, true);
+	return 0;
 }
 
 /**
- * fullbatt_vchk - Check voltage drop some times after "FULL" event.
- *
- * If a user has designated "fullbatt_vchkdrop_uV" values with
- * charger_desc, Charger Manager checks voltage drop after the battery
- * "FULL" event. It checks whether the voltage has dropped more than
- * fullbatt_vchkdrop_uV by calling this function after fullbatt_vchkrop_ms.
+ * cm_set_charging - Try to enable or disable charging.
+ * @cm: charger manager instance.
+ * @enable: true: enable / false: force_disable
  */
-static void fullbatt_vchk(struct charger_manager *cm)
+static int cm_set_charging(struct charger_manager *cm, bool enable)
 {
-	struct charger_desc *desc = cm->desc;
-	int batt_uV, err, diff;
+	struct battery_entity *battery = &cm->battery;
+	struct charger_dev *charger;
+	int i, ret;
 
-	if (!desc->fullbatt_vchkdrop_uV)
-		return;
+	if (enable) {
+		for (i = 0; i < cm->num_chargers; i++) {
+			charger = cm->chargers[i];
 
-	err = get_batt_uV(cm, &batt_uV);
-	if (err) {
-		dev_err(cm->dev, "%s: get_batt_uV error(%d)\n", __func__, err);
-		return;
-	}
+			if (charger->externally_control)
+				continue;
 
-	diff = desc->fullbatt_uV - batt_uV;
-	if (diff < 0)
-		return;
+			cm_charger_set_cc(charger, charger->aggr_cc);
 
-	dev_info(cm->dev, "VBATT dropped %duV after full-batt\n", diff);
+			ret = cm_charger_enable(charger);
+			if (ret)
+				return ret;
+		}
+	} else {
+		if (battery->fullcharged_at) {
+			struct charging_constraints *constraints =
+						 &cm->constraints;
+			u64 curr = ktime_to_ms(ktime_get());
+
+			if (curr - battery->fullcharged_at <
+					 constraints->top_off_time)
+				return 0;
+		}
+
+		for (i = 0; i < cm->num_chargers; i++) {
+			charger = cm->chargers[i];
 
-	if (diff > desc->fullbatt_vchkdrop_uV) {
-		try_charger_restart(cm);
-		power_supply_changed(&cm->charger_psy);
+			if (charger->externally_control)
+				continue;
+
+			ret = cm_charger_disable(charger);
+			if (ret)
+				return ret;
+		}
 	}
+
+	return 0;
 }
 
 /**
- * check_charging_duration - Monitor charging/discharging duration
- * @cm: the Charger Manager representing the battery.
+ * cm_check_charging_duration - Monitor charging time.
+ * @cm: charger manager instance
  *
  * If whole charging duration exceed 'charging_max_duration_ms',
- * cm stop charging to prevent overcharge/overheat. If discharging
- * duration exceed 'discharging _max_duration_ms', charger cable is
- * attached, after full-batt, cm start charging to maintain fully
- * charged state for battery.
+ * cm stop charging to prevent overcharge/overheat.
  */
-static int check_charging_duration(struct charger_manager *cm)
+static bool cm_check_charging_duration(struct charger_manager *cm)
 {
-	struct charger_desc *desc = cm->desc;
+	struct charging_constraints *constraints = &cm->constraints;
+	struct charger_dev *charger;
 	u64 curr = ktime_to_ms(ktime_get());
-	u64 duration;
-	int ret = false;
+	u32 duration = 0;
+	int i;
 
-	if (!desc->charging_max_duration_ms &&
-			!desc->discharging_max_duration_ms)
-		return ret;
+	if (!constraints->charging_duration)
+		return false;
 
-	if (cm->charger_enabled) {
-		duration = curr - cm->charging_start_time;
+	if (constraints->charging_avail_at > curr)
+		return true;
 
-		if (duration > desc->charging_max_duration_ms) {
-			dev_info(cm->dev, "Charging duration exceed %ums\n",
-				 desc->charging_max_duration_ms);
-			power_supply_changed(&cm->charger_psy);
-			try_charger_enable(cm, false);
-			ret = true;
-		}
-	} else if (is_ext_pwr_online(cm) && !cm->charger_enabled) {
-		duration = curr - cm->charging_end_time;
-
-		if (duration > desc->charging_max_duration_ms &&
-				is_ext_pwr_online(cm)) {
-			dev_info(cm->dev, "Discharging duration exceed %ums\n",
-				 desc->discharging_max_duration_ms);
-			power_supply_changed(&cm->charger_psy);
-			try_charger_enable(cm, true);
-			ret = true;
-		}
+	constraints->charging_avail_at = 0;
+
+	/* Find the longest charging time */
+	for (i = 0; i < cm->num_chargers; i++) {
+		int _dur;
+
+		charger = cm->chargers[i];
+
+		if (!charger->enabled)
+			continue;
+
+		_dur = curr - charger->charging_start;
+		if (_dur > duration)
+			duration = _dur;
 	}
 
-	return ret;
+	if (duration > constraints->charging_duration) {
+		dev_dbg(cm->dev, "Charging time exceeds to limit.(%ums:%ums)\n",
+			duration, constraints->charging_duration);
+		constraints->charging_avail_at =
+				curr + constraints->charging_hold_off;
+		return true;
+	}
+
+	return false;
 }
 
-static int cm_get_battery_temperature(struct charger_manager *cm,
-					int *temp)
+/**
+ * update_battery_state - Update current battery state.
+ * @battery: battery_entity instance
+ *
+ * Return true if battery state is varied from last checking.
+ */
+static bool update_battery_state(struct battery_entity *battery)
 {
+	struct power_supply *fuelgauge = battery->psy;
+	union power_supply_propval val;
+	bool updated = false;
 	int ret;
 
-	ret = thermal_zone_get_temp(cm->tzd_batt, (unsigned long *)temp);
-	if (!ret)
-		/* Calibrate temperature unit */
-		*temp /= 100;
+	ret = fuelgauge->get_property(fuelgauge,
+			POWER_SUPPLY_PROP_CAPACITY, &val);
+	if (!ret && battery->soc != val.intval) {
+		battery->soc = val.intval;
+		updated = true;
+	}
 
-	return ret;
+	ret = fuelgauge->get_property(fuelgauge,
+			POWER_SUPPLY_PROP_VOLTAGE_NOW, &val);
+	if (!ret && battery->voltage != val.intval) {
+		battery->voltage = val.intval;
+		updated = true;
+	}
+
+	if (battery->capacity != -EINVAL) {
+		ret = fuelgauge->get_property(fuelgauge,
+				POWER_SUPPLY_PROP_CHARGE_NOW, &val);
+		if (!ret && battery->capacity != val.intval) {
+			battery->capacity = val.intval;
+			updated = true;
+		} else if (ret == -EINVAL) {
+			battery->capacity = ret;
+		}
+	}
+
+	ret = thermal_zone_get_temp(battery->tzd,
+			(unsigned long *)&val.intval);
+	if (!ret) {
+		/* Change unit to decidegree Celcius */
+		val.intval /= 100;
+		if (battery->temperature != val.intval) {
+			battery->temperature = val.intval;
+			updated = true;
+		}
+	}
+
+	return updated;
 }
 
+/**
+ * cm_check_thermal_stats - Check battery temperature is safe.
+ * @cm: charger manager instance.
+ *
+ * Return 0 if battery temperature is safe, otherwise if temperature
+ * reaches out of thermal limitation then return non-zero.
+ */
 static int cm_check_thermal_status(struct charger_manager *cm)
 {
-	struct charger_desc *desc = cm->desc;
-	int temp, upper_limit, lower_limit;
-	int ret = 0;
-
-	ret = cm_get_battery_temperature(cm, &temp);
-	if (ret) {
-		/* FIXME:
-		 * No information of battery temperature might
-		 * occur hazadous result. We have to handle it
-		 * depending on battery type.
-		 */
-		dev_err(cm->dev, "Failed to get battery temperature\n");
-		return 0;
+	struct battery_entity *battery = &cm->battery;
+	struct charging_constraints *constraints = &cm->constraints;
+	int upper_limit = constraints->temp_max;
+	int lower_limit = constraints->temp_min;
+
+	if (battery->status == POWER_SUPPLY_STATUS_NOT_CHARGING) {
+		upper_limit -= constraints->temp_diff;
+		lower_limit += constraints->temp_diff;
 	}
 
-	upper_limit = desc->temp_max;
-	lower_limit = desc->temp_min;
+	if (battery->temperature >= upper_limit) {
+		battery->health = POWER_SUPPLY_HEALTH_OVERHEAT;
+		return -EPERM;
+	}
 
-	if (cm->emergency_stop) {
-		upper_limit -= desc->temp_diff;
-		lower_limit += desc->temp_diff;
+	if (battery->temperature <= lower_limit) {
+		battery->health = POWER_SUPPLY_HEALTH_COLD;
+		return -EPERM;
 	}
 
-	if (temp > upper_limit)
-		ret = CM_EVENT_BATT_OVERHEAT;
-	else if (temp < lower_limit)
-		ret = CM_EVENT_BATT_COLD;
+	battery->health = POWER_SUPPLY_HEALTH_GOOD;
 
-	return ret;
+	return 0;
 }
 
 /**
- * _cm_monitor - Monitor the temperature and return true for exceptions.
- * @cm: the Charger Manager representing the battery.
- *
- * Returns true if there is an event to notify for the battery.
- * (True if the status of "emergency_stop" changes)
+ * is_full_charged - Decide whether battery is full or not.
+ * @cm: charger manager instance.
  */
-static bool _cm_monitor(struct charger_manager *cm)
+static bool is_full_charged(struct charger_manager *cm)
 {
-	int temp_alrt;
+	struct battery_entity *battery = &cm->battery;
+	struct charging_constraints *constraints = &cm->constraints;
+	int conditions;
+	int *threshold;
+
+	if (battery->status == POWER_SUPPLY_STATUS_FULL &&
+				constraints->recharging_conds) {
+		conditions = constraints->recharging_conds;
+		threshold = constraints->recharging_thres;
+	} else {
+		conditions = constraints->fullbatt_conds;
+		threshold = constraints->fullbatt_thres;
+	}
 
-	temp_alrt = cm_check_thermal_status(cm);
+	while (conditions) {
+		struct power_supply *charger_psy;
+		union power_supply_propval val;
+		int cond = __fls(conditions);
+		int i, ret;
 
-	/* It has been stopped already */
-	if (temp_alrt && cm->emergency_stop)
-		return false;
+		switch (cond) {
+		case CM_FULLBATT_SOC:
+			if (battery->soc >= threshold[cond])
+				goto fullbatt_ok;
+			break;
+		case CM_FULLBATT_CAPACITY:
+			if (battery->capacity >= threshold[cond])
+				goto fullbatt_ok;
+			break;
+		case CM_FULLBATT_VOLTAGE:
+			if (battery->voltage >= threshold[cond])
+				goto fullbatt_ok;
+			break;
+		case CM_FULLBATT_STATUS:
+			for (i = 0; i < cm->num_chargers; i++) {
+				charger_psy = cm->chargers[i]->psy;
+				ret = charger_psy->get_property(charger_psy,
+						POWER_SUPPLY_PROP_STATUS, &val);
+				if (!ret && val.intval ==
+						 POWER_SUPPLY_STATUS_FULL)
+					goto fullbatt_ok;
+			}
+			break;
+		default:
+			return true;
+		}
+		conditions &= ~(1 << cond);
+	}
 
-	/*
-	 * Check temperature whether overheat or cold.
-	 * If temperature is out of range normal state, stop charging.
-	 */
-	if (temp_alrt) {
-		cm->emergency_stop = temp_alrt;
-		if (!try_charger_enable(cm, false))
-			power_supply_changed(&cm->charger_psy);
+	if ((battery->status == POWER_SUPPLY_STATUS_FULL) &&
+				constraints->recharging_count) {
+		if (++battery->fullbatt_check_count <
+				constraints->recharging_count)
+			return true;
 
-	/*
-	 * Check whole charging duration and discharing duration
-	 * after full-batt.
-	 */
-	} else if (!cm->emergency_stop && check_charging_duration(cm)) {
-		dev_dbg(cm->dev,
-			"Charging/Discharging duration is out of range\n");
-	/*
-	 * Check dropped voltage of battery. If battery voltage is more
-	 * dropped than fullbatt_vchkdrop_uV after fully charged state,
-	 * charger-manager have to recharge battery.
-	 */
-	} else if (!cm->emergency_stop && is_ext_pwr_online(cm) &&
-			!cm->charger_enabled) {
-		fullbatt_vchk(cm);
+		battery->fullbatt_check_count = 0;
+	}
 
-	/*
-	 * Check whether fully charged state to protect overcharge
-	 * if charger-manager is charging for battery.
-	 */
-	} else if (!cm->emergency_stop && is_full_charged(cm) &&
-			cm->charger_enabled) {
-		dev_info(cm->dev, "EVENT_HANDLE: Battery Fully Charged\n");
-		power_supply_changed(&cm->charger_psy);
+	return false;
 
-		try_charger_enable(cm, false);
+fullbatt_ok:
+	if ((battery->status != POWER_SUPPLY_STATUS_FULL) &&
+				constraints->fullbatt_count) {
+		if (++battery->fullbatt_check_count <
+				constraints->fullbatt_count)
+			return false;
 
-		fullbatt_vchk(cm);
-	} else {
-		cm->emergency_stop = 0;
-		if (is_ext_pwr_online(cm)) {
-			if (!try_charger_enable(cm, true))
-				power_supply_changed(&cm->charger_psy);
+		battery->fullbatt_check_count = 0;
+	}
+	return true;
+}
+
+/**
+ * cm_get_target_status - Check current status and get next target status.
+ * @cm: charger manager instance.
+ */
+static int cm_get_target_status(struct charger_manager *cm)
+{
+	struct battery_entity *battery = &cm->battery;
+
+	if (!is_ext_pwr_online(cm))
+		return POWER_SUPPLY_STATUS_DISCHARGING;
+
+	if (cm_check_thermal_status(cm))
+		return POWER_SUPPLY_STATUS_NOT_CHARGING;
+
+	switch (battery->status) {
+	case POWER_SUPPLY_STATUS_CHARGING:
+	case POWER_SUPPLY_STATUS_FULL:
+		if (cm_check_charging_duration(cm) ||
+				is_full_charged(cm)) {
+			if (!battery->fullcharged_at)
+				battery->fullcharged_at =
+				ktime_to_ms(ktime_get());
+			return POWER_SUPPLY_STATUS_FULL;
 		}
+	default:
+		break;
 	}
 
-	return true;
+	battery->fullcharged_at = 0;
+
+	return POWER_SUPPLY_STATUS_CHARGING;
+}
+
+/**
+ * _cm_monitor - Monitor a battery and set charging.
+ * @cm: charger manager instance.
+ */
+static int _cm_monitor(struct charger_manager *cm)
+{
+	struct battery_entity *battery = &cm->battery;
+	int target;
+	bool updated;
+	int ret = 0;
+
+	updated = update_battery_state(battery);
+
+	target = cm_get_target_status(cm);
+
+	ret = cm_set_charging(cm, (target == POWER_SUPPLY_STATUS_CHARGING));
+	if (ret)
+		goto out;
+
+	updated |= (battery->status != target);
+	battery->status = target;
+out:
+	if (updated)
+		power_supply_changed(&cm->psy);
+
+	return ret;
 }
 
+
 /**
  * cm_monitor - Monitor every battery.
- *
- * Returns true if there is an event to notify from any of the batteries.
- * (True if the status of "emergency_stop" changes)
  */
 static bool cm_monitor(void)
 {
@@ -592,6 +608,9 @@ static bool cm_monitor(void)
 	mutex_lock(&cm_list_mtx);
 
 	list_for_each_entry(cm, &cm_list, entry) {
+		if (!is_batt_present(cm))
+			continue;
+
 		if (_cm_monitor(cm))
 			stop = true;
 	}
@@ -615,11 +634,11 @@ static void _setup_polling(struct work_struct *work)
 	mutex_lock(&cm_list_mtx);
 
 	list_for_each_entry(cm, &cm_list, entry) {
-		if (is_polling_required(cm) && cm->desc->polling_interval_ms) {
+		if (is_polling_required(cm) && cm->polling_interval_ms) {
 			keep_polling = true;
 
-			if (min > cm->desc->polling_interval_ms)
-				min = cm->desc->polling_interval_ms;
+			if (min > cm->polling_interval_ms)
+				min = cm->polling_interval_ms;
 		}
 	}
 
@@ -668,32 +687,23 @@ static void cm_monitor_poller(struct work_struct *work)
 	schedule_work(&setup_polling);
 }
 
-static int charger_get_property(struct power_supply *psy,
-		enum power_supply_property psp,
-		union power_supply_propval *val)
+static int cm_get_property(struct power_supply *psy,
+			enum power_supply_property psp,
+			union power_supply_propval *val)
 {
 	struct charger_manager *cm = container_of(psy,
-			struct charger_manager, charger_psy);
-	struct charger_desc *desc = cm->desc;
+				struct charger_manager, psy);
+	struct battery_entity *battery = &cm->battery;
 	int ret = 0;
-	int uV;
+
+	update_battery_state(battery);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		if (is_charging(cm))
-			val->intval = POWER_SUPPLY_STATUS_CHARGING;
-		else if (is_ext_pwr_online(cm))
-			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
-		else
-			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		val->intval = battery->status;
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
-		if (cm->emergency_stop > 0)
-			val->intval = POWER_SUPPLY_HEALTH_OVERHEAT;
-		else if (cm->emergency_stop < 0)
-			val->intval = POWER_SUPPLY_HEALTH_COLD;
-		else
-			val->intval = POWER_SUPPLY_HEALTH_GOOD;
+		val->intval = battery->health;
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
 		if (is_batt_present(cm))
@@ -702,60 +712,32 @@ static int charger_get_property(struct power_supply *psy,
 			val->intval = 0;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		ret = get_batt_uV(cm, &val->intval);
+		val->intval = battery->voltage;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
+		ret = battery->psy->get_property(battery->psy,
 				POWER_SUPPLY_PROP_CURRENT_NOW, val);
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
-	case POWER_SUPPLY_PROP_TEMP_AMBIENT:
-		return cm_get_battery_temperature(cm, &val->intval);
+		val->intval = battery->temperature;
+		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
-		if (!cm->fuel_gauge) {
-			ret = -ENODEV;
-			break;
-		}
-
 		if (!is_batt_present(cm)) {
 			/* There is no battery. Assume 100% */
 			val->intval = 100;
 			break;
 		}
 
-		ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
-					POWER_SUPPLY_PROP_CAPACITY, val);
-		if (ret)
-			break;
+		val->intval = battery->soc;
 
-		if (val->intval > 100) {
+		if (val->intval > 100 ||
+			battery->status == POWER_SUPPLY_STATUS_FULL) {
 			val->intval = 100;
 			break;
 		}
 		if (val->intval < 0)
 			val->intval = 0;
 
-		/* Do not adjust SOC when charging: voltage is overrated */
-		if (is_charging(cm))
-			break;
-
-		/*
-		 * If the capacity value is inconsistent, calibrate it base on
-		 * the battery voltage values and the thresholds given as desc
-		 */
-		ret = get_batt_uV(cm, &uV);
-		if (ret) {
-			/* Voltage information not available. No calibration */
-			ret = 0;
-			break;
-		}
-
-		if (desc->fullbatt_uV > 0 && uV >= desc->fullbatt_uV &&
-		    !is_charging(cm)) {
-			val->intval = 100;
-			break;
-		}
-
 		break;
 	case POWER_SUPPLY_PROP_ONLINE:
 		if (is_ext_pwr_online(cm))
@@ -764,12 +746,13 @@ static int charger_get_property(struct power_supply *psy,
 			val->intval = 0;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
-		ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
+		ret = battery->psy->get_property(battery->psy,
 				POWER_SUPPLY_PROP_CHARGE_FULL, val);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		ret = cm->fuel_gauge->get_property(cm->fuel_gauge,
-				POWER_SUPPLY_PROP_CHARGE_NOW, val);
+		if (!battery->capacity)
+			return -EINVAL;
+		val->intval = battery->capacity;
 		break;
 	default:
 		return -EINVAL;
@@ -796,12 +779,7 @@ static enum power_supply_property cm_optional_props[] = {
 
 #define CM_NUM_OF_PROPS	\
 	(ARRAY_SIZE(cm_default_props) + ARRAY_SIZE(cm_optional_props))
-
-static struct power_supply psy_default = {
-	.name = "battery",
-	.type = POWER_SUPPLY_TYPE_BATTERY,
-	.get_property = charger_get_property,
-};
+#define DEFAULT_CM_PSY_NAME	"battery"
 
 /**
  * cm_setup_timer - For in-suspend monitoring setup wakeup alarm
@@ -826,12 +804,12 @@ static bool cm_setup_timer(void)
 	mutex_lock(&cm_list_mtx);
 	list_for_each_entry(cm, &cm_list, entry) {
 		/* Skip if polling is not required for this CM */
-		if (!is_polling_required(cm) && !cm->emergency_stop)
+		if (!is_polling_required(cm))
 			continue;
 		timer_req++;
-		if (cm->desc->polling_interval_ms == 0)
+		if (cm->polling_interval_ms == 0)
 			continue;
-		CM_MIN_VALID(wakeup_ms, cm->desc->polling_interval_ms);
+		CM_MIN_VALID(wakeup_ms, cm->polling_interval_ms);
 	}
 	mutex_unlock(&cm_list_mtx);
 
@@ -860,35 +838,6 @@ static bool cm_setup_timer(void)
 }
 
 /**
- * charger_extcon_work - enable/diable charger according to the state
- *			of charger cable
- *
- * @work: work_struct of the function charger_extcon_work.
- */
-static void charger_extcon_work(struct work_struct *work)
-{
-	struct charger_cable *cable =
-			container_of(work, struct charger_cable, wq);
-	int ret;
-
-	if (cable->attached && cable->min_uA != 0 && cable->max_uA != 0) {
-		ret = regulator_set_current_limit(cable->charger->consumer,
-					cable->min_uA, cable->max_uA);
-		if (ret < 0) {
-			pr_err("Cannot set current limit of %s (%s)\n",
-			       cable->charger->regulator_name, cable->name);
-			return;
-		}
-
-		pr_info("Set current limit of %s : %duA ~ %duA\n",
-			cable->charger->regulator_name,
-			cable->min_uA, cable->max_uA);
-	}
-
-	try_charger_enable(cable->cm, cable->attached);
-}
-
-/**
  * charger_extcon_notifier - receive the state of charger cable
  *			when registered cable is attached or detached.
  *
@@ -896,32 +845,22 @@ static void charger_extcon_work(struct work_struct *work)
  * @event: the cable state.
  * @ptr: the data pointer of notifier block.
  */
-static int charger_extcon_notifier(struct notifier_block *self,
+static int cm_extcon_notifier(struct notifier_block *self,
 			unsigned long event, void *ptr)
 {
 	struct charger_cable *cable =
 		container_of(self, struct charger_cable, nb);
 
-	/*
-	 * The newly state of charger cable.
-	 * If cable is attached, cable->attached is true.
-	 */
-	cable->attached = event;
-
-	/*
-	 * Setup monitoring to check battery state
-	 * when charger cable is attached.
-	 */
-	if (cable->attached && is_polling_required(cable->cm)) {
-		cancel_work_sync(&setup_polling);
-		schedule_work(&setup_polling);
+	if (event) {
+		cable->attached = event;
+		cable->charger->aggr_cc += cable->max_uA;
+	} else {
+		cable->attached = event;
+		cable->charger->aggr_cc -= cable->max_uA;
 	}
 
-	/*
-	 * Setup work for controlling charger(regulator)
-	 * according to charger cable.
-	 */
-	schedule_work(&cable->wq);
+	cancel_delayed_work(&cm_monitor_work);
+	queue_delayed_work(cm_wq, &cm_monitor_work, 0);
 
 	return NOTIFY_DONE;
 }
@@ -930,108 +869,52 @@ static int charger_extcon_notifier(struct notifier_block *self,
  * charger_extcon_init - register external connector to use it
  *			as the charger cable
  *
- * @cm: the Charger Manager representing the battery.
+ * @cm: charger manager instance.
  * @cable: the Charger cable representing the external connector.
  */
-static int charger_extcon_init(struct charger_manager *cm,
-		struct charger_cable *cable)
+static int charger_extcon_init(const char *extcon_name,
+				struct charger_cable *cable)
 {
 	int ret = 0;
 
-	/*
-	 * Charger manager use Extcon framework to identify
-	 * the charger cable among various external connector
-	 * cable (e.g., TA, USB, MHL, Dock).
-	 */
-	INIT_WORK(&cable->wq, charger_extcon_work);
-	cable->nb.notifier_call = charger_extcon_notifier;
-	ret = extcon_register_interest(&cable->extcon_dev,
-			cable->extcon_name, cable->name, &cable->nb);
+	cable->nb.notifier_call = cm_extcon_notifier;
+	ret = extcon_register_interest(&cable->extcon_dev, extcon_name,
+					cable->name, &cable->nb);
 	if (ret < 0) {
-		pr_info("Cannot register extcon_dev for %s(cable: %s)\n",
-			cable->extcon_name, cable->name);
-		ret = -EINVAL;
-	}
-
-	return ret;
-}
-
-/**
- * charger_manager_register_extcon - Register extcon device to recevie state
- *				     of charger cable.
- * @cm: the Charger Manager representing the battery.
- *
- * This function support EXTCON(External Connector) subsystem to detect the
- * state of charger cables for enabling or disabling charger(regulator) and
- * select the charger cable for charging among a number of external cable
- * according to policy of H/W board.
- */
-static int charger_manager_register_extcon(struct charger_manager *cm)
-{
-	struct charger_desc *desc = cm->desc;
-	struct charger_regulator *charger;
-	int ret = 0;
-	int i;
-	int j;
-
-	for (i = 0; i < desc->num_charger_regulators; i++) {
-		charger = &desc->charger_regulators[i];
-
-		charger->consumer = regulator_get(cm->dev,
-					charger->regulator_name);
-		if (IS_ERR(charger->consumer)) {
-			dev_err(cm->dev, "Cannot find charger(%s)\n",
-				charger->regulator_name);
-			return PTR_ERR(charger->consumer);
-		}
-		charger->cm = cm;
-
-		for (j = 0; j < charger->num_cables; j++) {
-			struct charger_cable *cable = &charger->cables[j];
-
-			ret = charger_extcon_init(cm, cable);
-			if (ret < 0) {
-				dev_err(cm->dev, "Cannot initialize charger(%s)\n",
-					charger->regulator_name);
-				goto err;
-			}
-			cable->charger = charger;
-			cable->cm = cm;
-		}
+		pr_err("Cannot register extcon_dev for %s(cable: %s)\n",
+			extcon_name, cable->name);
+		return ret;
 	}
 
-err:
-	return ret;
+	cable->attached = extcon_get_cable_state(cable->extcon_dev.edev,
+						cable->name);
+	return 0;
 }
 
 /* help function of sysfs node to control charger(regulator) */
 static ssize_t charger_name_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct charger_regulator *charger
-		= container_of(attr, struct charger_regulator, attr_name);
+	struct charger_dev *charger
+		= container_of(attr, struct charger_dev, attr_name);
 
-	return sprintf(buf, "%s\n", charger->regulator_name);
+	return sprintf(buf, "%s\n", charger->psy->name);
 }
 
 static ssize_t charger_state_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct charger_regulator *charger
-		= container_of(attr, struct charger_regulator, attr_state);
-	int state = 0;
+	struct charger_dev *charger
+		= container_of(attr, struct charger_dev, attr_state);
 
-	if (!charger->externally_control)
-		state = regulator_is_enabled(charger->consumer);
-
-	return sprintf(buf, "%s\n", state ? "enabled" : "disabled");
+	return sprintf(buf, "%s\n", charger->enabled ? "enabled" : "disabled");
 }
 
 static ssize_t charger_externally_control_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct charger_regulator *charger = container_of(attr,
-			struct charger_regulator, attr_externally_control);
+	struct charger_dev *charger = container_of(attr,
+			struct charger_dev, attr_externally_control);
 
 	return sprintf(buf, "%d\n", charger->externally_control);
 }
@@ -1040,15 +923,11 @@ static ssize_t charger_externally_control_store(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
 {
-	struct charger_regulator *charger
-		= container_of(attr, struct charger_regulator,
+	struct charger_dev *charger
+		= container_of(attr, struct charger_dev,
 					attr_externally_control);
-	struct charger_manager *cm = charger->cm;
-	struct charger_desc *desc = cm->desc;
-	int i;
 	int ret;
 	int externally_control;
-	int chargers_externally_control = 1;
 
 	ret = sscanf(buf, "%d", &externally_control);
 	if (ret == 0) {
@@ -1056,43 +935,14 @@ static ssize_t charger_externally_control_store(struct device *dev,
 		return ret;
 	}
 
-	if (!externally_control) {
-		charger->externally_control = 0;
-		return count;
-	}
-
-	for (i = 0; i < desc->num_charger_regulators; i++) {
-		if (&desc->charger_regulators[i] != charger &&
-			!desc->charger_regulators[i].externally_control) {
-			/*
-			 * At least, one charger is controlled by
-			 * charger-manager
-			 */
-			chargers_externally_control = 0;
-			break;
-		}
-	}
-
-	if (!chargers_externally_control) {
-		if (cm->charger_enabled) {
-			try_charger_enable(charger->cm, false);
-			charger->externally_control = externally_control;
-			try_charger_enable(charger->cm, true);
-		} else {
-			charger->externally_control = externally_control;
-		}
-	} else {
-		dev_warn(cm->dev,
-			 "'%s' regulator should be controlled in charger-manager because charger-manager must need at least one charger for charging\n",
-			 charger->regulator_name);
-	}
+	charger->externally_control = externally_control;
 
 	return count;
 }
 
 /**
  * charger_manager_register_sysfs - Register sysfs entry for each charger
- * @cm: the Charger Manager representing the battery.
+ * @cm: charger manager instance.
  *
  * This function add sysfs entry for charger(regulator) to control charger from
  * user-space. If some development board use one more chargers for charging
@@ -1103,19 +953,17 @@ static ssize_t charger_externally_control_store(struct device *dev,
  * externally_control, this charger isn't controlled from charger-manager and
  * always stay off state of regulator.
  */
-static int charger_manager_register_sysfs(struct charger_manager *cm)
+static int cm_charger_create_sysfs(struct charger_manager *cm)
 {
-	struct charger_desc *desc = cm->desc;
-	struct charger_regulator *charger;
-	int chargers_externally_control = 1;
+	struct charger_dev *charger;
 	char buf[11];
 	char *str;
 	int ret = 0;
 	int i;
 
 	/* Create sysfs entry to control charger(regulator) */
-	for (i = 0; i < desc->num_charger_regulators; i++) {
-		charger = &desc->charger_regulators[i];
+	for (i = 0; i < cm->num_chargers; i++) {
+		charger = cm->chargers[i];
 
 		snprintf(buf, 10, "charger.%d", i);
 		str = devm_kzalloc(cm->dev,
@@ -1152,29 +1000,15 @@ static int charger_manager_register_sysfs(struct charger_manager *cm)
 		charger->attr_externally_control.store
 				= charger_externally_control_store;
 
-		if (!desc->charger_regulators[i].externally_control ||
-				!chargers_externally_control)
-			chargers_externally_control = 0;
-
-		dev_info(cm->dev, "'%s' regulator's externally_control is %d\n",
-			 charger->regulator_name, charger->externally_control);
-
-		ret = sysfs_create_group(&cm->charger_psy.dev->kobj,
-					&charger->attr_g);
+		ret = sysfs_create_group(&cm->psy.dev->kobj, &charger->attr_g);
 		if (ret < 0) {
-			dev_err(cm->dev, "Cannot create sysfs entry of %s regulator\n",
-				charger->regulator_name);
+			dev_err(cm->dev, "Fail to create sysfs of charger.%d\n",
+				i);
 			ret = -EINVAL;
 			goto err;
 		}
 	}
 
-	if (chargers_externally_control) {
-		dev_err(cm->dev, "Cannot register regulator because charger-manager must need at least one charger for charging battery\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
 err:
 	return ret;
 }
@@ -1186,142 +1020,186 @@ static struct of_device_id charger_manager_match[] = {
 	{},
 };
 
-static struct charger_desc *of_cm_parse_desc(struct device *dev)
+static int cm_initialize_data(struct charger_manager *cm)
 {
-	struct charger_desc *desc;
-	struct device_node *np = dev->of_node;
-	u32 poll_mode = CM_POLL_DISABLE;
-	u32 battery_stat = CM_NO_BATTERY;
-	int num_chgs = 0;
-
-	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
-	if (!desc)
-		return ERR_PTR(-ENOMEM);
-
-	of_property_read_string(np, "cm-name", &desc->psy_name);
-
-	of_property_read_u32(np, "cm-poll-mode", &poll_mode);
-	desc->polling_mode = poll_mode;
-
-	of_property_read_u32(np, "cm-poll-interval",
-				&desc->polling_interval_ms);
-
-	of_property_read_u32(np, "cm-fullbatt-vchkdrop-volt",
-					&desc->fullbatt_vchkdrop_uV);
-	of_property_read_u32(np, "cm-fullbatt-voltage", &desc->fullbatt_uV);
-	of_property_read_u32(np, "cm-fullbatt-soc", &desc->fullbatt_soc);
-	of_property_read_u32(np, "cm-fullbatt-capacity",
-					&desc->fullbatt_full_capacity);
-
-	of_property_read_u32(np, "cm-battery-stat", &battery_stat);
-	desc->battery_present = battery_stat;
-
-	/* chargers */
-	of_property_read_u32(np, "cm-num-chargers", &num_chgs);
-	if (num_chgs) {
-		/* Allocate empty bin at the tail of array */
-		desc->psy_charger_stat = devm_kzalloc(dev, sizeof(char *)
-						* (num_chgs + 1), GFP_KERNEL);
-		if (desc->psy_charger_stat) {
-			int i;
-			for (i = 0; i < num_chgs; i++)
-				of_property_read_string_index(np, "cm-chargers",
-						i, &desc->psy_charger_stat[i]);
-		} else {
-			return ERR_PTR(-ENOMEM);
-		}
+	struct battery_entity *battery = &cm->battery;
+	struct charging_constraints *constraints = &cm->constraints;
+	struct charger_dev *charger;
+	struct device_node *np = cm->dev->of_node;
+	struct device_node *constraints_np, *battery_np;
+	struct device_node *charger_np, *cable_np;
+	const char *buf;
+	int ret, idx = 0;
+
+	/* Parse charger manager data */
+	if (!of_property_read_string(np, "cm-name", &cm->psy.name))
+		cm->psy.name = DEFAULT_CM_PSY_NAME;
+
+	if (of_property_read_u32(np, "cm-poll-mode", &cm->polling_mode))
+		cm->polling_mode = CM_POLL_DISABLE;
+
+	of_property_read_u32(np, "cm-poll-interval", &cm->polling_interval_ms);
+
+	if (of_property_read_u32(np, "cm-battery-stat", &cm->battery_present))
+		cm->battery_present = CM_BATTERY_PRESENT;
+
+
+	/* Parse charging contraints */
+	constraints_np = of_get_child_by_name(np, "constraints");
+	if (!constraints_np)
+		return -EINVAL;
+
+	of_property_read_u32(constraints_np, "cm-charging-duration",
+					&constraints->charging_duration);
+
+	of_property_read_u32(constraints_np, "cm-charging-hold-off",
+					&constraints->charging_hold_off);
+
+	of_property_read_u32(constraints_np, "cm-temp-cold",
+					&constraints->temp_min);
+	if (of_get_property(constraints_np, "cm-temp-cold-in-minus", NULL))
+		constraints->temp_min *= -1;
+	of_property_read_u32(constraints_np, "cm-temp-hot",
+					&constraints->temp_max);
+	of_property_read_u32(constraints_np, "cm-temp-diff",
+					&constraints->temp_diff);
+
+	if (!of_property_read_u32(constraints_np, "cm-fullbatt-soc",
+			&constraints->fullbatt_thres[CM_FULLBATT_SOC]))
+		constraints->fullbatt_conds |= (1 << CM_FULLBATT_SOC);
+	if (!of_property_read_u32(constraints_np, "cm-fullbatt-capcity",
+			&constraints->fullbatt_thres[CM_FULLBATT_CAPACITY]))
+		constraints->fullbatt_conds |= (1 << CM_FULLBATT_CAPACITY);
+	if (!of_property_read_u32(constraints_np, "cm-fullbatt-voltage",
+			&constraints->fullbatt_thres[CM_FULLBATT_VOLTAGE]))
+		constraints->fullbatt_conds |= (1 << CM_FULLBATT_VOLTAGE);
+	if (of_get_property(constraints_np, "cm-fullbatt-status", NULL))
+		constraints->fullbatt_conds |= (1 << CM_FULLBATT_STATUS);
+
+	if (!constraints->fullbatt_conds)
+		return -EINVAL;
+
+	of_property_read_u32(constraints_np, "cm-fullbatt-count",
+					&constraints->fullbatt_count);
+
+	of_property_read_u32(constraints_np, "cm-top-off-time",
+					&constraints->top_off_time);
+
+	if (!of_property_read_u32(constraints_np, "cm-recharging-soc",
+			&constraints->recharging_thres[CM_FULLBATT_SOC]))
+		constraints->recharging_conds |= (1 << CM_FULLBATT_SOC);
+	if (!of_property_read_u32(constraints_np, "cm-recharging-capcity",
+			&constraints->recharging_thres[CM_FULLBATT_CAPACITY]))
+		constraints->recharging_conds |= (1 << CM_FULLBATT_CAPACITY);
+	if (!of_property_read_u32(constraints_np, "cm-recharging-voltage",
+			&constraints->recharging_thres[CM_FULLBATT_VOLTAGE]))
+		constraints->recharging_conds |= (1 << CM_FULLBATT_VOLTAGE);
+	if (of_get_property(constraints_np, "cm-recharging-status", NULL))
+		constraints->recharging_conds |= (1 << CM_FULLBATT_STATUS);
+
+	of_property_read_u32(constraints_np, "cm-recharging-count",
+					&constraints->recharging_count);
+
+	/* Parse battery properties */
+	battery_np = of_get_child_by_name(np, "battery");
+	if (!battery_np)
+		return -EINVAL;
+
+	battery->psy = power_supply_get_by_phandle(battery_np, "cm-fuelgauge");
+	if (IS_ERR_OR_NULL(battery->psy)) {
+		dev_err(cm->dev, "Cannot find fuel gauge\n");
+		return -ENODEV;
+	}
+	if (!of_property_read_string(battery_np, "cm-thermal-zone", &buf))
+		battery->tzd = thermal_zone_get_zone_by_name(buf);
+	else
+		battery->tzd = battery->psy->tzd;
+	if (!battery->tzd) {
+		dev_err(cm->dev, "No way to monitor battery temperature.\n");
+		return -ENODEV;
 	}
 
-	of_property_read_string(np, "cm-fuel-gauge", &desc->psy_fuel_gauge);
-
-	of_property_read_string(np, "cm-thermal-zone", &desc->thermal_zone);
-
-	/* NOTICE : Default allowable minimum charge temperature is 0 */
-	of_property_read_u32(np, "cm-battery-cold", &desc->temp_min);
-	if (of_get_property(np, "cm-battery-cold-in-minus", NULL))
-		desc->temp_min *= -1;
-	of_property_read_u32(np, "cm-battery-hot", &desc->temp_max);
-	if (!desc->temp_max)
-		desc->temp_max = CM_DEFAULT_CHARGE_TEMP_MAX;
-	of_property_read_u32(np, "cm-battery-temp-diff", &desc->temp_diff);
-	if (!desc->temp_diff)
-		desc->temp_diff = CM_DEFAULT_RECHARGE_TEMP_DIFF;
-
-	of_property_read_u32(np, "cm-charging-max",
-				&desc->charging_max_duration_ms);
-	of_property_read_u32(np, "cm-discharging-max",
-				&desc->discharging_max_duration_ms);
-
-	/* battery charger regualtors */
-	desc->num_charger_regulators = of_get_child_count(np);
-	if (desc->num_charger_regulators) {
-		struct charger_regulator *chg_regs;
-		struct device_node *child;
-
-		chg_regs = devm_kzalloc(dev, sizeof(*chg_regs)
-					* desc->num_charger_regulators,
-					GFP_KERNEL);
-		if (!chg_regs)
-			return ERR_PTR(-ENOMEM);
-
-		desc->charger_regulators = chg_regs;
-
-		for_each_child_of_node(np, child) {
-			struct charger_cable *cables;
-			struct device_node *_child;
-
-			of_property_read_string(child, "cm-regulator-name",
-					&chg_regs->regulator_name);
-
-			/* charger cables */
-			chg_regs->num_cables = of_get_child_count(child);
-			if (chg_regs->num_cables) {
-				cables = devm_kzalloc(dev, sizeof(*cables)
-						* chg_regs->num_cables,
-						GFP_KERNEL);
-				if (!cables)
-					return ERR_PTR(-ENOMEM);
-
-				chg_regs->cables = cables;
-
-				for_each_child_of_node(child, _child) {
-					of_property_read_string(_child,
-					"cm-cable-name", &cables->name);
-					of_property_read_string(_child,
-					"cm-cable-extcon",
-					&cables->extcon_name);
-					of_property_read_u32(_child,
-					"cm-cable-min",
-					&cables->min_uA);
-					of_property_read_u32(_child,
-					"cm-cable-max",
-					&cables->max_uA);
-					cables++;
-				}
-			}
-			chg_regs++;
+	/* Parse charger properties */
+	cm->num_chargers = of_get_child_count(np);
+	/* Except battery, constratints child nodes*/
+	cm->num_chargers -= 2;
+	cm->chargers = devm_kzalloc(cm->dev,
+			 sizeof(cm->chargers) * cm->num_chargers, GFP_KERNEL);
+	if (!cm->chargers)
+		return -ENOMEM;
+
+	for_each_child_of_node(np, charger_np) {
+		if (strncmp(charger_np->name, "charger", 5))
+			continue;
+
+		charger = devm_kzalloc(cm->dev, sizeof(*charger), GFP_KERNEL);
+		if (!charger)
+			return -ENOMEM;
+
+		charger->psy = power_supply_get_by_phandle(charger_np,
+							"cm-charger");
+		if (IS_ERR_OR_NULL(charger->psy)) {
+			dev_err(cm->dev, "Cannot find charger(%s)\n",
+							charger_np->name);
+			return -ENODEV;
 		}
+
+		if (!of_property_read_string(charger_np,
+					"cm-regulator-name", &buf))
+			charger->regulator = regulator_get(cm->dev, buf);
+
+		of_property_read_u32(charger_np, "cm-charger-max-cc",
+							&charger->max_cc);
+
+		INIT_LIST_HEAD(&charger->cables);
+
+		/* charger cables */
+		for_each_child_of_node(charger_np, cable_np) {
+			struct charger_cable *cable;
+
+			cable = devm_kzalloc(cm->dev,
+						sizeof(*cable), GFP_KERNEL);
+			if (!cable)
+				return -ENOMEM;
+
+			of_property_read_string(cable_np,
+					"cm-cable-name", &cable->name);
+
+			if (of_property_read_string(cable_np,
+						"cm-cable-extcon", &buf))
+				return -EINVAL;
+
+			ret = charger_extcon_init(buf, cable);
+			if (ret)
+				return ret;
+
+			of_property_read_u32(cable_np,
+					"cm-cable-max", &cable->max_uA);
+
+			cable->charger = charger;
+
+			if (cable->attached)
+				charger->aggr_cc += cable->max_uA;
+
+			list_add(&cable->entry, &charger->cables);
+		}
+		cm->chargers[idx++] = charger;
 	}
-	return desc;
-}
 
-static inline struct charger_desc *cm_get_drv_data(struct platform_device *pdev)
-{
-	if (pdev->dev.of_node)
-		return of_cm_parse_desc(&pdev->dev);
-	return (struct charger_desc *)dev_get_platdata(&pdev->dev);
+	return 0;
 }
 
 static void cm_test_and_add_property(struct charger_manager *cm,
 					enum power_supply_property psp)
 {
+	struct power_supply *fuelgauge = cm->battery.psy;
 	union power_supply_propval val;
 
-	if (cm->fuel_gauge->get_property(cm->fuel_gauge, psp, &val))
+	if (fuelgauge->get_property(fuelgauge, psp, &val))
 		return;
 
-	cm->charger_psy.properties[cm->charger_psy.num_properties] = psp;
-	cm->charger_psy.num_properties++;
+	cm->psy.properties[cm->psy.num_properties] = psp;
+	cm->psy.num_properties++;
 }
 
 static enum alarmtimer_restart cm_timer_func(struct alarm *alarm, ktime_t now)
@@ -1332,15 +1210,9 @@ static enum alarmtimer_restart cm_timer_func(struct alarm *alarm, ktime_t now)
 
 static int charger_manager_probe(struct platform_device *pdev)
 {
-	struct charger_desc *desc = cm_get_drv_data(pdev);
 	struct charger_manager *cm;
+	struct charger_dev *charger;
 	int ret = 0, i = 0;
-	int j = 0;
-
-	if (!desc) {
-		dev_err(&pdev->dev, "No platform data (desc) found\n");
-		return -ENODEV;
-	}
 
 	cm = devm_kzalloc(&pdev->dev,
 			sizeof(struct charger_manager),	GFP_KERNEL);
@@ -1349,7 +1221,12 @@ static int charger_manager_probe(struct platform_device *pdev)
 
 	/* Basic Values. Unspecified are Null or 0 */
 	cm->dev = &pdev->dev;
-	cm->desc = desc;
+
+	ret = cm_initialize_data(cm);
+	if (ret) {
+		dev_err(cm->dev, "Failed to initialize charger-manager data\n");
+		return ret;
+	}
 
 	/* Initialize alarm timer */
 	if (alarmtimer_get_rtcdev()) {
@@ -1357,130 +1234,45 @@ static int charger_manager_probe(struct platform_device *pdev)
 		alarm_init(cm_timer, ALARM_BOOTTIME, cm_timer_func);
 	}
 
-	/*
-	 * The following two do not need to be errors.
-	 * Users may intentionally ignore those two features.
-	 */
-	if (desc->fullbatt_uV == 0) {
-		dev_info(&pdev->dev, "Ignoring full-battery voltage threshold as it is not supplied\n");
-	}
-	if (!desc->fullbatt_vchkdrop_uV) {
-		dev_info(&pdev->dev, "Disabling full-battery voltage drop checking mechanism as it is not supplied\n");
-		desc->fullbatt_vchkdrop_uV = 0;
-	}
-	if (desc->fullbatt_soc == 0) {
-		dev_info(&pdev->dev, "Ignoring full-battery soc(state of charge) threshold as it is not supplied\n");
-	}
-	if (desc->fullbatt_full_capacity == 0) {
-		dev_info(&pdev->dev, "Ignoring full-battery full capacity threshold as it is not supplied\n");
-	}
-
-	if (!desc->charger_regulators || desc->num_charger_regulators < 1) {
-		dev_err(&pdev->dev, "charger_regulators undefined\n");
-		return -EINVAL;
-	}
-
-	if (!desc->psy_charger_stat || !desc->psy_charger_stat[0]) {
-		dev_err(&pdev->dev, "No power supply defined\n");
-		return -EINVAL;
-	}
-
-	/* Counting index only */
-	while (desc->psy_charger_stat[i])
-		i++;
-
-	cm->charger_stat = devm_kzalloc(&pdev->dev,
-				sizeof(struct power_supply *) * i, GFP_KERNEL);
-	if (!cm->charger_stat)
-		return -ENOMEM;
-
-	for (i = 0; desc->psy_charger_stat[i]; i++) {
-		cm->charger_stat[i] = power_supply_get_by_name(
-					desc->psy_charger_stat[i]);
-		if (!cm->charger_stat[i]) {
-			dev_err(&pdev->dev, "Cannot find power supply \"%s\"\n",
-				desc->psy_charger_stat[i]);
-			return -ENODEV;
-		}
-	}
-
-	cm->fuel_gauge = power_supply_get_by_name(desc->psy_fuel_gauge);
-	if (!cm->fuel_gauge) {
-		dev_err(&pdev->dev, "Cannot find power supply \"%s\"\n",
-			desc->psy_fuel_gauge);
-		return -ENODEV;
-	}
-
-	if (desc->polling_interval_ms == 0 ||
-	    msecs_to_jiffies(desc->polling_interval_ms) <= CM_JIFFIES_SMALL) {
+	if (cm->polling_interval_ms != 0 &&
+	    msecs_to_jiffies(cm->polling_interval_ms) <= CM_JIFFIES_SMALL) {
 		dev_err(&pdev->dev, "polling_interval_ms is too small\n");
-		return -EINVAL;
-	}
-
-	if (!desc->charging_max_duration_ms ||
-			!desc->discharging_max_duration_ms) {
-		dev_info(&pdev->dev, "Cannot limit charging duration checking mechanism to prevent overcharge/overheat and control discharging duration\n");
-		desc->charging_max_duration_ms = 0;
-		desc->discharging_max_duration_ms = 0;
+		ret = -EINVAL;
+		goto err_out;
 	}
 
 	platform_set_drvdata(pdev, cm);
 
-	memcpy(&cm->charger_psy, &psy_default, sizeof(psy_default));
-
-	if (!desc->psy_name)
-		strncpy(cm->psy_name_buf, psy_default.name, PSY_NAME_MAX);
-	else
-		strncpy(cm->psy_name_buf, desc->psy_name, PSY_NAME_MAX);
-	cm->charger_psy.name = cm->psy_name_buf;
-
-	/* Allocate for psy properties because they may vary */
-	cm->charger_psy.properties = devm_kzalloc(&pdev->dev,
+	cm->psy.type = POWER_SUPPLY_TYPE_BATTERY;
+	cm->psy.get_property = cm_get_property;
+	cm->psy.properties = devm_kzalloc(&pdev->dev,
 				sizeof(enum power_supply_property)
 				* CM_NUM_OF_PROPS, GFP_KERNEL);
-	if (!cm->charger_psy.properties)
-		return -ENOMEM;
+	if (!cm->psy.properties) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
 
-	memcpy(cm->charger_psy.properties, cm_default_props,
+	memcpy(cm->psy.properties, cm_default_props,
 			sizeof(enum power_supply_property) *
 			ARRAY_SIZE(cm_default_props));
-	cm->charger_psy.num_properties = ARRAY_SIZE(cm_default_props);
+	cm->psy.num_properties = ARRAY_SIZE(cm_default_props);
 
+	/* Find which optional psy-properties are available */
 	for (i = 0; i < ARRAY_SIZE(cm_optional_props); i++)
 		cm_test_and_add_property(cm, cm_optional_props[i]);
 
-	if (desc->thermal_zone)
-		cm->tzd_batt =
-			thermal_zone_get_zone_by_name(desc->thermal_zone);
-	else
-		cm->tzd_batt = cm->fuel_gauge->tzd;
-
-	if (!cm->tzd_batt) {
-		pr_err("No way to monitor battery temperature.\n");
-		return -ENODEV;
-	}
-
-	ret = power_supply_register(NULL, &cm->charger_psy);
+	ret = power_supply_register(NULL, &cm->psy);
 	if (ret) {
-		dev_err(&pdev->dev, "Cannot register charger-manager with name \"%s\"\n",
-			cm->charger_psy.name);
-		return ret;
-	}
-
-	/* Register extcon device for charger cable */
-	ret = charger_manager_register_extcon(cm);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Cannot initialize extcon device\n");
-		goto err_reg_extcon;
+		dev_err(&pdev->dev, "Cannot register charger-manager(%s)\n",
+			cm->psy.name);
+		goto err_out;
 	}
 
 	/* Register sysfs entry for charger(regulator) */
-	ret = charger_manager_register_sysfs(cm);
-	if (ret < 0) {
-		dev_err(&pdev->dev,
-			"Cannot initialize sysfs entry of regulator\n");
-		goto err_reg_sysfs;
-	}
+	ret = cm_charger_create_sysfs(cm);
+	if (ret)
+		goto err_out;
 
 	/* Add to the list */
 	mutex_lock(&cm_list_mtx);
@@ -1494,34 +1286,24 @@ static int charger_manager_probe(struct platform_device *pdev)
 	device_init_wakeup(&pdev->dev, true);
 	device_set_wakeup_capable(&pdev->dev, false);
 
+	/* Update initial battery state */
+	_cm_monitor(cm);
+
 	schedule_work(&setup_polling);
 
 	return 0;
 
-err_reg_sysfs:
-	for (i = 0; i < desc->num_charger_regulators; i++) {
-		struct charger_regulator *charger;
+err_out:
+	for (i = 0; i < cm->num_chargers; i++) {
+		struct charger_cable *cable;
 
-		charger = &desc->charger_regulators[i];
-		sysfs_remove_group(&cm->charger_psy.dev->kobj,
-				&charger->attr_g);
-	}
-err_reg_extcon:
-	for (i = 0; i < desc->num_charger_regulators; i++) {
-		struct charger_regulator *charger;
-
-		charger = &desc->charger_regulators[i];
-		for (j = 0; j < charger->num_cables; j++) {
-			struct charger_cable *cable = &charger->cables[j];
-			/* Remove notifier block if only edev exists */
-			if (cable->extcon_dev.edev)
-				extcon_unregister_interest(&cable->extcon_dev);
-		}
+		charger = cm->chargers[i];
 
-		regulator_put(desc->charger_regulators[i].consumer);
-	}
+		list_for_each_entry(cable, &charger->cables, entry)
+			extcon_unregister_interest(&cable->extcon_dev);
 
-	power_supply_unregister(&cm->charger_psy);
+		regulator_put(charger->regulator);
+	}
 
 	return ret;
 }
@@ -1529,9 +1311,8 @@ err_reg_extcon:
 static int charger_manager_remove(struct platform_device *pdev)
 {
 	struct charger_manager *cm = platform_get_drvdata(pdev);
-	struct charger_desc *desc = cm->desc;
+	struct charger_dev *charger;
 	int i = 0;
-	int j = 0;
 
 	/* Remove from the list */
 	mutex_lock(&cm_list_mtx);
@@ -1541,21 +1322,20 @@ static int charger_manager_remove(struct platform_device *pdev)
 	cancel_work_sync(&setup_polling);
 	cancel_delayed_work_sync(&cm_monitor_work);
 
-	for (i = 0 ; i < desc->num_charger_regulators ; i++) {
-		struct charger_regulator *charger
-				= &desc->charger_regulators[i];
-		for (j = 0 ; j < charger->num_cables ; j++) {
-			struct charger_cable *cable = &charger->cables[j];
+	for (i = 0; i < cm->num_chargers; i++) {
+		struct charger_cable *cable;
+
+		charger = cm->chargers[i];
+
+		list_for_each_entry(cable, &charger->cables, entry)
 			extcon_unregister_interest(&cable->extcon_dev);
-		}
-	}
 
-	for (i = 0 ; i < desc->num_charger_regulators ; i++)
-		regulator_put(desc->charger_regulators[i].consumer);
+		regulator_put(charger->regulator);
+	}
 
-	power_supply_unregister(&cm->charger_psy);
+	power_supply_unregister(&cm->psy);
 
-	try_charger_enable(cm, false);
+	cm_set_charging(cm, false);
 
 	return 0;
 }
diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
index a61053f..1962ec5 100644
--- a/include/linux/power/charger-manager.h
+++ b/include/linux/power/charger-manager.h
@@ -33,213 +33,175 @@ enum polling_modes {
 	CM_POLL_CHARGING_ONLY,
 };
 
-enum cm_event_types {
-	CM_EVENT_UNKNOWN = 0,
-	CM_EVENT_BATT_FULL,
-	CM_EVENT_BATT_IN,
-	CM_EVENT_BATT_OUT,
-	CM_EVENT_BATT_OVERHEAT,
-	CM_EVENT_BATT_COLD,
-	CM_EVENT_EXT_PWR_IN_OUT,
-	CM_EVENT_CHG_START_STOP,
-	CM_EVENT_OTHERS,
+/**
+ * struct battery_entity
+ * @psy: power_supply instance of fuel gauge device
+ * @tzd: Thermal_zone_device instance for battery
+ * @soc: Current battery soc
+ * @voltage: Current battery voltage
+ * @capacity: Current battery capacity
+ * @temperature: Current battery temperature
+ * @health: Current battery health
+ * @status: Current battery status
+ * @fullbatt_check_count: Number of times checking if battery is full
+ * @fullcharged_at: The time when batter is fully charged
+ */
+struct battery_entity {
+	struct power_supply *psy;
+	struct thermal_zone_device *tzd;
+
+	int soc;
+	int voltage;
+	int capacity;
+	int temperature;
+	int health;
+	int status;
+
+	int fullbatt_check_count;
+	u64 fullcharged_at;
 };
 
 /**
  * struct charger_cable
- * @extcon_name: the name of extcon device.
- * @name: the name of charger cable(external connector).
- * @extcon_dev: the extcon device.
- * @wq: the workqueue to control charger according to the state of
- *	charger cable. If charger cable is attached, enable charger.
- *	But if charger cable is detached, disable charger.
- * @nb: the notifier block to receive changed state from EXTCON
- *	(External Connector) when charger cable is attached/detached.
- * @attached: the state of charger cable.
- *	true: the charger cable is attached
- *	false: the charger cable is detached
- * @charger: the instance of struct charger_regulator.
- * @cm: the Charger Manager representing the battery.
+ * @name: Cable name
+ * @entry: Entry for list
+ * @attached: The state of charger cable
+ * @max_uA: Maximum current that cable can supply
+ * @extcon_dev: extcon device for cable notification
+ * @nb: Notification block
+ * @charger: The instance of struct charger_dev
  */
 struct charger_cable {
-	const char *extcon_name;
 	const char *name;
+	struct list_head entry;
+	bool attached;
+	int max_uA;
 
-	/* The charger-manager use Exton framework*/
 	struct extcon_specific_cable_nb extcon_dev;
-	struct work_struct wq;
 	struct notifier_block nb;
 
-	/* The state of charger cable */
-	bool attached;
-
-	struct charger_regulator *charger;
-
-	/*
-	 * Set min/max current of regulator to protect over-current issue
-	 * according to a kind of charger cable when cable is attached.
-	 */
-	int min_uA;
-	int max_uA;
-
-	struct charger_manager *cm;
+	struct charger_dev *charger;
 };
 
 /**
- * struct charger_regulator
- * @regulator_name: the name of regulator for using charger.
- * @consumer: the regulator consumer for the charger.
- * @externally_control:
- *	Set if the charger-manager cannot control charger,
- *	the charger will be maintained with disabled state.
- * @cables:
- *	the array of charger cables to enable/disable charger
- *	and set current limit according to constratint data of
- *	struct charger_cable if only charger cable included
- *	in the array of charger cables is attached/detached.
- * @num_cables: the number of charger cables.
+ * struct charger_dev
+ * @psy: power_supply instance of charger device
+ * @regulator: regulator device instance
+ * @enabled: Represent if charger device is enabled
+ * @externally_control: Set if charger is externally controlled
+ * @max_cc: Maximum charging current that charger device allowed
+ * @curr_cc: Charging current
+ * @aggr_cc: Aggregated current from conntected cables
+ * @cables: List of cables
+ * @charging_start: Time of last charging start
+ * @charging_stop: Time of last charging end
  * @attr_g: Attribute group for the charger(regulator)
  * @attr_name: "name" sysfs entry
  * @attr_state: "state" sysfs entry
  * @attr_externally_control: "externally_control" sysfs entry
  * @attrs: Arrays pointing to attr_name/state/externally_control for attr_g
  */
-struct charger_regulator {
-	/* The name of regulator for charging */
-	const char *regulator_name;
-	struct regulator *consumer;
+struct charger_dev {
+	struct power_supply *psy;
+	struct regulator *regulator;
 
-	/* charger never on when system is on */
+	bool enabled;
 	int externally_control;
 
-	/*
-	 * Store constraint information related to current limit,
-	 * each cable have different condition for charging.
-	 */
-	struct charger_cable *cables;
-	int num_cables;
+	int max_cc;
+	int curr_cc;
+	int aggr_cc;
+
+	struct list_head cables;
+
+	u64 charging_start;
+	u64 charging_stop;
 
 	struct attribute_group attr_g;
 	struct device_attribute attr_name;
 	struct device_attribute attr_state;
 	struct device_attribute attr_externally_control;
 	struct attribute *attrs[4];
+};
 
-	struct charger_manager *cm;
+/**
+ * Full battery conditions:
+ * - CM_FULLBATT_SOC: Full battery's determined by state-of-charge
+ * - CM_FULLBATT_CAPACITY: Full battery's determined by capacity
+ * - CM_FULLBATT_VOLTAGE: Full battery's determined by voltage
+ * - CM_FULLBATT_STATUS: Full battery's determined by charger status
+ */
+enum {
+	CM_FULLBATT_SOC,
+	CM_FULLBATT_CAPACITY,
+	CM_FULLBATT_VOLTAGE,
+	CM_FULLBATT_STATUS,
 };
 
 /**
- * struct charger_desc
- * @psy_name: the name of power-supply-class for charger manager
- * @polling_mode:
- *	Determine which polling mode will be used
- * @fullbatt_vchkdrop_uV:
- *	Check voltage drop after the battery is fully charged.
- *	If it has dropped more than fullbatt_vchkdrop_uV
- *	CM will restart charging.
- * @fullbatt_uV: voltage in microvolt
- *	If VBATT >= fullbatt_uV, it is assumed to be full.
- * @fullbatt_soc: state of Charge in %
- *	If state of Charge >= fullbatt_soc, it is assumed to be full.
- * @fullbatt_full_capacity: full capacity measure
- *	If full capacity of battery >= fullbatt_full_capacity,
- *	it is assumed to be full.
- * @polling_interval_ms: interval in millisecond at which
- *	charger manager will monitor battery health
- * @battery_present:
- *	Specify where information for existance of battery can be obtained
- * @psy_charger_stat: the names of power-supply for chargers
- * @num_charger_regulator: the number of entries in charger_regulators
- * @charger_regulators: array of charger regulators
- * @psy_fuel_gauge: the name of power-supply for fuel gauge
- * @thermal_zone : the name of thermal zone for battery
+ * struct charging_constraints
+ * @charging_duration: Maximum charging duration
+ * @charging_hold_off: Hold off time for expiring of charging duration
+ * @charging_avail_at: Represent the time When re-charging is available
  * @temp_min : Minimum battery temperature for charging.
  * @temp_max : Maximum battery temperature for charging.
  * @temp_diff : Temperature diffential to restart charging.
- * @measure_battery_temp:
- *	true: measure battery temperature
- *	false: measure ambient temperature
- * @charging_max_duration_ms: Maximum possible duration for charging
- *	If whole charging duration exceed 'charging_max_duration_ms',
- *	cm stop charging.
- * @discharging_max_duration_ms:
- *	Maximum possible duration for discharging with charger cable
- *	after full-batt. If discharging duration exceed 'discharging
- *	max_duration_ms', cm start charging.
+ * @fullbatt_conds: Conditions for determining battery is full
+ * @fullbatt_thres: Thresholds for full battery conditions
+ * @fullbatt_count: Number of trial for full battery checking
+ * @top_off_time: Time for retainning top off mode
+ * @recharging_conds: Conditions for determining recharging is required
+ * @recharging_thres: Thresholds for recharging conditions
+ * @fullbatt_count: Number of trial for recharging checking
  */
-struct charger_desc {
-	const char *psy_name;
-
-	enum polling_modes polling_mode;
-	unsigned int polling_interval_ms;
-
-	unsigned int fullbatt_vchkdrop_uV;
-	unsigned int fullbatt_uV;
-	unsigned int fullbatt_soc;
-	unsigned int fullbatt_full_capacity;
-
-	enum data_source battery_present;
-
-	const char **psy_charger_stat;
-
-	int num_charger_regulators;
-	struct charger_regulator *charger_regulators;
-
-	const char *psy_fuel_gauge;
-
-	const char *thermal_zone;
+struct charging_constraints {
+	u32 charging_duration;
+	u32 charging_hold_off;
+	u32 charging_avail_at;
 
 	int temp_min;
 	int temp_max;
 	int temp_diff;
 
-	bool measure_battery_temp;
+	int fullbatt_conds;
+	int fullbatt_thres[3];
+	int fullbatt_count;
 
-	u32 charging_max_duration_ms;
-	u32 discharging_max_duration_ms;
-};
+	int top_off_time;
 
-#define PSY_NAME_MAX	30
+	int recharging_conds;
+	int recharging_thres[3];
+	int recharging_count;
+};
 
 /**
  * struct charger_manager
  * @entry: entry for list
  * @dev: device pointer
- * @desc: instance of charger_desc
- * @fuel_gauge: power_supply for fuel gauge
- * @charger_stat: array of power_supply for chargers
- * @tzd_batt : thermal zone device for battery
- * @charger_enabled: the state of charger
- * @emergency_stop:
- *	When setting true, stop charging
- * @psy_name_buf: the name of power-supply-class for charger manager
- * @charger_psy: power_supply for charger manager
- * @status_save_ext_pwr_inserted:
- *	saved status of external power before entering suspend-to-RAM
- * @status_save_batt:
- *	saved status of battery before entering suspend-to-RAM
- * @charging_start_time: saved start time of enabling charging
- * @charging_end_time: saved end time of disabling charging
+ * @psy: power_supply for charger manager
+ * @polling_mode: Determine which polling mode will be used
+ * @polling_interval_ms: interval in millisecond at which
+ * @battery_present:
+ *	Specify where information for existance of battery can be obtained
+ * @num_chargers: number of chargers associated with the battery
+ * @chargers: charger device instances
+ * @battery: entity related with battery information
+ * @constraints: charging constraint applied to the battery
  */
 struct charger_manager {
 	struct list_head entry;
 	struct device *dev;
-	struct charger_desc *desc;
-
-	struct power_supply *fuel_gauge;
-	struct power_supply **charger_stat;
-
-	struct thermal_zone_device *tzd_batt;
+	struct power_supply psy;
 
-	bool charger_enabled;
-
-	int emergency_stop;
+	enum polling_modes polling_mode;
+	unsigned int polling_interval_ms;
 
-	char psy_name_buf[PSY_NAME_MAX + 1];
-	struct power_supply charger_psy;
+	enum data_source battery_present;
 
-	u64 charging_start_time;
-	u64 charging_end_time;
+	int num_chargers;
+	struct charger_dev **chargers;
+	struct battery_entity battery;
+	struct charging_constraints constraints;
 };
 
 #endif /* _CHARGER_MANAGER_H */
-- 
1.7.9.5

