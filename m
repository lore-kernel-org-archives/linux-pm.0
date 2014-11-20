From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/4] ARM: EXYNOS: add code for setting/clearing boot flag
Date: Thu, 20 Nov 2014 16:11:47 +0100
Message-ID: <1416496309-27602-3-git-send-email-b.zolnierkie@samsung.com>
References: <1416496309-27602-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1416496309-27602-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

This code is needed for cpuidle (W-)AFTR mode support on Exynos3250.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/common.h |  6 ++++++
 arch/arm/mach-exynos/exynos.c | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 431be1b..155f019 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -119,6 +119,12 @@ extern void __iomem *sysram_base_addr;
 extern void __iomem *pmu_base_addr;
 void exynos_sysram_init(void);
 
+/* CPU BOOT mode flag */
+#define C2_STATE	(1 << 3)
+
+void exynos_set_boot_flag(unsigned int cpu, unsigned int mode);
+void exynos_clear_boot_flag(unsigned int cpu, unsigned int mode);
+
 enum {
 	FW_DO_IDLE_SLEEP,
 	FW_DO_IDLE_AFTR,
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 8f638ad..847cd0a 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -148,6 +148,31 @@ static void __init exynos_init_late(void)
 	exynos_pm_init();
 }
 
+#define REG_CPU_STATE_ADDR	(sysram_ns_base_addr + 0x28)
+#define BOOT_MODE_MASK		0x1f
+
+void exynos_set_boot_flag(unsigned int cpu, unsigned int mode)
+{
+	unsigned int tmp;
+
+	tmp = __raw_readl(REG_CPU_STATE_ADDR + cpu * 4);
+
+	if (mode & BOOT_MODE_MASK)
+		tmp &= ~BOOT_MODE_MASK;
+
+	tmp |= mode;
+	__raw_writel(tmp, REG_CPU_STATE_ADDR + cpu * 4);
+}
+
+void exynos_clear_boot_flag(unsigned int cpu, unsigned int mode)
+{
+	unsigned int tmp;
+
+	tmp = __raw_readl(REG_CPU_STATE_ADDR + cpu * 4);
+	tmp &= ~mode;
+	__raw_writel(tmp, REG_CPU_STATE_ADDR + cpu * 4);
+}
+
 static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
 					int depth, void *data)
 {
-- 
1.8.2.3
