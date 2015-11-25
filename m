From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v3 3/4] thermal: of: parse stacked thermal zones from device tree
Date: Wed, 25 Nov 2015 15:09:45 +0000
Message-ID: <1448464186-26289-4-git-send-email-javi.merino@arm.com>
References: <1448464186-26289-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448464186-26289-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rui.zang@intel.com, edubezval@gmail.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Now that devicetree specifies how to create a hierarchy of thermal
zones, let of-thermal parse it.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/of-thermal.c | 100 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 42b7d4253b94..7bbc0c32ee59 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -166,6 +166,27 @@ of_thermal_get_trip_points(struct thermal_zone_device *tz)
 EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
 
 /**
+ * of_thermal_is_thermal_zone - check that a device node corresponds to a thermal zone
+ * @np:	the device node
+ *
+ * Valid thermal zone device nodes must provide the
+ * polling-delay-passive and polling-delay properties.  This function
+ * checks if @np is thermal-zone node.
+ *
+ * Return: true if @np is a valid device for a thermal zone.
+ */
+static bool of_thermal_is_thermal_zone(struct device_node *np)
+{
+	u32 out;
+
+	if ((of_property_read_u32(np, "polling-delay-passive", &out)) ||
+	    (of_property_read_u32(np, "polling-delay", &out)))
+		return false;
+
+	return true;
+}
+
+/**
  * of_thermal_set_emul_temp - function to set emulated temperature
  *
  * @tz:	pointer to a thermal zone
@@ -858,6 +879,82 @@ static inline void of_thermal_free_zone(struct __thermal_zone *tz)
 }
 
 /**
+ * link_stacked_thermal_zones - link thermal zones that are a superset of thermal zones
+ * @np:	device node for the root of the thermal zones
+ *
+ * A thermal zone can specify other thermal zones as its input using
+ * the thermal-sensors property of device tree.  This function parses
+ * all the thermal zones in dt and adds the thermal zones in their
+ * thermal-sensors as sub-thermalzones.
+ */
+static void link_stacked_thermal_zones(struct device_node *np)
+{
+	struct device_node *child;
+
+	for_each_child_of_node(np, child) {
+		int i, num_sensors;
+		struct thermal_zone_device *tz;
+
+		num_sensors = of_count_phandle_with_args(child,
+							 "thermal-sensors",
+							 "#thermal-sensor-cells");
+		if (num_sensors <= 0)
+			continue;
+
+		tz = thermal_zone_get_zone_by_name(child->name);
+		if (IS_ERR_OR_NULL(tz)) {
+			/*
+			 * If the tz is available we should have added
+			 * it in of_parse_thermal_zones()
+			 */
+			WARN(of_device_is_available(child),
+			     "Couldn't find thermal zone for %s\n",
+			     of_node_full_name(child));
+			continue;
+		}
+
+		for (i = 0; i < num_sensors; i++) {
+			struct of_phandle_args sensor_specs;
+			struct thermal_zone_device *subtz;
+			int ret;
+
+			ret = of_parse_phandle_with_args(child,
+							 "thermal-sensors",
+							 "#thermal-sensor-cells",
+							 i, &sensor_specs);
+			if (ret) {
+				pr_warn("Failed to parse thermal-sensors of %s: %d\n",
+					of_node_full_name(child), ret);
+				of_node_put(sensor_specs.np);
+				continue;
+			}
+
+			if (!of_thermal_is_thermal_zone(sensor_specs.np)) {
+				of_node_put(sensor_specs.np);
+				continue;
+			}
+
+			subtz = thermal_zone_get_zone_by_name(
+				sensor_specs.np->name);
+			if (IS_ERR_OR_NULL(subtz)) {
+				pr_warn("Couldn't find thermal zone for %s, is it disabled?\n",
+					of_node_full_name(sensor_specs.np));
+				of_node_put(sensor_specs.np);
+				continue;
+			}
+
+			ret = thermal_zone_add_subtz(tz, subtz,
+						     THERMAL_WEIGHT_DEFAULT);
+			if (ret)
+				pr_warn("Failed to add thermal zone %s to %s: %d\n",
+					subtz->type, tz->type, ret);
+
+			of_node_put(sensor_specs.np);
+		}
+	}
+}
+
+/**
  * of_parse_thermal_zones - parse device tree thermal data
  *
  * Initialization function that can be called by machine initialization
@@ -936,6 +1033,9 @@ int __init of_parse_thermal_zones(void)
 			/* attempting to build remaining zones still */
 		}
 	}
+
+	link_stacked_thermal_zones(np);
+
 	of_node_put(np);
 
 	return 0;
-- 
1.9.1
