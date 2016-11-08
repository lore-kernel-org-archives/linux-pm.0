From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 44/49] thermal: core: remove void function return statements
Date: Mon,  7 Nov 2016 21:09:22 -0800
Message-ID: <1478581767-7009-45-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34224 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbcKHF0l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 00:26:41 -0500
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Simply removing useless returns of void functions.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d33b29a..8365d0b 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -202,7 +202,6 @@ void thermal_unregister_governor(struct thermal_governor *governor)
 	list_del(&governor->governor_list);
 exit:
 	mutex_unlock(&thermal_governor_lock);
-	return;
 }
 
 int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
@@ -1069,7 +1068,6 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
 	release_idr(&thermal_cdev_idr, &thermal_idr_lock, cdev->id);
 	device_unregister(&cdev->device);
-	return;
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 
-- 
2.1.4

