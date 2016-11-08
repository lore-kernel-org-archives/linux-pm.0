From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 31/49] thermal: core: move bind_cdev() to where it is used
Date: Mon,  7 Nov 2016 21:09:09 -0800
Message-ID: <1478581767-7009-32-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34831 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbcKHF12 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 00:27:28 -0500
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Moving the helper to closer where it is used.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 76 +++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c121933..e397d88 100644
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
@@ -889,6 +851,44 @@ static struct class thermal_class = {
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

