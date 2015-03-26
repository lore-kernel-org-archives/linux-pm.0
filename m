From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 13/13] thermal: of: implement .set_trips for device tree thermal zones
Date: Thu, 26 Mar 2015 16:54:00 +0100
Message-ID: <1427385240-6086-14-git-send-email-s.hauer@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/thermal/of-thermal.c | 12 ++++++++++++
 include/linux/thermal.h      |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 9b63193..a3de5de 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -97,6 +97,17 @@ static int of_thermal_get_temp(struct thermal_zone_device *tz,
 	return data->ops->get_temp(data->sensor_data, temp);
 }
 
+static int of_thermal_set_trips(struct thermal_zone_device *tz,
+			       unsigned long low, unsigned long high)
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
index b870702..84a5b5d 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -276,6 +276,7 @@ struct thermal_genl_event {
  */
 struct thermal_zone_of_device_ops {
 	int (*get_temp)(void *, unsigned long *);
+	int (*set_trips)(void *, unsigned long, unsigned long);
 	int (*get_trend)(void *, int trend, enum thermal_trend *);
 	int (*set_emul_temp)(void *, unsigned long);
 };
-- 
2.1.4
