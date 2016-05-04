From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 15/31] thermal: core: split available_policies_show()
Date: Tue,  3 May 2016 23:02:29 -0700
Message-ID: <1462341765-13268-16-git-send-email-edubezval@gmail.com>
References: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
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
index b4772e7..93da7d9 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -721,6 +721,25 @@ exit:
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
@@ -974,21 +993,7 @@ static ssize_t
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
index 5bb5101..b80847c 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -58,6 +58,7 @@ int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
 void thermal_zone_device_passive_update(struct thermal_zone_device *, int);
 int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
+int thermal_build_list_of_policies(char *buf);
 
 #ifdef CONFIG_THERMAL_GOV_STEP_WISE
 int thermal_gov_step_wise_register(void);
-- 
2.1.4
