From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v4 4/6] ARM: Exynos: switch to using generic cpufreq driver for
 Exynos4x12
Date: Thu, 06 Aug 2015 15:41:52 +0200
Message-ID: <1438868514-8814-5-git-send-email-b.zolnierkie@samsung.com>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

The new CPU clock type allows the use of generic CPUfreq driver.
Switch Exynos4x12 to using generic cpufreq driver.

Previously (when exynos-cpufreq driver was used with boost
functionality) ARM_EXYNOS_CPU_FREQ_BOOST_SW config option
(which enabled boost functionality) selected EXYNOS_THERMAL
one.  After switching Exynos4x12 platforms to use cpufreq-dt
driver boost support is enabled in the cpufreq-dt driver
itself (because there are turbo OPPs defined in the board's
DTS file).  However we still would like to allow enabling
boost support only if thermal support is also enabled for
Exynos platforms.  To achieve this make ARCH_EXYNOS config
option select THERMAL and EXYNOS_THERMAL ones.

Please also note that the switch to use the generic cpufreq-dt
driver fixes the minor issue present with the old code (support
for 'boost' mode in the exynos-cpufreq driver was enabled for
all supported SoCs even though 'boost' frequency was provided
only for Exynos4x12 ones).

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/Kconfig  | 2 ++
 arch/arm/mach-exynos/exynos.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 4c4858c..143e332 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -25,6 +25,8 @@ menuconfig ARCH_EXYNOS
 	select S5P_DEV_MFC
 	select SRAM
 	select MFD_SYSCON
+	select THERMAL
+	select EXYNOS_THERMAL
 	help
 	  Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
 
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
-- 
1.9.1
