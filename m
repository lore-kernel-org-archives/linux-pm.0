From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH v2 5/6] ARM: dts: imx53: add cpufreq-dt support
Date: Fri, 26 Sep 2014 15:41:03 +0200
Message-ID: <1411738864-26549-5-git-send-email-l.stach@pengutronix.de>
References: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39597 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbaIZNl3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 09:41:29 -0400
In-Reply-To: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

Add all required properties for the cpufreq-dt driver.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2:
- split out device instantiation
---
 arch/arm/boot/dts/imx53.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index c6c58c1c00e3..aa2fb2f3616d 100644
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
 
-- 
2.1.0

