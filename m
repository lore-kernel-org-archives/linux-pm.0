From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 03/15] thermal: sysfs: lock tz while on trip_point_type properties
Date: Mon, 30 May 2016 23:31:24 -0700
Message-ID: <1464676296-5610-4-git-send-email-edubezval@gmail.com>
References: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Serialized calls to tz.ops in user facing
sysfs handler trip_point_type_show() and trip_point_temp_store().

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 1db2406..b69036e 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -114,7 +114,9 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip) != 1)
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
 	result = tz->ops->get_trip_type(tz, trip, &type);
+	mutex_unlock(&tz->lock);
 	if (result)
 		return result;
 
-- 
2.1.4
