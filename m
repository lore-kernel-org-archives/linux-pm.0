From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 11/15] thermal: sysfs: lock cdev while accessing type
Date: Mon, 30 May 2016 23:31:32 -0700
Message-ID: <1464676296-5610-12-git-send-email-edubezval@gmail.com>
References: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33290 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162127AbcEaGc1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 02:32:27 -0400
In-Reply-To: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Serialized data access to cdev->type in user facing
sysfs handler thermal_cooling_device_type_show().

The existing cdev lock is used. Updating comment
on the lock definition.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 7 ++++++-
 include/linux/thermal.h         | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 86a77cd..044090a 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -682,8 +682,13 @@ thermal_cooling_device_type_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
 	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+	char *type;
+
+	mutex_lock(&cdev->lock);
+	type = cdev->type;
+	mutex_unlock(&cdev->lock);
 
-	return sprintf(buf, "%s\n", cdev->type);
+	return sprintf(buf, "%s\n", type);
 }
 
 static ssize_t
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index fa2c2be..7b2c014 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -137,7 +137,7 @@ struct thermal_cooling_device {
 	void *devdata;
 	const struct thermal_cooling_device_ops *ops;
 	bool updated; /* true if the cooling device does not need update */
-	struct mutex lock; /* protect thermal_instances list */
+	struct mutex lock; /* protect thermal_cooling_device */
 	struct list_head thermal_instances;
 	struct list_head node;
 };
-- 
2.1.4

