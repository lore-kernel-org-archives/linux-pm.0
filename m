From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 18/49] thermal: core: split available_policies_show()
Date: Mon,  7 Nov 2016 21:08:56 -0800
Message-ID: <1478581767-7009-19-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34747 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753322AbcKHFKZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 00:10:25 -0500
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

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
index 23f138f..3d51184 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -779,6 +779,25 @@ int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
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
@@ -1048,21 +1067,7 @@ static ssize_t
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

