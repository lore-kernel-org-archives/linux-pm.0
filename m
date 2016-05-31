From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 28/48] thermal: core: move idr handling to device management section
Date: Mon, 30 May 2016 23:18:35 -0700
Message-ID: <1464675535-2433-29-git-send-email-edubezval@gmail.com>
References: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36565 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755768AbcEaGUM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 02:20:12 -0400
In-Reply-To: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>

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
index 16d43ee..e77e6d1 100644
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
@@ -692,6 +668,30 @@ void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
 
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

