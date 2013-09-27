From: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv4 08/18] hwmon: tmp102: expose to thermal fw via DT nodes
Date: Thu, 26 Sep 2013 23:13:15 -0400
Message-ID: <1380251605-3804-9-git-send-email-eduardo.valentin@ti.com>
References: <1380251605-3804-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380251605-3804-1-git-send-email-eduardo.valentin-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch adds to tmp102 temperature sensor the possibility
to expose itself as thermal zone device, registered on the
thermal framework.

The thermal zone is built only if a device tree node
describing a thermal zone for this sensor is present
inside the tmp102 DT node. Otherwise, the driver behavior
will be the same.

Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Acked-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Signed-off-by: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
---
 drivers/hwmon/tmp102.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index d7b47ab..6748b45 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -27,6 +27,8 @@
 #include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/jiffies.h>
+#include <linux/thermal.h>
+#include <linux/of.h>
 
 #define	DRIVER_NAME "tmp102"
 
@@ -50,6 +52,7 @@
 
 struct tmp102 {
 	struct device *hwmon_dev;
+	struct thermal_zone_device *tz;
 	struct mutex lock;
 	u16 config_orig;
 	unsigned long last_update;
@@ -93,6 +96,15 @@ static struct tmp102 *tmp102_update_device(struct i2c_client *client)
 	return tmp102;
 }
 
+static int tmp102_read_temp(void *dev, long *temp)
+{
+	struct tmp102 *tmp102 = tmp102_update_device(to_i2c_client(dev));
+
+	*temp = tmp102->temp[0];
+
+	return 0;
+}
+
 static ssize_t tmp102_show_temp(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
@@ -204,6 +216,12 @@ static int tmp102_probe(struct i2c_client *client,
 		goto fail_remove_sysfs;
 	}
 
+	tmp102->tz = thermal_zone_of_sensor_register(&client->dev, 0,
+						     &client->dev,
+						     tmp102_read_temp, NULL);
+	if (IS_ERR(tmp102->tz))
+		tmp102->tz = NULL;
+
 	dev_info(&client->dev, "initialized\n");
 
 	return 0;
@@ -220,6 +238,7 @@ static int tmp102_remove(struct i2c_client *client)
 {
 	struct tmp102 *tmp102 = i2c_get_clientdata(client);
 
+	thermal_zone_of_sensor_unregister(&client->dev, tmp102->tz);
 	hwmon_device_unregister(tmp102->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &tmp102_attr_group);
 
-- 
1.8.2.1.342.gfa7285d

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
