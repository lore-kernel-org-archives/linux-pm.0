From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 34/40] thermal: core: move __bind() to where it is used
Date: Mon, 30 May 2016 14:27:53 -0700
Message-ID: <1464643679-2733-35-git-send-email-edubezval@gmail.com>
References: <1464643679-2733-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34710 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423386AbcE3V3Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2016 17:29:16 -0400
In-Reply-To: <1464643679-2733-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Moving the helper to closer where it is used.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 66 +++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 59fe92d..460220c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -286,39 +286,6 @@ static void thermal_unregister_governors(void)
 	thermal_gov_power_allocator_unregister();
 }
 
-static void print_bind_err_msg(struct thermal_zone_device *tz,
-			       struct thermal_cooling_device *cdev, int ret)
-{
-	dev_err(&tz->device, "binding zone %s with cdev %s failed:%d\n",
-		tz->type, cdev->type, ret);
-}
-
-static void __bind(struct thermal_zone_device *tz, int mask,
-		   struct thermal_cooling_device *cdev,
-		   unsigned long *limits,
-		   unsigned int weight)
-{
-	int i, ret;
-
-	for (i = 0; i < tz->trips; i++) {
-		if (mask & (1 << i)) {
-			unsigned long upper, lower;
-
-			upper = THERMAL_NO_LIMIT;
-			lower = THERMAL_NO_LIMIT;
-			if (limits) {
-				lower = limits[i * 2];
-				upper = limits[i * 2 + 1];
-			}
-			ret = thermal_zone_bind_cooling_device(tz, i, cdev,
-							       upper, lower,
-							       weight);
-			if (ret)
-				print_bind_err_msg(tz, cdev, ret);
-		}
-	}
-}
-
 static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 					    int delay)
 {
@@ -804,6 +771,39 @@ static struct class thermal_class = {
 	.dev_release = thermal_release,
 };
 
+static void print_bind_err_msg(struct thermal_zone_device *tz,
+			       struct thermal_cooling_device *cdev, int ret)
+{
+	dev_err(&tz->device, "binding zone %s with cdev %s failed:%d\n",
+		tz->type, cdev->type, ret);
+}
+
+static void __bind(struct thermal_zone_device *tz, int mask,
+		   struct thermal_cooling_device *cdev,
+		   unsigned long *limits,
+		   unsigned int weight)
+{
+	int i, ret;
+
+	for (i = 0; i < tz->trips; i++) {
+		if (mask & (1 << i)) {
+			unsigned long upper, lower;
+
+			upper = THERMAL_NO_LIMIT;
+			lower = THERMAL_NO_LIMIT;
+			if (limits) {
+				lower = limits[i * 2];
+				upper = limits[i * 2 + 1];
+			}
+			ret = thermal_zone_bind_cooling_device(tz, i, cdev,
+							       upper, lower,
+							       weight);
+			if (ret)
+				print_bind_err_msg(tz, cdev, ret);
+		}
+	}
+}
+
 static void bind_cdev(struct thermal_cooling_device *cdev)
 {
 	int i, ret;
-- 
2.1.4

