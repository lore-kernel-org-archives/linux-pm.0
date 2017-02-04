From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v5 4/8] power: power_supply: Add power_supply_battery_info and API
Date: Sat,  4 Feb 2017 01:15:59 -0800
Message-ID: <20170204091603.32242-5-liam@networkimprov.net>
References: <20170204091603.32242-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36013 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753745AbdBDJSj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Feb 2017 04:18:39 -0500
Received: by mail-pg0-f67.google.com with SMTP id 75so4127813pgf.3
        for <linux-pm@vger.kernel.org>; Sat, 04 Feb 2017 01:18:39 -0800 (PST)
In-Reply-To: <20170204091603.32242-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, Matt Ranostay <matt@ranostay.consulting>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

From: Matt Ranostay <matt@ranostay.consulting>

From: Matt Ranostay <matt@ranostay.consulting>

power_supply_get_battery_info() reads battery data from devicetree.
struct power_supply_battery_info provides battery data to drivers.
Drivers may surface battery data in sysfs via corresponding
POWER_SUPPLY_PROP_* fields.

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/power_supply_core.c | 43 ++++++++++++++++++++++++++++++++
 include/linux/power_supply.h             | 19 ++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index a74d8ca..2d564a5 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -17,6 +17,7 @@
 #include <linux/device.h>
 #include <linux/notifier.h>
 #include <linux/err.h>
+#include <linux/of.h>
 #include <linux/power_supply.h>
 #include <linux/thermal.h>
 #include "power_supply.h"
@@ -487,6 +488,48 @@ struct power_supply *devm_power_supply_get_by_phandle(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_power_supply_get_by_phandle);
 #endif /* CONFIG_OF */
 
+int power_supply_get_battery_info(struct power_supply *psy,
+				  struct power_supply_battery_info *info)
+{
+	struct device_node *battery_np;
+	const char *value;
+	int err;
+
+	info->energy_full_design_uwh = -EINVAL;
+	info->charge_full_design_uah = -EINVAL;
+	info->voltage_min_design_uv  = -EINVAL;
+	info->voltage_max_design_uv  = -EINVAL;
+
+	if (!psy->of_node) {
+		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
+			 __func__);
+		return -ENXIO;
+	}
+
+	battery_np = of_parse_phandle(psy->of_node, "monitored-battery", 0);
+	if (!battery_np)
+		return -ENODEV;
+
+	err = of_property_read_string(battery_np, "compatible", &value);
+	if (err)
+		return err;
+
+	if (strcmp("fixed-battery", value))
+		return -ENODEV;
+
+	of_property_read_u32(battery_np, "energy-full-design-microwatt-hours",
+			     &info->energy_full_design_uwh);
+	of_property_read_u32(battery_np, "charge-full-design-microamp-hours",
+			     &info->charge_full_design_uah);
+	of_property_read_u32(battery_np, "voltage-min-design-microvolt",
+			     &info->voltage_min_design_uv);
+	of_property_read_u32(battery_np, "voltage-max-design-microvolt",
+			     &info->voltage_max_design_uv);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
+
 int power_supply_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 3965503..3f3fea5 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -288,6 +288,22 @@ struct power_supply_info {
 	int use_for_apm;
 };
 
+/*
+ * This is the recommended struct to manage static battery parameters,
+ * populated by power_supply_get_battery_info(). Most platform drivers should
+ * use these for consistency.
+ * Its field names must correspond to elements in enum power_supply_property.
+ * The default field value is -EINVAL.
+ * Power supply class itself doesn't use this.
+ */
+
+struct power_supply_battery_info {
+	int energy_full_design_uwh;	/* microWatt-hours */
+	int charge_full_design_uah;	/* microAmp-hours */
+	int voltage_min_design_uv;	/* microVolts */
+	int voltage_max_design_uv;	/* microVolts */
+};
+
 extern struct atomic_notifier_head power_supply_notifier;
 extern int power_supply_reg_notifier(struct notifier_block *nb);
 extern void power_supply_unreg_notifier(struct notifier_block *nb);
@@ -306,6 +322,9 @@ static inline struct power_supply *
 devm_power_supply_get_by_phandle(struct device *dev, const char *property)
 { return NULL; }
 #endif /* CONFIG_OF */
+
+extern int power_supply_get_battery_info(struct power_supply *psy,
+					 struct power_supply_battery_info *info);
 extern void power_supply_changed(struct power_supply *psy);
 extern int power_supply_am_i_supplied(struct power_supply *psy);
 extern int power_supply_set_battery_charged(struct power_supply *psy);
-- 
2.9.3

