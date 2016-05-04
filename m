From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 25/31] thermal: core: move bind_tz() to where it is used
Date: Tue,  3 May 2016 23:02:39 -0700
Message-ID: <1462341765-13268-26-git-send-email-edubezval@gmail.com>
References: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Moving the helper to closer where it is used.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 80 +++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cbe9829..7182bec 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -319,46 +319,6 @@ static void __bind(struct thermal_zone_device *tz, int mask,
 	}
 }
 
-static void bind_tz(struct thermal_zone_device *tz)
-{
-	int i, ret;
-	struct thermal_cooling_device *pos = NULL;
-	const struct thermal_zone_params *tzp = tz->tzp;
-
-	if (!tzp && !tz->ops->bind)
-		return;
-
-	mutex_lock(&thermal_list_lock);
-
-	/* If there is ops->bind, try to use ops->bind */
-	if (tz->ops->bind) {
-		list_for_each_entry(pos, &thermal_cdev_list, node) {
-			ret = tz->ops->bind(tz, pos);
-			if (ret)
-				print_bind_err_msg(tz, pos, ret);
-		}
-		goto exit;
-	}
-
-	if (!tzp || !tzp->tbp)
-		goto exit;
-
-	list_for_each_entry(pos, &thermal_cdev_list, node) {
-		for (i = 0; i < tzp->num_tbps; i++) {
-			if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
-				continue;
-			if (tzp->tbp[i].match(tz, pos))
-				continue;
-			tzp->tbp[i].cdev = pos;
-			__bind(tz, tzp->tbp[i].trip_mask, pos,
-			       tzp->tbp[i].binding_limits,
-			       tzp->tbp[i].weight);
-		}
-	}
-exit:
-	mutex_unlock(&thermal_list_lock);
-}
-
 static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 					    int delay)
 {
@@ -1085,6 +1045,46 @@ void thermal_notify_framework(struct thermal_zone_device *tz, int trip)
 }
 EXPORT_SYMBOL_GPL(thermal_notify_framework);
 
+static void bind_tz(struct thermal_zone_device *tz)
+{
+	int i, ret;
+	struct thermal_cooling_device *pos = NULL;
+	const struct thermal_zone_params *tzp = tz->tzp;
+
+	if (!tzp && !tz->ops->bind)
+		return;
+
+	mutex_lock(&thermal_list_lock);
+
+	/* If there is ops->bind, try to use ops->bind */
+	if (tz->ops->bind) {
+		list_for_each_entry(pos, &thermal_cdev_list, node) {
+			ret = tz->ops->bind(tz, pos);
+			if (ret)
+				print_bind_err_msg(tz, pos, ret);
+		}
+		goto exit;
+	}
+
+	if (!tzp || !tzp->tbp)
+		goto exit;
+
+	list_for_each_entry(pos, &thermal_cdev_list, node) {
+		for (i = 0; i < tzp->num_tbps; i++) {
+			if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
+				continue;
+			if (tzp->tbp[i].match(tz, pos))
+				continue;
+			tzp->tbp[i].cdev = pos;
+			__bind(tz, tzp->tbp[i].trip_mask, pos,
+			       tzp->tbp[i].binding_limits,
+			       tzp->tbp[i].weight);
+		}
+	}
+exit:
+	mutex_unlock(&thermal_list_lock);
+}
+
 /**
  * thermal_zone_device_register() - register a new thermal zone device
  * @type:	the thermal zone device type
-- 
2.1.4
