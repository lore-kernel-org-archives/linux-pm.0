From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 5/5] ARM: imx53: add cpufreq support
Date: Fri, 19 Sep 2014 18:16:21 +0200
Message-ID: <1411143381-10516-6-git-send-email-l.stach@pengutronix.de>
References: <1411143381-10516-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48981 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757190AbaISQQx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Sep 2014 12:16:53 -0400
In-Reply-To: <1411143381-10516-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, kernel@pengutronix.de

Instanciate the platform device for the generic cpufreq-cpu0
driver and add all required properties to the DT.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi   | 13 ++++++++++++-
 arch/arm/mach-imx/mach-imx53.c |  4 ++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 64fa27b36be0..bd5226a7ea20 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -46,10 +46,21 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a8";
 			reg = <0x0>;
+			clocks = <&clks IMX5_CLK_ARM>;
+			clock-latency = <61036>;
+			voltage-tolerance = <5>;
+			operating-points = <
+				/* kHz */
+				 166666  850000
+				 400000  900000
+				 800000 1050000
+				1000000 1200000
+				1200000 1300000
+			>;
 		};
 	};
 
diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 03dd6ea13acc..4eb6849c52d2 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -38,9 +38,13 @@ static void __init imx53_dt_init(void)
 	imx_aips_allow_unprivileged_access("fsl,imx53-aipstz");
 }
 
+static struct platform_device imx53_cpufreq_pdev = { .name = "cpufreq-cpu0", };
+
 static void __init imx53_init_late(void)
 {
 	imx53_pm_init();
+
+	platform_device_register(&imx53_cpufreq_pdev);
 }
 
 static const char * const imx53_dt_board_compat[] __initconst = {
-- 
2.1.0

