From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 6/7] ARM: Exynos: switch to using generic cpufreq driver for
 Exynos4x12
Date: Thu, 09 Jul 2015 17:43:40 +0200
Message-ID: <1436456621-29839-7-git-send-email-b.zolnierkie@samsung.com>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Kevin Hilman <khilman@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, b.zolnierkie@samsung.com, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier@dowhile0.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

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
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/exynos.c    | 14 ++++++++++++++
 drivers/cpufreq/Kconfig.arm      |  2 +-
 drivers/cpufreq/exynos-cpufreq.c |  3 ---
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 4015ec3..0c74e90 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/irqchip.h>
+#include <linux/cpufreq-dt.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -224,6 +225,12 @@ static void __init exynos_init_irq(void)
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
 	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
@@ -235,6 +242,13 @@ static void __init exynos_cpufreq_init(void)
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
index 9ab6388c1..5f5a15a 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -49,7 +49,7 @@ config ARM_EXYNOS4X12_CPUFREQ
 
 config ARM_EXYNOS_CPU_FREQ_BOOST_SW
 	bool "EXYNOS Frequency Overclocking - Software"
-	depends on ARM_EXYNOS_CPUFREQ && THERMAL
+	depends on CPUFREQ_DT && THERMAL
 	select CPU_FREQ_BOOST_SW
 	select EXYNOS_THERMAL
 	help
diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 71d8891..89d252e 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -150,9 +150,6 @@ static struct cpufreq_driver exynos_driver = {
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
1.9.1
