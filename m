From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 07/14] ARM: cpuidle: Add runtime PM support for CPUs
Date: Fri, 29 Jul 2016 15:56:18 -0600
Message-ID: <1469829385-11511-8-git-send-email-lina.iyer@linaro.org>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

Notify runtime PM when the CPU is going to be powered off in the idle
state. This allows for runtime PM suspend/resume of the CPU as well as
its PM domain.

We do not call into runtime PM for ARM WFI to keep the default state
simple and faster.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/cpuidle/cpuidle-arm.c | 55 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index e342565e..3abd145 100644
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
@@ -46,12 +49,20 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 	ret = cpu_pm_enter();
 	if (!ret) {
 		/*
+		 * Call runtime PM suspend on our device
+		 * Notify RCU to pay attention to critical sections
+		 * called from within runtime PM.
+		 */
+		RCU_NONIDLE(pm_runtime_put_sync_suspend(cpu_dev));
+
+		/*
 		 * Pass idle state index to cpu_suspend which in turn will
 		 * call the CPU ops suspend protocol with idle index as a
 		 * parameter.
 		 */
 		ret = arm_cpuidle_suspend(idx);
 
+		RCU_NONIDLE(pm_runtime_get_sync(cpu_dev));
 		cpu_pm_exit();
 	}
 
@@ -84,6 +95,34 @@ static const struct of_device_id arm_idle_state_match[] __initconst = {
 	{ },
 };
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int arm_idle_cpu_hotplug(struct notifier_block *nb,
+			unsigned long action, void *data)
+{
+	struct device *cpu_dev = get_cpu_device(smp_processor_id());
+
+	/* Execute CPU runtime PM on that CPU */
+	switch (action & ~CPU_TASKS_FROZEN) {
+	case CPU_DYING:
+		pm_runtime_put_sync_suspend(cpu_dev);
+		break;
+	case CPU_STARTING:
+		pm_runtime_get_sync(cpu_dev);
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+#else
+static int arm_idle_cpu_hotplug(struct notifier_block *nb,
+			unsigned long action, void *data)
+{
+	return NOTIFY_OK;
+}
+#endif
+
 /*
  * arm_idle_init
  *
@@ -96,6 +135,7 @@ static int __init arm_idle_init(void)
 	int cpu, ret;
 	struct cpuidle_driver *drv = &arm_idle_driver;
 	struct cpuidle_device *dev;
+	struct device *cpu_dev;
 
 	/*
 	 * Initialize idle states data, starting at index 1.
@@ -118,6 +158,16 @@ static int __init arm_idle_init(void)
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
@@ -148,10 +198,15 @@ static int __init arm_idle_init(void)
 		}
 	}
 
+	/* Register for hotplug notifications for runtime PM */
+	hotcpu_notifier(arm_idle_cpu_hotplug, 0);
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
2.7.4
