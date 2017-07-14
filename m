From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH 1/2] thermal: add a sysfs entry for thermal zone description
Date: Fri, 14 Jul 2017 11:48:54 -0600
Message-ID: <1500054535-975-2-git-send-email-pprakash@codeaurora.org>
References: <1500054535-975-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38052 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbdGNR7C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2017 13:59:02 -0400
In-Reply-To: <1500054535-975-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, Prashanth Prakash <pprakash@codeaurora.org>

Add a method to thermal_zone_device_ops to read the description of a
thermal zone. Use the same method to expose the description to the
userspace via a sysfs entry.

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 Documentation/thermal/sysfs-api.txt |  6 ++++++
 drivers/thermal/thermal_sysfs.c     | 19 +++++++++++++++++++
 include/linux/thermal.h             |  4 ++++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index bb9a0a5..b6aa417 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -62,6 +62,7 @@ temperature) and throttle appropriate devices.
 			will be fired.
 	.set_emul_temp: set the emulation temperature which helps in debugging
 			different threshold temperature points.
+	.get_desc: get a user friendly description for a thermal zone (optional)
     tzp: thermal zone platform parameters.
     passive_delay: number of milliseconds to wait between polls when
 	performing passive cooling.
@@ -280,6 +281,7 @@ Thermal zone device sys I/F, created once it's registered:
     |---integral_cutoff:        Offset above which errors are accumulated
     |---slope:                  Slope constant applied as linear extrapolation
     |---offset:                 Offset constant applied as linear extrapolation
+    |---desc			User friendly description/name
 
 Thermal cooling device sys I/F, created once it's registered:
 /sys/class/thermal/cooling_device[0-*]:
@@ -329,6 +331,10 @@ temp
 	Unit: millidegree Celsius
 	RO, Required
 
+desc
+	Provides a user friendly description/name for thermal zone
+        RO, Optional
+
 mode
 	One of the predefined values in [enabled, disabled].
 	This file gives information about the algorithm that is currently
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index a694de9..46d961d 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -34,6 +34,23 @@
 }
 
 static ssize_t
+desc_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	int ret;
+	char desc_str[THERMAL_MAX_DESC_STR_LEN];
+
+	if (!tz->ops->get_desc)
+		return scnprintf(buf, PAGE_SIZE, "<not supported>\n");
+
+	ret = tz->ops->get_desc(tz, desc_str, THERMAL_MAX_DESC_STR_LEN);
+	if (ret)
+		return ret;
+
+	return scnprintf(buf, THERMAL_MAX_DESC_STR_LEN, "%s\n", desc_str);
+}
+
+static ssize_t
 temp_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
@@ -397,6 +414,7 @@
  * present on the sysfs interface.
  */
 static DEVICE_ATTR(type, 0444, type_show, NULL);
+static DEVICE_ATTR(desc, 0444, desc_show, NULL);
 static DEVICE_ATTR(temp, 0444, temp_show, NULL);
 static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_store);
 static DEVICE_ATTR(available_policies, S_IRUGO, available_policies_show, NULL);
@@ -411,6 +429,7 @@ static DEVICE_ATTR(sustainable_power, S_IWUSR | S_IRUGO, sustainable_power_show,
 static struct attribute *thermal_zone_dev_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_temp.attr,
+	&dev_attr_desc.attr,
 #if (IS_ENABLED(CONFIG_THERMAL_EMULATION))
 	&dev_attr_emul_temp.attr,
 #endif
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index dab11f9..bd8377a 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -47,6 +47,9 @@
 /* use value, which < 0K, to indicate an invalid/uninitialized temperature */
 #define THERMAL_TEMP_INVALID	-274000
 
+/* Maximum length of thermal zone description string */
+#define THERMAL_MAX_DESC_STR_LEN 32
+
 /* Unit conversion macros */
 #define DECI_KELVIN_TO_CELSIUS(t)	({			\
 	long _t = (t);						\
@@ -127,6 +130,7 @@ struct thermal_zone_device_ops {
 			  enum thermal_trend *);
 	int (*notify) (struct thermal_zone_device *, int,
 		       enum thermal_trip_type);
+	int (*get_desc) (struct thermal_zone_device *, char *, int);
 };
 
 struct thermal_cooling_device_ops {
-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
