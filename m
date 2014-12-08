From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v3 5/5] thermal: of: Extend current of-thermal.c code to allow
 setting emulated temp
Date: Mon, 08 Dec 2014 18:04:21 +0100
Message-ID: <1418058261-25251-6-git-send-email-l.majewski@samsung.com>
References: <1416500488-7232-1-git-send-email-l.majewski@samsung.com>
 <1418058261-25251-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1418058261-25251-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Mikko Perttunen <mperttunen@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, Caesar Wang <caesar.wang@rock-chips.com>, navneet kumar <navneetk@nvidia.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Before this change it was only possible to set get_temp() and get_trend()
methods to be used in the common code handling passing parameters via
device tree to "cpu-thermal" CPU thermal zone device.

Now it is possible to also set emulated value of temperature for debug
purposes.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Acked-by: Eduardo Valentin <edubezval@gmail.com>
---
Changes for v3:
- Update comment for .set_emul_temp method to indicate that it is optional

Changes for v2:
- Rework the emulated temperature setting code to use of_thermal_sensor_ops
structure
---
 drivers/thermal/of-thermal.c | 24 ++++++++++++++++++++++++
 include/linux/thermal.h      |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index e062bf5..e145b66 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -161,6 +161,28 @@ of_thermal_get_trip_points(struct thermal_zone_device *tz)
 }
 EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
 
+/**
+ * of_thermal_set_emul_temp - function to set emulated temperature
+ *
+ * @tz:	pointer to a thermal zone
+ * @temp:	temperature to set
+ *
+ * This function gives the ability to set emulated value of temperature,
+ * which is handy for debugging
+ *
+ * Return: zero on success, error code otherwise
+ */
+static int of_thermal_set_emul_temp(struct thermal_zone_device *tz,
+				    unsigned long temp)
+{
+	struct __thermal_zone *data = tz->devdata;
+
+	if (!data->ops || !data->ops->set_emul_temp)
+		return -EINVAL;
+
+	return data->ops->set_emul_temp(data->sensor_data, temp);
+}
+
 static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
 				enum thermal_trend *trend)
 {
@@ -392,6 +414,7 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 
 	tzd->ops->get_temp = of_thermal_get_temp;
 	tzd->ops->get_trend = of_thermal_get_trend;
+	tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
 	mutex_unlock(&tzd->lock);
 
 	return tzd;
@@ -520,6 +543,7 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
 	mutex_lock(&tzd->lock);
 	tzd->ops->get_temp = NULL;
 	tzd->ops->get_trend = NULL;
+	tzd->ops->set_emul_temp = NULL;
 
 	tz->ops = NULL;
 	tz->sensor_data = NULL;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index b8d91ef..99be7fc 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -297,10 +297,13 @@ struct thermal_genl_event {
  *
  * Optional:
  * @get_trend: a pointer to a function that reads the sensor temperature trend.
+ * @set_emul_temp: a pointer to a function that sets sensor emulated
+ *		   temperature.
  */
 struct thermal_zone_of_device_ops {
 	int (*get_temp)(void *, long *);
 	int (*get_trend)(void *, long *);
+	int (*set_emul_temp)(void *, unsigned long);
 };
 
 /**
-- 
2.0.0.rc2
