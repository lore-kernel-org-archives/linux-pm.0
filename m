From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 15/40] thermal: core: remove unnecessary device_remove() calls
Date: Mon, 30 May 2016 14:27:34 -0700
Message-ID: <1464643679-2733-16-git-send-email-edubezval@gmail.com>
References: <1464643679-2733-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464643679-2733-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Given that cdevs sysfs properties are already registered using
the dev.groups, there is no need to explicitly call device_remove()
for each property.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 0156a6b..61410c3 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1799,11 +1799,6 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
 	mutex_unlock(&thermal_list_lock);
 
-	if (cdev->type[0])
-		device_remove_file(&cdev->device, &dev_attr_cdev_type);
-	device_remove_file(&cdev->device, &dev_attr_max_state);
-	device_remove_file(&cdev->device, &dev_attr_cur_state);
-
 	release_idr(&thermal_cdev_idr, &thermal_idr_lock, cdev->id);
 	device_unregister(&cdev->device);
 	return;
-- 
2.1.4
