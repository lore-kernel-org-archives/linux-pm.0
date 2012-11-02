From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH] PM / Qos: Ensure device not in PRM_SUSPENDED when pm qos flags request functions are invoked in the pm core.
Date: Fri,  2 Nov 2012 16:03:50 +0800
Message-ID: <1351843430-8023-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13497 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977Ab2KBIHo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 2 Nov 2012 04:07:44 -0400
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
 drivers/base/power/qos.c   |   10 ++++++++--
 drivers/base/power/sysfs.c |    4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 31d3f48..b50ba72 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -624,15 +624,19 @@ int dev_pm_qos_expose_flags(struct device *dev, s32 val)
 	if (!req)
 		return -ENOMEM;
 
+	pm_runtime_get_sync(dev);
 	ret = dev_pm_qos_add_request(dev, req, DEV_PM_QOS_FLAGS, val);
+	pm_runtime_put(dev);
 	if (ret < 0)
 		return ret;
 
 	dev->power.qos->flags_req = req;
 	ret = pm_qos_sysfs_add_flags(dev);
-	if (ret)
+	if (ret) {
+		pm_runtime_get_sync(dev);
 		__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_FLAGS);
-
+		pm_runtime_put(dev);
+	}
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_expose_flags);
@@ -645,7 +649,9 @@ void dev_pm_qos_hide_flags(struct device *dev)
 {
 	if (dev->power.qos && dev->power.qos->flags_req) {
 		pm_qos_sysfs_remove_flags(dev);
+		pm_runtime_get_sync(dev);
 		__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_FLAGS);
+		pm_runtime_put(dev);
 	}
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_hide_flags);
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 50d16e3..240bfaa 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -264,7 +264,9 @@ static ssize_t pm_qos_no_power_off_store(struct device *dev,
 	if (ret != 0 && ret != 1)
 		return -EINVAL;
 
+	pm_runtime_get_sync(dev);
 	ret = dev_pm_qos_update_flags(dev, PM_QOS_FLAG_NO_POWER_OFF, ret);
+	pm_runtime_put(dev);
 	return ret < 0 ? ret : n;
 }
 
@@ -291,7 +293,9 @@ static ssize_t pm_qos_remote_wakeup_store(struct device *dev,
 	if (ret != 0 && ret != 1)
 		return -EINVAL;
 
+	pm_runtime_get_sync(dev);
 	ret = dev_pm_qos_update_flags(dev, PM_QOS_FLAG_REMOTE_WAKEUP, ret);
+	pm_runtime_put(dev);
 	return ret < 0 ? ret : n;
 }
 
-- 
1.7.9.5

