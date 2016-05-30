From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv3 31/48] thermal: core: move bind_cdev() to where it is used
Date: Mon, 30 May 2016 15:16:07 -0700
Message-ID: <1464646584-14322-32-git-send-email-edubezval@gmail.com>
References: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
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
 drivers/thermal/thermal_core.c | 76 +++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 75b7854..e0ebf9f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -319,44 +319,6 @@ static void __bind(struct thermal_zone_device *tz, int mask,
 	}
 }
 
-static void bind_cdev(struct thermal_cooling_device *cdev)
-{
-	int i, ret;
-	const struct thermal_zone_params *tzp;
-	struct thermal_zone_device *pos = NULL;
-
-	mutex_lock(&thermal_list_lock);
-
-	list_for_each_entry(pos, &thermal_tz_list, node) {
-		if (!pos->tzp && !pos->ops->bind)
-			continue;
-
-		if (pos->ops->bind) {
-			ret = pos->ops->bind(pos, cdev);
-			if (ret)
-				print_bind_err_msg(pos, cdev, ret);
-			continue;
-		}
-
-		tzp = pos->tzp;
-		if (!tzp || !tzp->tbp)
-			continue;
-
-		for (i = 0; i < tzp->num_tbps; i++) {
-			if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
-				continue;
-			if (tzp->tbp[i].match(pos, cdev))
-				continue;
-			tzp->tbp[i].cdev = cdev;
-			__bind(pos, tzp->tbp[i].trip_mask, cdev,
-			       tzp->tbp[i].binding_limits,
-			       tzp->tbp[i].weight);
-		}
-	}
-
-	mutex_unlock(&thermal_list_lock);
-}
-
 static void bind_tz(struct thermal_zone_device *tz)
 {
 	int i, ret;
@@ -882,6 +844,44 @@ static struct class thermal_class = {
 	.dev_release = thermal_release,
 };
 
+static void bind_cdev(struct thermal_cooling_device *cdev)
+{
+	int i, ret;
+	const struct thermal_zone_params *tzp;
+	struct thermal_zone_device *pos = NULL;
+
+	mutex_lock(&thermal_list_lock);
+
+	list_for_each_entry(pos, &thermal_tz_list, node) {
+		if (!pos->tzp && !pos->ops->bind)
+			continue;
+
+		if (pos->ops->bind) {
+			ret = pos->ops->bind(pos, cdev);
+			if (ret)
+				print_bind_err_msg(pos, cdev, ret);
+			continue;
+		}
+
+		tzp = pos->tzp;
+		if (!tzp || !tzp->tbp)
+			continue;
+
+		for (i = 0; i < tzp->num_tbps; i++) {
+			if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
+				continue;
+			if (tzp->tbp[i].match(pos, cdev))
+				continue;
+			tzp->tbp[i].cdev = cdev;
+			__bind(pos, tzp->tbp[i].trip_mask, cdev,
+			       tzp->tbp[i].binding_limits,
+			       tzp->tbp[i].weight);
+		}
+	}
+
+	mutex_unlock(&thermal_list_lock);
+}
+
 /**
  * __thermal_cooling_device_register() - register a new thermal cooling device
  * @np:		a pointer to a device tree node.
-- 
2.1.4
