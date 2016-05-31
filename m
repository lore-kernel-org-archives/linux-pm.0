From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 44/48] thermal: core: remove void function return statements
Date: Mon, 30 May 2016 23:18:51 -0700
Message-ID: <1464675535-2433-45-git-send-email-edubezval@gmail.com>
References: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Simply removing useless returns of void functions.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 3f1082d..6e248bb 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -202,7 +202,6 @@ void thermal_unregister_governor(struct thermal_governor *governor)
 	list_del(&governor->governor_list);
 exit:
 	mutex_unlock(&thermal_governor_lock);
-	return;
 }
 
 int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
@@ -1061,7 +1060,6 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
 	release_idr(&thermal_cdev_idr, &thermal_idr_lock, cdev->id);
 	device_unregister(&cdev->device);
-	return;
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 
-- 
2.1.4
