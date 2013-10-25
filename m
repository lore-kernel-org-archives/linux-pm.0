From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 3/3] charger-manager : Support deivce tree in charger manager
 driver
Date: Fri, 25 Oct 2013 11:47:33 +0900
Message-ID: <1382669253-23629-4-git-send-email-jonghwa3.lee@samsung.com>
References: <1382669253-23629-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:34870 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278Ab3JYCrw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2013 22:47:52 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MV7008YHEDVL540@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 25 Oct 2013 11:47:51 +0900 (KST)
In-reply-to: <1382669253-23629-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: anton@enomsg.org, dwmw2@infradead.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

With this patch, charger manager can parse charger_desc data from DT
which is used to register charger manager.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
---
 .../bindings/power_supply/charger-manager.txt      |   82 +++++++++++
 drivers/power/charger-manager.c                    |  144 +++++++++++++++++++-
 include/linux/power/charger-manager.h              |   10 +-
 3 files changed, 228 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/charger-manager.txt

diff --git a/Documentation/devicetree/bindings/power_supply/charger-manager.txt b/Documentation/devicetree/bindings/power_supply/charger-manager.txt
new file mode 100644
index 0000000..806ea67
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/charger-manager.txt
@@ -0,0 +1,82 @@
+charger-manager bindings
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Required properties :
+ - compatible : "charger-manager"
+ - <>-supply : for regulator consumer
+ - cm-num-chargers : number of chargers
+ - cm-chargers : name of chargers
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
+ - cm-battery-* : data related to battery temperature
+	-cold : critical cold temperature for battery
+	-in-minus : flag that cold temerature is in minus degree
+	-hot : critical hot temperature for battery
+	-temp-diff : temperature difference to allow recharging
+ - cm-battery-has-therm : flag that fuel gauge has thermometer
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
+		/* in milli centigrade */
+		cm-battery-cold = <5000>;
+		cm-battery-cold-in-minus;
+		cm-battery-hot = <80000>;
+		cm-battery-temp-diff = <15000>;
+
+		cm-num-chargers = <3>;
+		cm-chargers = "charger0", "charger1", "charger2";
+
+		cm-fuel-gauge = "fuelgauge0";
+		cm-battery-has-therm;
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
+
+
diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 959eace..8576675 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -518,7 +518,7 @@ static int check_charging_duration(struct charger_manager *cm)
 		duration = curr - cm->charging_start_time;
 
 		if (duration > desc->charging_max_duration_ms) {
-			dev_info(cm->dev, "Charging duration exceed %lldms\n",
+			dev_info(cm->dev, "Charging duration exceed %ums\n",
 				 desc->charging_max_duration_ms);
 			uevent_notify(cm, "Discharging");
 			try_charger_enable(cm, false);
@@ -529,7 +529,7 @@ static int check_charging_duration(struct charger_manager *cm)
 
 		if (duration > desc->charging_max_duration_ms &&
 				is_ext_pwr_online(cm)) {
-			dev_info(cm->dev, "Discharging duration exceed %lldms\n",
+			dev_info(cm->dev, "Discharging duration exceed %ums\n",
 				 desc->discharging_max_duration_ms);
 			uevent_notify(cm, "Recharging");
 			try_charger_enable(cm, true);
@@ -1501,9 +1501,146 @@ static int cm_default_get_temp(struct charger_manager *cm)
 	return last_temp_status;
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id charger_manager_match[] = {
+	{
+		.compatible = "charger-manager",
+	},
+	{},
+ };
+
+struct charger_desc *of_cm_parse_desc(struct device *dev)
+{
+	struct charger_desc *desc;
+	struct device_node *np = dev->of_node;
+	u32 poll_mode = CM_POLL_DISABLE;
+	u32 battery_stat = CM_NO_BATTERY;
+	int num_chgs;
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
+	of_property_read_u32(np, "cm-battery-cold", &desc->temp_alert_min);
+	if (of_get_property(np, "cm-battery-cold-in-minus", NULL))
+		desc->temp_alert_min *= -1;
+	of_property_read_u32(np, "cm-battery-hot", &desc->temp_alert_max);
+	of_property_read_u32(np, "cm-battery-temp-diff",
+					&desc->temp_alert_diff);
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
+	if (of_get_property(np, "cm-battery-has-therm", NULL))
+		desc->measure_battery_temp = true;
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
+#else
+#define charger_manager_match	NULL
+#endif
+
+static inline struct charger_desc *cm_get_drv_data(struct platform_device *pdev)
+{
+#ifdef CONFIG_OF
+	if (pdev->dev.of_node)
+		return of_cm_parse_desc(&pdev->dev);
+#endif
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
@@ -1872,6 +2009,7 @@ static struct platform_driver charger_manager_driver = {
 		.name = "charger-manager",
 		.owner = THIS_MODULE,
 		.pm = &charger_manager_pm,
+		.of_match_table = charger_manager_match,
 	},
 	.probe = charger_manager_probe,
 	.remove = charger_manager_remove,
diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
index 2088619..0f6f574 100644
--- a/include/linux/power/charger-manager.h
+++ b/include/linux/power/charger-manager.h
@@ -195,7 +195,7 @@ struct charger_manager;
  *	max_duration_ms', cm start charging.
  */
 struct charger_desc {
-	char *psy_name;
+	const char *psy_name;
 
 	enum polling_modes polling_mode;
 	unsigned int polling_interval_ms;
@@ -208,12 +208,12 @@ struct charger_desc {
 
 	enum data_source battery_present;
 
-	char **psy_charger_stat;
+	const char **psy_charger_stat;
 
 	int num_charger_regulators;
 	struct charger_regulator *charger_regulators;
 
-	char *psy_fuel_gauge;
+	const char *psy_fuel_gauge;
 
 	int temp_alert_min;
 	int temp_alert_max;
@@ -222,8 +222,8 @@ struct charger_desc {
 	int (*temperature_out_of_range)(struct charger_manager *);
 	bool measure_battery_temp;
 
-	u64 charging_max_duration_ms;
-	u64 discharging_max_duration_ms;
+	u32 charging_max_duration_ms;
+	u32 discharging_max_duration_ms;
 };
 
 #define PSY_NAME_MAX	30
-- 
1.7.9.5

