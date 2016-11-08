From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 06/49] thermal: core: move mode attribute to tz->device.groups
Date: Mon,  7 Nov 2016 21:08:44 -0800
Message-ID: <1478581767-7009-7-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33006 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752881AbcKHFWt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 00:22:49 -0500
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Moving mode attribute to tz->device.groups requires the implementation
of a .is_visible() callback. The condition returned by .is_visible() of
the mode attribute group is kept the same, we allow the attribute to be
visible only if ops->get_mode() is set by the thermal driver.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index ec15a60..ec8551a 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1064,6 +1064,7 @@ static DEVICE_ATTR(sustainable_power, S_IWUSR | S_IRUGO, sustainable_power_show,
 static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
 static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive_store);
 
+/* These attributes are unconditionally added to a thermal zone */
 static struct attribute *thermal_zone_dev_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_temp.attr,
@@ -1087,8 +1088,35 @@ static struct attribute_group thermal_zone_attribute_group = {
 	.attrs = thermal_zone_dev_attrs,
 };
 
+/* We expose mode only if .get_mode is present */
+static struct attribute *thermal_zone_mode_attrs[] = {
+	&dev_attr_mode.attr,
+	NULL,
+};
+
+static umode_t thermal_zone_mode_is_visible(struct kobject *kobj,
+					    struct attribute *attr,
+					    int attrno)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct thermal_zone_device *tz;
+
+	tz = container_of(dev, struct thermal_zone_device, device);
+
+	if (tz->ops->get_mode)
+		return attr->mode;
+
+	return 0;
+}
+
+static struct attribute_group thermal_zone_mode_attribute_group = {
+	.attrs = thermal_zone_mode_attrs,
+	.is_visible = thermal_zone_mode_is_visible,
+};
+
 static const struct attribute_group *thermal_zone_attribute_groups[] = {
 	&thermal_zone_attribute_group,
+	&thermal_zone_mode_attribute_group,
 	NULL
 };
 
@@ -1932,12 +1960,6 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	}
 
 	/* sys I/F */
-	if (ops->get_mode) {
-		result = device_create_file(&tz->device, &dev_attr_mode);
-		if (result)
-			goto unregister;
-	}
-
 	result = create_trip_attrs(tz, mask);
 	if (result)
 		goto unregister;
@@ -2054,8 +2076,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	thermal_zone_device_set_polling(tz, 0);
 
-	if (tz->ops->get_mode)
-		device_remove_file(&tz->device, &dev_attr_mode);
 	remove_trip_attrs(tz);
 	thermal_set_governor(tz, NULL);
 
-- 
2.1.4

