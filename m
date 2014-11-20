From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/4] ARM: EXYNOS: fix CPU1 hotplug for AFTR mode on Exynos3250
Date: Thu, 20 Nov 2014 16:11:46 +0100
Message-ID: <1416496309-27602-2-git-send-email-b.zolnierkie@samsung.com>
References: <1416496309-27602-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1416496309-27602-1-git-send-email-b.zolnierkie@samsung.com>
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

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c  | 19 +++++++++++++++++--
 arch/arm/mach-exynos/regs-pmu.h |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 7a1ebfe..9f9d7cd 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -126,6 +126,8 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
  */
 void exynos_cpu_power_down(int cpu)
 {
+	u32 core_conf;
+
 	if (cpu == 0 && (of_machine_is_compatible("samsung,exynos5420") ||
 		of_machine_is_compatible("samsung,exynos5800"))) {
 		/*
@@ -138,7 +140,10 @@ void exynos_cpu_power_down(int cpu)
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
@@ -149,7 +154,12 @@ void exynos_cpu_power_down(int cpu)
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
 
@@ -227,6 +237,11 @@ static void exynos_core_restart(u32 core_id)
 	if (!of_machine_is_compatible("samsung,exynos3250"))
 		return;
 
+	/* 0x0908 is an undocumented register */
+	while (!pmu_raw_readl(0x0908))
+		udelay(10);
+	udelay(10);
+
 	val = pmu_raw_readl(EXYNOS_ARM_CORE_STATUS(core_id));
 	val |= S5P_CORE_WAKEUP_FROM_LOCAL_CFG;
 	pmu_raw_writel(val, EXYNOS_ARM_CORE_STATUS(core_id));
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index b5f4406..77defeb 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -180,6 +180,7 @@
 
 #define S5P_CORE_LOCAL_PWR_EN			0x3
 #define S5P_CORE_WAKEUP_FROM_LOCAL_CFG		(0x3 << 8)
+#define S5P_CORE_AUTOWAKEUP_EN			(1 << 31)
 
 /* Only for EXYNOS4210 */
 #define S5P_CMU_CLKSTOP_LCD1_LOWPWR	0x1154
-- 
1.8.2.3
