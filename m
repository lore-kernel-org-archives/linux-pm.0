From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3 3/5] ARM: Exynos: switch to using generic cpufreq driver for
 Exynos4x12
Date: Fri, 31 Jul 2015 20:49:15 +0200
Message-ID: <1438368557-2352-4-git-send-email-b.zolnierkie@samsung.com>
References: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

The new CPU clock type allows the use of generic CPUfreq driver.
Switch Exynos4x12 to using generic cpufreq driver.

Also make CPUFREQ_DT config option select Exynos thermal driver
if Exynos platform support is enabled.

Please also note that the switch to use the generic cpufreq-dt
driver fixes the minor issue present with the old code (support
for 'boost' mode in the exynos-cpufreq driver was enabled for
all supported SoCs even though 'boost' frequency was provided
only for Exynos4x12 ones).

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/exynos.c | 2 ++
 drivers/cpufreq/Kconfig       | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 77ac021..1c47aee 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -227,6 +227,8 @@ static void __init exynos_init_irq(void)
 static const struct of_device_id exynos_cpufreq_matches[] = {
 	{ .compatible = "samsung,exynos3250", .data = "cpufreq-dt" },
 	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
+	{ .compatible = "samsung,exynos4212", .data = "cpufreq-dt" },
+	{ .compatible = "samsung,exynos4412", .data = "cpufreq-dt" },
 	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
 	{ /* sentinel */ }
 };
diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 659879a..bf6d596 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -191,6 +191,7 @@ config CPUFREQ_DT
 	# if CPU_THERMAL is on and THERMAL=m, CPUFREQ_DT cannot be =y:
 	depends on !CPU_THERMAL || THERMAL
 	select PM_OPP
+	select EXYNOS_THERMAL if ARCH_EXYNOS
 	help
 	  This adds a generic DT based cpufreq driver for frequency management.
 	  It supports both uniprocessor (UP) and symmetric multiprocessor (SMP)
-- 
1.9.1
