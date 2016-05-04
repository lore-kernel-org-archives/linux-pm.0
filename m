From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 14/31] thermal: core: split policy_store
Date: Tue,  3 May 2016 23:02:28 -0700
Message-ID: <1462341765-13268-15-git-send-email-edubezval@gmail.com>
References: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Similarly to passive_store, policy_store now is split
between thermal core data structure handling and sysfs handling.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 37 ++++++++++++++++++++++++-------------
 drivers/thermal/thermal_core.h |  1 +
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6042ea2..b4772e7 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -699,6 +699,28 @@ void thermal_zone_device_passive_update(struct thermal_zone_device *tz,
 	thermal_zone_device_update(tz);
 }
 
+int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
+				   char *policy)
+{
+	struct thermal_governor *gov;
+	int ret = -EINVAL;
+
+	mutex_lock(&thermal_governor_lock);
+	mutex_lock(&tz->lock);
+
+	gov = __find_governor(strim(policy));
+	if (!gov)
+		goto exit;
+
+	ret = thermal_set_governor(tz, gov);
+
+exit:
+	mutex_unlock(&tz->lock);
+	mutex_unlock(&thermal_governor_lock);
+
+	return ret;
+}
+
 /* sys I/F for thermal zone */
 
 #define to_thermal_zone(_dev) \
@@ -927,27 +949,16 @@ static ssize_t
 policy_store(struct device *dev, struct device_attribute *attr,
 		    const char *buf, size_t count)
 {
-	int ret = -EINVAL;
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_governor *gov;
 	char name[THERMAL_NAME_LENGTH];
+	int ret;
 
 	snprintf(name, sizeof(name), "%s", buf);
 
-	mutex_lock(&thermal_governor_lock);
-	mutex_lock(&tz->lock);
-
-	gov = __find_governor(strim(name));
-	if (!gov)
-		goto exit;
-
-	ret = thermal_set_governor(tz, gov);
+	ret = thermal_zone_device_set_policy(tz, name);
 	if (!ret)
 		ret = count;
 
-exit:
-	mutex_unlock(&tz->lock);
-	mutex_unlock(&thermal_governor_lock);
 	return ret;
 }
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index da53693..5bb5101 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -57,6 +57,7 @@ struct thermal_instance {
 int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
 void thermal_zone_device_passive_update(struct thermal_zone_device *, int);
+int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
 
 #ifdef CONFIG_THERMAL_GOV_STEP_WISE
 int thermal_gov_step_wise_register(void);
-- 
2.1.4
