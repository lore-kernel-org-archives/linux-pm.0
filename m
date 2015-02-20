From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 5/5] cpuidle: exynos: add coupled cpuidle support for Exynos3250
Date: Fri, 20 Feb 2015 17:22:21 +0100
Message-ID: <1424449341-7782-6-git-send-email-b.zolnierkie@samsung.com>
References: <1424449341-7782-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1424449341-7782-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Colin Cross <ccross@google.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

The following patch adds coupled cpuidle support for Exynos3250 to
an existing cpuidle-exynos driver.  As a result it enables AFTR mode
to be used by default on Exynos3250 without the need to hot unplug
CPU1 first.

The detailed changelog:
- use exynos_[get,set]_boot_addr() in cpuidle-exynos.c and then make
  cpu_boot_reg_base() static
- use exynos_core_restart() in exynos_cpu0_enter_aftr()
- add missing smp_rmb() to exynos_cpu0_enter_aftr() (to make the code
  in-sync with the platform SMP code)
- add call_firmware_op(cpu_boot, 1) to exynos_cpu0_enter_aftr()
- use dsb_sev() instead of IPI wakeup for Exynos3250 in
  exynos_cpu0_enter_aftr()
- add CPU0 vs CPU1 synchronization based on S5P_PMU_SPARE2 register
  for Exynos3250 to cpuidle-exynos.c
- add flush_cache_all() for CPU1/0 before powerdown/AFTR for
  Exynos3250 to exynos_wfi_finisher()/exynos_do_idle()

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/common.h    |  4 +++-
 arch/arm/mach-exynos/exynos.c    |  3 ++-
 arch/arm/mach-exynos/firmware.c  |  1 +
 arch/arm/mach-exynos/platsmp.c   |  8 +++----
 arch/arm/mach-exynos/pm.c        | 51 +++++++++++++++++++++++++++++++++-------
 drivers/cpuidle/cpuidle-exynos.c |  3 ++-
 6 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 826367f..bc515f0 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -163,7 +163,9 @@ extern void exynos_set_delayed_reset_assertion(bool enable);
 
 extern void s5p_init_cpu(void __iomem *cpuid_addr);
 extern unsigned int samsung_rev(void);
-extern void __iomem *cpu_boot_reg_base(void);
+extern void exynos_core_restart(u32 core_id);
+extern int exynos_set_boot_addr(u32 core_id, unsigned long boot_addr);
+extern int exynos_get_boot_addr(u32 core_id, unsigned long *boot_addr);
 
 static inline void pmu_raw_writel(u32 val, u32 offset)
 {
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index c8996b3..c605826 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -264,7 +264,8 @@ static void __init exynos_dt_machine_init(void)
 		exynos_sysram_init();
 
 #ifdef CONFIG_ARM_EXYNOS_CPUIDLE
-	if (of_machine_is_compatible("samsung,exynos4210"))
+	if (of_machine_is_compatible("samsung,exynos4210") ||
+	    of_machine_is_compatible("samsung,exynos3250"))
 		exynos_cpuidle.dev.platform_data = &cpuidle_coupled_exynos_data;
 #endif
 	if (of_machine_is_compatible("samsung,exynos4210") ||
diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index 0f37d0b..d19b05c 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -48,6 +48,7 @@ static int exynos_do_idle(unsigned long mode)
 			     sysram_ns_base_addr + 0x24);
 		__raw_writel(EXYNOS_AFTR_MAGIC, sysram_ns_base_addr + 0x20);
 		if (soc_is_exynos3250()) {
+			flush_cache_all();
 			exynos_smc(SMC_CMD_SAVE, OP_TYPE_CORE,
 				   SMC_POWERSTATE_IDLE, 0);
 			exynos_smc(SMC_CMD_SHUTDOWN, OP_TYPE_CLUSTER,
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index c5c6700..a461be7 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -170,7 +170,7 @@ int exynos_cluster_power_state(int cluster)
 		S5P_CORE_LOCAL_PWR_EN);
 }
 
-void __iomem *cpu_boot_reg_base(void)
+static void __iomem *cpu_boot_reg_base(void)
 {
 	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
 		return pmu_base_addr + S5P_INFORM5;
@@ -196,7 +196,7 @@ static inline void __iomem *cpu_boot_reg(int cpu)
  *
  * Currently this is needed only when booting secondary CPU on Exynos3250.
  */
-static void exynos_core_restart(u32 core_id)
+void exynos_core_restart(u32 core_id)
 {
 	u32 val;
 
@@ -248,7 +248,7 @@ static void exynos_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-static int exynos_set_boot_addr(u32 core_id, unsigned long boot_addr)
+int exynos_set_boot_addr(u32 core_id, unsigned long boot_addr)
 {
 	int ret;
 
@@ -273,7 +273,7 @@ fail:
 	return ret;
 }
 
-static int exynos_get_boot_addr(u32 core_id, unsigned long *boot_addr)
+int exynos_get_boot_addr(u32 core_id, unsigned long *boot_addr)
 {
 	int ret;
 
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 0a7e3af..1b00146 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -22,6 +22,7 @@
 #include <asm/firmware.h>
 #include <asm/smp_scu.h>
 #include <asm/suspend.h>
+#include <asm/cacheflush.h>
 
 #include <mach/map.h>
 
@@ -208,6 +209,8 @@ static int exynos_cpu0_enter_aftr(void)
 		 * sequence, let's wait for one of these to happen
 		 */
 		while (exynos_cpu_power_state(1)) {
+			unsigned long boot_addr;
+
 			/*
 			 * The other cpu may skip idle and boot back
 			 * up again
@@ -220,7 +223,11 @@ static int exynos_cpu0_enter_aftr(void)
 			 * boot back up again, getting stuck in the
 			 * boot rom code
 			 */
-			if (__raw_readl(cpu_boot_reg_base()) == 0)
+			ret = exynos_get_boot_addr(1, &boot_addr);
+			if (ret)
+				goto fail;
+			ret = -1;
+			if (boot_addr == 0)
 				goto abort;
 
 			cpu_relax();
@@ -232,11 +239,14 @@ static int exynos_cpu0_enter_aftr(void)
 
 abort:
 	if (cpu_online(1)) {
+		unsigned long boot_addr = virt_to_phys(exynos_cpu_resume);
+
 		/*
 		 * Set the boot vector to something non-zero
 		 */
-		__raw_writel(virt_to_phys(exynos_cpu_resume),
-			     cpu_boot_reg_base());
+		ret = exynos_set_boot_addr(1, boot_addr);
+		if (ret)
+			goto fail;
 		dsb();
 
 		/*
@@ -246,22 +256,42 @@ abort:
 		while (exynos_cpu_power_state(1) != S5P_CORE_LOCAL_PWR_EN)
 			cpu_relax();
 
+		if (soc_is_exynos3250()) {
+			while (!pmu_raw_readl(S5P_PMU_SPARE2) &&
+			       !atomic_read(&cpu1_wakeup))
+				cpu_relax();
+
+			if (!atomic_read(&cpu1_wakeup))
+				exynos_core_restart(1);
+		}
+
 		while (!atomic_read(&cpu1_wakeup)) {
+			smp_rmb();
+
 			/*
 			 * Poke cpu1 out of the boot rom
 			 */
-			__raw_writel(virt_to_phys(exynos_cpu_resume),
-				     cpu_boot_reg_base());
 
-			arch_send_wakeup_ipi_mask(cpumask_of(1));
+			ret = exynos_set_boot_addr(1, boot_addr);
+			if (ret)
+				goto fail;
+
+			call_firmware_op(cpu_boot, 1);
+
+			if (soc_is_exynos3250())
+				dsb_sev();
+			else
+				arch_send_wakeup_ipi_mask(cpumask_of(1));
 		}
 	}
-
+fail:
 	return ret;
 }
 
 static int exynos_wfi_finisher(unsigned long flags)
 {
+	if (soc_is_exynos3250())
+		flush_cache_all();
 	cpu_do_idle();
 
 	return -1;
@@ -282,6 +312,9 @@ static int exynos_cpu1_powerdown(void)
 	 */
 	exynos_cpu_power_down(1);
 
+	if (soc_is_exynos3250())
+		pmu_raw_writel(0, S5P_PMU_SPARE2);
+
 	ret = cpu_suspend(0, exynos_wfi_finisher);
 
 	cpu_pm_exit();
@@ -298,7 +331,9 @@ cpu1_aborted:
 
 static void exynos_pre_enter_aftr(void)
 {
-	__raw_writel(virt_to_phys(exynos_cpu_resume), cpu_boot_reg_base());
+	unsigned long boot_addr = virt_to_phys(exynos_cpu_resume);
+
+	(void)exynos_set_boot_addr(1, boot_addr);
 }
 
 static void exynos_post_enter_aftr(void)
diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cpuidle-exynos.c
index 26f5f29..bbd7682 100644
--- a/drivers/cpuidle/cpuidle-exynos.c
+++ b/drivers/cpuidle/cpuidle-exynos.c
@@ -117,7 +117,8 @@ static int exynos_cpuidle_probe(struct platform_device *pdev)
 {
 	int ret;
 
-	if (of_machine_is_compatible("samsung,exynos4210")) {
+	if (of_machine_is_compatible("samsung,exynos4210") ||
+	    of_machine_is_compatible("samsung,exynos3250")) {
 		exynos_cpuidle_pdata = pdev->dev.platform_data;
 
 		ret = cpuidle_register(&exynos_coupled_idle_driver,
-- 
1.8.2.3
