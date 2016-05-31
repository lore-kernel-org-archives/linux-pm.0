From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 04/15] thermal: sysfs: lock tz while on trip_point_temp properties
Date: Mon, 30 May 2016 23:31:25 -0700
Message-ID: <1464676296-5610-5-git-send-email-edubezval@gmail.com>
References: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Serialized calls to tz.ops in user facing
sysfs handler trip_point_temp_show() and trip_point_temp_store().

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index b69036e..32f410f 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -151,7 +151,9 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
 	ret = tz->ops->set_trip_temp(tz, trip, temperature);
+	mutex_unlock(&tz->lock);
 	if (ret)
 		return ret;
 
@@ -174,7 +176,9 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
 	ret = tz->ops->get_trip_temp(tz, trip, &temperature);
+	mutex_unlock(&tz->lock);
 
 	if (ret)
 		return ret;
-- 
2.1.4
