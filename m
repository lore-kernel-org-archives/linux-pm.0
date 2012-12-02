From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 09/34] Thermal: Make thermal_cdev_update as a global function
Date: Sun,  2 Dec 2012 22:44:43 +0800
Message-ID: <1354459508-3707-9-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:33009 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301Ab2LBOpg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:36 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Durgadoss R <durgadoss.r@intel.com>, Zhang Rui <rui.zhang@intel.com>

From: Durgadoss R <durgadoss.r@intel.com>

This patch makes the thermal_cdev_update function as a
global one, so that other files can use it. This function
serves as a single arbitrator to set the state of a cooling
device.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |    5 +++--
 include/linux/thermal.h       |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index a328032..9d21f82 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -1257,7 +1257,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 }
 EXPORT_SYMBOL(thermal_cooling_device_unregister);
 
-static void thermal_cdev_do_update(struct thermal_cooling_device *cdev)
+void thermal_cdev_update(struct thermal_cooling_device *cdev)
 {
 	struct thermal_instance *instance;
 	unsigned long target = 0;
@@ -1278,13 +1278,14 @@ static void thermal_cdev_do_update(struct thermal_cooling_device *cdev)
 	cdev->ops->set_cur_state(cdev, target);
 	cdev->updated = true;
 }
+EXPORT_SYMBOL(thermal_cdev_update);
 
 static void thermal_zone_do_update(struct thermal_zone_device *tz)
 {
 	struct thermal_instance *instance;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-		thermal_cdev_do_update(instance->cdev);
+		thermal_cdev_update(instance->cdev);
 }
 
 /*
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 6182bd5..2bd9158 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -231,6 +231,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
 		struct thermal_cooling_device *, int);
+void thermal_cdev_update(struct thermal_cooling_device *);
 
 int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
-- 
1.7.7.6

