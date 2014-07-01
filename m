From: Chander Kashyap <k.chander@samsung.com>
Subject: [PATCH 1/2] ARM: Exynos: remove arm diagnostic and power register save/restore code
Date: Tue,  1 Jul 2014 20:02:37 +0530
Message-ID: <1404225158-8453-2-git-send-email-k.chander@samsung.com>
References: <1404225158-8453-1-git-send-email-k.chander@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1404225158-8453-1-git-send-email-k.chander@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: daniel.lezcano@linaro.org, kgene.kim@samsung.com, linux-pm@vger.kernel.org, Chander Kashyap <k.chander@samsung.com>
List-Id: linux-pm@vger.kernel.org

As save/restore of arm "diagnostic" and "power" registers is handled by
generic code, so remove the same.

Signed-off-by: Chander Kashyap <k.chander@samsung.com>
---
 arch/arm/mach-exynos/pm.c |   54 ++-------------------------------------------
 1 file changed, 2 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 202ca73..a092cc3 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -196,45 +196,6 @@ void exynos_enter_aftr(void)
 	exynos_sys_powerdown_conf(SYS_AFTR);
 }
 
-/* For Cortex-A9 Diagnostic and Power control register */
-static unsigned int save_arm_register[2];
-
-static void exynos_cpu_save_register(void)
-{
-	unsigned long tmp;
-
-	/* Save Power control register */
-	asm ("mrc p15, 0, %0, c15, c0, 0"
-	     : "=r" (tmp) : : "cc");
-
-	save_arm_register[0] = tmp;
-
-	/* Save Diagnostic register */
-	asm ("mrc p15, 0, %0, c15, c0, 1"
-	     : "=r" (tmp) : : "cc");
-
-	save_arm_register[1] = tmp;
-}
-
-static void exynos_cpu_restore_register(void)
-{
-	unsigned long tmp;
-
-	/* Restore Power control register */
-	tmp = save_arm_register[0];
-
-	asm volatile ("mcr p15, 0, %0, c15, c0, 0"
-		      : : "r" (tmp)
-		      : "cc");
-
-	/* Restore Diagnostic register */
-	tmp = save_arm_register[1];
-
-	asm volatile ("mcr p15, 0, %0, c15, c0, 1"
-		      : : "r" (tmp)
-		      : "cc");
-}
-
 static int exynos_cpu_suspend(unsigned long arg)
 {
 #ifdef CONFIG_CACHE_L2X0
@@ -300,9 +261,6 @@ static int exynos_pm_suspend(void)
 	tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
 	__raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
 
-	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
-		exynos_cpu_save_register();
-
 	return 0;
 }
 
@@ -334,9 +292,6 @@ static void exynos_pm_resume(void)
 	if (exynos_pm_central_resume())
 		goto early_wakeup;
 
-	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
-		exynos_cpu_restore_register();
-
 	/* For release retention */
 
 	__raw_writel((1 << 28), S5P_PAD_RET_MAUDIO_OPTION);
@@ -438,20 +393,15 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
 
 	switch (cmd) {
 	case CPU_PM_ENTER:
-		if (cpu == 0) {
+		if (cpu == 0)
 			exynos_pm_central_suspend();
-			if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
-				exynos_cpu_save_register();
-		}
 		break;
 
 	case CPU_PM_EXIT:
 		if (cpu == 0) {
 			if (read_cpuid_part_number() ==
-					ARM_CPU_PART_CORTEX_A9) {
+					ARM_CPU_PART_CORTEX_A9)
 				scu_enable(S5P_VA_SCU);
-				exynos_cpu_restore_register();
-			}
 			exynos_pm_central_resume();
 		}
 		break;
-- 
1.7.9.5
