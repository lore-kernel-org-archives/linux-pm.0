From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/2] cpufreq: dt-platdev: Drop few entries from whitelist
Date: Wed, 16 Aug 2017 11:07:28 +0530
Message-ID: <7182e308a552d37064f61e724c709667a6fa098d.1502861444.git.viresh.kumar@linaro.org>
References: <e93c74a19ebf6d7ee687ef8b71b3150a96527f7c.1502861444.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e93c74a19ebf6d7ee687ef8b71b3150a96527f7c.1502861444.git.viresh.kumar@linaro.org>
In-Reply-To: <e93c74a19ebf6d7ee687ef8b71b3150a96527f7c.1502861444.git.viresh.kumar@linaro.org>
References: <e93c74a19ebf6d7ee687ef8b71b3150a96527f7c.1502861444.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, geert@linux-m68k.org, maxime.ripard@free-electrons.com, wens@csie.org, xuwei5@hisilicon.com, kgene@kernel.org, krzk@kernel.org, yamada.masahiro@socionext.com, jun.nie@linaro.org, baoyou.xie@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Drop few ARM (32 and 64 bit) platforms from the whitelist which always
use "operating-points-v2" property from their DT. They should continue
to work after this patch.

Tested on Hikey platform (only the "hisilicon,hi6220" entry).

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 061b468512a2..45f2ec3b7f7a 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -27,7 +27,6 @@ static const struct of_device_id whitelist[] __initconst = {
 	{ .compatible = "allwinner,sun6i-a31s", },
 	{ .compatible = "allwinner,sun7i-a20", },
 	{ .compatible = "allwinner,sun8i-a23", },
-	{ .compatible = "allwinner,sun8i-a33", },
 	{ .compatible = "allwinner,sun8i-a83t", },
 	{ .compatible = "allwinner,sun8i-h3", },
 
@@ -37,7 +36,6 @@ static const struct of_device_id whitelist[] __initconst = {
 	{ .compatible = "arm,integrator-cp", },
 
 	{ .compatible = "hisilicon,hi3660", },
-	{ .compatible = "hisilicon,hi6220", },
 
 	{ .compatible = "fsl,imx27", },
 	{ .compatible = "fsl,imx51", },
@@ -51,11 +49,8 @@ static const struct of_device_id whitelist[] __initconst = {
 	{ .compatible = "samsung,exynos3250", },
 	{ .compatible = "samsung,exynos4210", },
 	{ .compatible = "samsung,exynos4212", },
-	{ .compatible = "samsung,exynos4412", },
 	{ .compatible = "samsung,exynos5250", },
 #ifndef CONFIG_BL_SWITCHER
-	{ .compatible = "samsung,exynos5420", },
-	{ .compatible = "samsung,exynos5433", },
 	{ .compatible = "samsung,exynos5800", },
 #endif
 
@@ -87,11 +82,7 @@ static const struct of_device_id whitelist[] __initconst = {
 	{ .compatible = "rockchip,rk3368", },
 	{ .compatible = "rockchip,rk3399", },
 
-	{ .compatible = "socionext,uniphier-pro5", },
-	{ .compatible = "socionext,uniphier-pxs2", },
 	{ .compatible = "socionext,uniphier-ld6b", },
-	{ .compatible = "socionext,uniphier-ld11", },
-	{ .compatible = "socionext,uniphier-ld20", },
 
 	{ .compatible = "ti,omap2", },
 	{ .compatible = "ti,omap3", },
@@ -101,8 +92,6 @@ static const struct of_device_id whitelist[] __initconst = {
 	{ .compatible = "xlnx,zynq-7000", },
 	{ .compatible = "xlnx,zynqmp", },
 
-	{ .compatible = "zte,zx296718", },
-
 	{ }
 };
 
-- 
2.7.4
