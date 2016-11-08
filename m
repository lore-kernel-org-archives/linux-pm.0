From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 48/49] thermal: sysfs: use kcalloc() instead of kzalloc()
Date: Mon,  7 Nov 2016 21:09:26 -0800
Message-ID: <1478581767-7009-49-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Simplify size computation by using kcalloc() for
allocating memory for arrays.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 4807015..a694de9 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -511,7 +511,6 @@ static const struct attribute_group *thermal_zone_attribute_groups[] = {
  */
 static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 {
-	int size = sizeof(struct thermal_attr) * tz->trips;
 	struct attribute **attrs;
 	int indx;
 
@@ -519,18 +518,22 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 	if (tz->trips <= 0)
 		return -EINVAL;
 
-	tz->trip_type_attrs = kzalloc(size, GFP_KERNEL);
+	tz->trip_type_attrs = kcalloc(tz->trips, sizeof(*tz->trip_type_attrs),
+				      GFP_KERNEL);
 	if (!tz->trip_type_attrs)
 		return -ENOMEM;
 
-	tz->trip_temp_attrs = kzalloc(size, GFP_KERNEL);
+	tz->trip_temp_attrs = kcalloc(tz->trips, sizeof(*tz->trip_temp_attrs),
+				      GFP_KERNEL);
 	if (!tz->trip_temp_attrs) {
 		kfree(tz->trip_type_attrs);
 		return -ENOMEM;
 	}
 
 	if (tz->ops->get_trip_hyst) {
-		tz->trip_hyst_attrs = kzalloc(size, GFP_KERNEL);
+		tz->trip_hyst_attrs = kcalloc(tz->trips,
+					      sizeof(*tz->trip_hyst_attrs),
+					      GFP_KERNEL);
 		if (!tz->trip_hyst_attrs) {
 			kfree(tz->trip_type_attrs);
 			kfree(tz->trip_temp_attrs);
@@ -538,7 +541,7 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		}
 	}
 
-	attrs = kzalloc(sizeof(*attrs) * tz->trips * 3 + 1, GFP_KERNEL);
+	attrs = kcalloc(tz->trips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
 	if (!attrs) {
 		kfree(tz->trip_type_attrs);
 		kfree(tz->trip_temp_attrs);
-- 
2.1.4
