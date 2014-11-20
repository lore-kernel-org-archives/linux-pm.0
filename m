From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v2 4/4] thermal: of: Extend current of-thermal.c code to allow
 setting emulated temp
Date: Thu, 20 Nov 2014 17:21:28 +0100
Message-ID: <1416500488-7232-5-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1416500488-7232-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1416500488-7232-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Mikko Perttunen <mperttunen@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, Caesar Wang <caesar.wang@rock-chips.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Before this change it was only possible to set get_temp() and get_trend()
methods to be used in the common code handling passing parameters via
device tree to "cpu-thermal" CPU thermal zone device.

Now it is possible to also set emulated value of temperature for debug
purposes.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- Rework the emulated temperature setting code to use of_thermal_sensor_ops
structure
---
 drivers/thermal/of-thermal.c | 24 ++++++++++++++++++++++++
 include/linux/thermal.h      |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 33921c5..ad7dc2b 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -174,6 +174,28 @@ of_thermal_get_trip_points(struct thermal_zone_device *tz)
 	return data->gtrips;
 }
 
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
@@ -405,6 +427,7 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 
 	tzd->ops->get_temp = of_thermal_get_temp;
 	tzd->ops->get_trend = of_thermal_get_trend;
+	tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
 	mutex_unlock(&tzd->lock);
 
 	return tzd;
@@ -533,6 +556,7 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
 	mutex_lock(&tzd->lock);
 	tzd->ops->get_temp = NULL;
 	tzd->ops->get_trend = NULL;
+	tzd->ops->set_emul_temp = NULL;
 
 	tz->ops = NULL;
 	tz->sensor_data = NULL;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 88d7249..5eb9d44 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -301,6 +301,7 @@ struct thermal_genl_event {
 struct thermal_zone_of_device_ops {
 	int (*get_temp)(void *, long *);
 	int (*get_trend)(void *, long *);
+	int (*set_emul_temp)(void *, unsigned long);
 };
 
 /**
-- 
2.0.0.rc2
