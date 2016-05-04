From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 28/31] thermal: core: move notify to the zone update section
Date: Tue,  3 May 2016 23:02:42 -0700
Message-ID: <1462341765-13268-29-git-send-email-edubezval@gmail.com>
References: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

moving the helper function to closer to similar functions.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 609c3be..0317aea 100644
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
@@ -1027,24 +1045,6 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
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
