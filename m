From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 27/49] thermal: core: group functions related to governor handling
Date: Mon,  7 Nov 2016 21:09:05 -0800
Message-ID: <1478581767-7009-28-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33489 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbcKHF1W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 00:27:22 -0500
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Organize thermal core code to group the functions
handling with governor manipulation in one single section.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 153 +++++++++++++++++++++--------------------
 1 file changed, 80 insertions(+), 73 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 519aa94..e36a6a6 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -64,6 +64,13 @@ static atomic_t in_suspend;
 
 static struct thermal_governor *def_governor;
 
+/*
+ * Governor section: set of functions to handle thermal governors
+ *
+ * Functions to help in the life cycle of thermal governors within
+ * the thermal core and by the thermal governor code.
+ */
+
 static struct thermal_governor *__find_governor(const char *name)
 {
 	struct thermal_governor *pos;
@@ -206,6 +213,79 @@ void thermal_unregister_governor(struct thermal_governor *governor)
 	return;
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
+static int __init thermal_register_governors(void)
+{
+	int result;
+
+	result = thermal_gov_step_wise_register();
+	if (result)
+		return result;
+
+	result = thermal_gov_fair_share_register();
+	if (result)
+		return result;
+
+	result = thermal_gov_bang_bang_register();
+	if (result)
+		return result;
+
+	result = thermal_gov_user_space_register();
+	if (result)
+		return result;
+
+	return thermal_gov_power_allocator_register();
+}
+
+static void thermal_unregister_governors(void)
+{
+	thermal_gov_step_wise_unregister();
+	thermal_gov_fair_share_unregister();
+	thermal_gov_bang_bang_unregister();
+	thermal_gov_user_space_unregister();
+	thermal_gov_power_allocator_unregister();
+}
+
 static int get_idr(struct idr *idr, struct mutex *lock, int *id)
 {
 	int ret;
@@ -617,47 +697,6 @@ void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
 	mutex_unlock(&thermal_list_lock);
 }
 
-int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
-				   char *policy)
-{
-	struct thermal_governor *gov;
-	int ret = -EINVAL;
-
-	mutex_lock(&thermal_governor_lock);
-	mutex_lock(&tz->lock);
-
-	gov = __find_governor(strim(policy));
-	if (!gov)
-		goto exit;
-
-	ret = thermal_set_governor(tz, gov);
-
-exit:
-	mutex_unlock(&tz->lock);
-	mutex_unlock(&thermal_governor_lock);
-
-	return ret;
-}
-
-int thermal_build_list_of_policies(char *buf)
-{
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
-}
-
 /* Device management */
 
 /**
@@ -1424,38 +1463,6 @@ static inline int genetlink_init(void) { return 0; }
 static inline void genetlink_exit(void) {}
 #endif /* !CONFIG_NET */
 
-static int __init thermal_register_governors(void)
-{
-	int result;
-
-	result = thermal_gov_step_wise_register();
-	if (result)
-		return result;
-
-	result = thermal_gov_fair_share_register();
-	if (result)
-		return result;
-
-	result = thermal_gov_bang_bang_register();
-	if (result)
-		return result;
-
-	result = thermal_gov_user_space_register();
-	if (result)
-		return result;
-
-	return thermal_gov_power_allocator_register();
-}
-
-static void thermal_unregister_governors(void)
-{
-	thermal_gov_step_wise_unregister();
-	thermal_gov_fair_share_unregister();
-	thermal_gov_bang_bang_unregister();
-	thermal_gov_user_space_unregister();
-	thermal_gov_power_allocator_unregister();
-}
-
 static int thermal_pm_notify(struct notifier_block *nb,
 				unsigned long mode, void *_unused)
 {
-- 
2.1.4

