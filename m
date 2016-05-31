From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 14/15] thermal: sysfs: serialize access to instances
Date: Mon, 30 May 2016 23:31:35 -0700
Message-ID: <1464676296-5610-15-git-send-email-edubezval@gmail.com>
References: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35338 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162180AbcEaGcb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 02:32:31 -0400
In-Reply-To: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Because instances are the result of a matching
between cdev and tz, we need to lock both
in order to access the instance reliably.

This patch locks both tz and cdev in user
facing sysfs handlers when accessing thermal
zone instance.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index ab78e08..31314be 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -781,14 +781,20 @@ thermal_cooling_device_trip_point_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
 	struct thermal_instance *instance;
+	int trip;
 
 	instance =
 	    container_of(attr, struct thermal_instance, attr);
 
+	mutex_lock(&instance->tz->lock);
+	mutex_lock(&instance->cdev->lock);
+	trip = instance->trip;
+	mutex_unlock(&instance->cdev->lock);
+	mutex_unlock(&instance->tz->lock);
 	if (instance->trip == THERMAL_TRIPS_NONE)
 		return sprintf(buf, "-1\n");
 	else
-		return sprintf(buf, "%d\n", instance->trip);
+		return sprintf(buf, "%d\n", trip);
 }
 
 ssize_t
@@ -796,10 +802,16 @@ thermal_cooling_device_weight_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct thermal_instance *instance;
+	int weight;
 
 	instance = container_of(attr, struct thermal_instance, weight_attr);
+	mutex_lock(&instance->tz->lock);
+	mutex_lock(&instance->cdev->lock);
+	weight = instance->weight;
+	mutex_unlock(&instance->cdev->lock);
+	mutex_unlock(&instance->tz->lock);
 
-	return sprintf(buf, "%d\n", instance->weight);
+	return sprintf(buf, "%d\n", weight);
 }
 
 ssize_t
@@ -815,7 +827,11 @@ thermal_cooling_device_weight_store(struct device *dev,
 		return ret;
 
 	instance = container_of(attr, struct thermal_instance, weight_attr);
+	mutex_lock(&instance->tz->lock);
+	mutex_lock(&instance->cdev->lock);
 	instance->weight = weight;
+	mutex_unlock(&instance->cdev->lock);
+	mutex_unlock(&instance->tz->lock);
 
 	return count;
 }
-- 
2.1.4

