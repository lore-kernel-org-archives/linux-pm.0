From: Lina Iyer <lina.iyer@linaro.org>
Subject: [RFC PATCH 1/2] PM / runtime: Add CPU runtime PM suspend/resume api
Date: Tue,  6 Oct 2015 15:57:35 -0600
Message-ID: <1444168656-6576-2-git-send-email-lina.iyer@linaro.org>
References: <1444168656-6576-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36240 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313AbbJFV5w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2015 17:57:52 -0400
Received: by pablk4 with SMTP id lk4so220829410pab.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2015 14:57:51 -0700 (PDT)
In-Reply-To: <1444168656-6576-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: grygorii.strashko@ti.com, ulf.hansson@linaro.org, khilman@linaro.org, daniel.lezcano@linaro.org, tglx@linutronix.de, geert+renesas@glider.be, lorenzo.pieralisi@arm.com, sboyd@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

CPU devices that use runtime PM, have the followign characteristics -
	- Runs in a IRQs disabled context
	- Every CPU does its own runtime PM
	- CPUs do not access other CPU's runtime PM
	- The runtime PM state of the CPU is determined by the CPU

These allow for some interesting optimizations -
	- The CPUs have a limited runtime PM states
	- The runtime state of CPU need not be protected by spinlocks
	- Options like auto-suspend/async are not relevant to CPU
	  devices

A simplified runtime PM would therefore provide all that is needed for
the CPU devices. After making a quick check for the usage count of the
CPU devices (to allow for the CPU to not power down the domain), the
runtime PM could just call the PM callbacks for the CPU devices. Locking
is also avoided.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/runtime.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_runtime.h   |  3 ++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index e1a10a0..5f7512c 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -13,6 +13,7 @@
 #include <linux/pm_wakeirq.h>
 #include <trace/events/rpm.h>
 #include "power.h"
+#include <linux/cpu.h>
 
 typedef int (*pm_callback_t)(struct device *);
 
@@ -577,6 +578,66 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	goto out;
 }
 
+void cpu_pm_runtime_suspend(void)
+{
+	int ret;
+	int (*callback)(struct device *);
+	struct device *dev = get_cpu_device(smp_processor_id());
+
+	trace_rpm_suspend(dev, 0);
+
+	/**
+	 * Use device usage_count to disallow bubbling up suspend.
+	 * This CPU has already decided to suspend, we cannot
+	 * prevent it here.
+	 */
+	if (!atomic_dec_and_test(&dev->power.usage_count))
+		return 0;
+
+	ret = rpm_check_suspend_allowed(dev);
+	if (ret)
+		return ret;
+
+	__update_runtime_status(dev, RPM_SUSPENDING);
+
+	pm_runtime_cancel_pending(dev);
+	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
+
+	ret = callback(dev);
+	if (!ret)
+		__update_runtime_status(dev, RPM_SUSPENDED);
+	else
+		__update_runtime_status(dev, RPM_ACTIVE);
+
+	trace_rpm_return_int(dev, _THIS_IP_, ret);
+}
+
+void cpu_pm_runtime_resume(void)
+{
+	int ret;
+	int (*callback)(struct device *);
+	struct device *dev = get_cpu_device(smp_processor_id());
+
+	trace_rpm_resume(dev, 0);
+
+	if (dev->power.runtime_status == RPM_ACTIVE)
+		return 1;
+
+	atomic_inc(&dev->power.usage_count);
+
+	__update_runtime_status(dev, RPM_RESUMING);
+
+	callback = RPM_GET_CALLBACK(dev, runtime_resume);
+
+	ret = callback(dev);
+	if (!ret)
+		__update_runtime_status(dev, RPM_ACTIVE);
+	else
+		__update_runtime_status(dev, RPM_SUSPENDED);
+
+	trace_rpm_return_int(dev, _THIS_IP_, ret);
+}
+
 /**
  * rpm_resume - Carry out runtime resume of given device.
  * @dev: Device to resume.
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 3bdbb41..3655ead 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -31,6 +31,8 @@ static inline bool queue_pm_work(struct work_struct *work)
 	return queue_work(pm_wq, work);
 }
 
+extern void cpu_pm_runtime_suspend(void);
+extern void cpu_pm_runtime_resume(void);
 extern int pm_generic_runtime_suspend(struct device *dev);
 extern int pm_generic_runtime_resume(struct device *dev);
 extern int pm_runtime_force_suspend(struct device *dev);
@@ -273,5 +275,4 @@ static inline void pm_runtime_dont_use_autosuspend(struct device *dev)
 {
 	__pm_runtime_use_autosuspend(dev, false);
 }
-
 #endif
-- 
2.1.4

