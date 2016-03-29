From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 3/3] cpufreq: exynos: Use generic platdev driver
Date: Tue, 29 Mar 2016 12:09:49 +0530
Message-ID: <81a8da75a0e7783e2b47f9e04297f167e8134afe.1459233524.git.viresh.kumar@linaro.org>
References: <cover.1459233524.git.viresh.kumar@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <cover.1459233524.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1459233524.git.viresh.kumar@linaro.org>
References: <cover.1459233524.git.viresh.kumar@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, xf@rock-chips.com, heiko@sntech.de, mmcclint@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
device now, reuse that and remove similar code from platform code.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/exynos.c        | 29 -----------------------------
 drivers/cpufreq/cpufreq-dt-platdev.c |  9 +++++++++
 2 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index bbf51a46f772..4d3b056fd786 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -213,33 +213,6 @@ static void __init exynos_init_irq(void)
 	exynos_map_pmu();
 }
 
-static const struct of_device_id exynos_cpufreq_matches[] = {
-	{ .compatible = "samsung,exynos3250", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos4212", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos4412", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
-#ifndef CONFIG_BL_SWITCHER
-	{ .compatible = "samsung,exynos5420", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos5800", .data = "cpufreq-dt" },
-#endif
-	{ /* sentinel */ }
-};
-
-static void __init exynos_cpufreq_init(void)
-{
-	struct device_node *root = of_find_node_by_path("/");
-	const struct of_device_id *match;
-
-	match = of_match_node(exynos_cpufreq_matches, root);
-	if (!match) {
-		platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
-		return;
-	}
-
-	platform_device_register_simple(match->data, -1, NULL, 0);
-}
-
 static void __init exynos_dt_machine_init(void)
 {
 	/*
@@ -262,8 +235,6 @@ static void __init exynos_dt_machine_init(void)
 	    of_machine_is_compatible("samsung,exynos5250"))
 		platform_device_register(&exynos_cpuidle);
 
-	exynos_cpufreq_init();
-
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 18b81724ca0b..c5a70b683c7c 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -20,6 +20,15 @@ struct cpufreq_dt_compat {
 };
 
 static struct cpufreq_dt_compat compat[] = {
+	{ "samsung,exynos3250",		NULL,		0 },
+	{ "samsung,exynos4210",		NULL,		0 },
+	{ "samsung,exynos4212",		NULL,		0 },
+	{ "samsung,exynos4412",		NULL,		0 },
+	{ "samsung,exynos5250",		NULL,		0 },
+#ifndef CONFIG_BL_SWITCHER
+	{ "samsung,exynos5420",		NULL,		0 },
+	{ "samsung,exynos5800",		NULL,		0 },
+#endif
 };
 
 static int __init cpufreq_dt_platdev_init(void)
-- 
2.7.1.410.g6faf27b
