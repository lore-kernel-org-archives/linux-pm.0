From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] thermal: Make sysfs attributes of cooling devices default attributes
Date: Fri, 20 Feb 2015 18:10:08 -0800
Message-ID: <1424484608-20181-1-git-send-email-mka@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:50276 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796AbbBUCK0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Feb 2015 21:10:26 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so10908915igb.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2015 18:10:25 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Matthias Kaehlcke <mka@chromium.org>

Default attributes are created when the device is registered. Attributes
created after device registration can lead to race conditions, where user space
(e.g. udev) sees the device but not the attributes.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/thermal_core.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 48491d1..174d3bc 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -899,6 +899,22 @@ thermal_cooling_device_trip_point_show(struct device *dev,
 		return sprintf(buf, "%d\n", instance->trip);
 }
 
+static struct attribute *cooling_device_attrs[] = {
+	&dev_attr_cdev_type.attr,
+	&dev_attr_max_state.attr,
+	&dev_attr_cur_state.attr,
+	NULL,
+};
+
+static const struct attribute_group cooling_device_attr_group = {
+	.attrs = cooling_device_attrs,
+};
+
+static const struct attribute_group *cooling_device_attr_groups[] = {
+	&cooling_device_attr_group,
+	NULL,
+};
+
 /* Device management */
 
 /**
@@ -1130,6 +1146,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->ops = ops;
 	cdev->updated = false;
 	cdev->device.class = &thermal_class;
+	cdev->device.groups = cooling_device_attr_groups;
 	cdev->devdata = devdata;
 	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
 	result = device_register(&cdev->device);
@@ -1139,21 +1156,6 @@ __thermal_cooling_device_register(struct device_node *np,
 		return ERR_PTR(result);
 	}
 
-	/* sys I/F */
-	if (type) {
-		result = device_create_file(&cdev->device, &dev_attr_cdev_type);
-		if (result)
-			goto unregister;
-	}
-
-	result = device_create_file(&cdev->device, &dev_attr_max_state);
-	if (result)
-		goto unregister;
-
-	result = device_create_file(&cdev->device, &dev_attr_cur_state);
-	if (result)
-		goto unregister;
-
 	/* Add 'this' new cdev to the global cdev list */
 	mutex_lock(&thermal_list_lock);
 	list_add(&cdev->node, &thermal_cdev_list);
@@ -1163,11 +1165,6 @@ __thermal_cooling_device_register(struct device_node *np,
 	bind_cdev(cdev);
 
 	return cdev;
-
-unregister:
-	release_idr(&thermal_cdev_idr, &thermal_idr_lock, cdev->id);
-	device_unregister(&cdev->device);
-	return ERR_PTR(result);
 }
 
 /**
-- 
2.2.0.rc0.207.ga3a616c

