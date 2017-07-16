From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/3] thermal: core: Avoid code duplication in 'thermal_zone_device_register()'
Date: Sun, 16 Jul 2017 08:59:04 +0200
Message-ID: <8eeaa51b6d95f3b73ec476a01157dc6308a1b732.1500187753.git.christophe.jaillet@wanadoo.fr>
References: <dcc79547980dca6c42c16c60f76cf8b4cbd5a392.1500187753.git.christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dcc79547980dca6c42c16c60f76cf8b4cbd5a392.1500187753.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1500187753.git.christophe.jaillet@wanadoo.fr>
References: <cover.1500187753.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-pm@vger.kernel.org

Jump in the error handling path in order to avoid code duplication if
some function fail.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/thermal/thermal_core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c58714800660..fe4b812eeb12 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1213,10 +1213,8 @@ thermal_zone_device_register(const char *type, int trips, int mask,
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
@@ -1239,11 +1237,8 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 
 	dev_set_name(&tz->device, "thermal_zone%d", tz->id);
 	result = device_register(&tz->device);
-	if (result) {
-		ida_simple_remove(&thermal_tz_ida, tz->id);
-		kfree(tz);
-		return ERR_PTR(result);
-	}
+	if (result)
+		goto remove_id;
 
 	for (count = 0; count < trips; count++) {
 		if (tz->ops->get_trip_type(tz, count, &trip_type))
@@ -1297,6 +1292,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	device_unregister(&tz->device);
 remove_id:
 	ida_simple_remove(&thermal_tz_ida, tz->id);
+free_tz:
 	kfree(tz);
 	return ERR_PTR(result);
 }
-- 
2.11.0
