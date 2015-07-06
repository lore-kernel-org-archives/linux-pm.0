From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/4] thermal: Use IS_ENABLED instead of #ifdef
Date: Mon,  6 Jul 2015 09:46:16 +0200
Message-ID: <1436168777-10463-4-git-send-email-s.hauer@pengutronix.de>
References: <1436168777-10463-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436168777-10463-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

Use IS_ENABLED(CONFIG_THERMAL_EMULATION) to make the code more readable
and to get rid of the addtional #ifdef around the variable definitions
in thermal_zone_get_temp().

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/thermal/thermal_core.c | 45 ++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index aa0a661..67296da 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -477,11 +477,9 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long *temp)
 {
 	int ret = -EINVAL;
-#ifdef CONFIG_THERMAL_EMULATION
 	int count;
 	unsigned long crit_temp = -1UL;
 	enum thermal_trip_type type;
-#endif
 
 	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
 		goto exit;
@@ -489,25 +487,21 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long *temp)
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
 
-	if (ret)
-		goto skip_emul;
+	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
+		for (count = 0; count < tz->trips; count++) {
+			ret = tz->ops->get_trip_type(tz, count, &type);
+			if (!ret && type == THERMAL_TRIP_CRITICAL) {
+				ret = tz->ops->get_trip_temp(tz, count,
+						&crit_temp);
+				break;
+			}
+		}
 
-	if (*temp < crit_temp)
-		*temp = tz->emul_temperature;
-skip_emul:
-#endif
+		if (!ret && *temp < crit_temp)
+			*temp = tz->emul_temperature;
+	}
+ 
 	mutex_unlock(&tz->lock);
 exit:
 	return ret;
@@ -847,7 +841,6 @@ policy_show(struct device *dev, struct device_attribute *devattr, char *buf)
 	return sprintf(buf, "%s\n", tz->governor->name);
 }
 
-#ifdef CONFIG_THERMAL_EMULATION
 static ssize_t
 emul_temp_store(struct device *dev, struct device_attribute *attr,
 		     const char *buf, size_t count)
@@ -873,7 +866,6 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
 	return ret ? ret : count;
 }
 static DEVICE_ATTR(emul_temp, S_IWUSR, NULL, emul_temp_store);
-#endif/*CONFIG_THERMAL_EMULATION*/
 
 static ssize_t
 sustainable_power_show(struct device *dev, struct device_attribute *devattr,
@@ -1802,11 +1794,12 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 			goto unregister;
 	}
 
-#ifdef CONFIG_THERMAL_EMULATION
-	result = device_create_file(&tz->device, &dev_attr_emul_temp);
-	if (result)
-		goto unregister;
-#endif
+	if (IS_ENABLED(CONFIG_THERMAL_EMULATION)) {
+		result = device_create_file(&tz->device, &dev_attr_emul_temp);
+		if (result)
+			goto unregister;
+	}
+
 	/* Create policy attribute */
 	result = device_create_file(&tz->device, &dev_attr_policy);
 	if (result)
-- 
2.1.4
