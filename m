From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/4] thermal: user_space gov: Add additional information in uevent
Date: Fri, 26 Aug 2016 16:21:17 -0700
Message-ID: <1472253679-15084-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1472253679-15084-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35062 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752118AbcHZXVc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Aug 2016 19:21:32 -0400
In-Reply-To: <1472253679-15084-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Add additional properties:
NAME= Thermal zone type
TEMP= Temperature sample value
TRIP= Violated trip index
EVENT= The notification event (new temperature sample, trip violation
trip changed)

This is the additional information to what kobject_uevent already
provides. So it will not impact existing user spaces.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/user_space.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/user_space.c b/drivers/thermal/user_space.c
index 10adcdd..c908150 100644
--- a/drivers/thermal/user_space.c
+++ b/drivers/thermal/user_space.c
@@ -23,19 +23,30 @@
  */
 
 #include <linux/thermal.h>
-
+#include <linux/slab.h>
 #include "thermal_core.h"
 
 /**
  * notify_user_space - Notifies user space about thermal events
  * @tz - thermal_zone_device
+ * @trip - Trip point index
  *
  * This function notifies the user space through UEvents.
  */
 static int notify_user_space(struct thermal_zone_device *tz, int trip)
 {
+	char *thermal_prop[5];
+	int i;
+
 	mutex_lock(&tz->lock);
-	kobject_uevent(&tz->device.kobj, KOBJ_CHANGE);
+	thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s", tz->type);
+	thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d", tz->temperature);
+	thermal_prop[2] = kasprintf(GFP_KERNEL, "TRIP=%d", trip);
+	thermal_prop[3] = kasprintf(GFP_KERNEL, "EVENT=%d", tz->notify_event);
+	thermal_prop[4] = NULL;
+	kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, thermal_prop);
+	for (i = 0; i < 4; ++i)
+		kfree(thermal_prop[i]);
 	mutex_unlock(&tz->lock);
 	return 0;
 }
-- 
2.7.4

