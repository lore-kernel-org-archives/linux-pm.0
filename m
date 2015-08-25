From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH v1 2/3] thermal: use iio binding calls
Date: Tue, 25 Aug 2015 12:58:31 -0700
Message-ID: <1440532712-5025-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1440532712-5025-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48119 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756249AbbHYT7g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 25 Aug 2015 15:59:36 -0400
In-Reply-To: <1440532712-5025-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jic23@kernel.org, edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Register zone temperature sensor as IIO device during zone registration.
Also IIO device is removed during zone removal.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/thermal_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 4ca211b..c48f62e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1834,10 +1834,15 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 
 	mutex_unlock(&thermal_governor_lock);
 
+	if (thermal_iio_sensor_register(tz))
+		goto unregister;
+
 	if (!tz->tzp || !tz->tzp->no_hwmon) {
 		result = thermal_add_hwmon_sysfs(tz);
-		if (result)
+		if (result) {
+			thermal_iio_sensor_unregister(tz);
 			goto unregister;
+		}
 	}
 
 	mutex_lock(&thermal_list_lock);
@@ -1920,7 +1925,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	device_remove_file(&tz->device, &dev_attr_policy);
 	remove_trip_attrs(tz);
 	thermal_set_governor(tz, NULL);
-
+	thermal_iio_sensor_unregister(tz);
 	thermal_remove_hwmon_sysfs(tz);
 	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
 	idr_destroy(&tz->idr);
-- 
2.4.3

