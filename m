From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 04/21] thermal: of: Extend current of-thermal.c code to allow
 setting emulated temp
Date: Thu, 09 Oct 2014 18:38:40 +0200
Message-ID: <1412872737-624-5-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:65347 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757508AbaJIQjZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 12:39:25 -0400
In-reply-to: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

Before this change it was only possible to set get_temp() and get_trend()
methods to be used in the common code handling passing parameters via
device tree to "cpu-thermal" CPU thermal zone device.

Now it is possible to also set emulated value of temperature for debug
purposes.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 drivers/thermal/of-thermal.c | 25 ++++++++++++++++++++++---
 include/linux/thermal.h      |  6 ++++--
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index cd74e64..f206375 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -98,10 +98,22 @@ struct __thermal_zone {
 	void *sensor_data;
 	int (*get_temp)(void *, long *);
 	int (*get_trend)(void *, long *);
+	int (*set_emul_temp)(void *, unsigned long);
 };
 
 /***   DT thermal zone device callbacks   ***/
 
+static int of_thermal_set_emul_temp(struct thermal_zone_device *tz,
+				    unsigned long temp)
+{
+	struct __thermal_zone *data = tz->devdata;
+
+	if (!data->set_emul_temp)
+		return -EINVAL;
+
+	return data->set_emul_temp(data->sensor_data, temp);
+}
+
 static int of_thermal_get_temp(struct thermal_zone_device *tz,
 			       unsigned long *temp)
 {
@@ -352,7 +364,8 @@ static struct thermal_zone_device *
 thermal_zone_of_add_sensor(struct device_node *zone,
 			   struct device_node *sensor, void *data,
 			   int (*get_temp)(void *, long *),
-			   int (*get_trend)(void *, long *))
+			   int (*get_trend)(void *, long *),
+			   int (*set_emul_temp)(void *, unsigned long))
 {
 	struct thermal_zone_device *tzd;
 	struct __thermal_zone *tz;
@@ -366,10 +379,12 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 	mutex_lock(&tzd->lock);
 	tz->get_temp = get_temp;
 	tz->get_trend = get_trend;
+	tz->set_emul_temp = set_emul_temp;
 	tz->sensor_data = data;
 
 	tzd->ops->get_temp = of_thermal_get_temp;
 	tzd->ops->get_trend = of_thermal_get_trend;
+	tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
 	mutex_unlock(&tzd->lock);
 
 	return tzd;
@@ -411,7 +426,8 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 struct thermal_zone_device *
 thermal_zone_of_sensor_register(struct device *dev, int sensor_id,
 				void *data, int (*get_temp)(void *, long *),
-				int (*get_trend)(void *, long *))
+				int (*get_trend)(void *, long *),
+				int (*set_emul_temp)(void *, unsigned long))
 {
 	struct device_node *np, *child, *sensor_np;
 
@@ -453,7 +469,8 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id,
 			return thermal_zone_of_add_sensor(child, sensor_np,
 							  data,
 							  get_temp,
-							  get_trend);
+							  get_trend,
+							  set_emul_temp);
 		}
 	}
 	of_node_put(np);
@@ -494,9 +511,11 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
 	mutex_lock(&tzd->lock);
 	tzd->ops->get_temp = NULL;
 	tzd->ops->get_trend = NULL;
+	tzd->ops->set_emul_temp = NULL;
 
 	tz->get_temp = NULL;
 	tz->get_trend = NULL;
+	tz->set_emul_temp = NULL;
 	tz->sensor_data = NULL;
 	mutex_unlock(&tzd->lock);
 }
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 0305cde..36010e9 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -290,14 +290,16 @@ struct thermal_genl_event {
 struct thermal_zone_device *
 thermal_zone_of_sensor_register(struct device *dev, int id,
 				void *data, int (*get_temp)(void *, long *),
-				int (*get_trend)(void *, long *));
+				int (*get_trend)(void *, long *),
+				int (*set_emul_temp)(void *, unsigned long));
 void thermal_zone_of_sensor_unregister(struct device *dev,
 				       struct thermal_zone_device *tz);
 #else
 static inline struct thermal_zone_device *
 thermal_zone_of_sensor_register(struct device *dev, int id,
 				void *data, int (*get_temp)(void *, long *),
-				int (*get_trend)(void *, long *))
+				int (*get_trend)(void *, long *),
+				int (*set_emul_temp)(void *, unsigned long))
 {
 	return NULL;
 }
-- 
2.0.0.rc2

