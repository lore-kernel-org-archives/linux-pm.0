From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 16/40] thermal: core: split passive_store
Date: Mon, 30 May 2016 14:27:35 -0700
Message-ID: <1464643679-2733-17-git-send-email-edubezval@gmail.com>
References: <1464643679-2733-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464643679-2733-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Split passive_store between sysfs handling and thermal
core internal data handling.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 62 ++++++++++++++++++++++++++++--------------
 drivers/thermal/thermal_core.h |  4 +++
 2 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 61410c3..5f5a87e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -663,6 +663,43 @@ int power_actor_set_power(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
+void thermal_zone_device_rebind_exception(struct thermal_zone_device *tz,
+					  const char *cdev_type, size_t size)
+{
+	struct thermal_cooling_device *cdev = NULL;
+
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(cdev, &thermal_cdev_list, node) {
+		/* skip non matching cdevs */
+		if (strncmp(cdev_type, cdev->type, size))
+			continue;
+
+		/* re binding the exception matching the type pattern */
+		thermal_zone_bind_cooling_device(tz, THERMAL_TRIPS_NONE, cdev,
+						 THERMAL_NO_LIMIT,
+						 THERMAL_NO_LIMIT,
+						 THERMAL_WEIGHT_DEFAULT);
+	}
+	mutex_unlock(&thermal_list_lock);
+}
+
+void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
+					  const char *cdev_type, size_t size)
+{
+	struct thermal_cooling_device *cdev = NULL;
+
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(cdev, &thermal_cdev_list, node) {
+		/* skip non matching cdevs */
+		if (strncmp(cdev_type, cdev->type, size))
+			continue;
+		/* unbinding the exception matching the type pattern */
+		thermal_zone_unbind_cooling_device(tz, THERMAL_TRIPS_NONE,
+						   cdev);
+	}
+	mutex_unlock(&thermal_list_lock);
+}
+
 /* sys I/F for thermal zone */
 
 #define to_thermal_zone(_dev) \
@@ -862,7 +899,6 @@ passive_store(struct device *dev, struct device_attribute *attr,
 		    const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_cooling_device *cdev = NULL;
 	int state;
 
 	if (!sscanf(buf, "%d\n", &state))
@@ -875,30 +911,14 @@ passive_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	if (state && !tz->forced_passive) {
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
 		if (!tz->passive_delay)
 			tz->passive_delay = 1000;
+		thermal_zone_device_rebind_exception(tz, "Processor",
+						     sizeof("Processor"));
 	} else if (!state && tz->forced_passive) {
-		mutex_lock(&thermal_list_lock);
-		list_for_each_entry(cdev, &thermal_cdev_list, node) {
-			if (!strncmp("Processor", cdev->type,
-				     sizeof("Processor")))
-				thermal_zone_unbind_cooling_device(tz,
-								   THERMAL_TRIPS_NONE,
-								   cdev);
-		}
-		mutex_unlock(&thermal_list_lock);
 		tz->passive_delay = 0;
+		thermal_zone_device_unbind_exception(tz, "Processor",
+						     sizeof("Processor"));
 	}
 
 	tz->forced_passive = state;
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 749d41a..a765c75 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -56,6 +56,10 @@ struct thermal_instance {
 
 int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
+void thermal_zone_device_rebind_exception(struct thermal_zone_device *,
+					  const char *, size_t);
+void thermal_zone_device_unbind_exception(struct thermal_zone_device *,
+					  const char *, size_t);
 
 #ifdef CONFIG_THERMAL_GOV_STEP_WISE
 int thermal_gov_step_wise_register(void);
-- 
2.1.4
