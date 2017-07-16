From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/3] thermal: core: Reorder 'thermal_zone_device_register()' error handling code
Date: Sun, 16 Jul 2017 08:59:03 +0200
Message-ID: <1b2b2a818d356097d5f6092745086b79d43aeafe.1500187753.git.christophe.jaillet@wanadoo.fr>
References: <dcc79547980dca6c42c16c60f76cf8b4cbd5a392.1500187753.git.christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dcc79547980dca6c42c16c60f76cf8b4cbd5a392.1500187753.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1500187753.git.christophe.jaillet@wanadoo.fr>
References: <cover.1500187753.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-pm@vger.kernel.org

Reorder code in the error handling path in order to match the way resources
have been allocated.

With this new order, we can avoid a call to 'device_unregister()' if
'thermal_zone_create_device_groups'()' fails. At this point,
'device_register()' has not been called yet.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/thermal/thermal_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9743f3e65eb0..c58714800660 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1232,7 +1232,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	/* Add nodes that are always present via .groups */
 	result = thermal_zone_create_device_groups(tz, mask);
 	if (result)
-		goto unregister;
+		goto remove_id;
 
 	/* A new thermal zone needs to be updated anyway. */
 	atomic_set(&tz->need_update, 1);
@@ -1294,8 +1294,9 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	return tz;
 
 unregister:
-	ida_simple_remove(&thermal_tz_ida, tz->id);
 	device_unregister(&tz->device);
+remove_id:
+	ida_simple_remove(&thermal_tz_ida, tz->id);
 	kfree(tz);
 	return ERR_PTR(result);
 }
-- 
2.11.0
