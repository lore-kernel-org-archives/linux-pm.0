From: Rob Herring <robh@kernel.org>
Subject: [PATCH] thermal: Convert to using %pOFn instead of device_node.name
Date: Mon, 27 Aug 2018 20:52:46 -0500
Message-ID: <20180828015252.28511-45-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/thermal/of-thermal.c    | 10 +++++-----
 drivers/thermal/qoriq_thermal.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 977a8307fbb1..e201ae1c382f 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -483,8 +483,8 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 		if (sensor_specs.args_count >= 1) {
 			id = sensor_specs.args[0];
 			WARN(sensor_specs.args_count > 1,
-			     "%s: too many cells in sensor specifier %d\n",
-			     sensor_specs.np->name, sensor_specs.args_count);
+			     "%pOFn: too many cells in sensor specifier %d\n",
+			     sensor_specs.np, sensor_specs.args_count);
 		} else {
 			id = 0;
 		}
@@ -960,8 +960,8 @@ int __init of_parse_thermal_zones(void)
 
 		tz = thermal_of_build_thermal_zone(child);
 		if (IS_ERR(tz)) {
-			pr_err("failed to build thermal zone %s: %ld\n",
-			       child->name,
+			pr_err("failed to build thermal zone %pOFn: %ld\n",
+			       child,
 			       PTR_ERR(tz));
 			continue;
 		}
@@ -995,7 +995,7 @@ int __init of_parse_thermal_zones(void)
 						    tz->passive_delay,
 						    tz->polling_delay);
 		if (IS_ERR(zone)) {
-			pr_err("Failed to build %s zone %ld\n", child->name,
+			pr_err("Failed to build %pOFn zone %ld\n", child,
 			       PTR_ERR(zone));
 			kfree(tzp);
 			kfree(ops);
diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index c866cc165960..1fa132fc316b 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -129,8 +129,8 @@ static int qoriq_tmu_get_sensor_id(void)
 	if (sensor_specs.args_count >= 1) {
 		id = sensor_specs.args[0];
 		WARN(sensor_specs.args_count > 1,
-				"%s: too many cells in sensor specifier %d\n",
-				sensor_specs.np->name, sensor_specs.args_count);
+				"%pOFn: too many cells in sensor specifier %d\n",
+				sensor_specs.np, sensor_specs.args_count);
 	} else {
 		id = 0;
 	}
-- 
2.17.1
