From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 13/31] thermal: core: split passive_store
Date: Tue,  3 May 2016 23:02:27 -0700
Message-ID: <1462341765-13268-14-git-send-email-edubezval@gmail.com>
References: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34984 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757162AbcEDGDM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2016 02:03:12 -0400
In-Reply-To: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Split passive_store between sysfs handling and thermal
core internal data handling.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 69 +++++++++++++++++++++++-------------------
 drivers/thermal/thermal_core.h |  1 +
 2 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5c13fa8..6042ea2 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -662,6 +662,43 @@ int power_actor_set_power(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
+void thermal_zone_device_passive_update(struct thermal_zone_device *tz,
+					int passive)
+{
+	struct thermal_cooling_device *cdev = NULL;
+
+	if (passive && !tz->forced_passive) {
+		mutex_lock(&thermal_list_lock);
+		list_for_each_entry(cdev, &thermal_cdev_list, node) {
+			if (!strncmp("Processor", cdev->type,
+				     sizeof("Processor")))
+				thermal_zone_bind_cooling_device(tz,
+						THERMAL_TRIPS_NONE, cdev,
+						THERMAL_NO_LIMIT,
+						THERMAL_NO_LIMIT,
+						THERMAL_WEIGHT_DEFAULT);
+		}
+		mutex_unlock(&thermal_list_lock);
+		if (!tz->passive_delay)
+			tz->passive_delay = 1000;
+	} else if (!passive && tz->forced_passive) {
+		mutex_lock(&thermal_list_lock);
+		list_for_each_entry(cdev, &thermal_cdev_list, node) {
+			if (!strncmp("Processor", cdev->type,
+				     sizeof("Processor")))
+				thermal_zone_unbind_cooling_device(tz,
+								   THERMAL_TRIPS_NONE,
+								   cdev);
+		}
+		mutex_unlock(&thermal_list_lock);
+		tz->passive_delay = 0;
+	}
+
+	tz->forced_passive = passive;
+
+	thermal_zone_device_update(tz);
+}
+
 /* sys I/F for thermal zone */
 
 #define to_thermal_zone(_dev) \
@@ -861,7 +898,6 @@ passive_store(struct device *dev, struct device_attribute *attr,
 		    const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_cooling_device *cdev = NULL;
 	int state;
 
 	if (!sscanf(buf, "%d\n", &state))
@@ -873,36 +909,7 @@ passive_store(struct device *dev, struct device_attribute *attr,
 	if (state && state < 1000)
 		return -EINVAL;
 
-	if (state && !tz->forced_passive) {
-		mutex_lock(&thermal_list_lock);
-		list_for_each_entry(cdev, &thermal_cdev_list, node) {
-			if (!strncmp("Processor", cdev->type,
-				     sizeof("Processor")))
-				thermal_zone_bind_cooling_device(tz,
-						THERMAL_TRIPS_NONE, cdev,
-						THERMAL_NO_LIMIT,
-						THERMAL_NO_LIMIT,
-						THERMAL_WEIGHT_DEFAULT);
-		}
-		mutex_unlock(&thermal_list_lock);
-		if (!tz->passive_delay)
-			tz->passive_delay = 1000;
-	} else if (!state && tz->forced_passive) {
-		mutex_lock(&thermal_list_lock);
-		list_for_each_entry(cdev, &thermal_cdev_list, node) {
-			if (!strncmp("Processor", cdev->type,
-				     sizeof("Processor")))
-				thermal_zone_unbind_cooling_device(tz,
-								   THERMAL_TRIPS_NONE,
-								   cdev);
-		}
-		mutex_unlock(&thermal_list_lock);
-		tz->passive_delay = 0;
-	}
-
-	tz->forced_passive = state;
-
-	thermal_zone_device_update(tz);
+	thermal_zone_device_passive_update(tz, state);
 
 	return count;
 }
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 749d41a..da53693 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -56,6 +56,7 @@ struct thermal_instance {
 
 int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
+void thermal_zone_device_passive_update(struct thermal_zone_device *, int);
 
 #ifdef CONFIG_THERMAL_GOV_STEP_WISE
 int thermal_gov_step_wise_register(void);
-- 
2.1.4

