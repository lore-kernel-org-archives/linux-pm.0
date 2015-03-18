From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 4/5] ARM: EXYNOS: add exynos_get_boot_addr() helper
Date: Wed, 18 Mar 2015 14:09:56 +0100
Message-ID: <1426684197-22281-5-git-send-email-b.zolnierkie@samsung.com>
References: <1426684197-22281-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1426684197-22281-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Colin Cross <ccross@google.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

Add get_cpu_boot_addr() firmware operation and then
exynos_get_boot_addr() helper.

This is a preparation for adding coupled cpuidle support
for Exynos3250 SoC.

There should be no functional changes caused by this patch.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/include/asm/firmware.h |  4 ++++
 arch/arm/mach-exynos/firmware.c | 17 +++++++++++++++++
 arch/arm/mach-exynos/platsmp.c  | 25 +++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/arch/arm/include/asm/firmware.h b/arch/arm/include/asm/firmware.h
index 89aefe1..34c1d96 100644
--- a/arch/arm/include/asm/firmware.h
+++ b/arch/arm/include/asm/firmware.h
@@ -34,6 +34,10 @@ struct firmware_ops {
 	 */
 	int (*set_cpu_boot_addr)(int cpu, unsigned long boot_addr);
 	/*
+	 * Gets boot address of specified physical CPU
+	 */
+	int (*get_cpu_boot_addr)(int cpu, unsigned long *boot_addr);
+	/*
 	 * Boots specified physical CPU
 	 */
 	int (*cpu_boot)(int cpu);
diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index f236877..c9e4481 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -104,6 +104,22 @@ static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
 	return 0;
 }
 
+static int exynos_get_cpu_boot_addr(int cpu, unsigned long *boot_addr)
+{
+	void __iomem *boot_reg;
+
+	if (!sysram_ns_base_addr)
+		return -ENODEV;
+
+	boot_reg = sysram_ns_base_addr + 0x1c;
+
+	if (soc_is_exynos4412())
+		boot_reg += 4 * cpu;
+
+	*boot_addr = __raw_readl(boot_reg);
+	return 0;
+}
+
 static int exynos_cpu_suspend(unsigned long arg)
 {
 	flush_cache_all();
@@ -138,6 +154,7 @@ static int exynos_resume(void)
 static const struct firmware_ops exynos_firmware_ops = {
 	.do_idle		= IS_ENABLED(CONFIG_EXYNOS_CPU_SUSPEND) ? exynos_do_idle : NULL,
 	.set_cpu_boot_addr	= exynos_set_cpu_boot_addr,
+	.get_cpu_boot_addr	= exynos_get_cpu_boot_addr,
 	.cpu_boot		= exynos_cpu_boot,
 	.suspend		= IS_ENABLED(CONFIG_PM_SLEEP) ? exynos_suspend : NULL,
 	.resume			= IS_ENABLED(CONFIG_EXYNOS_CPU_SUSPEND) ? exynos_resume : NULL,
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index b7cfcdc..449edd1 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -272,6 +272,31 @@ fail:
 	return ret;
 }
 
+static int exynos_get_boot_addr(u32 core_id, unsigned long *boot_addr)
+{
+	int ret;
+
+	/*
+	 * Try to get boot address using firmware first
+	 * and fall back to boot register if it fails.
+	 */
+	ret = call_firmware_op(get_cpu_boot_addr, core_id, boot_addr);
+	if (ret && ret != -ENOSYS)
+		goto fail;
+	if (ret == -ENOSYS) {
+		void __iomem *boot_reg = cpu_boot_reg(core_id);
+
+		if (IS_ERR(boot_reg)) {
+			ret = PTR_ERR(boot_reg);
+			goto fail;
+		}
+		*boot_addr = __raw_readl(boot_reg);
+		ret = 0;
+	}
+fail:
+	return ret;
+}
+
 static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
-- 
1.8.2.3
