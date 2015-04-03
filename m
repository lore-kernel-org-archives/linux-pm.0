From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 5/6] ARM: Exynos: switch to using generic cpufreq driver for
 Exynos4210
Date: Fri, 03 Apr 2015 18:43:48 +0200
Message-ID: <1428079429-4252-6-git-send-email-b.zolnierkie@samsung.com>
References: <'@samsung.com>
 <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

From: Thomas Abraham <thomas.ab@samsung.com>

The new CPU clock type allows the use of generic CPUfreq driver.
Switch Exynos4210 to using generic cpufreq driver.

Changes by Bartlomiej:
- removed non-Exynos4210 support for now

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/exynos.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index bcde0dd..4e13de5 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -197,6 +197,25 @@ static void __init exynos_init_irq(void)
 	exynos_map_pmu();
 }
 
+static const struct of_device_id exynos_cpufreq_matches[] = {
+	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
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
 	/*
@@ -218,7 +237,7 @@ static void __init exynos_dt_machine_init(void)
 	    of_machine_is_compatible("samsung,exynos5250"))
 		platform_device_register(&exynos_cpuidle);
 
-	platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
+	exynos_cpufreq_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
-- 
1.7.9.5
