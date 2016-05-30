From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv3 48/48] thermal: sysfs: use kcalloc() instead of kzalloc()
Date: Mon, 30 May 2016 15:16:24 -0700
Message-ID: <1464646584-14322-49-git-send-email-edubezval@gmail.com>
References: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
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
index 10c8fe4..d208071 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -502,22 +502,25 @@ static const struct attribute_group *thermal_zone_attribute_groups[] = {
  */
 static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 {
-	int size = sizeof(struct thermal_attr) * tz->trips;
 	struct attribute **attrs;
 	int indx;
 
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
@@ -525,7 +528,7 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		}
 	}
 
-	attrs = kzalloc(sizeof(*attrs) * tz->trips * 3, GFP_KERNEL);
+	attrs = kcalloc(tz->trips * 3, sizeof(*attrs), GFP_KERNEL);
 	if (!attrs) {
 		kfree(tz->trip_type_attrs);
 		kfree(tz->trip_temp_attrs);
-- 
2.1.4
