From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 05/48] thermal: core: move emul_temp creation to tz->device.groups
Date: Mon, 30 May 2016 23:18:12 -0700
Message-ID: <1464675535-2433-6-git-send-email-edubezval@gmail.com>
References: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

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
index 657cc2a..6c1017e 100644
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
@@ -1894,12 +1897,6 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
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
