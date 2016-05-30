From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv3 02/48] thermal: core: group thermal_zone DEVICE_ATTR's declarations
Date: Mon, 30 May 2016 15:15:38 -0700
Message-ID: <1464646584-14322-3-git-send-email-edubezval@gmail.com>
References: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Simply reorganize the code to have all DEVICE_ATTR's
in one point in the file.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6359c05..956e7e1 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -917,7 +917,6 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
 
 	return ret ? ret : count;
 }
-static DEVICE_ATTR(emul_temp, S_IWUSR, NULL, emul_temp_store);
 
 static ssize_t
 sustainable_power_show(struct device *dev, struct device_attribute *devattr,
@@ -948,8 +947,6 @@ sustainable_power_store(struct device *dev, struct device_attribute *devattr,
 
 	return count;
 }
-static DEVICE_ATTR(sustainable_power, S_IWUSR | S_IRUGO, sustainable_power_show,
-		sustainable_power_store);
 
 #define create_s32_tzp_attr(name)					\
 	static ssize_t							\
@@ -992,6 +989,16 @@ create_s32_tzp_attr(slope);
 create_s32_tzp_attr(offset);
 #undef create_s32_tzp_attr
 
+static DEVICE_ATTR(type, 0444, type_show, NULL);
+static DEVICE_ATTR(temp, 0444, temp_show, NULL);
+static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
+static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive_store);
+static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_store);
+static DEVICE_ATTR(available_policies, S_IRUGO, available_policies_show, NULL);
+static DEVICE_ATTR(emul_temp, S_IWUSR, NULL, emul_temp_store);
+static DEVICE_ATTR(sustainable_power, S_IWUSR | S_IRUGO, sustainable_power_show,
+		   sustainable_power_store);
+
 static struct device_attribute *dev_tzp_attrs[] = {
 	&dev_attr_sustainable_power,
 	&dev_attr_k_po,
@@ -1099,13 +1106,6 @@ int power_actor_set_power(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
-static DEVICE_ATTR(type, 0444, type_show, NULL);
-static DEVICE_ATTR(temp, 0444, temp_show, NULL);
-static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
-static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive_store);
-static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_store);
-static DEVICE_ATTR(available_policies, S_IRUGO, available_policies_show, NULL);
-
 /* sys I/F for cooling device */
 #define to_cooling_device(_dev)	\
 	container_of(_dev, struct thermal_cooling_device, device)
-- 
2.1.4
