From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 45/49] thermal: core: remove style warnings and checks
Date: Mon,  7 Nov 2016 21:09:23 -0800
Message-ID: <1478581767-7009-46-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33381 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbcKHF35 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 00:29:57 -0500
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Removing several style issues in thermal code code.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 8365d0b..e3cdba5 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -718,10 +718,10 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
 	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
-	    if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
-		result = -EEXIST;
-		break;
-	}
+		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
+			result = -EEXIST;
+			break;
+		}
 	if (!result) {
 		list_add_tail(&dev->tz_node, &tz->thermal_instances);
 		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
@@ -801,8 +801,8 @@ static void thermal_release(struct device *dev)
 		     sizeof("thermal_zone") - 1)) {
 		tz = to_thermal_zone(dev);
 		kfree(tz);
-	} else if(!strncmp(dev_name(dev), "cooling_device",
-			   sizeof("cooling_device") - 1)) {
+	} else if (!strncmp(dev_name(dev), "cooling_device",
+			    sizeof("cooling_device") - 1)) {
 		cdev = to_cooling_device(dev);
 		kfree(cdev);
 	}
@@ -1036,8 +1036,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
 	mutex_lock(&thermal_list_lock);
 	list_for_each_entry(pos, &thermal_cdev_list, node)
-	    if (pos == cdev)
-		break;
+		if (pos == cdev)
+			break;
 	if (pos != cdev) {
 		/* thermal cooling device not found */
 		mutex_unlock(&thermal_list_lock);
@@ -1241,7 +1241,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	/* Bind cooling devices for this zone */
 	bind_tz(tz);
 
-	INIT_DELAYED_WORK(&(tz->poll_queue), thermal_zone_device_check);
+	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
 
 	thermal_zone_device_reset(tz);
 	/* Update the new thermal zone and mark it as already updated. */
@@ -1275,8 +1275,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	mutex_lock(&thermal_list_lock);
 	list_for_each_entry(pos, &thermal_tz_list, node)
-	    if (pos == tz)
-		break;
+		if (pos == tz)
+			break;
 	if (pos != tz) {
 		/* thermal zone device not found */
 		mutex_unlock(&thermal_list_lock);
-- 
2.1.4

