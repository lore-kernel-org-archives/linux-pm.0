From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 08/13] thermal: Allow sensor ops to fail with -ENOSYS
Date: Thu, 26 Mar 2015 16:53:55 +0100
Message-ID: <1427385240-6086-9-git-send-email-s.hauer@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

The thermal core uses the existence of the .get_temp, .get_trend and
.set_emul_temp to detect whether this operation exists and should be
used or whether it should be emulated in software. This makes problems
for of-thermal which has to modify the struct thermal_zone_device_ops
during runtime whenever a sensor is registered or unregistered.

Let the core test for -ENOSYS from these callbacks and treat it like
if the callbacks were not present.

This allows of-thermal to always set the sensor related callbacks and
to make struct thermal_zone_device_ops const again.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/thermal/thermal_core.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6d0fdad..acf00b5 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -413,10 +413,13 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
  */
 int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long *temp)
 {
-	int ret = -EINVAL;
+	int ret;
 
-	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
-		goto exit;
+	if (!tz || IS_ERR(tz))
+		return -EINVAL;
+
+	if (!tz->ops->get_temp)
+		return -ENOSYS;
 
 	mutex_lock(&tz->lock);
 
@@ -426,7 +429,7 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long *temp)
 		*temp = tz->emul_temperature;
 
 	mutex_unlock(&tz->lock);
-exit:
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
@@ -437,10 +440,11 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 	unsigned long temp;
 	int ret;
 
-	if (!tz->ops->get_temp)
+	ret = thermal_zone_get_temp(tz, &temp);
+
+	if (ret == -ENOSYS)
 		return;
 
-	ret = thermal_zone_get_temp(tz, &temp);
 	if (ret) {
 		dev_warn(&tz->device, "failed to read out thermal zone %d\n",
 			 tz->id);
@@ -788,12 +792,16 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
 		}
 	}
 
-	if (!tz->ops->set_emul_temp) {
+	if (tz->ops->set_emul_temp)
+		ret = tz->ops->set_emul_temp(tz, temperature);
+	else
+		ret = -ENOSYS;
+
+	if (ret == -ENOSYS) {
 		mutex_lock(&tz->lock);
 		tz->emul_temperature = temperature;
 		mutex_unlock(&tz->lock);
-	} else {
-		ret = tz->ops->set_emul_temp(tz, temperature);
+		ret = 0;
 	}
 
 	if (!ret)
-- 
2.1.4
