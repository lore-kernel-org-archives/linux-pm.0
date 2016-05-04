From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 22/31] thermal: core: move idr handling to device management section
Date: Tue,  3 May 2016 23:02:36 -0700
Message-ID: <1462341765-13268-23-git-send-email-edubezval@gmail.com>
References: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Given that idr is only used to get id for thermal devices
(zones and cooling), makes sense to move the code closer.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 48 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 09b4b42..480db91 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -286,30 +286,6 @@ static void thermal_unregister_governors(void)
 	thermal_gov_power_allocator_unregister();
 }
 
-static int get_idr(struct idr *idr, struct mutex *lock, int *id)
-{
-	int ret;
-
-	if (lock)
-		mutex_lock(lock);
-	ret = idr_alloc(idr, NULL, 0, 0, GFP_KERNEL);
-	if (lock)
-		mutex_unlock(lock);
-	if (unlikely(ret < 0))
-		return ret;
-	*id = ret;
-	return 0;
-}
-
-static void release_idr(struct idr *idr, struct mutex *lock, int id)
-{
-	if (lock)
-		mutex_lock(lock);
-	idr_remove(idr, id);
-	if (lock)
-		mutex_unlock(lock);
-}
-
 static void print_bind_err_msg(struct thermal_zone_device *tz,
 			struct thermal_cooling_device *cdev, int ret)
 {
@@ -691,6 +667,30 @@ void thermal_zone_device_passive_update(struct thermal_zone_device *tz,
 
 /* Device management */
 
+static int get_idr(struct idr *idr, struct mutex *lock, int *id)
+{
+	int ret;
+
+	if (lock)
+		mutex_lock(lock);
+	ret = idr_alloc(idr, NULL, 0, 0, GFP_KERNEL);
+	if (lock)
+		mutex_unlock(lock);
+	if (unlikely(ret < 0))
+		return ret;
+	*id = ret;
+	return 0;
+}
+
+static void release_idr(struct idr *idr, struct mutex *lock, int id)
+{
+	if (lock)
+		mutex_lock(lock);
+	idr_remove(idr, id);
+	if (lock)
+		mutex_unlock(lock);
+}
+
 /**
  * thermal_zone_bind_cooling_device() - bind a cooling device to a thermal zone
  * @tz:		pointer to struct thermal_zone_device
-- 
2.1.4
