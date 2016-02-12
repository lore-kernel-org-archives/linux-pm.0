From: Lina Iyer <lina.iyer@linaro.org>
Subject: [RFC v2 04/12] ARM: cpuidle: Add runtime PM support for CPUs
Date: Fri, 12 Feb 2016 13:50:30 -0700
Message-ID: <1455310238-8963-5-git-send-email-lina.iyer@linaro.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:32916 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbcBLUvY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2016 15:51:24 -0500
Received: by mail-pf0-f181.google.com with SMTP id q63so52948243pfb.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2016 12:51:24 -0800 (PST)
In-Reply-To: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

Notify runtime PM when the CPU is going to be powered off in the idle
state. This allows for runtime PM suspend/resume of the CPU as well as
its PM domain.

We do not call into runtime PM for ARM WFI to keep the default state
simple and faster.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
Changes since RFC v1 -
- runtime PM initialization is now done as part of this file
- hotplug and its runtime PM invocation is done here

 drivers/cpuidle/cpuidle-arm.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 545069d..bf7a80c 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -11,12 +11,14 @@
 
 #define pr_fmt(fmt) "CPUidle arm: " fmt
 
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include <asm/cpuidle.h>
@@ -37,6 +39,7 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int idx)
 {
 	int ret;
+	struct device *cpu_dev = get_cpu_device(dev->cpu);
 
 	if (!idx) {
 		cpu_do_idle();
@@ -45,6 +48,8 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 
 	ret = cpu_pm_enter();
 	if (!ret) {
+		RCU_NONIDLE(pm_runtime_put_sync_suspend(cpu_dev));
+
 		/*
 		 * Pass idle state index to cpu_suspend which in turn will
 		 * call the CPU ops suspend protocol with idle index as a
@@ -52,6 +57,7 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 		 */
 		arm_cpuidle_suspend(idx);
 
+		RCU_NONIDLE(pm_runtime_get_sync(cpu_dev));
 		cpu_pm_exit();
 	}
 
@@ -84,6 +90,30 @@ static const struct of_device_id arm_idle_state_match[] __initconst = {
 	{ },
 };
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int cpu_hotplug(struct notifier_block *nb,
+			unsigned long action, void *data)
+{
+	struct device *cpu_dev = get_cpu_device(smp_processor_id());
+
+	/* Execute CPU runtime PM on that CPU */
+	switch (action) {
+	case CPU_DYING:
+	case CPU_DYING_FROZEN:
+		RCU_NONIDLE(pm_runtime_put_sync_suspend(cpu_dev));
+		break;
+	case CPU_STARTING:
+	case CPU_STARTING_FROZEN:
+		RCU_NONIDLE(pm_runtime_get_sync(cpu_dev));
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+#endif
+
 /*
  * arm_idle_init
  *
@@ -96,6 +126,7 @@ static int __init arm_idle_init(void)
 	int cpu, ret;
 	struct cpuidle_driver *drv = &arm_idle_driver;
 	struct cpuidle_device *dev;
+	struct device *cpu_dev;
 
 	/*
 	 * Initialize idle states data, starting at index 1.
@@ -118,6 +149,16 @@ static int __init arm_idle_init(void)
 	 * idle states suspend back-end specific data
 	 */
 	for_each_possible_cpu(cpu) {
+
+		/* Initialize Runtime PM for the CPU */
+		cpu_dev = get_cpu_device(cpu);
+		pm_runtime_irq_safe(cpu_dev);
+		pm_runtime_enable(cpu_dev);
+		if (cpu_online(cpu)) {
+			pm_runtime_get_noresume(cpu_dev);
+			pm_runtime_set_active(cpu_dev);
+		}
+
 		ret = arm_cpuidle_init(cpu);
 
 		/*
@@ -148,10 +189,17 @@ static int __init arm_idle_init(void)
 		}
 	}
 
+#ifdef CONFIG_HOTPLUG_CPU
+	/* Register for hotplug notifications for runtime PM */
+	hotcpu_notifier(cpu_hotplug, 0);
+#endif
+
 	return 0;
 out_fail:
 	while (--cpu >= 0) {
 		dev = per_cpu(cpuidle_devices, cpu);
+		cpu_dev = get_cpu_device(cpu);
+		__pm_runtime_disable(cpu_dev, false);
 		cpuidle_unregister_device(dev);
 		kfree(dev);
 	}
-- 
2.1.4

