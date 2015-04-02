From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH] thermal: user_space: add trip point number to uevent data
Date: Wed,  1 Apr 2015 17:55:43 -0700
Message-ID: <1427936143-26508-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>
List-Id: linux-pm@vger.kernel.org

A user-space thermal governor does not currently know which trip point
caused a uevent to trigger. Let's add this information to the payload.

This is just an RFC, because this patch (on its own) is not very useful.
The only current caller of the .throttle callback is in
thermal_zone_device_update(), which loops over *all* trip points. This
seems very counter-intuitive and unhelpful, but maybe I'm just clueless.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/thermal/user_space.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/user_space.c b/drivers/thermal/user_space.c
index 10adcddc8821..9fc03d3271d6 100644
--- a/drivers/thermal/user_space.c
+++ b/drivers/thermal/user_space.c
@@ -22,6 +22,8 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
+#include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
@@ -34,9 +36,18 @@
  */
 static int notify_user_space(struct thermal_zone_device *tz, int trip)
 {
+	char *envp[] = { NULL, NULL };
+
+	envp[0] = kasprintf(GFP_KERNEL, "TRIPNUM=%u", trip);
+	if (!envp[0])
+		return -ENOMEM;
+
 	mutex_lock(&tz->lock);
-	kobject_uevent(&tz->device.kobj, KOBJ_CHANGE);
+	kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, envp);
 	mutex_unlock(&tz->lock);
+
+	kfree(envp[0]);
+
 	return 0;
 }
 
-- 
1.9.1
