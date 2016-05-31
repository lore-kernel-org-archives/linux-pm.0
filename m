From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 20/48] thermal: core: treat correctly the return value of *scanf calls
Date: Mon, 30 May 2016 23:18:27 -0700
Message-ID: <1464675535-2433-21-git-send-email-edubezval@gmail.com>
References: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

This patch checks the return value of all calls to *scanf.
The check is to simply match the number of expect inputs.

The current code does not do any recovery in case the
number of treated inputs are different than the expected.
Therefore, keeping the same behavior.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 71fb762..9545e15 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -817,7 +817,7 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
 	if (!tz->ops->get_trip_type)
 		return -EPERM;
 
-	if (!sscanf(attr->attr.name, "trip_point_%d_type", &trip))
+	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip) != 1)
 		return -EINVAL;
 
 	result = tz->ops->get_trip_type(tz, trip, &type);
@@ -849,7 +849,7 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	if (!tz->ops->set_trip_temp)
 		return -EPERM;
 
-	if (!sscanf(attr->attr.name, "trip_point_%d_temp", &trip))
+	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
 		return -EINVAL;
 
 	if (kstrtoint(buf, 10, &temperature))
@@ -875,7 +875,7 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 	if (!tz->ops->get_trip_temp)
 		return -EPERM;
 
-	if (!sscanf(attr->attr.name, "trip_point_%d_temp", &trip))
+	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
 		return -EINVAL;
 
 	ret = tz->ops->get_trip_temp(tz, trip, &temperature);
@@ -897,7 +897,7 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 	if (!tz->ops->set_trip_hyst)
 		return -EPERM;
 
-	if (!sscanf(attr->attr.name, "trip_point_%d_hyst", &trip))
+	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
 		return -EINVAL;
 
 	if (kstrtoint(buf, 10, &temperature))
@@ -924,7 +924,7 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 	if (!tz->ops->get_trip_hyst)
 		return -EPERM;
 
-	if (!sscanf(attr->attr.name, "trip_point_%d_hyst", &trip))
+	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
 		return -EINVAL;
 
 	ret = tz->ops->get_trip_hyst(tz, trip, &temperature);
@@ -939,7 +939,7 @@ passive_store(struct device *dev, struct device_attribute *attr,
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	int state;
 
-	if (!sscanf(buf, "%d\n", &state))
+	if (sscanf(buf, "%d\n", &state) != 1)
 		return -EINVAL;
 
 	/* sanity check: values below 1000 millicelcius don't make sense
@@ -1385,7 +1385,7 @@ thermal_cooling_device_cur_state_store(struct device *dev,
 	unsigned long state;
 	int result;
 
-	if (!sscanf(buf, "%ld\n", &state))
+	if (sscanf(buf, "%ld\n", &state) != 1)
 		return -EINVAL;
 
 	if ((long)state < 0)
-- 
2.1.4
