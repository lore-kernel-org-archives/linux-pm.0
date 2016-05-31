From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 06/15] thermal: sysfs: lock tz while on passive properties
Date: Mon, 30 May 2016 23:31:27 -0700
Message-ID: <1464676296-5610-7-git-send-email-edubezval@gmail.com>
References: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33213 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525AbcEaGcP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 02:32:15 -0400
In-Reply-To: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Serialized calls to tz.ops in user facing
sysfs handler passive_store() and
passive_show().

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index afb42a2..dcaeb17 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -252,18 +252,24 @@ passive_store(struct device *dev, struct device_attribute *attr,
 	if (state && state < 1000)
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
 	if (state && !tz->forced_passive) {
 		if (!tz->passive_delay)
 			tz->passive_delay = 1000;
+		mutex_unlock(&tz->lock);
 		thermal_zone_device_rebind_exception(tz, "Processor",
 						     sizeof("Processor"));
+		mutex_lock(&tz->lock);
 	} else if (!state && tz->forced_passive) {
 		tz->passive_delay = 0;
+		mutex_unlock(&tz->lock);
 		thermal_zone_device_unbind_exception(tz, "Processor",
 						     sizeof("Processor"));
+		mutex_lock(&tz->lock);
 	}
 
 	tz->forced_passive = state;
+	mutex_unlock(&tz->lock);
 
 	thermal_zone_device_update(tz);
 
@@ -275,8 +281,13 @@ passive_show(struct device *dev, struct device_attribute *attr,
 	     char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	unsigned int passive;
 
-	return sprintf(buf, "%d\n", tz->forced_passive);
+	mutex_lock(&tz->lock);
+	passive = tz->forced_passive;
+	mutex_unlock(&tz->lock);
+
+	return sprintf(buf, "%u\n", passive);
 }
 
 static ssize_t
@@ -494,7 +505,9 @@ static umode_t thermal_zone_passive_is_visible(struct kobject *kobj,
 	tz = container_of(dev, struct thermal_zone_device, device);
 
 	for (count = 0; count < tz->trips; count++) {
+		mutex_lock(&tz->lock);
 		tz->ops->get_trip_type(tz, count, &trip_type);
+		mutex_unlock(&tz->lock);
 
 		if (trip_type == THERMAL_TRIP_PASSIVE)
 			return attr->mode;
-- 
2.1.4

