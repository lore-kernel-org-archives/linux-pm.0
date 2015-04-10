From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 5/6] ARM: Exynos: switch to using generic cpufreq driver for
 Exynos4x12
Date: Fri, 10 Apr 2015 19:59:01 +0200
Message-ID: <1428688742-15578-6-git-send-email-b.zolnierkie@samsung.com>
References: <1428688742-15578-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:19937 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756566AbbDJSAO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2015 14:00:14 -0400
In-reply-to: <1428688742-15578-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

The new CPU clock type allows the use of generic CPUfreq driver.
Switch Exynos4x12 to using generic cpufreq driver.

This patch also takes care of making ARM_EXYNOS_CPU_FREQ_BOOST_SW
config option depend on cpufreq-dt driver instead of exynos-cpufreq
one and fixes the minor issue present with the old code (support
for 'boost' mode in the exynos-cpufreq driver was enabled for all
supported SoCs even though 'boost' frequency was provided only for
Exynos4x12 ones).

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/exynos.c    |   14 ++++++++++++++
 drivers/cpufreq/Kconfig.arm      |    2 +-
 drivers/cpufreq/exynos-cpufreq.c |    3 ---
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 4e13de5..637d862 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/irqchip.h>
+#include <linux/cpufreq-dt.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -197,6 +198,12 @@ static void __init exynos_init_irq(void)
 	exynos_map_pmu();
 }
 
+struct cpufreq_dt_platform_data cpufreq_dt_pd = {
+#ifdef CONFIG_ARM_EXYNOS_CPU_FREQ_BOOST_SW
+	.boost_supported = true,
+#endif
+};
+
 static const struct of_device_id exynos_cpufreq_matches[] = {
 	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
 	{ /* sentinel */ }
@@ -207,6 +214,13 @@ static void __init exynos_cpufreq_init(void)
 	struct device_node *root = of_find_node_by_path("/");
 	const struct of_device_id *match;
 
+	if (of_machine_is_compatible("samsung,exynos4212") ||
+	    of_machine_is_compatible("samsung,exynos4412")) {
+		platform_device_register_data(NULL, "cpufreq-dt", -1,
+					&cpufreq_dt_pd, sizeof(cpufreq_dt_pd));
+		return;
+	}
+
 	match = of_match_node(exynos_cpufreq_matches, root);
 	if (!match) {
 		platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 1d7ddc5..78cb0b9 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -60,7 +60,7 @@ config ARM_EXYNOS5250_CPUFREQ
 
 config ARM_EXYNOS_CPU_FREQ_BOOST_SW
 	bool "EXYNOS Frequency Overclocking - Software"
-	depends on ARM_EXYNOS_CPUFREQ && THERMAL
+	depends on CPUFREQ_DT && THERMAL
 	select CPU_FREQ_BOOST_SW
 	select EXYNOS_THERMAL
 	help
diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 2d78f63..e48d4f1 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -125,9 +125,6 @@ static struct cpufreq_driver exynos_driver = {
 	.init		= exynos_cpufreq_cpu_init,
 	.name		= "exynos_cpufreq",
 	.attr		= cpufreq_generic_attr,
-#ifdef CONFIG_ARM_EXYNOS_CPU_FREQ_BOOST_SW
-	.boost_supported = true,
-#endif
 #ifdef CONFIG_PM
 	.suspend	= cpufreq_generic_suspend,
 #endif
-- 
1.7.9.5

