From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][v2] mfd: intel-lpss: Avoid resuming runtime-suspended lpss unnecessarily
Date: Thu, 29 Sep 2016 00:29:39 +0800
Message-ID: <1475080179-7692-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59521 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932652AbcI1QV1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Sep 2016 12:21:27 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Lee Jones <lee.jones@linaro.org>

We have report that the intel_lpss_prepare() takes too much time during
suspend, and this is because we first resume the devices from runtime
suspend by resume_lpss_device(), to make sure they are in proper state
before system suspend, which takes 100ms for each LPSS devices(PCI power
state from D3_cold to D0). And since resume_lpss_device() resumes the
devices synchronously, we might get huge latency if we have many
LPSS devices.

So first try is to use pm_request_resume() instead, to make the runtime
resume process asynchronously. Unfortunately the asynchronous runtime
resume relies on pm_wq, which is freezed at early stage. So we choose
another method, that is to avoid resuming runtime-suspended devices,
if they are already runtime suspended. This is safe because for LPSS
driver, the runtime suspend and system suspend are of the same
hook - i.e., intel_lpss_suspend(). And moreover, this device is
neither runtime wakeup source nor system wakeup source.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/mfd/intel-lpss.c | 9 +++++++++
 include/linux/pm.h       | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 41b1138..2583db8 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -485,6 +485,15 @@ static int resume_lpss_device(struct device *dev, void *data)
 int intel_lpss_prepare(struct device *dev)
 {
 	/*
+	 * This is safe because:
+	 * 1. The runtime suspend and system suspend
+	 * are of the same hook.
+	 * 2. This device is neither runtime wakeup source
+	 * nor system wakeup source.
+	 */
+	if (pm_runtime_status_suspended(dev))
+		return DPM_DIRECT_COMPLETE;
+	/*
 	 * Resume both child devices before entering system sleep. This
 	 * ensures that they are in proper state before they get suspended.
 	 */
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 06eb353..5606ad9 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -786,4 +786,7 @@ enum dpm_order {
 	DPM_ORDER_DEV_LAST,
 };
 
+/* The device is OK to remain runtime-suspended during suspend.*/
+#define DPM_DIRECT_COMPLETE 1
+
 #endif /* _LINUX_PM_H */
-- 
2.7.4

