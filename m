From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 25/49] thermal: core: remove a couple of style issues on helpers
Date: Mon,  7 Nov 2016 21:09:03 -0800
Message-ID: <1478581767-7009-26-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33095 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753178AbcKHFXD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 00:23:03 -0500
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Reorganizing the code of helper functions to improve
readability and style, as recommended by checkpatch.pl.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index fb19021..3a189fd 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -248,8 +248,9 @@ int get_tz_trend(struct thermal_zone_device *tz, int trip)
 }
 EXPORT_SYMBOL(get_tz_trend);
 
-struct thermal_instance *get_thermal_instance(struct thermal_zone_device *tz,
-			struct thermal_cooling_device *cdev, int trip)
+struct thermal_instance *
+get_thermal_instance(struct thermal_zone_device *tz,
+		     struct thermal_cooling_device *cdev, int trip)
 {
 	struct thermal_instance *pos = NULL;
 	struct thermal_instance *target_instance = NULL;
@@ -513,7 +514,7 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 		if (!ret && *temp < crit_temp)
 			*temp = tz->emul_temperature;
 	}
- 
+
 	mutex_unlock(&tz->lock);
 exit:
 	return ret;
@@ -1192,7 +1193,7 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 	/* Make sure cdev enters the deepest cooling state */
 	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
 		dev_dbg(&cdev->device, "zone%d->target=%lu\n",
-				instance->tz->id, instance->target);
+			instance->tz->id, instance->target);
 		if (instance->target == THERMAL_NO_TARGET)
 			continue;
 		if (instance->target > target)
-- 
2.1.4

