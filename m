From: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Subject: [RFC/PATCH 3/6] ARM: shmobile: APMU: Add Core-Standby function for CPUIdle
Date: Wed, 4 Mar 2015 13:55:43 +0900
Message-ID: <1425444946-3084-4-git-send-email-keita.kobayashi.ym@renesas.com>
References: <1425444946-3084-1-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:29788 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752665AbbCDE4N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2015 23:56:13 -0500
In-Reply-To: <1425444946-3084-1-git-send-email-keita.kobayashi.ym@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: horms@verge.net.au, rjw@rjwysocki.net
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com, Keita Kobayashi <keita.kobayashi.ym@renesas.com>

This patch add CPUIdle process in platsmp-apmu code.
The shmobile_smp_apmu_enter_cpuidle function will be
used by R-Car SoC series.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 arch/arm/mach-shmobile/common.h       |  4 ++++
 arch/arm/mach-shmobile/platsmp-apmu.c | 20 ++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 4adecd4..ea34893 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -24,6 +24,7 @@ extern int shmobile_smp_scu_cpu_kill(unsigned int cpu);
 struct clk;
 extern int shmobile_clk_init(void);
 extern struct platform_suspend_ops shmobile_suspend_ops;
+struct cpuidle_device;
 struct cpuidle_driver;
 
 #ifdef CONFIG_SUSPEND
@@ -37,6 +38,9 @@ static inline void shmobile_smp_apmu_suspend_init(void) { }
 #ifdef CONFIG_CPU_IDLE
 int shmobile_cpuidle_init(void);
 extern void shmobile_cpuidle_set_driver(struct renesas_cpuidle *drv);
+extern int shmobile_smp_apmu_enter_cpuidle(struct cpuidle_device *dev,
+					   struct cpuidle_driver *drv,
+					   int index);
 #else
 static inline int shmobile_cpuidle_init(void) { return 0; }
 #endif
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index f483b56..f5c8044 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -139,7 +139,8 @@ int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
 }
 #endif
 
-#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_SUSPEND)
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_SUSPEND) || \
+defined(CONFIG_ARM_RENESAS_CPUIDLE)
 /* nicked from arch/arm/mach-exynos/hotplug.c */
 static inline void cpu_enter_lowpower_a15(void)
 {
@@ -215,7 +216,7 @@ int shmobile_smp_apmu_cpu_kill(unsigned int cpu)
 }
 #endif
 
-#if defined(CONFIG_SUSPEND)
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_ARM_RENESAS_CPUIDLE)
 static int shmobile_smp_apmu_do_suspend(unsigned long cpu)
 {
 	shmobile_smp_hook(cpu, virt_to_phys(cpu_resume), 0);
@@ -223,7 +224,9 @@ static int shmobile_smp_apmu_do_suspend(unsigned long cpu)
 	cpu_do_idle(); /* WFI selects Core Standby */
 	return 1;
 }
+#endif
 
+#if defined(CONFIG_SUSPEND)
 static int shmobile_smp_apmu_enter_suspend(suspend_state_t state)
 {
 	cpu_suspend(smp_processor_id(), shmobile_smp_apmu_do_suspend);
@@ -236,3 +239,16 @@ void __init shmobile_smp_apmu_suspend_init(void)
 	shmobile_suspend_ops.enter = shmobile_smp_apmu_enter_suspend;
 }
 #endif
+
+#if defined(CONFIG_ARM_RENESAS_CPUIDLE)
+int shmobile_smp_apmu_enter_cpuidle(struct cpuidle_device *dev,
+				    struct cpuidle_driver *drv, int index)
+{
+	cpu_pm_enter();
+	cpu_suspend(smp_processor_id(), shmobile_smp_apmu_do_suspend);
+	cpu_leave_lowpower();
+	cpu_pm_exit();
+
+	return index;
+}
+#endif
-- 
1.9.1

