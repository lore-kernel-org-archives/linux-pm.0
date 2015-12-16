From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 2/3] thermal: rework core to allow emul_temp to be treated as regular temp
Date: Tue, 15 Dec 2015 19:49:13 -0800
Message-ID: <1450237754-31906-3-git-send-email-edubezval@gmail.com>
References: <1450237754-31906-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450237754-31906-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Change the way we handle emul_temp. This is to allow
emul_temp to be used as input to exercise thermal core
properly. Now, even if .get_temp is not available,
the emul_temp can be used to emulate temperature.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 8fa82c0..f826589 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -472,18 +472,25 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	int ret = -EINVAL;
-	int count;
-	int crit_temp = INT_MAX;
-	enum thermal_trip_type type;
+	int crit_temp = INT_MAX, real_temp = crit_temp - 1;
 
-	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
-		goto exit;
+	if (!tz || IS_ERR(tz))
+		return ret;
 
 	mutex_lock(&tz->lock);
 
-	ret = tz->ops->get_temp(tz, temp);
+	/* Allow emulation if .get_temp is still not available */
+	if (tz->ops->get_temp) {
+		ret = tz->ops->get_temp(tz, temp);
+		if (!ret)
+			real_temp = *temp;
+	}
 
 	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
+		enum thermal_trip_type type;
+		int count;
+
+		ret = 0;
 		for (count = 0; count < tz->trips; count++) {
 			ret = tz->ops->get_trip_type(tz, count, &type);
 			if (!ret && type == THERMAL_TRIP_CRITICAL) {
@@ -498,17 +505,17 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 		 * is below the critical temperature so that the emulation code
 		 * cannot hide critical conditions.
 		 */
-		if (!ret && *temp < crit_temp)
+		if (!ret && real_temp < crit_temp)
 			*temp = tz->emul_temperature;
 	}
  
 	mutex_unlock(&tz->lock);
-exit:
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
 
-static void update_temperature(struct thermal_zone_device *tz)
+static int update_temperature(struct thermal_zone_device *tz)
 {
 	int temp, ret;
 
@@ -518,7 +525,7 @@ static void update_temperature(struct thermal_zone_device *tz)
 			dev_warn(&tz->device,
 				 "failed to read out thermal zone (%d)\n",
 				 ret);
-		return;
+		return ret;
 	}
 
 	mutex_lock(&tz->lock);
@@ -529,17 +536,17 @@ static void update_temperature(struct thermal_zone_device *tz)
 	trace_thermal_temperature(tz);
 	dev_dbg(&tz->device, "last_temperature=%d, current_temperature=%d\n",
 				tz->last_temperature, tz->temperature);
+
+	return 0;
 }
 
 void thermal_zone_device_update(struct thermal_zone_device *tz)
 {
 	int count;
 
-	if (!tz->ops->get_temp)
+	if (update_temperature(tz))
 		return;
 
-	update_temperature(tz);
-
 	for (count = 0; count < tz->trips; count++)
 		handle_thermal_trip(tz, count);
 
-- 
2.5.0
