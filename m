From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 17/40] thermal: core: split policy_store
Date: Mon, 30 May 2016 14:27:36 -0700
Message-ID: <1464643679-2733-18-git-send-email-edubezval@gmail.com>
References: <1464643679-2733-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464643679-2733-1-git-send-email-edubezval@gmail.com>
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
index 5f5a87e..078b260 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -700,6 +700,28 @@ void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
 	mutex_unlock(&thermal_list_lock);
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
@@ -941,27 +963,16 @@ static ssize_t
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
index a765c75..db65d3b 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -60,6 +60,7 @@ void thermal_zone_device_rebind_exception(struct thermal_zone_device *,
 					  const char *, size_t);
 void thermal_zone_device_unbind_exception(struct thermal_zone_device *,
 					  const char *, size_t);
+int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
 
 #ifdef CONFIG_THERMAL_GOV_STEP_WISE
 int thermal_gov_step_wise_register(void);
-- 
2.1.4
