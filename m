From: Wei Ni <wni@nvidia.com>
Subject: [PATCH] thermal: add trip parameter for of .get_trend
Date: Wed, 8 Jan 2014 17:07:17 +0800
Message-ID: <1389172038-723-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3400 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755152AbaAHJHC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2014 04:07:02 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: eduardo.valentin@ti.com, rui.zhang@intel.com, mark.rutland@arm.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, Wei Ni <wni@nvidia.com>

Add trip parameter for the of-thermal's .get_trend(), so
that it can be compatible with current thermal framework.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/of-thermal.c                       |   16 +++++-----------
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   18 +++++++++---------
 include/linux/thermal.h                            |    4 ++--
 3 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 97c12cf..a503e61 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -97,7 +97,7 @@ struct __thermal_zone {
 	/* sensor interface */
 	void *sensor_data;
 	int (*get_temp)(void *, long *);
-	int (*get_trend)(void *, long *);
+	int (*get_trend)(void *, int, long *);
 };
 
 /***   DT thermal zone device callbacks   ***/
@@ -123,17 +123,11 @@ static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
 	if (!data->get_trend)
 		return -EINVAL;
 
-	r = data->get_trend(data->sensor_data, &dev_trend);
+	r = data->get_trend(data->sensor_data, trip, &dev_trend);
 	if (r)
 		return r;
 
-	/* TODO: These intervals might have some thresholds, but in core code */
-	if (dev_trend > 0)
-		*trend = THERMAL_TREND_RAISING;
-	else if (dev_trend < 0)
-		*trend = THERMAL_TREND_DROPPING;
-	else
-		*trend = THERMAL_TREND_STABLE;
+	*trend = dev_trend;
 
 	return 0;
 }
@@ -325,7 +319,7 @@ static struct thermal_zone_device *
 thermal_zone_of_add_sensor(struct device_node *zone,
 			   struct device_node *sensor, void *data,
 			   int (*get_temp)(void *, long *),
-			   int (*get_trend)(void *, long *))
+			   int (*get_trend)(void *, int, long *))
 {
 	struct thermal_zone_device *tzd;
 	struct __thermal_zone *tz;
@@ -384,7 +378,7 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 struct thermal_zone_device *
 thermal_zone_of_sensor_register(struct device *dev, int sensor_id,
 				void *data, int (*get_temp)(void *, long *),
-				int (*get_trend)(void *, long *))
+				int (*get_trend)(void *, int, long *))
 {
 	struct device_node *np, *child, *sensor_np;
 
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 9eec26d..1a8ae03 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -239,7 +239,7 @@ static int ti_thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-static int __ti_thermal_get_trend(void *p, long *trend)
+static int __ti_thermal_get_trend(void *p, int trip, long *trend)
 {
 	struct ti_thermal_data *data = p;
 	struct ti_bandgap *bgp;
@@ -252,7 +252,12 @@ static int __ti_thermal_get_trend(void *p, long *trend)
 	if (ret)
 		return ret;
 
-	*trend = tr;
+	if (tr > 0)
+		*trend = THERMAL_TREND_RAISING;
+	else if (tr < 0)
+		*trend = THERMAL_TREND_DROPPING;
+	else
+		*trend = THERMAL_TREND_STABLE;
 
 	return 0;
 }
@@ -264,16 +269,11 @@ static int ti_thermal_get_trend(struct thermal_zone_device *thermal,
 	int ret;
 	long tr;
 
-	ret = __ti_thermal_get_trend(thermal->devdata, &tr);
+	ret = __ti_thermal_get_trend(thermal->devdata, trip, &tr);
 	if (ret)
 		return ret;
 
-	if (tr > 0)
-		*trend = THERMAL_TREND_RAISING;
-	else if (tr < 0)
-		*trend = THERMAL_TREND_DROPPING;
-	else
-		*trend = THERMAL_TREND_STABLE;
+	*trend = tr;
 
 	return 0;
 }
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index a94de8c..37e4e03 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -249,14 +249,14 @@ struct thermal_genl_event {
 struct thermal_zone_device *
 thermal_zone_of_sensor_register(struct device *dev, int id,
 				void *data, int (*get_temp)(void *, long *),
-				int (*get_trend)(void *, long *));
+				int (*get_trend)(void *, int, long *));
 void thermal_zone_of_sensor_unregister(struct device *dev,
 				       struct thermal_zone_device *tz);
 #else
 static inline struct thermal_zone_device *
 thermal_zone_of_sensor_register(struct device *dev, int id,
 				void *data, int (*get_temp)(void *, long *),
-				int (*get_trend)(void *, long *))
+				int (*get_trend)(void *, int, long *))
 {
 	return NULL;
 }
-- 
1.7.9.5

