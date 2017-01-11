From: Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH v3 3/7] power: power_supply: add battery info platform data retrieval
Date: Tue, 10 Jan 2017 22:19:59 -0800
Message-ID: <20170111062003.10110-4-matt@ranostay.consulting>
References: <20170111062003.10110-1-matt@ranostay.consulting>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36273 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751636AbdAKGUK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jan 2017 01:20:10 -0500
Received: by mail-pg0-f48.google.com with SMTP id f188so278519100pgc.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2017 22:20:10 -0800 (PST)
In-Reply-To: <20170111062003.10110-1-matt@ranostay.consulting>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: sre@kernel.org, tony@atomide.com, Matt Ranostay <matt@ranostay.consulting>

Add power_supply_get_battery_info() to get battery platform data

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
 drivers/power/supply/power_supply_core.c | 31 +++++++++++++++++++++++++++++++
 include/linux/power_supply.h             |  4 ++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 1e0960b646e8..08ddf3020658 100644
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
@@ -487,6 +488,36 @@ struct power_supply *devm_power_supply_get_by_phandle(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_power_supply_get_by_phandle);
 #endif /* CONFIG_OF */
 
+int power_supply_get_battery_info(struct power_supply *psy,
+				  struct power_supply_battery_info *info,
+				  const char *property)
+{
+	struct device_node *np = psy->of_node;
+	struct device_node *power_supply_battery_info_np;
+	int ret;
+
+	if (!np)
+		return -ENXIO;
+
+	power_supply_battery_info_np = of_parse_phandle(np, property, 0);
+	if (!power_supply_battery_info_np)
+		return -ENODEV;
+
+	ret = of_property_read_u32(power_supply_battery_info_np,
+				   "nominal-microvolt", &info->nominal_voltage);
+	if (ret < 0)
+		return ret;
+
+	ret = of_property_read_u32(power_supply_battery_info_np,
+				   "design-microwatt-hours", &info->energy);
+	if (ret < 0)
+		return ret;
+
+	return of_property_read_u32(power_supply_battery_info_np,
+				   "design-microamp-hours", &info->power);
+}
+EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
+
 int power_supply_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 59674a257d5e..859d0e7f9b6a 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -318,6 +318,10 @@ static inline struct power_supply *
 devm_power_supply_get_by_phandle(struct device *dev, const char *property)
 { return NULL; }
 #endif /* CONFIG_OF */
+
+extern int power_supply_get_battery_info(struct power_supply *psy,
+					 struct power_supply_battery_info *info,
+					 const char *property);
 extern void power_supply_changed(struct power_supply *psy);
 extern int power_supply_am_i_supplied(struct power_supply *psy);
 extern int power_supply_set_battery_charged(struct power_supply *psy);
-- 
2.10.2

