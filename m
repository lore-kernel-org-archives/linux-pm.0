From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 18/48] thermal: core: split available_policies_show()
Date: Mon, 30 May 2016 23:18:25 -0700
Message-ID: <1464675535-2433-19-git-send-email-edubezval@gmail.com>
References: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

This patch creates a helper to build a list of available governors.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 35 ++++++++++++++++++++---------------
 drivers/thermal/thermal_core.h |  1 +
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5fd852f..da1c4b1 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -722,6 +722,25 @@ exit:
 	return ret;
 }
 
+int thermal_build_list_of_policies(char *buf)
+{
+	struct thermal_governor *pos;
+	ssize_t count = 0;
+	ssize_t size = PAGE_SIZE;
+
+	mutex_lock(&thermal_governor_lock);
+
+	list_for_each_entry(pos, &thermal_governor_list, governor_list) {
+		size = PAGE_SIZE - count;
+		count += scnprintf(buf + count, size, "%s ", pos->name);
+	}
+	count += scnprintf(buf + count, size, "\n");
+
+	mutex_unlock(&thermal_governor_lock);
+
+	return count;
+}
+
 /* sys I/F for thermal zone */
 
 #define to_thermal_zone(_dev) \
@@ -988,21 +1007,7 @@ static ssize_t
 available_policies_show(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
-	struct thermal_governor *pos;
-	ssize_t count = 0;
-	ssize_t size = PAGE_SIZE;
-
-	mutex_lock(&thermal_governor_lock);
-
-	list_for_each_entry(pos, &thermal_governor_list, governor_list) {
-		size = PAGE_SIZE - count;
-		count += scnprintf(buf + count, size, "%s ", pos->name);
-	}
-	count += scnprintf(buf + count, size, "\n");
-
-	mutex_unlock(&thermal_governor_lock);
-
-	return count;
+	return thermal_build_list_of_policies(buf);
 }
 
 static ssize_t
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index db65d3b..8994d2a 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -61,6 +61,7 @@ void thermal_zone_device_rebind_exception(struct thermal_zone_device *,
 void thermal_zone_device_unbind_exception(struct thermal_zone_device *,
 					  const char *, size_t);
 int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
+int thermal_build_list_of_policies(char *buf);
 
 #ifdef CONFIG_THERMAL_GOV_STEP_WISE
 int thermal_gov_step_wise_register(void);
-- 
2.1.4
