From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 15/49] thermal: core: remove unnecessary device_remove() calls
Date: Mon,  7 Nov 2016 21:08:53 -0800
Message-ID: <1478581767-7009-16-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33406 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbcKHGSh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 01:18:37 -0500
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

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
index b1d6de9..6100ae7 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1876,11 +1876,6 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
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

