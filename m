From: Eduardo Valentin <edubezval@gmail.com>
Subject: [RFC PATCH 05/11] thermal: move emul_temp creation to tz->device.groups
Date: Sat, 23 Apr 2016 16:34:24 -0700
Message-ID: <1461454470-27714-6-git-send-email-edubezval@gmail.com>
References: <1461454470-27714-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35952 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbcDWXe5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 Apr 2016 19:34:57 -0400
In-Reply-To: <1461454470-27714-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

emul_temp creation is dependent on a compile time
condition. Moving to tz->device.groups.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 0a7d918..e32f851 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -996,6 +996,7 @@ create_s32_tzp_attr(offset);
  */
 static DEVICE_ATTR(type, 0444, type_show, NULL);
 static DEVICE_ATTR(temp, 0444, temp_show, NULL);
+static DEVICE_ATTR(emul_temp, S_IWUSR, NULL, emul_temp_store);
 static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_store);
 static DEVICE_ATTR(available_policies, S_IRUGO, available_policies_show, NULL);
 static DEVICE_ATTR(sustainable_power, S_IWUSR | S_IRUGO, sustainable_power_show,
@@ -1004,11 +1005,13 @@ static DEVICE_ATTR(sustainable_power, S_IWUSR | S_IRUGO, sustainable_power_show,
 /* These thermal zone device attributes are created based on conditions */
 static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
 static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive_store);
-static DEVICE_ATTR(emul_temp, S_IWUSR, NULL, emul_temp_store);
 
 static struct attribute *thermal_zone_dev_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_temp.attr,
+#if (IS_ENABLED(CONFIG_THERMAL_EMULATION))
+	&dev_attr_emul_temp.attr,
+#endif
 	&dev_attr_policy.attr,
 	&dev_attr_available_policies.attr,
 	&dev_attr_sustainable_power.attr,
@@ -1893,12 +1896,6 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 			goto unregister;
 	}
 
-	if (IS_ENABLED(CONFIG_THERMAL_EMULATION)) {
-		result = device_create_file(&tz->device, &dev_attr_emul_temp);
-		if (result)
-			goto unregister;
-	}
-
 	/* Update 'this' zone's governor information */
 	mutex_lock(&thermal_governor_lock);
 
-- 
2.1.4

