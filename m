From: Jacob von Chorus <jacobvonchorus@cwphoto.ca>
Subject: [PATCH] thermal: core: move tz->device.groups cleanup to thermal_release
Date: Fri, 30 Dec 2016 14:07:52 -0500
Message-ID: <20161230190752.7050-1-jacobvonchorus@cwphoto.ca>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52224 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752063AbcL3TIj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Dec 2016 14:08:39 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Jacob von Chorus <jacobvonchorus@cwphoto.ca>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The device_unregister call in thermal_zone_device_unregister causes the
thermal_zone_device structure to be freed before the call to free the
dynamically allocated attribute groups. This leads to a kernel panic.

Furthermore, the 4 calls to free the trip point attribute structures
occur before the call to unregister the device, leading to a kernel
panic when sysfs attempts to access the attributes to remove them.

This patch moves the kfree calls to clean up the dynamic attributes to
the thermal_class's thermal_zone_device release function.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jacob von Chorus <jacobvonchorus@cwphoto.ca>
---
 drivers/thermal/thermal_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 641faab..6555913 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -799,6 +799,11 @@ static void thermal_release(struct device *dev)
 	if (!strncmp(dev_name(dev), "thermal_zone",
 		     sizeof("thermal_zone") - 1)) {
 		tz = to_thermal_zone(dev);
+		kfree(tz->trip_type_attrs);
+		kfree(tz->trip_temp_attrs);
+		kfree(tz->trip_hyst_attrs);
+		kfree(tz->trips_attribute_group.attrs);
+		kfree(tz->device.groups);
 		kfree(tz);
 	} else if (!strncmp(dev_name(dev), "cooling_device",
 			    sizeof("cooling_device") - 1)) {
@@ -1305,10 +1310,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	thermal_zone_device_set_polling(tz, 0);
 
-	kfree(tz->trip_type_attrs);
-	kfree(tz->trip_temp_attrs);
-	kfree(tz->trip_hyst_attrs);
-	kfree(tz->trips_attribute_group.attrs);
 	thermal_set_governor(tz, NULL);
 
 	thermal_remove_hwmon_sysfs(tz);
@@ -1316,7 +1317,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	idr_destroy(&tz->idr);
 	mutex_destroy(&tz->lock);
 	device_unregister(&tz->device);
-	kfree(tz->device.groups);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
 
-- 
2.9.3

