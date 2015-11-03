From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] thermal: underflow in trip_point_temp_store()
Date: Wed, 4 Nov 2015 01:14:34 +0300
Message-ID: <20151103221434.GB19280@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is to address a static checker warning about an underflow in
imx_set_trip_temp().  The checker is complaining that we have a user
supplied value for "temp" from kstrtoul() where we treat it as signed,
we cap the upper but we accept negative values.

This looks unintentional since the caller is using unsigned longs to
represent the temperature.  Let's change it to int and reject negatives
in the caller.

Also I changed it to reject negative "trip" values as well.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Someday we will use super cooled CPUs and we will need to rethink this
code.  :)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d9e525c..151a630 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -664,7 +664,7 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	int trip, ret;
-	unsigned long temperature;
+	int temperature;
 
 	if (!tz->ops->set_trip_temp)
 		return -EPERM;
@@ -672,7 +672,9 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	if (!sscanf(attr->attr.name, "trip_point_%d_temp", &trip))
 		return -EINVAL;
 
-	if (kstrtoul(buf, 10, &temperature))
+	if (kstrtoint(buf, 10, &temperature))
+		return -EINVAL;
+	if (trip < 0 || temperature < 0)
 		return -EINVAL;
 
 	ret = tz->ops->set_trip_temp(tz, trip, temperature);
