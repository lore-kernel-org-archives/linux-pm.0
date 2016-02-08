From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH] thermal: of: use for_each_available_child_of_node for child iterator
Date: Mon, 8 Feb 2016 18:58:34 +0530
Message-ID: <1454938114-28507-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Use for_each_available_child_of_node() for iterating over each
available child instead of iterating over each child and then
checking their status.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/thermal/of-thermal.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index be4eedc..9043f8f 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -475,14 +475,10 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 
 	sensor_np = of_node_get(dev->of_node);
 
-	for_each_child_of_node(np, child) {
+	for_each_available_child_of_node(np, child) {
 		struct of_phandle_args sensor_specs;
 		int ret, id;
 
-		/* Check whether child is enabled or not */
-		if (!of_device_is_available(child))
-			continue;
-
 		/* For now, thermal framework supports only 1 sensor per zone */
 		ret = of_parse_phandle_with_args(child, "thermal-sensors",
 						 "#thermal-sensor-cells",
@@ -881,16 +877,12 @@ int __init of_parse_thermal_zones(void)
 		return 0; /* Run successfully on systems without thermal DT */
 	}
 
-	for_each_child_of_node(np, child) {
+	for_each_available_child_of_node(np, child) {
 		struct thermal_zone_device *zone;
 		struct thermal_zone_params *tzp;
 		int i, mask = 0;
 		u32 prop;
 
-		/* Check whether child is enabled or not */
-		if (!of_device_is_available(child))
-			continue;
-
 		tz = thermal_of_build_thermal_zone(child);
 		if (IS_ERR(tz)) {
 			pr_err("failed to build thermal zone %s: %ld\n",
@@ -968,13 +960,9 @@ void of_thermal_destroy_zones(void)
 		return;
 	}
 
-	for_each_child_of_node(np, child) {
+	for_each_available_child_of_node(np, child) {
 		struct thermal_zone_device *zone;
 
-		/* Check whether child is enabled or not */
-		if (!of_device_is_available(child))
-			continue;
-
 		zone = thermal_zone_get_zone_by_name(child->name);
 		if (IS_ERR(zone))
 			continue;
-- 
2.1.4
