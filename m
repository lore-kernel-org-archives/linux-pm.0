From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 04/13] thermal: Fix not emulating critical temperatures
Date: Thu, 26 Mar 2015 16:53:51 +0100
Message-ID: <1427385240-6086-5-git-send-email-s.hauer@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

commit e6e238c38 (thermal: sysfs: Add a new sysfs node emul_temp for
thermal emulation)  promised not to emulate critical temperatures,
but the check for critical temperatures is broken in multiple ways:

- The code should only accept an emulated temperature when the emulated
  temperature is lower than the critical temperature. Instead the code
  accepts an emulated temperature whenever the real temperature is lower
  than the critical temperature. This makes no sense and trying to
  emulate a temperature higher than the critical temperature halts the
  system.
- When trying to emulate a higher-than-critical temperature we should either
  limit the emulated temperature to the maximum non critical temperature
  or refuse to emulate this temperature. Instead the code just silently
  ignores the emulated temperature and continues with the real temperature.

This patch moves the test for illegal emulated temperature to the sysfs
write function so that we can properly refuse illegal temperatures here.
Trying to write illegal temperatures results in an error message. While
at it use IS_ENABLED() instead of #ifdefs.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/thermal/thermal_core.c | 46 ++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index dcea909..ebca854 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -414,11 +414,6 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long *temp)
 {
 	int ret = -EINVAL;
-#ifdef CONFIG_THERMAL_EMULATION
-	int count;
-	unsigned long crit_temp = -1UL;
-	enum thermal_trip_type type;
-#endif
 
 	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
 		goto exit;
@@ -426,25 +421,10 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long *temp)
 	mutex_lock(&tz->lock);
 
 	ret = tz->ops->get_temp(tz, temp);
-#ifdef CONFIG_THERMAL_EMULATION
-	if (!tz->emul_temperature)
-		goto skip_emul;
-
-	for (count = 0; count < tz->trips; count++) {
-		ret = tz->ops->get_trip_type(tz, count, &type);
-		if (!ret && type == THERMAL_TRIP_CRITICAL) {
-			ret = tz->ops->get_trip_temp(tz, count, &crit_temp);
-			break;
-		}
-	}
-
-	if (ret)
-		goto skip_emul;
 
-	if (*temp < crit_temp)
+	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature)
 		*temp = tz->emul_temperature;
-skip_emul:
-#endif
+
 	mutex_unlock(&tz->lock);
 exit:
 	return ret;
@@ -788,10 +768,32 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	int ret = 0;
 	unsigned long temperature;
+	int trip;
+	unsigned long crit_temp;
+	enum thermal_trip_type type;
 
 	if (kstrtoul(buf, 10, &temperature))
 		return -EINVAL;
 
+	for (trip = 0; trip < tz->trips; trip++) {
+		ret = tz->ops->get_trip_type(tz, trip, &type);
+		if (ret)
+			return ret;
+
+		if (type != THERMAL_TRIP_CRITICAL)
+			continue;
+
+		ret = tz->ops->get_trip_temp(tz, trip, &crit_temp);
+		if (ret)
+			return ret;
+
+		if (temperature >= crit_temp) {
+			dev_err(&tz->device, "Will not emulate critical temperature %luC (tcrit=%luC)\n",
+					temperature / 1000, crit_temp / 1000);
+			return -EINVAL;
+		}
+	}
+
 	if (!tz->ops->set_emul_temp) {
 		mutex_lock(&tz->lock);
 		tz->emul_temperature = temperature;
-- 
2.1.4
