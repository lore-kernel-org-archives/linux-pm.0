From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 7/9] cpufreq: sunxi: Use generic platdev driver
Date: Fri, 22 Apr 2016 16:58:45 +0530
Message-ID: <5f0f49d36f37c83f0162064be4c49e78482b08c6.1461324267.git.viresh.kumar@linaro.org>
References: <cover.1461324267.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36828 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377AbcDVL3d (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 07:29:33 -0400
Received: by mail-pa0-f45.google.com with SMTP id er2so39083386pad.3
        for <linux-pm@vger.kernel.org>; Fri, 22 Apr 2016 04:29:33 -0700 (PDT)
In-Reply-To: <cover.1461324267.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461324267.git.viresh.kumar@linaro.org>
References: <cover.1461324267.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
device now, reuse that and remove similar code from platform code.

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-sunxi/sunxi.c          |  9 ---------
 drivers/cpufreq/cpufreq-dt-platdev.c | 12 ++++++++++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 3c156190a1d4..95dca8c2c9ed 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -17,11 +17,6 @@
 
 #include <asm/mach/arch.h>
 
-static void __init sunxi_dt_cpufreq_init(void)
-{
-	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
-}
-
 static const char * const sunxi_board_dt_compat[] = {
 	"allwinner,sun4i-a10",
 	"allwinner,sun5i-a10s",
@@ -32,7 +27,6 @@ static const char * const sunxi_board_dt_compat[] = {
 
 DT_MACHINE_START(SUNXI_DT, "Allwinner sun4i/sun5i Families")
 	.dt_compat	= sunxi_board_dt_compat,
-	.init_late	= sunxi_dt_cpufreq_init,
 MACHINE_END
 
 static const char * const sun6i_board_dt_compat[] = {
@@ -53,7 +47,6 @@ static void __init sun6i_timer_init(void)
 DT_MACHINE_START(SUN6I_DT, "Allwinner sun6i (A31) Family")
 	.init_time	= sun6i_timer_init,
 	.dt_compat	= sun6i_board_dt_compat,
-	.init_late	= sunxi_dt_cpufreq_init,
 MACHINE_END
 
 static const char * const sun7i_board_dt_compat[] = {
@@ -63,7 +56,6 @@ static const char * const sun7i_board_dt_compat[] = {
 
 DT_MACHINE_START(SUN7I_DT, "Allwinner sun7i (A20) Family")
 	.dt_compat	= sun7i_board_dt_compat,
-	.init_late	= sunxi_dt_cpufreq_init,
 MACHINE_END
 
 static const char * const sun8i_board_dt_compat[] = {
@@ -77,7 +69,6 @@ static const char * const sun8i_board_dt_compat[] = {
 DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i Family")
 	.init_time	= sun6i_timer_init,
 	.dt_compat	= sun8i_board_dt_compat,
-	.init_late	= sunxi_dt_cpufreq_init,
 MACHINE_END
 
 static const char * const sun9i_board_dt_compat[] = {
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 4b94fe3427f9..24dde5e256d4 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -12,6 +12,18 @@
 #include <linux/platform_device.h>
 
 static const struct of_device_id machines[] __initconst = {
+	{ .compatible = "allwinner,sun4i-a10", },
+	{ .compatible = "allwinner,sun5i-a10s", },
+	{ .compatible = "allwinner,sun5i-a13", },
+	{ .compatible = "allwinner,sun5i-r8", },
+	{ .compatible = "allwinner,sun6i-a31", },
+	{ .compatible = "allwinner,sun6i-a31s", },
+	{ .compatible = "allwinner,sun7i-a20", },
+	{ .compatible = "allwinner,sun8i-a23", },
+	{ .compatible = "allwinner,sun8i-a33", },
+	{ .compatible = "allwinner,sun8i-a83t", },
+	{ .compatible = "allwinner,sun8i-h3", },
+
 	{ .compatible = "fsl,imx27", },
 	{ .compatible = "fsl,imx51", },
 	{ .compatible = "fsl,imx53", },
-- 
2.7.1.410.g6faf27b

