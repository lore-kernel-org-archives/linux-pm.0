From: Bai Ping <ping.bai@nxp.com>
Subject: [PATCH] thermal: common: free the mem allocated when out of use
Date: Tue, 12 Jan 2016 18:37:23 +0800
Message-ID: <1452595043-7239-1-git-send-email-ping.bai@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-am1on0086.outbound.protection.outlook.com ([157.56.112.86]:17713
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933125AbcALKvl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 Jan 2016 05:51:41 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org

The memory resource allocated for thermal_zone_device
should be freed when thermal_zone_device registers failed
or the thermal_zone_device unregistered.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
 drivers/thermal/thermal_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 7f7a3ca..1a9cf31 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -2012,6 +2012,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 unregister:
 	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
 	device_unregister(&tz->device);
+	kfree(tz);
 	return ERR_PTR(result);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_register);
@@ -2081,6 +2082,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	idr_destroy(&tz->idr);
 	mutex_destroy(&tz->lock);
 	device_unregister(&tz->device);
+	kfree(tz);
 	return;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
-- 
1.9.1

