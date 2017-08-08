From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/3 v2] thermal: core: Fix resources release in error paths in thermal_zone_device_register()
Date: Tue,  8 Aug 2017 16:39:54 +0200
Message-ID: <4063ac00b12066ce1886190230da2fd7fad7d992.1502201798.git.christophe.jaillet@wanadoo.fr>
References: <cover.1502201798.git.christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1502201798.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1502201798.git.christophe.jaillet@wanadoo.fr>
References: <cover.1502201798.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-pm@vger.kernel.org

Reorder error handling code in order to fix some resources leaks in some
cases:
   - 'tz' would leak if 'thermal_zone_create_device_groups()' fails
   - memory allocated by 'thermal_zone_create_device_groups()' would leak
     if 'device_register()' fails

With this patch, we now have 2 error handling paths: one before
'device_register()', and one after it.
This is needed because some resources are released in 'thermal_release()'.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Should 'ida_simple_remove()' be folded somehow into 'thermal_release()'?
---
 drivers/thermal/thermal_core.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2523901325d0..dfb4b5570c5a 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1209,10 +1209,8 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	ida_init(&tz->ida);
 	mutex_init(&tz->lock);
 	result = ida_simple_get(&thermal_tz_ida, 0, 0, GFP_KERNEL);
-	if (result < 0) {
-		kfree(tz);
-		return ERR_PTR(result);
-	}
+	if (result < 0)
+		goto free_tz;
 
 	tz->id = result;
 	strlcpy(tz->type, type, sizeof(tz->type));
@@ -1228,18 +1226,15 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	/* Add nodes that are always present via .groups */
 	result = thermal_zone_create_device_groups(tz, mask);
 	if (result)
-		goto unregister;
+		goto remove_id;
 
 	/* A new thermal zone needs to be updated anyway. */
 	atomic_set(&tz->need_update, 1);
 
 	dev_set_name(&tz->device, "thermal_zone%d", tz->id);
 	result = device_register(&tz->device);
-	if (result) {
-		ida_simple_remove(&thermal_tz_ida, tz->id);
-		kfree(tz);
-		return ERR_PTR(result);
-	}
+	if (result)
+		goto remove_device_groups;
 
 	for (count = 0; count < trips; count++) {
 		if (tz->ops->get_trip_type(tz, count, &trip_type))
@@ -1293,6 +1288,14 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	ida_simple_remove(&thermal_tz_ida, tz->id);
 	device_unregister(&tz->device);
 	return ERR_PTR(result);
+
+remove_device_groups:
+	thermal_zone_destroy_device_groups(tz);
+remove_id:
+	ida_simple_remove(&thermal_tz_ida, tz->id);
+free_tz:
+	kfree(tz);
+	return ERR_PTR(result);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_register);
 
-- 
2.11.0
