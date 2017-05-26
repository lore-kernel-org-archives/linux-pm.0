From: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v3 2/4] power: supply: core: add charging voltage/current battery info
Date: Fri, 26 May 2017 13:04:11 +0200
Message-ID: <20170526110413.24836-2-enric.balletbo@collabora.com>
References: <20170526110413.24836-1-enric.balletbo@collabora.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170526110413.24836-1-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Add the parameters to define the battery charging voltage and charging
current. Charger driver can get this information from the struct
power_supply_battery_info and apply the desired value.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
---
Changes since v2:
 - Requested by Sebastian Reichel
   - Move to its own patch and apply to simple-battery framework.
Changes since v1:
 - Requested by Rob Herring
   - Rename ti,charge-* to charge-* to be standard properties.
   - Use unit suffixes as per bindings/property-units.txt

 drivers/power/supply/power_supply_core.c | 6 ++++++
 include/linux/power_supply.h             | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 862fa8fc..a6857c2 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -530,6 +530,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->energy_full_design_uwh = -EINVAL;
 	info->charge_full_design_uah = -EINVAL;
 	info->voltage_min_design_uv  = -EINVAL;
+	info->charge_voltage_uv = -EINVAL;
+	info->charge_current_ua = -EINVAL;
 
 	if (!psy->of_node) {
 		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
@@ -559,6 +561,10 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			     &info->charge_full_design_uah);
 	of_property_read_u32(battery_np, "voltage-min-design-microvolt",
 			     &info->voltage_min_design_uv);
+	of_property_read_u32(battery_np, "charge-voltage-microvolt",
+			     &info->charge_voltage_uv);
+	of_property_read_u32(battery_np, "charge-current-microamp",
+			     &info->charge_current_ua);
 
 	return 0;
 }
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 8220f7b..3eea323 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -302,6 +302,8 @@ struct power_supply_battery_info {
 	int energy_full_design_uwh;	/* microWatt-hours */
 	int charge_full_design_uah;	/* microAmp-hours */
 	int voltage_min_design_uv;	/* microVolts */
+	int charge_voltage_uv;		/* microVolts */
+	int charge_current_ua;		/* microAmp */
 };
 
 extern struct atomic_notifier_head power_supply_notifier;
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
