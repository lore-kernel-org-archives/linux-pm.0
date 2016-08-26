From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v5 07/16] kernel/cpu_pm: Add runtime PM support for CPUs
Date: Fri, 26 Aug 2016 14:17:49 -0600
Message-ID: <1472242678-33700-8-git-send-email-lina.iyer@linaro.org>
References: <1472242678-33700-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34764 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753741AbcHZUSc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Aug 2016 16:18:32 -0400
Received: by mail-pf0-f175.google.com with SMTP id p64so31715331pfb.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Aug 2016 13:18:32 -0700 (PDT)
In-Reply-To: <1472242678-33700-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>

Notify runtime PM when the CPU is going to be powered off in the idle
state. This allows for runtime PM suspend/resume of the CPU as well as
its PM domain.

Cc: Kevin Hilman <khilman@kernel.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 kernel/cpu_pm.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 009cc9a..657ce06 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -16,9 +16,11 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/cpu.h>
 #include <linux/cpu_pm.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 
@@ -99,6 +101,7 @@ int cpu_pm_enter(void)
 {
 	int nr_calls;
 	int ret = 0;
+	struct device *dev = get_cpu_device(smp_processor_id());
 
 	read_lock(&cpu_pm_notifier_lock);
 	ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
@@ -110,6 +113,10 @@ int cpu_pm_enter(void)
 		cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
 	read_unlock(&cpu_pm_notifier_lock);
 
+	/* Notify Runtime PM that we are suspending the CPU */
+	if (!ret && dev)
+		RCU_NONIDLE(pm_runtime_put_sync_suspend(dev));
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cpu_pm_enter);
@@ -129,6 +136,11 @@ EXPORT_SYMBOL_GPL(cpu_pm_enter);
 int cpu_pm_exit(void)
 {
 	int ret;
+	struct device *dev = get_cpu_device(smp_processor_id());
+
+	/* Notify Runtime PM that we are resuming the CPU */
+	if (dev)
+		RCU_NONIDLE(pm_runtime_get_sync(dev));
 
 	read_lock(&cpu_pm_notifier_lock);
 	ret = cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
@@ -200,6 +212,39 @@ int cpu_cluster_pm_exit(void)
 }
 EXPORT_SYMBOL_GPL(cpu_cluster_pm_exit);
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int cpu_pm_cpu_hotplug(struct notifier_block *nb,
+			unsigned long action, void *data)
+{
+	struct device *dev = get_cpu_device(smp_processor_id());
+
+	if (!dev)
+		return NOTIFY_OK;
+
+	/* Execute CPU runtime PM on that CPU */
+	switch (action & ~CPU_TASKS_FROZEN) {
+	case CPU_DYING:
+		pm_runtime_put_sync_suspend(dev);
+		break;
+	case CPU_STARTING:
+		pm_runtime_get_sync(dev);
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int __init cpu_pm_hotplug_init(void)
+{
+	/* Register for hotplug notifications for runtime PM */
+	hotcpu_notifier(cpu_pm_cpu_hotplug, 0);
+	return 0;
+}
+device_initcall(cpu_pm_hotplug_init);
+#endif
+
 #ifdef CONFIG_PM
 static int cpu_pm_suspend(void)
 {
-- 
2.7.4

