From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH v3 RESEND 2/2] charger-manager : Support deivce tree in charger
 manager driver
Date: Wed, 18 Dec 2013 15:42:35 +0900
Message-ID: <1387348955-23174-3-git-send-email-jonghwa3.lee@samsung.com>
References: <1387348955-23174-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:31807 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab3LRGmn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2013 01:42:43 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXZ001CXPB5NB40@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 18 Dec 2013 15:42:41 +0900 (KST)
In-reply-to: <1387348955-23174-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: anton@enomsg.org, dwmw2@infradead.org, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>

Charger-manager can parse charger_desc data from devicetree which is used to
register charger manager.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
---
 .../bindings/power_supply/charger-manager.txt      |   81 ++++++++++++
 drivers/power/charger-manager.c                    |  138 +++++++++++++++++++-
 include/linux/power/charger-manager.h              |   12 +-
 3 files changed, 222 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/charger-manager.txt

diff --git a/Documentation/devicetree/bindings/power_supply/charger-manager.txt b/Documentation/devicetree/bindings/power_supply/charger-manager.txt
new file mode 100644
index 0000000..2b33750
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/charger-manager.txt
@@ -0,0 +1,81 @@
+charger-manager bindings
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Required properties :
+ - compatible : "charger-manager"
+ - <>-supply : for regulator consumer
+ - cm-num-chargers : number of chargers
+ - cm-chargers : name of chargers
+ - cm-fuel-gauge : name of battery fuel gauge
+ - subnode <regulator> :
+	- cm-regulator-name : name of charger regulator
+	- subnode <cable> :
+		- cm-cable-name : name of charger cable
+		- cm-cable-extcon : name of extcon dev
+(optional)	- cm-cable-min : minimum current of cable
+(optional)	- cm-cable-max : maximum current of cable
+
+Optional properties :
+ - cm-name : charger manager's name (default : "battery")
+ - cm-poll-mode : polling mode (enum polling_modes)
+ - cm-poll-interval : polling interval
+ - cm-battery-stat : battery status (enum data_source)
+ - cm-fullbatt-* : data for full battery checking
+ - cm-thermal-zone : name of external thermometer's thermal zone
+ - cm-battery-* : threshold battery temperature for charging
+	-cold : critical cold temperature of battery for charging
+	-cold-in-minus : flag that cold temerature is in minus degree
+	-hot : critical hot temperature of battery for charging
+	-temp-diff : temperature difference to allow recharging
+ - cm-dis/charging-max = limits of charging duration
+
+Example :
+	charger-manager@0 {
+		compatible = "charger-manager";
+		chg-reg-supply = <&charger_regulator>;
+
+		cm-name = "battery";
+		/* Always polling ON : 30s */
+		cm-poll-mode = <1>;
+		cm-poll-interval = <30000>;
+
+		cm-fullbatt-vchkdrop-ms = <30000>;
+		cm-fullbatt-vchkdrop-volt = <150000>;
+		cm-fullbatt-soc = <100>;
+
+		cm-battery-stat = <3>;
+
+		cm-num-chargers = <3>;
+		cm-chargers = "charger0", "charger1", "charger2";
+
+		cm-fuel-gauge = "fuelgauge0";
+
+		cm-thermal-zone = "thermal_zone.1"
+		/* in deci centigrade */
+		cm-battery-cold = <50>;
+		cm-battery-cold-in-minus;
+		cm-battery-hot = <800>;
+		cm-battery-temp-diff = <100>;
+
+		/* Allow charging for 5hr */
+		cm-charging-max = <18000000>;
+		/* Allow discharging for 2hr */
+		cm-discharging-max = <7200000>;
+
+		regulator@0 {
+			cm-regulator-name = "chg-reg";
+			cable@0 {
+				cm-cable-name = "USB";
+				cm-cable-extcon = "extcon-dev.0";
+				cm-cable-min = <475000>;
+				cm-cable-max = <500000>;
+			};
+			cable@1 {
+				cm-cable-name = "TA";
+				cm-cable-extcon = "extcon-dev.0";
+				cm-cable-min = <650000>;
+				cm-cable-max = <675000>;
+			};
+		};
+
+	};
diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 6b68d15..ec5c140 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -25,6 +25,7 @@
 #include <linux/power/charger-manager.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sysfs.h>
+#include <linux/of.h>
 #include <linux/thermal.h>
 
 /*
@@ -528,7 +529,7 @@ static int check_charging_duration(struct charger_manager *cm)
 		duration = curr - cm->charging_start_time;
 
 		if (duration > desc->charging_max_duration_ms) {
-			dev_info(cm->dev, "Charging duration exceed %lldms\n",
+			dev_info(cm->dev, "Charging duration exceed %ums\n",
 				 desc->charging_max_duration_ms);
 			uevent_notify(cm, "Discharging");
 			try_charger_enable(cm, false);
@@ -539,7 +540,7 @@ static int check_charging_duration(struct charger_manager *cm)
 
 		if (duration > desc->charging_max_duration_ms &&
 				is_ext_pwr_online(cm)) {
-			dev_info(cm->dev, "Discharging duration exceed %lldms\n",
+			dev_info(cm->dev, "Discharging duration exceed %ums\n",
 				 desc->discharging_max_duration_ms);
 			uevent_notify(cm, "Recharging");
 			try_charger_enable(cm, true);
@@ -1528,9 +1529,139 @@ static int cm_init_thermal_data(struct charger_manager *cm)
 	return ret;
 }
 
+static struct of_device_id charger_manager_match[] = {
+	{
+		.compatible = "charger-manager",
+	},
+	{},
+};
+
+struct charger_desc *of_cm_parse_desc(struct device *dev)
+{
+	struct charger_desc *desc;
+	struct device_node *np = dev->of_node;
+	u32 poll_mode = CM_POLL_DISABLE;
+	u32 battery_stat = CM_NO_BATTERY;
+	int num_chgs = 0;
+
+	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return ERR_PTR(-ENOMEM);
+
+	of_property_read_string(np, "cm-name", &desc->psy_name);
+
+	of_property_read_u32(np, "cm-poll-mode", &poll_mode);
+	desc->polling_mode = poll_mode;
+
+	of_property_read_u32(np, "cm-poll-interval",
+				&desc->polling_interval_ms);
+
+	of_property_read_u32(np, "cm-fullbatt-vchkdrop-ms",
+					&desc->fullbatt_vchkdrop_ms);
+	of_property_read_u32(np, "cm-fullbatt-vchkdrop-volt",
+					&desc->fullbatt_vchkdrop_uV);
+	of_property_read_u32(np, "cm-fullbatt-voltage", &desc->fullbatt_uV);
+	of_property_read_u32(np, "cm-fullbatt-soc", &desc->fullbatt_soc);
+	of_property_read_u32(np, "cm-fullbatt-capacity",
+					&desc->fullbatt_full_capacity);
+
+	of_property_read_u32(np, "cm-battery-stat", &battery_stat);
+	desc->battery_present = battery_stat;
+
+	/* chargers */
+	of_property_read_u32(np, "cm-num-chargers", &num_chgs);
+	if (num_chgs) {
+		/* Allocate empty bin at the tail of array */
+		desc->psy_charger_stat = devm_kzalloc(dev, sizeof(char *)
+						* (num_chgs + 1), GFP_KERNEL);
+		if (desc->psy_charger_stat) {
+			int i;
+			for (i = 0; i < num_chgs; i++)
+				of_property_read_string_index(np, "cm-chargers",
+						i, &desc->psy_charger_stat[i]);
+		} else {
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	of_property_read_string(np, "cm-fuel-gauge", &desc->psy_fuel_gauge);
+
+	of_property_read_string(np, "cm-thermal-zone", &desc->thermal_zone);
+
+	of_property_read_u32(np, "cm-battery-cold", &desc->temp_min);
+	if (of_get_property(np, "cm-battery-cold-in-minus", NULL))
+		desc->temp_min *= -1;
+	of_property_read_u32(np, "cm-battery-hot", &desc->temp_max);
+	of_property_read_u32(np, "cm-battery-temp-diff", &desc->temp_diff);
+
+	of_property_read_u32(np, "cm-charging-max",
+				&desc->charging_max_duration_ms);
+	of_property_read_u32(np, "cm-discharging-max",
+				&desc->discharging_max_duration_ms);
+
+	/* battery charger regualtors */
+	desc->num_charger_regulators = of_get_child_count(np);
+	if (desc->num_charger_regulators) {
+		struct charger_regulator *chg_regs;
+		struct device_node *child;
+
+		chg_regs = devm_kzalloc(dev, sizeof(*chg_regs)
+					* desc->num_charger_regulators,
+					GFP_KERNEL);
+		if (!chg_regs)
+			return ERR_PTR(-ENOMEM);
+
+		desc->charger_regulators = chg_regs;
+
+		for_each_child_of_node(np, child) {
+			struct charger_cable *cables;
+			struct device_node *_child;
+
+			of_property_read_string(child, "cm-regulator-name",
+					&chg_regs->regulator_name);
+
+			/* charger cables */
+			chg_regs->num_cables = of_get_child_count(child);
+			if (chg_regs->num_cables) {
+				cables = devm_kzalloc(dev, sizeof(*cables)
+						* chg_regs->num_cables,
+						GFP_KERNEL);
+				if (!cables)
+					return ERR_PTR(-ENOMEM);
+
+				chg_regs->cables = cables;
+
+				for_each_child_of_node(child, _child) {
+					of_property_read_string(_child,
+					"cm-cable-name", &cables->name);
+					of_property_read_string(_child,
+					"cm-cable-extcon",
+					&cables->extcon_name);
+					of_property_read_u32(_child,
+					"cm-cable-min",
+					&cables->min_uA);
+					of_property_read_u32(_child,
+					"cm-cable-max",
+					&cables->max_uA);
+					cables++;
+				}
+			}
+			chg_regs++;
+		}
+	}
+	return desc;
+}
+
+static inline struct charger_desc *cm_get_drv_data(struct platform_device *pdev)
+{
+	if (pdev->dev.of_node)
+		return of_cm_parse_desc(&pdev->dev);
+	return (struct charger_desc *)dev_get_platdata(&pdev->dev);
+}
+
 static int charger_manager_probe(struct platform_device *pdev)
 {
-	struct charger_desc *desc = dev_get_platdata(&pdev->dev);
+	struct charger_desc *desc = cm_get_drv_data(pdev);
 	struct charger_manager *cm;
 	int ret = 0, i = 0;
 	int j = 0;
@@ -1887,6 +2018,7 @@ static struct platform_driver charger_manager_driver = {
 		.name = "charger-manager",
 		.owner = THIS_MODULE,
 		.pm = &charger_manager_pm,
+		.of_match_table = charger_manager_match,
 	},
 	.probe = charger_manager_probe,
 	.remove = charger_manager_remove,
diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
index 9aec029..07e7945 100644
--- a/include/linux/power/charger-manager.h
+++ b/include/linux/power/charger-manager.h
@@ -191,7 +191,7 @@ struct charger_regulator {
  *	max_duration_ms', cm start charging.
  */
 struct charger_desc {
-	char *psy_name;
+	const char *psy_name;
 
 	enum polling_modes polling_mode;
 	unsigned int polling_interval_ms;
@@ -204,14 +204,14 @@ struct charger_desc {
 
 	enum data_source battery_present;
 
-	char **psy_charger_stat;
+	const char **psy_charger_stat;
 
 	int num_charger_regulators;
 	struct charger_regulator *charger_regulators;
 
-	char *psy_fuel_gauge;
+	const char *psy_fuel_gauge;
 
-	char *thermal_zone;
+	const char *thermal_zone;
 
 	int temp_min;
 	int temp_max;
@@ -219,8 +219,8 @@ struct charger_desc {
 
 	bool measure_battery_temp;
 
-	u64 charging_max_duration_ms;
-	u64 discharging_max_duration_ms;
+	u32 charging_max_duration_ms;
+	u32 discharging_max_duration_ms;
 };
 
 #define PSY_NAME_MAX	30
-- 
1.7.9.5

