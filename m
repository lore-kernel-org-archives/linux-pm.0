From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 05/15] thermal: sysfs: lock tz while on trip_point_hyst properties
Date: Mon, 30 May 2016 23:31:26 -0700
Message-ID: <1464676296-5610-6-git-send-email-edubezval@gmail.com>
References: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Serialized calls to tz.ops in user facing
sysfs handler trip_point_hyst_store() and
trip_point_hyst_show().

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 32f410f..afb42a2 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -208,7 +208,9 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 	 * here. The driver implementing 'set_trip_hyst' has to
 	 * take care of this.
 	 */
+	mutex_lock(&tz->lock);
 	ret = tz->ops->set_trip_hyst(tz, trip, temperature);
+	mutex_unlock(&tz->lock);
 
 	return ret ? ret : count;
 }
@@ -227,7 +229,9 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
 	ret = tz->ops->get_trip_hyst(tz, trip, &temperature);
+	mutex_unlock(&tz->lock);
 
 	return ret ? ret : sprintf(buf, "%d\n", temperature);
 }
-- 
2.1.4
