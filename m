From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v4 2/4] ARM: EXYNOS: add code for setting/clearing boot flag
Date: Wed, 18 Mar 2015 17:00:51 +0100
Message-ID: <1426694453-3242-3-git-send-email-b.zolnierkie@samsung.com>
References: <1426694453-3242-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1426694453-3242-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

This code is needed for cpuidle (W-)AFTR mode support on Exynos3250.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/common.h   |  6 ++++++
 arch/arm/mach-exynos/firmware.c | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index f70eca7..acd5b56 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -126,6 +126,12 @@ enum {
 
 void exynos_firmware_init(void);
 
+/* CPU BOOT mode flag for Exynos3250 SoC bootloader */
+#define C2_STATE	(1 << 3)
+
+void exynos_set_boot_flag(unsigned int cpu, unsigned int mode);
+void exynos_clear_boot_flag(unsigned int cpu, unsigned int mode);
+
 extern u32 exynos_get_eint_wake_mask(void);
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index 4791a3c..27b8ae3 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -206,3 +206,28 @@ void __init exynos_firmware_init(void)
 		outer_cache.configure = exynos_l2_configure;
 	}
 }
+
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
-- 
1.8.2.3
