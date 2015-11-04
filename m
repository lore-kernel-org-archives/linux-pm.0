From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v2 2/3] thermal: of: parse stacked thermal zones from device tree
Date: Wed,  4 Nov 2015 17:37:41 +0000
Message-ID: <1446658662-19582-3-git-send-email-javi.merino@arm.com>
References: <1446658662-19582-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446658662-19582-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rui.zang@intel.com, edubezval@gmail.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Let device tree set thermal zones in the thermal-sensors list of
phandles and set up the thermal zone hierarchy based on the information
present there.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 .../devicetree/bindings/thermal/thermal.txt        | 154 ++++++++++++++++++++-
 drivers/thermal/of-thermal.c                       |  99 +++++++++++++
 2 files changed, 250 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index 41b817f7b670..52b7e9ae3b4d 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -145,9 +145,12 @@ Required properties:
   Size: one cell
 
 - thermal-sensors:	A list of thermal sensor phandles and sensor specifier
-  Type: list of 	used while monitoring the thermal zone.
-  phandles + sensor
-  specifier
+  Type: list of 	used while monitoring the thermal zone. The phandles
+  phandles + sensor	can point to thermal sensors or other thermal zone
+  specifier		nodes. If it points to other thermal zone
+			nodes you should omit the sensor specifier
+			and set #thermal-sensor-cells to 0 for the
+			thermal zone.
 
 - trips:		A sub-node which is a container of only trip point nodes
   Type: sub-node	required to describe the thermal zone.
@@ -603,3 +606,148 @@ thermal-zones {
 The above example is a mix of previous examples, a sensor IP with several internal
 sensors used to monitor different zones, one of them is composed by several sensors and
 with different cooling devices.
+
+(e) Board thermal with stacked thermal zones
+
+Instead of setting up one thermal zone combining multiple thermal
+zones and multiple trip points for each cooling device, we can create
+a hierarchy of thermal zones.
+
+#include <dt-bindings/thermal/thermal.h>
+
+&i2c1 {
+	...
+	/*
+	 * An IC with several temperature sensor.
+	 */
+	adc_dummy: sensor@0x50 {
+		...
+		#thermal-sensor-cells = <1>; /* sensor internal ID */
+	};
+};
+
+thermal-zones {
+
+        cpu_thermal: cpu_thermal {
+		polling-delay-passive = <1000>; /* milliseconds */
+		polling-delay = <2500>; /* milliseconds */
+
+		sustainable-power = <2500>;
+
+		thermal-sensors = <&adc_dummy 0>
+
+		trips {
+			cpu_trip: cpu-trip {
+				temperature = <60000>; /* millicelsius */
+				hysteresis = <2000>; /* millicelsius */
+				type = "passive";
+			};
+                };
+
+		cooling-maps {
+			map0 {
+				trip = <&cpu_trip>;
+				cooling-device = <&cpu0 0 2>;
+			};
+                };
+        };
+
+        gpu_thermal: gpu_thermal {
+		polling-delay-passive = <1000>; /* milliseconds */
+		polling-delay = <2500>; /* milliseconds */
+
+		sustainable-power = <2500>;
+
+		thermal-sensors = <&adc_dummy 2>
+
+		trips {
+			gpu_trip: gpu-trip {
+				temperature = <55000>; /* millicelsius */
+				hysteresis = <2000>; /* millicelsius */
+				type = "passive";
+			}
+                };
+
+		cooling-maps {
+			map0 {
+				trip = <&gpu_trip>;
+				cooling-device = <&gpu0 0 2>;
+			};
+                };
+        };
+
+        lcd_thermal: lcd_thermal {
+		polling-delay-passive = <1000>; /* milliseconds */
+		polling-delay = <2500>; /* milliseconds */
+
+		sustainable-power = <2500>;
+
+		thermal-sensors = <&adc_dummy 1>
+
+		trips {
+			lcd_trip: lcp-trip {
+				temperature = <53000>; /* millicelsius */
+				hysteresis = <2000>; /* millicelsius */
+				type = "passive";
+			};
+                };
+
+		cooling-maps {
+			map0 {
+				trip = <&lcd_trip>;
+				cooling-device = <&lcd0 5 10>;
+			};
+                };
+        };
+
+	board_thermal: board-thermal {
+		polling-delay-passive = <1000>; /* milliseconds */
+		polling-delay = <2500>; /* milliseconds */
+
+		thermal-sensors = <&cpu_thermal &gpu_thermal &lcd_thermal>
+
+		sustainable-power = <2500>;
+
+		trips {
+			warm_trip: warm-trip {
+				temperature = <62000>; /* millicelsius */
+				hysteresis = <2000>; /* millicelsius */
+				type = "passive";
+			};
+			crit_trip: crit-trip {
+				temperature = <68000>; /* millicelsius */
+				hysteresis = <2000>; /* millicelsius */
+				type = "critical";
+			};
+		};
+
+		cooling-maps {
+			map0 {
+				trip = <&warm_trip>;
+				cooling-device = <&cpu0 2 2>;
+				contribution = <55>;
+			};
+			map1 {
+				trip = <&warm_trip>;
+				cooling-device = <&gpu0 2 2>;
+				contribution = <20>;
+			};
+			map2 {
+				trip = <&lcd_trip>;
+				cooling-device = <&lcd0 7 10>;
+				contribution = <15>;
+			};
+		};
+	};
+};
+
+The above example is a different take at example (d).  We create one
+thermal zone per sensor: cpu_thermal, gpu_thermal and lcd_thermal.
+Each of which has its own trip point for each own cooling device.  We
+then define a board_thermal thermal zone that is a combination of all
+the other thermal zones.  If the board hits its warm_trip, then all
+cooling devices are throttled.
+
+This example illustrates how we can throttle each device individually
+if its too hot and at the same time have some control over the whole
+system.
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 42b7d4253b94..17e8ae5edd73 100644
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
@@ -858,6 +879,81 @@ static inline void of_thermal_free_zone(struct __thermal_zone *tz)
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
+							"thermal-sensors",
+							"#thermal-sensor-cells",
+							i, &sensor_specs);
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
+			ret = thermal_zone_add_subtz(tz, subtz);
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
@@ -936,6 +1032,9 @@ int __init of_parse_thermal_zones(void)
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
