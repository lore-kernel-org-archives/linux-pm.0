From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v12.7 03/10] power: power_supply: Add power_supply_battery_info and API
Date: Fri, 21 Apr 2017 02:59:53 -0700
Message-ID: <20170421095959.14151-2-liam@networkimprov.net>
References: <20170421095959.14151-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34739 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1037544AbdDUKAR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Apr 2017 06:00:17 -0400
Received: by mail-io0-f195.google.com with SMTP id h41so28519808ioi.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Apr 2017 03:00:16 -0700 (PDT)
In-Reply-To: <20170421095959.14151-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org
Cc: Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

power_supply_get_battery_info() reads battery data from devicetree.
struct power_supply_battery_info provides battery data to drivers.
Drivers may surface battery data in sysfs via corresponding
POWER_SUPPLY_PROP_* fields.

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 Documentation/power/power_supply_class.txt | 12 ++++++++
 drivers/power/supply/power_supply_core.c   | 45 ++++++++++++++++++++++++++++++
 include/linux/power_supply.h               | 18 ++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/Documentation/power/power_supply_class.txt b/Documentation/power/power_supply_class.txt
index 0c72588..01f0075 100644
--- a/Documentation/power/power_supply_class.txt
+++ b/Documentation/power/power_supply_class.txt
@@ -174,6 +174,18 @@ issued by external power supply will notify supplicants via
 external_power_changed callback.
 
 
+Devicetree battery characteristics
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Drivers should call power_supply_get_battery_info() to obtain battery
+characteristics from a devicetree battery node, defined in
+Documentation/devicetree/bindings/power/supply/battery.txt. This is
+implemented in drivers/power/supply/bq27xxx_battery.c.
+
+Properties in struct power_supply_battery_info and their counterparts in the
+battery node have names corresponding to elements in enum power_supply_property,
+for naming consistency between sysfs attributes and battery node properties.
+
+
 QA
 ~~
 Q: Where is POWER_SUPPLY_PROP_XYZ attribute?
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index a74d8ca..61e20b1 100644
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
@@ -487,6 +488,50 @@ struct power_supply *devm_power_supply_get_by_phandle(struct device *dev,
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
+	if (strcmp("simple-battery", value))
+		return -ENODEV;
+
+	/* The property and field names below must correspond to elements
+	 * in enum power_supply_property. For reasoning, see
+	 * Documentation/power/power_supply_class.txt.
+	 */
+
+	of_property_read_u32(battery_np, "energy-full-design-microwatt-hours",
+			     &info->energy_full_design_uwh);
+	of_property_read_u32(battery_np, "charge-full-design-microamp-hours",
+			     &info->charge_full_design_uah);
+	of_property_read_u32(battery_np, "voltage-min-design-microvolt",
+			     &info->voltage_min_design_uv);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
+
 int power_supply_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 3965503..e84f1d3 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -288,6 +288,21 @@ struct power_supply_info {
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
+};
+
 extern struct atomic_notifier_head power_supply_notifier;
 extern int power_supply_reg_notifier(struct notifier_block *nb);
 extern void power_supply_unreg_notifier(struct notifier_block *nb);
@@ -306,6 +321,9 @@ static inline struct power_supply *
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
