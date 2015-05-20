From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 04/16] thermal: Use IS_ENABLED instead of #ifdef
Date: Wed, 20 May 2015 15:20:34 +0200
Message-ID: <1432128046-12921-5-git-send-email-s.hauer@pengutronix.de>
References: <1432128046-12921-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35022 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137AbbETNV1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2015 09:21:27 -0400
In-Reply-To: <1432128046-12921-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

Use IS_ENABLED(CONFIG_THERMAL_EMULATION) to make the code more readable
and to get rid of the addtional #ifdef around the variable definitions
in thermal_zone_get_temp().

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/thermal/thermal_core.c | 45 ++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 1b68d20..3e0fe55 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -414,11 +414,9 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	int ret = -EINVAL;
-#ifdef CONFIG_THERMAL_EMULATION
 	int count;
 	int crit_temp = INT_MAX;
 	enum thermal_trip_type type;
-#endif
 
 	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
 		goto exit;
@@ -426,25 +424,21 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
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
@@ -780,7 +774,6 @@ policy_show(struct device *dev, struct device_attribute *devattr, char *buf)
 	return sprintf(buf, "%s\n", tz->governor->name);
 }
 
-#ifdef CONFIG_THERMAL_EMULATION
 static ssize_t
 emul_temp_store(struct device *dev, struct device_attribute *attr,
 		     const char *buf, size_t count)
@@ -806,7 +799,6 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
 	return ret ? ret : count;
 }
 static DEVICE_ATTR(emul_temp, S_IWUSR, NULL, emul_temp_store);
-#endif/*CONFIG_THERMAL_EMULATION*/
 
 static DEVICE_ATTR(type, 0444, type_show, NULL);
 static DEVICE_ATTR(temp, 0444, temp_show, NULL);
@@ -1536,11 +1528,12 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
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

