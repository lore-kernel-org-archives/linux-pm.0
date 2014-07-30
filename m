From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq driver for
 Exynos4210/5250/5420
Date: Wed, 30 Jul 2014 13:37:41 +0530
Message-ID: <1406707663-16656-5-git-send-email-thomas.ab@samsung.com>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:38772 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbaG3IL6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jul 2014 04:11:58 -0400
In-reply-to: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, heiko@sntech.de, cw00.choi@samsung.com

The new CPU clock type allows the use of generic CPUfreq drivers. So for
Exynos4210/5250, switch to using generic cpufreq driver. For Exynos5420,
which did not have CPUfreq driver support, enable the use of generic
CPUfreq driver.

Suggested-by: Tomasz Figa <t.figa@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/exynos.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 493dbc2..e61bb36 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -281,6 +281,28 @@ static void __init exynos_init_irq(void)
 	exynos_map_pmu();
 }
 
+static const struct of_device_id exynos_cpufreq_matches[] = {
+	{ .compatible = "samsung,exynos5420", .data = "arm-bL-cpufreq-dt" },
+	{ .compatible = "samsung,exynos5250", .data = "cpufreq-cpu0" },
+	{ .compatible = "samsung,exynos4210", .data = "cpufreq-cpu0" },
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
@@ -320,7 +342,7 @@ static void __init exynos_dt_machine_init(void)
 			of_machine_is_compatible("samsung,exynos5250"))
 		platform_device_register(&exynos_cpuidle);
 
-	platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
+	exynos_cpufreq_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
-- 
1.7.9.5

