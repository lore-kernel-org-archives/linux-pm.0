From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 3/9] cpufreq: imx: Use generic platdev driver
Date: Fri, 22 Apr 2016 16:58:41 +0530
Message-ID: <8f9d83e29dc104584bb95bc0010c96721fecd176.1461324267.git.viresh.kumar@linaro.org>
References: <cover.1461324267.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34994 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbcDVL3U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 07:29:20 -0400
Received: by mail-pf0-f170.google.com with SMTP id n1so40711576pfn.2
        for <linux-pm@vger.kernel.org>; Fri, 22 Apr 2016 04:29:20 -0700 (PDT)
In-Reply-To: <cover.1461324267.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461324267.git.viresh.kumar@linaro.org>
References: <cover.1461324267.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, Lucas Stach <l.stach@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
device now, reuse that and remove similar code from platform code.

Note that the complete routine imx27_dt_init() is removed as

of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);

has same effect as a NULL .init_machine machine callback pointer.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/imx27-dt.c         | 10 ----------
 arch/arm/mach-imx/mach-imx51.c       |  3 ---
 arch/arm/mach-imx/mach-imx53.c       |  2 --
 arch/arm/mach-imx/mach-imx7d.c       |  6 ------
 drivers/cpufreq/cpufreq-dt-platdev.c |  5 +++++
 5 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index bd42d1bd10af..530a728c2acc 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -18,15 +18,6 @@
 #include "common.h"
 #include "mx27.h"
 
-static void __init imx27_dt_init(void)
-{
-	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-
-	platform_device_register_full(&devinfo);
-}
-
 static const char * const imx27_dt_board_compat[] __initconst = {
 	"fsl,imx27",
 	NULL
@@ -36,6 +27,5 @@ DT_MACHINE_START(IMX27_DT, "Freescale i.MX27 (Device Tree Support)")
 	.map_io		= mx27_map_io,
 	.init_early	= imx27_init_early,
 	.init_irq	= mx27_init_irq,
-	.init_machine	= imx27_dt_init,
 	.dt_compat	= imx27_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
index 6883fbaf9484..10a82a4f1e58 100644
--- a/arch/arm/mach-imx/mach-imx51.c
+++ b/arch/arm/mach-imx/mach-imx51.c
@@ -50,13 +50,10 @@ static void __init imx51_ipu_mipi_setup(void)
 
 static void __init imx51_dt_init(void)
 {
-	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
-
 	imx51_ipu_mipi_setup();
 	imx_src_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	platform_device_register_full(&devinfo);
 }
 
 static void __init imx51_init_late(void)
diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 86316a979297..18b5c5c136db 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -40,8 +40,6 @@ static void __init imx53_dt_init(void)
 static void __init imx53_init_late(void)
 {
 	imx53_pm_init();
-
-	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
 }
 
 static const char * const imx53_dt_board_compat[] __initconst = {
diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.c
index 5a27f20c9a82..b450f525a670 100644
--- a/arch/arm/mach-imx/mach-imx7d.c
+++ b/arch/arm/mach-imx/mach-imx7d.c
@@ -105,11 +105,6 @@ static void __init imx7d_init_irq(void)
 	irqchip_init();
 }
 
-static void __init imx7d_init_late(void)
-{
-	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
-}
-
 static const char *const imx7d_dt_compat[] __initconst = {
 	"fsl,imx7d",
 	NULL,
@@ -117,7 +112,6 @@ static const char *const imx7d_dt_compat[] __initconst = {
 
 DT_MACHINE_START(IMX7D, "Freescale i.MX7 Dual (Device Tree)")
 	.init_irq	= imx7d_init_irq,
-	.init_late	= imx7d_init_late,
 	.init_machine	= imx7d_init_machine,
 	.dt_compat	= imx7d_dt_compat,
 MACHINE_END
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 3e1c8211c213..3843314389c7 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -12,6 +12,11 @@
 #include <linux/platform_device.h>
 
 static const struct of_device_id machines[] __initconst = {
+	{ .compatible = "fsl,imx27", },
+	{ .compatible = "fsl,imx51", },
+	{ .compatible = "fsl,imx53", },
+	{ .compatible = "fsl,imx7d", },
+
 	{ .compatible = "marvell,berlin", },
 
 	{ .compatible = "samsung,exynos3250", },
-- 
2.7.1.410.g6faf27b

