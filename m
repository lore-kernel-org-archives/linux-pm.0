From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 36/48] thermal: core: move notify to the zone update section
Date: Mon, 30 May 2016 23:18:43 -0700
Message-ID: <1464675535-2433-37-git-send-email-edubezval@gmail.com>
References: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35697 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbcEaGUa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 02:20:30 -0400
In-Reply-To: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>

moving the helper function to closer to similar functions.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c1908c4..6dbb86f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -419,6 +419,24 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
+/**
+ * thermal_notify_framework - Sensor drivers use this API to notify framework
+ * @tz:		thermal zone device
+ * @trip:	indicates which trip point has been crossed
+ *
+ * This function handles the trip events from sensor drivers. It starts
+ * throttling the cooling devices according to the policy configured.
+ * For CRITICAL and HOT trip points, this notifies the respective drivers,
+ * and does actual throttling for other trip points i.e ACTIVE and PASSIVE.
+ * The throttling policy is based on the configured platform data; if no
+ * platform data is provided, this uses the step_wise throttling policy.
+ */
+void thermal_notify_framework(struct thermal_zone_device *tz, int trip)
+{
+	handle_thermal_trip(tz, trip);
+}
+EXPORT_SYMBOL_GPL(thermal_notify_framework);
+
 static void thermal_zone_device_check(struct work_struct *work)
 {
 	struct thermal_zone_device *tz = container_of(work, struct
@@ -1029,24 +1047,6 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 
-/**
- * thermal_notify_framework - Sensor drivers use this API to notify framework
- * @tz:		thermal zone device
- * @trip:	indicates which trip point has been crossed
- *
- * This function handles the trip events from sensor drivers. It starts
- * throttling the cooling devices according to the policy configured.
- * For CRITICAL and HOT trip points, this notifies the respective drivers,
- * and does actual throttling for other trip points i.e ACTIVE and PASSIVE.
- * The throttling policy is based on the configured platform data; if no
- * platform data is provided, this uses the step_wise throttling policy.
- */
-void thermal_notify_framework(struct thermal_zone_device *tz, int trip)
-{
-	handle_thermal_trip(tz, trip);
-}
-EXPORT_SYMBOL_GPL(thermal_notify_framework);
-
 static void bind_tz(struct thermal_zone_device *tz)
 {
 	int i, ret;
-- 
2.1.4

