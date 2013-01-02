From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [RFC PATCH 1/1] thermal: introduce thermal_zone_lookup_temperature helper function
Date: Wed, 2 Jan 2013 17:53:44 +0200
Message-ID: <1357142024-8324-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53970 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752761Ab3ABPyG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 2 Jan 2013 10:54:06 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: durgadoss.r@intel.com
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-pm@lists.linux-foundation.org, Eduardo Valentin <eduardo.valentin@ti.com>

This patch adds a helper function to get temperature of
a thermal zone, based on the zone type name.

It will perform a zone name lookup and return the last
sensor temperature reading. In case the zone is not found
or if the required parameters are invalid, it will return
the corresponding error code.


With this, we could write platform code to fetch several temperature
from several sensors and derive "summary" temperature for a virtual
thermal zone.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/thermal_sys.c |   30 ++++++++++++++++++++++++++++++
 include/linux/thermal.h       |    1 +
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index a24b010..4269571 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -1703,6 +1703,36 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 }
 EXPORT_SYMBOL(thermal_zone_device_unregister);
 
+/**
+ * thermal_lookup_temperature - search for a zone and returns its temperature
+ * @name: thermal zone name to fetch the temperature
+ * @temperature: pointer to store the zone temperature, in case it is found
+ *
+ * When the zone is found, updates @temperature and returns 0. Returns
+ * -EINVAL in case of wrong parameters and -ENODEV in case the zone is not found
+ */
+int thermal_zone_lookup_temperature(const char *name, int *temperature)
+{
+	struct thermal_zone_device *pos = NULL;
+	bool found = false;
+
+	if (!name || !temperature)
+		return -EINVAL;
+
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(pos, &thermal_tz_list, node)
+		if (!strcmp(pos->type, name)) {
+			found = true;
+			break;
+		}
+	if (found)
+		*temperature = pos->last_temperature;
+	mutex_unlock(&thermal_list_lock);
+
+	return found ? 0 : -ENODEV;
+}
+EXPORT_SYMBOL(thermal_zone_lookup_temperature);
+
 #ifdef CONFIG_NET
 static struct genl_family thermal_event_genl_family = {
 	.id = GENL_ID_GENERATE,
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e85ac70..e0cb335c 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -233,6 +233,7 @@ void thermal_zone_device_update(struct thermal_zone_device *);
 struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
 		const struct thermal_cooling_device_ops *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
+int thermal_zone_lookup_temperature(const char *name, int *temperature);
 
 int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
-- 
1.7.7.1.488.ge8e1c

