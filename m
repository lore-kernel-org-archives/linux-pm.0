From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH v12 4/6] ARM: Exynos: switch to using generic cpufreq driver
 for Exynos4210/5250/5420
Date: Fri, 21 Nov 2014 19:01:20 +0530
Message-ID: <1416576682-5255-5-git-send-email-thomas.ab@samsung.com>
References: <1416576682-5255-1-git-send-email-thomas.ab@samsung.com>
 <1416576682-5255-2-git-send-email-thomas.ab@samsung.com>
 <1416576682-5255-3-git-send-email-thomas.ab@samsung.com>
 <1416576682-5255-4-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1416576682-5255-4-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, tomasz.figa@gmail.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, heiko@sntech.de, cw00.choi@samsung.com, khilman@linaro.org
List-Id: linux-pm@vger.kernel.org

The new CPU clock type allows the use of generic CPUfreq drivers. So for
Exynos4210/5250, switch to using generic cpufreq driver. For Exynos5420,
which did not have CPUfreq driver support, enable the use of generic
CPUfreq driver.

Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Chander Kashyap <k.chander@samsung.com>
---
 arch/arm/mach-exynos/exynos.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 6b283eb..402a2ae 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -282,6 +282,30 @@ static void __init exynos_init_irq(void)
 	exynos_map_pmu();
 }
 
+static const struct of_device_id exynos_cpufreq_matches[] = {
+	{ .compatible = "samsung,exynos5420", .data = "arm-bL-cpufreq-dt" },
+	{ .compatible = "samsung,exynos5422", .data = "arm-bL-cpufreq-dt" },
+	{ .compatible = "samsung,exynos5800", .data = "arm-bL-cpufreq-dt" },
+	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
+	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
+	{ .compatible = "samsung,exynos5440", .data = "exynos5440-cpufreq" },
+	{ /* sentinel */ }
+};
+
+static void __init exynos_cpufreq_init(void)
+{
+	struct device_node *root = of_find_node_by_path("/");
+	const struct of_device_id *match;
+
+	match = of_match_node(exynos_cpufreq_matches, root);
+	if (!match) {
+		platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
+		return;
+	}
+
+	platform_device_register_simple(match->data, -1, NULL, 0);
+}
+
 static void __init exynos_dt_machine_init(void)
 {
 	struct device_node *i2c_np;
@@ -321,7 +345,7 @@ static void __init exynos_dt_machine_init(void)
 			of_machine_is_compatible("samsung,exynos5250"))
 		platform_device_register(&exynos_cpuidle);
 
-	platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
+	exynos_cpufreq_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
-- 
1.6.6.rc2
