From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH] Thermal: Fix to use read critical temperature when required
Date: Tue,  8 Jan 2013 16:18:59 -0800
Message-ID: <1357690739-17009-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:42647 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755530Ab3AIATM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jan 2013 19:19:12 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org, durgadoss.r@intel.com

This patch modifies the code to use get_crit_temp instead of
the normal get_trip_temp when critical threshold point is crossed
or queried about.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/thermal/thermal_sys.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index ecdfc7d..0dc6403 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -345,7 +345,10 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 {
 	long trip_temp;
 
-	tz->ops->get_trip_temp(tz, trip, &trip_temp);
+	if (tz->ops->get_crit_temp)
+		tz->ops->get_crit_temp(tz, &trip_temp);
+	else
+		tz->ops->get_trip_temp(tz, trip, &trip_temp);
 
 	/* If we have not crossed the trip_temp, we do not care. */
 	if (tz->temperature < trip_temp)
@@ -550,6 +553,7 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	int trip, ret;
 	long temperature;
+	enum thermal_trip_type type;
 
 	if (!tz->ops->get_trip_temp)
 		return -EPERM;
@@ -557,7 +561,14 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 	if (!sscanf(attr->attr.name, "trip_point_%d_temp", &trip))
 		return -EINVAL;
 
-	ret = tz->ops->get_trip_temp(tz, trip, &temperature);
+	ret = tz->ops->get_trip_type(tz, trip, &type);
+	if (ret)
+		return ret;
+
+	if (type == THERMAL_TRIP_CRITICAL && tz->ops->get_crit_temp)
+		ret = tz->ops->get_crit_temp(tz, &temperature);
+	else
+		ret = tz->ops->get_trip_temp(tz, trip, &temperature);
 
 	if (ret)
 		return ret;
-- 
1.7.10.4

