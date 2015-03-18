From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v4 1/4] ARM: EXYNOS: fix CPU1 hotplug on Exynos3250
Date: Wed, 18 Mar 2015 17:00:50 +0100
Message-ID: <1426694453-3242-2-git-send-email-b.zolnierkie@samsung.com>
References: <1426694453-3242-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1426694453-3242-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

CPU1 hotplug may hang when AFTR is used.  Fix it by:
- setting AUTOWAKEUP_EN bit in ARM_COREx_CONFIGURATION register in
  exynos_cpu_power_up()
- not clearing reserved bits of ARM_COREx_CONFIGURATION register in
  exynos_cpu_power_down()
- waiting while an undocumented register 0x0908 becomes non-zero in
  exynos_core_restart()
- using dsb_sev() instead of IPI in exynos_boot_secondary() on
  Exynos3250

This patch also fixes hotplug issues during resume from S2R:
$ echo mem > /sys/power/state
[  156.517266] Disabling non-boot CPUs ...
[  156.517781] IRQ18 no longer affine to CPU1
[  156.518043] CPU1: shutdown
[  156.544718] Enabling non-boot CPUs ...
[  156.554925] CPU1: Software reset
[  158.552631] CPU1: failed to come online
[  158.552753] Error taking CPU1 up: -5

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c  | 23 ++++++++++++++++++++---
 arch/arm/mach-exynos/regs-pmu.h |  2 ++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index d2e9f12..ebd135b 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -126,6 +126,8 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
  */
 void exynos_cpu_power_down(int cpu)
 {
+	u32 core_conf;
+
 	if (cpu == 0 && (soc_is_exynos5420() || soc_is_exynos5800())) {
 		/*
 		 * Bypass power down for CPU0 during suspend. Check for
@@ -137,7 +139,10 @@ void exynos_cpu_power_down(int cpu)
 		if (!(val & S5P_CORE_LOCAL_PWR_EN))
 			return;
 	}
-	pmu_raw_writel(0, EXYNOS_ARM_CORE_CONFIGURATION(cpu));
+
+	core_conf = pmu_raw_readl(EXYNOS_ARM_CORE_CONFIGURATION(cpu));
+	core_conf &= ~S5P_CORE_LOCAL_PWR_EN;
+	pmu_raw_writel(core_conf, EXYNOS_ARM_CORE_CONFIGURATION(cpu));
 }
 
 /**
@@ -148,7 +153,12 @@ void exynos_cpu_power_down(int cpu)
  */
 void exynos_cpu_power_up(int cpu)
 {
-	pmu_raw_writel(S5P_CORE_LOCAL_PWR_EN,
+	u32 core_conf = S5P_CORE_LOCAL_PWR_EN;
+
+	if (soc_is_exynos3250())
+		core_conf |= S5P_CORE_AUTOWAKEUP_EN;
+
+	pmu_raw_writel(core_conf,
 			EXYNOS_ARM_CORE_CONFIGURATION(cpu));
 }
 
@@ -226,6 +236,10 @@ static void exynos_core_restart(u32 core_id)
 	if (!of_machine_is_compatible("samsung,exynos3250"))
 		return;
 
+	while (!pmu_raw_readl(S5P_PMU_SPARE2))
+		udelay(10);
+	udelay(10);
+
 	val = pmu_raw_readl(EXYNOS_ARM_CORE_STATUS(core_id));
 	val |= S5P_CORE_WAKEUP_FROM_LOCAL_CFG;
 	pmu_raw_writel(val, EXYNOS_ARM_CORE_STATUS(core_id));
@@ -346,7 +360,10 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 		call_firmware_op(cpu_boot, core_id);
 
-		arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+		if (soc_is_exynos3250())
+			dsb_sev();
+		else
+			arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 
 		if (pen_release == -1)
 			break;
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index eb461e1..84ddce1 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -49,6 +49,7 @@
 #define S5P_INFORM5				0x0814
 #define S5P_INFORM6				0x0818
 #define S5P_INFORM7				0x081C
+#define S5P_PMU_SPARE2				0x0908
 #define S5P_PMU_SPARE3				0x090C
 
 #define EXYNOS_IROM_DATA2			0x0988
@@ -182,6 +183,7 @@
 
 #define S5P_CORE_LOCAL_PWR_EN			0x3
 #define S5P_CORE_WAKEUP_FROM_LOCAL_CFG		(0x3 << 8)
+#define S5P_CORE_AUTOWAKEUP_EN			(1 << 31)
 
 /* Only for EXYNOS4210 */
 #define S5P_CMU_CLKSTOP_LCD1_LOWPWR	0x1154
-- 
1.8.2.3
