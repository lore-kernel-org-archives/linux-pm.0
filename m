From: keita kobayashi <keita.kobayashi.ym@renesas.com>
Subject: [PATCH 2/6] ARM: shmobile: APMU: Add CPUIdle function
Date: Fri, 1 Aug 2014 18:48:30 +0900
Message-ID: <53DB626E.7070101@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
Cc: horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, rjw@rjwysocki.net
List-Id: linux-pm@vger.kernel.org

This patch add support Core-Standby state for CPUIdle.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 arch/arm/mach-shmobile/common.h       |    1 +
 arch/arm/mach-shmobile/platsmp-apmu.c |   19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 9805608..adbb422 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -32,6 +32,7 @@ extern void shmobile_handle_irq_intc(struct pt_regs *);
 extern struct platform_suspend_ops shmobile_suspend_ops;
 struct cpuidle_driver;
 extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
+extern void shmobile_smp_apmu_enter_cpuidle(void);

 #ifdef CONFIG_SUSPEND
 int shmobile_suspend_init(void);
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index ad6a383..3bfb1a0 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -7,6 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 #include <linux/delay.h>
 #include <linux/init.h>
@@ -18,6 +19,7 @@
 #include <linux/threads.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
+#include <asm/cpuidle.h>
 #include <asm/proc-fns.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
@@ -148,7 +150,8 @@ int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
 }
 #endif

-#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_SUSPEND)
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_SUSPEND) || \
+defined(CONFIG_CPU_IDLE)
 /* nicked from arch/arm/mach-exynos/hotplug.c */
 static inline void cpu_enter_lowpower_a15(void)
 {
@@ -224,14 +227,16 @@ int shmobile_smp_apmu_cpu_kill(unsigned int cpu)
 }
 #endif

-#if defined(CONFIG_SUSPEND)
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_CPU_IDLE)
 static int shmobile_smp_apmu_do_suspend(unsigned long cpu)
 {
 	shmobile_smp_apmu_cpu_shutdown(cpu);
 	cpu_do_idle(); /* WFI selects Core Standby */
 	return 1;
 }
+#endif

+#if defined(CONFIG_SUSPEND)
 static int shmobile_smp_apmu_enter_suspend(suspend_state_t state)
 {
 	shmobile_smp_hook(smp_processor_id(), virt_to_phys(cpu_resume), 0);
@@ -245,3 +250,13 @@ void __init shmobile_smp_apmu_suspend_init(void)
 	shmobile_suspend_ops.enter = shmobile_smp_apmu_enter_suspend;
 }
 #endif
+
+#if defined(CONFIG_CPU_IDLE)
+void shmobile_smp_apmu_enter_cpuidle(void)
+{
+	cpu_pm_enter();
+	cpu_suspend(smp_processor_id(), shmobile_smp_apmu_do_suspend);
+	cpu_leave_lowpower();
+	cpu_pm_exit();
+}
+#endif
-- 
1.7.9.5
