From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 13/16] thermal: of: implement .set_trips for device tree thermal zones
Date: Wed, 20 May 2015 15:20:43 +0200
Message-ID: <1432128046-12921-14-git-send-email-s.hauer@pengutronix.de>
References: <1432128046-12921-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432128046-12921-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/thermal/of-thermal.c | 12 ++++++++++++
 include/linux/thermal.h      |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index bd3185e..f8dd847 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -97,6 +97,17 @@ static int of_thermal_get_temp(struct thermal_zone_device *tz,
 	return data->ops->get_temp(data->sensor_data, temp);
 }
 
+static int of_thermal_set_trips(struct thermal_zone_device *tz,
+			       int low, int high)
+{
+	struct __thermal_zone *data = tz->devdata;
+
+	if (!data->ops || !data->ops->set_trips)
+		return -ENOSYS;
+
+	return data->ops->set_trips(data->sensor_data, low, high);
+}
+
 /**
  * of_thermal_get_ntrips - function to export number of available trip
  *			   points.
@@ -367,6 +378,7 @@ static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 
 static const struct thermal_zone_device_ops of_thermal_ops = {
 	.get_temp = of_thermal_get_temp,
+	.set_trips = of_thermal_set_trips,
 	.get_trend = of_thermal_get_trend,
 	.set_emul_temp = of_thermal_set_emul_temp,
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index aef6e13..3ae8996 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -267,12 +267,16 @@ struct thermal_genl_event {
  *
  * Optional:
  * @get_trend: a pointer to a function that reads the sensor temperature trend.
+ * @set_trips: a pointer to a function that sets a temperature window. When this
+ *             window is left the driver must inform the thermal core via
+ *             thermal_zone_device_update.
  * @set_emul_temp: a pointer to a function that sets sensor emulated
  *		   temperature.
  */
 struct thermal_zone_of_device_ops {
 	int (*get_temp)(void *, int *);
 	int (*get_trend)(void *, int, enum thermal_trend *);
+	int (*set_trips)(void *, int, int);
 	int (*set_emul_temp)(void *, int);
 };
 
-- 
2.1.4
