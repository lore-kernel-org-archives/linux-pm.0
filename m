From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH 2/2] ARM: EXYNOS: Support CPU hotplug for exynos5440
Date: Mon, 11 Mar 2013 16:27:02 +0530
Message-ID: <1362999422-24655-2-git-send-email-amit.daniel@samsung.com>
References: <1362999422-24655-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362999422-24655-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds support for CPU hotlpug for the 3 secondary cores
of the exynos5440 SOC. The command to hotplug out/in is,
echo 0 > /sys/devices/system/cpu/cpu[1-3]/online
echo 1 > /sys/devices/system/cpu/cpu[1-3]/online

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm/mach-exynos/hotplug.c |   14 +++++++++++---
 arch/arm/mach-exynos/platsmp.c |   26 +++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index c3f825b..fbee967 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -93,11 +93,19 @@ static inline void cpu_leave_lowpower(void)
 
 static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 {
+	unsigned int val;
 	for (;;) {
 
-		/* make cpu1 to be turned off at next WFI command */
-		if (cpu == 1)
-			__raw_writel(0, S5P_ARM_CORE1_CONFIGURATION);
+		/* make cpu to be turned off at next WFI command */
+		if (soc_is_exynos5440()) {
+			void __iomem *pmu_ctrl2_reg = S5P_VA_CHIPID + 0xc4;
+			val = __raw_readl(pmu_ctrl2_reg);
+			val |= (1 << (cpu + 8));
+			__raw_writel(val, pmu_ctrl2_reg);
+		} else {
+			if (cpu == 1)
+				__raw_writel(0, S5P_ARM_CORE1_CONFIGURATION);
+		}
 
 		/*
 		 * here's the WFI
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 087b73f..8a5eb80 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -101,6 +101,7 @@ static int __cpuinit exynos_boot_secondary(unsigned int cpu, struct task_struct
 {
 	unsigned long timeout;
 	unsigned long phys_cpu = cpu_logical_map(cpu);
+	unsigned int val;
 
 	/*
 	 * Set synchronisation state between this boot processor
@@ -119,7 +120,30 @@ static int __cpuinit exynos_boot_secondary(unsigned int cpu, struct task_struct
 	write_pen_release(phys_cpu);
 
 	timeout = 10;
-	if (!soc_is_exynos5440()) {
+	if (soc_is_exynos5440()) {
+		void __iomem *pmu_status_reg = S5P_VA_CHIPID + 0xbc;
+		void __iomem *pmu_ctrl_reg = S5P_VA_CHIPID + 0xc0;
+		void __iomem *pmu_ctrl2_reg = S5P_VA_CHIPID + 0xc4;
+
+		if (!(__raw_readl(pmu_status_reg) & (1 << cpu))) {
+			val = __raw_readl(pmu_ctrl_reg);
+			val |= (1 << cpu);
+			__raw_writel(val, pmu_ctrl_reg);
+			/* wait max 10 ms until cpu1 is on */
+			while (!(__raw_readl(pmu_status_reg) & (1 << cpu))) {
+				if (timeout-- == 0)
+					break;
+
+				mdelay(1);
+			}
+		}
+		/* clear the ctrl2 powerdown */
+		val = __raw_readl(pmu_ctrl2_reg);
+		if (val & (1 << (cpu + 8))) {
+			val &= ~(1 << (cpu + 8));
+			__raw_writel(val, pmu_ctrl2_reg);
+		}
+	} else {
 		if (!(__raw_readl(S5P_ARM_CORE1_STATUS) &
 					S5P_CORE_LOCAL_PWR_EN)) {
 
-- 
1.7.1
