From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 26/31] thermal: core: move __bind() to where it is used
Date: Tue,  3 May 2016 23:02:40 -0700
Message-ID: <1462341765-13268-27-git-send-email-edubezval@gmail.com>
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
 drivers/thermal/thermal_core.c | 66 +++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 7182bec..d836a90 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -286,39 +286,6 @@ static void thermal_unregister_governors(void)
 	thermal_gov_power_allocator_unregister();
 }
 
-static void print_bind_err_msg(struct thermal_zone_device *tz,
-			struct thermal_cooling_device *cdev, int ret)
-{
-	dev_err(&tz->device, "binding zone %s with cdev %s failed:%d\n",
-				tz->type, cdev->type, ret);
-}
-
-static void __bind(struct thermal_zone_device *tz, int mask,
-			struct thermal_cooling_device *cdev,
-			unsigned long *limits,
-			unsigned int weight)
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
@@ -803,6 +770,39 @@ static struct class thermal_class = {
 	.dev_release = thermal_release,
 };
 
+static void print_bind_err_msg(struct thermal_zone_device *tz,
+			struct thermal_cooling_device *cdev, int ret)
+{
+	dev_err(&tz->device, "binding zone %s with cdev %s failed:%d\n",
+				tz->type, cdev->type, ret);
+}
+
+static void __bind(struct thermal_zone_device *tz, int mask,
+			struct thermal_cooling_device *cdev,
+			unsigned long *limits,
+			unsigned int weight)
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
