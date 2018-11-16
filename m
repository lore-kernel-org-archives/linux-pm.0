From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 5/6] power: supply: charger-manager: Remove deprecated extcon APIs
Date: Fri, 16 Nov 2018 19:01:12 +0800
Message-ID: <a41e3aad0147b25c4c22189dd7af0d68c5587b92.1542362262.git.baolin.wang@linaro.org>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
In-Reply-To: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org, linus.walleij@linaro.org
List-Id: linux-pm@vger.kernel.org

The struct extcon_specific_cable_nb and related APIs are deprecated now,
so we should use new method to get one extcon device and register extcon
notifier.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../bindings/power/supply/charger-manager.txt      |    6 +--
 drivers/power/supply/charger-manager.c             |   51 ++++++++------------
 include/linux/power/charger-manager.h              |    2 +-
 3 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/charger-manager.txt b/Documentation/devicetree/bindings/power/supply/charger-manager.txt
index ec4fe9d..315b0cb 100644
--- a/Documentation/devicetree/bindings/power/supply/charger-manager.txt
+++ b/Documentation/devicetree/bindings/power/supply/charger-manager.txt
@@ -11,7 +11,7 @@ Required properties :
 	- cm-regulator-name : name of charger regulator
 	- subnode <cable> :
 		- cm-cable-name : name of charger cable
-		- cm-cable-extcon : name of extcon dev
+		- extcon : phandles to external connector devices
 (optional)	- cm-cable-min : minimum current of cable
 (optional)	- cm-cable-max : maximum current of cable
 
@@ -66,13 +66,13 @@ Example :
 			cm-regulator-name = "chg-reg";
 			cable@0 {
 				cm-cable-name = "USB";
-				cm-cable-extcon = "extcon-dev.0";
+				extcon = <&extcon_usb>;
 				cm-cable-min = <475000>;
 				cm-cable-max = <500000>;
 			};
 			cable@1 {
 				cm-cable-name = "TA";
-				cm-cable-extcon = "extcon-dev.0";
+				extcon = <&extcon_usb>;
 				cm-cable-min = <650000>;
 				cm-cable-max = <675000>;
 			};
diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index dc0c9a6..4f28c03 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1207,12 +1207,11 @@ static int charger_extcon_init(struct charger_manager *cm,
 	 */
 	INIT_WORK(&cable->wq, charger_extcon_work);
 	cable->nb.notifier_call = charger_extcon_notifier;
-	ret = extcon_register_interest(&cable->extcon_dev,
-			cable->extcon_name, cable->name, &cable->nb);
-	if (ret < 0) {
-		pr_info("Cannot register extcon_dev for %s(cable: %s)\n",
-			cable->extcon_name, cable->name);
-	}
+	ret = devm_extcon_register_notifier(cm->dev, cable->extcon_dev,
+					    EXTCON_USB, &cable->nb);
+	if (ret < 0)
+		dev_err(cm->dev, "Cannot register extcon_dev for (cable: %s)\n",
+			cable->name);
 
 	return ret;
 }
@@ -1589,15 +1588,25 @@ static struct charger_desc *of_cm_parse_desc(struct device *dev)
 				for_each_child_of_node(child, _child) {
 					of_property_read_string(_child,
 					"cm-cable-name", &cables->name);
-					of_property_read_string(_child,
-					"cm-cable-extcon",
-					&cables->extcon_name);
 					of_property_read_u32(_child,
 					"cm-cable-min",
 					&cables->min_uA);
 					of_property_read_u32(_child,
 					"cm-cable-max",
 					&cables->max_uA);
+
+					if (of_property_read_bool(_child, "extcon")) {
+						struct device_node *np;
+
+						np = of_parse_phandle(_child, "extcon", 0);
+						if (!np)
+							return ERR_PTR(-ENODEV);
+
+						cables->extcon_dev = extcon_find_edev_by_node(np);
+						of_node_put(np);
+						if (IS_ERR(cables->extcon_dev))
+							return ERR_PTR(PTR_ERR(cables->extcon_dev));
+					}
 					cables++;
 				}
 			}
@@ -1625,7 +1634,6 @@ static int charger_manager_probe(struct platform_device *pdev)
 	struct charger_desc *desc = cm_get_drv_data(pdev);
 	struct charger_manager *cm;
 	int ret, i = 0;
-	int j = 0;
 	union power_supply_propval val;
 	struct power_supply *fuel_gauge;
 	struct power_supply_config psy_cfg = {};
@@ -1823,19 +1831,8 @@ static int charger_manager_probe(struct platform_device *pdev)
 				&charger->attr_g);
 	}
 err_reg_extcon:
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
-
+	for (i = 0; i < desc->num_charger_regulators; i++)
 		regulator_put(desc->charger_regulators[i].consumer);
-	}
 
 	power_supply_unregister(cm->charger_psy);
 
@@ -1847,7 +1844,6 @@ static int charger_manager_remove(struct platform_device *pdev)
 	struct charger_manager *cm = platform_get_drvdata(pdev);
 	struct charger_desc *desc = cm->desc;
 	int i = 0;
-	int j = 0;
 
 	/* Remove from the list */
 	mutex_lock(&cm_list_mtx);
@@ -1857,15 +1853,6 @@ static int charger_manager_remove(struct platform_device *pdev)
 	cancel_work_sync(&setup_polling);
 	cancel_delayed_work_sync(&cm_monitor_work);
 
-	for (i = 0 ; i < desc->num_charger_regulators ; i++) {
-		struct charger_regulator *charger
-				= &desc->charger_regulators[i];
-		for (j = 0 ; j < charger->num_cables ; j++) {
-			struct charger_cable *cable = &charger->cables[j];
-			extcon_unregister_interest(&cable->extcon_dev);
-		}
-	}
-
 	for (i = 0 ; i < desc->num_charger_regulators ; i++)
 		regulator_put(desc->charger_regulators[i].consumer);
 
diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
index c4fa907..e4d0269 100644
--- a/include/linux/power/charger-manager.h
+++ b/include/linux/power/charger-manager.h
@@ -66,7 +66,7 @@ struct charger_cable {
 	const char *name;
 
 	/* The charger-manager use Extcon framework */
-	struct extcon_specific_cable_nb extcon_dev;
+	struct extcon_dev *extcon_dev;
 	struct work_struct wq;
 	struct notifier_block nb;
 
-- 
1.7.9.5
