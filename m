From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/3] ARM: EXYNOS: remove non-working AFTR mode support
Date: Wed, 26 Jun 2013 12:13:45 +0200
Message-ID: <1372241627-22695-2-git-send-email-b.zolnierkie@samsung.com>
References: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:15082 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab3FZKOS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 06:14:18 -0400
In-reply-to: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kgene.kim@samsung.com
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, jc.lee@samsung.com, lorenzo.pieralisi@arm.com, amit.kachhap@linaro.org, t.figa@samsung.com, daniel.lezcano@linaro.org, rjw@sisk.pl, kyungmin.park@samsung.com, b.zolnierkie@samsung.com

AFTR mode support was introduced by commit 67173ca ("ARM: EXYNOS: Add
support AFTR mode on EXYNOS4210") in v3.4 kernel.  Unfortunately even
in v3.4 kernel it hasn't worked as supposed and this is still the case
with v3.10-rc6 (it probably wasn't noticed because CONFIG_CPU_IDLE is
not turned on by default):

- on revision 0 of Exynos4210 (Universal C210 board) it causes lockup
  (on this revision only one core is usable so entry to AFTR mode is
  always attempted because the code tries to go into AFTR mode when all
  other CPUs except CPU0 are offlined)

- on revision 1.1 of Exynos4210 (Trats board) it causes a lockup when
  CPU1 is offlined (i.e. echo 0 > /sys/devices/system/cpu/cpu1/online)

- on later Exynos4/5 SoCs wrong registers may be accessed when all CPUs
  except CPU0 are offlined resulting in panic/lockup (REG_DIRECTGO_ADDR
  and REG_DIRECTGO_FLAG register selections was implemented only for
  Exynos4210)

Just remove AFTR mode support for now.

Cc: Jaecheol Lee <jc.lee@samsung.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c | 131 +----------------------------------------
 1 file changed, 1 insertion(+), 130 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 17a18ff..0a657ac 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -17,30 +17,11 @@
 #include <linux/time.h>
 
 #include <asm/proc-fns.h>
-#include <asm/smp_scu.h>
-#include <asm/suspend.h>
-#include <asm/unified.h>
 #include <asm/cpuidle.h>
 #include <mach/regs-clock.h>
-#include <mach/regs-pmu.h>
-
-#include <plat/cpu.h>
 
 #include "common.h"
 
-#define REG_DIRECTGO_ADDR	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
-			S5P_INFORM7 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
-			(S5P_VA_SYSRAM + 0x24) : S5P_INFORM0))
-#define REG_DIRECTGO_FLAG	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
-			S5P_INFORM6 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
-			(S5P_VA_SYSRAM + 0x20) : S5P_INFORM1))
-
-#define S5P_CHECK_AFTR		0xFCBA0D10
-
-static int exynos4_enter_lowpower(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-				int index);
-
 static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
 
 static struct cpuidle_driver exynos4_idle_driver = {
@@ -48,117 +29,11 @@ static struct cpuidle_driver exynos4_idle_driver = {
 	.owner			= THIS_MODULE,
 	.states = {
 		[0] = ARM_CPUIDLE_WFI_STATE,
-		[1] = {
-			.enter			= exynos4_enter_lowpower,
-			.exit_latency		= 300,
-			.target_residency	= 100000,
-			.flags			= CPUIDLE_FLAG_TIME_VALID,
-			.name			= "C1",
-			.desc			= "ARM power down",
-		},
 	},
-	.state_count = 2,
+	.state_count = 1,
 	.safe_state_index = 0,
 };
 
-/* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
-static void exynos4_set_wakeupmask(void)
-{
-	__raw_writel(0x0000ff3e, S5P_WAKEUP_MASK);
-}
-
-static unsigned int g_pwr_ctrl, g_diag_reg;
-
-static void save_cpu_arch_register(void)
-{
-	/*read power control register*/
-	asm("mrc p15, 0, %0, c15, c0, 0" : "=r"(g_pwr_ctrl) : : "cc");
-	/*read diagnostic register*/
-	asm("mrc p15, 0, %0, c15, c0, 1" : "=r"(g_diag_reg) : : "cc");
-	return;
-}
-
-static void restore_cpu_arch_register(void)
-{
-	/*write power control register*/
-	asm("mcr p15, 0, %0, c15, c0, 0" : : "r"(g_pwr_ctrl) : "cc");
-	/*write diagnostic register*/
-	asm("mcr p15, 0, %0, c15, c0, 1" : : "r"(g_diag_reg) : "cc");
-	return;
-}
-
-static int idle_finisher(unsigned long flags)
-{
-	cpu_do_idle();
-	return 1;
-}
-
-static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-				int index)
-{
-	unsigned long tmp;
-
-	exynos4_set_wakeupmask();
-
-	/* Set value of power down register for aftr mode */
-	exynos_sys_powerdown_conf(SYS_AFTR);
-
-	__raw_writel(virt_to_phys(s3c_cpu_resume), REG_DIRECTGO_ADDR);
-	__raw_writel(S5P_CHECK_AFTR, REG_DIRECTGO_FLAG);
-
-	save_cpu_arch_register();
-
-	/* Setting Central Sequence Register for power down mode */
-	tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
-	tmp &= ~S5P_CENTRAL_LOWPWR_CFG;
-	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
-
-	cpu_pm_enter();
-	cpu_suspend(0, idle_finisher);
-
-#ifdef CONFIG_SMP
-	if (!soc_is_exynos5250())
-		scu_enable(S5P_VA_SCU);
-#endif
-	cpu_pm_exit();
-
-	restore_cpu_arch_register();
-
-	/*
-	 * If PMU failed while entering sleep mode, WFI will be
-	 * ignored by PMU and then exiting cpu_do_idle().
-	 * S5P_CENTRAL_LOWPWR_CFG bit will not be set automatically
-	 * in this situation.
-	 */
-	tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
-	if (!(tmp & S5P_CENTRAL_LOWPWR_CFG)) {
-		tmp |= S5P_CENTRAL_LOWPWR_CFG;
-		__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
-	}
-
-	/* Clear wakeup state register */
-	__raw_writel(0x0, S5P_WAKEUP_STAT);
-
-	return index;
-}
-
-static int exynos4_enter_lowpower(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-				int index)
-{
-	int new_index = index;
-
-	/* This mode only can be entered when other core's are offline */
-	if (num_online_cpus() > 1)
-		new_index = drv->safe_state_index;
-
-	if (new_index == 0)
-		return arm_cpuidle_simple_enter(dev, drv, new_index);
-	else
-		return exynos4_enter_core0_aftr(dev, drv, new_index);
-}
-
 static void __init exynos5_core_down_clk(void)
 {
 	unsigned int tmp;
@@ -209,10 +84,6 @@ static int __init exynos4_init_cpuidle(void)
 		device = &per_cpu(exynos4_cpuidle_device, cpu_id);
 		device->cpu = cpu_id;
 
-		/* Support IDLE only */
-		if (cpu_id != 0)
-			device->state_count = 1;
-
 		ret = cpuidle_register_device(device);
 		if (ret) {
 			printk(KERN_ERR "CPUidle register device failed\n");
-- 
1.8.2.3

