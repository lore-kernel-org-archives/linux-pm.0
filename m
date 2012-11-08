From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH V2] PM / Qos: Ensure device not in PRM_SUSPENDED when pm qos flags request functions are invoked in the pm core.
Date: Thu,  8 Nov 2012 11:14:08 +0800
Message-ID: <1352344448-9971-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23981 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753109Ab2KHDSP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Nov 2012 22:18:15 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: Lan Tianyu <tianyu.lan@intel.com>, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

Since dev_pm_qos_add_request(), dev_pm_qos_update_request() and
dev_pm_qos_remove_request() for pm qos flags should not be invoked
when device in RPM_SUSPENDED. Add pm_runtime_get_sync() and pm_runtime_put()
around these functions in the pm core to ensure device not in RPM_SUSPENDED.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
Change since v1:
	Remove unnecessary pm_runtime_get_sync() and pm_runtime_put()
around dev_pm_qos_update_flags().
---
 drivers/base/power/qos.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 081db2d..fdc3894 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -633,15 +633,18 @@ int dev_pm_qos_expose_flags(struct device *dev, s32 val)
 	if (!req)
 		return -ENOMEM;
 
+	pm_runtime_get_sync(dev);
 	ret = dev_pm_qos_add_request(dev, req, DEV_PM_QOS_FLAGS, val);
 	if (ret < 0)
-		return ret;
+		goto fail;
 
 	dev->power.qos->flags_req = req;
 	ret = pm_qos_sysfs_add_flags(dev);
 	if (ret)
 		__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_FLAGS);
 
+fail:
+	pm_runtime_put(dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_expose_flags);
@@ -654,7 +657,9 @@ void dev_pm_qos_hide_flags(struct device *dev)
 {
 	if (dev->power.qos && dev->power.qos->flags_req) {
 		pm_qos_sysfs_remove_flags(dev);
+		pm_runtime_get_sync(dev);
 		__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_FLAGS);
+		pm_runtime_put(dev);
 	}
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_hide_flags);
-- 
1.7.9.5

