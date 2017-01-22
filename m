From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Subject: [PATCH v4 4/8] power: power_supply: add battery info platform data retrieval
Date: Sat, 21 Jan 2017 23:14:00 -0800
Message-ID: <20170122071404.9654-5-matt@ranostay.consulting>
References: <20170122071404.9654-1-matt@ranostay.consulting>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170122071404.9654-1-matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add power_supply_get_battery_info() to get battery platform data

Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
---
 drivers/power/supply/power_supply_core.c | 41 ++++++++++++++++++++++++++++++++
 include/linux/power_supply.h             |  4 ++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 1e0960b646e8..21490b5e233f 100644
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
@@ -487,6 +488,46 @@ struct power_supply *devm_power_supply_get_by_phandle(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_power_supply_get_by_phandle);
 #endif /* CONFIG_OF */
 
+int power_supply_get_battery_info(struct power_supply *psy,
+				  struct power_supply_battery_info *info,
+				  const char *property)
+{
+	struct device_node *np = psy->of_node;
+	struct device_node *power_supply_battery_info_np;
+	struct property *p;
+	char *prefix = "fixed-battery";
+	int ret;
+
+	if (!np)
+		return -ENXIO;
+
+	power_supply_battery_info_np = of_parse_phandle(np, property, 0);
+	if (!power_supply_battery_info_np)
+		return -ENODEV;
+
+	p = of_find_property(power_supply_battery_info_np, "compatible", NULL);
+
+	if (!p || !p->value)
+		return -ENODEV;
+
+	if (strncmp(prefix, p->value, strlen(prefix)))
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
