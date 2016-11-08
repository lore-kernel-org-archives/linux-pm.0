From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 20/49] thermal: core: treat correctly the return value of *scanf calls
Date: Mon,  7 Nov 2016 21:08:58 -0800
Message-ID: <1478581767-7009-21-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34774 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753076AbcKHFKa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 00:10:30 -0500
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

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
index f5b519a..e2c4fc4 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -874,7 +874,7 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
 	if (!tz->ops->get_trip_type)
 		return -EPERM;
 
-	if (!sscanf(attr->attr.name, "trip_point_%d_type", &trip))
+	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip) != 1)
 		return -EINVAL;
 
 	result = tz->ops->get_trip_type(tz, trip, &type);
@@ -906,7 +906,7 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	if (!tz->ops->set_trip_temp)
 		return -EPERM;
 
-	if (!sscanf(attr->attr.name, "trip_point_%d_temp", &trip))
+	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
 		return -EINVAL;
 
 	if (kstrtoint(buf, 10, &temperature))
@@ -932,7 +932,7 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 	if (!tz->ops->get_trip_temp)
 		return -EPERM;
 
-	if (!sscanf(attr->attr.name, "trip_point_%d_temp", &trip))
+	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
 		return -EINVAL;
 
 	ret = tz->ops->get_trip_temp(tz, trip, &temperature);
@@ -954,7 +954,7 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 	if (!tz->ops->set_trip_hyst)
 		return -EPERM;
 
-	if (!sscanf(attr->attr.name, "trip_point_%d_hyst", &trip))
+	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
 		return -EINVAL;
 
 	if (kstrtoint(buf, 10, &temperature))
@@ -984,7 +984,7 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 	if (!tz->ops->get_trip_hyst)
 		return -EPERM;
 
-	if (!sscanf(attr->attr.name, "trip_point_%d_hyst", &trip))
+	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
 		return -EINVAL;
 
 	ret = tz->ops->get_trip_hyst(tz, trip, &temperature);
@@ -999,7 +999,7 @@ passive_store(struct device *dev, struct device_attribute *attr,
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	int state;
 
-	if (!sscanf(buf, "%d\n", &state))
+	if (sscanf(buf, "%d\n", &state) != 1)
 		return -EINVAL;
 
 	/* sanity check: values below 1000 millicelcius don't make sense
@@ -1457,7 +1457,7 @@ thermal_cooling_device_cur_state_store(struct device *dev,
 	unsigned long state;
 	int result;
 
-	if (!sscanf(buf, "%ld\n", &state))
+	if (sscanf(buf, "%ld\n", &state) != 1)
 		return -EINVAL;
 
 	if ((long)state < 0)
-- 
2.1.4

