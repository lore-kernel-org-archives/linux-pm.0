From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 4/4] ARM: imx53: add basic cpufreq properties to dtsi
Date: Mon, 26 May 2014 12:15:08 +0200
Message-ID: <1401099308-9658-4-git-send-email-l.stach@pengutronix.de>
References: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46441 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbaEZKP3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 May 2014 06:15:29 -0400
In-Reply-To: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawn.guo@freescale.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de

Only thing missing is the vddgp regulator, which is board
specific.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index b57ab57740f6..8f005919cf6c 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -45,10 +45,24 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a8";
 			reg = <0x0>;
+			clocks = <&clks IMX5_CLK_CPU_PODF>,
+			         <&clks IMX5_CLK_PLL1_SW>,
+			         <&clks IMX5_CLK_STEP_SEL>,
+			         <&clks IMX5_CLK_LP_APM>;
+			clock-names = "cpu", "pll1", "step", "lp_apm";
+			vddgp-supply-max-microvolt = <1400000>;
+			operating-points = <
+				/* kHz     uV */
+				 166666  850000
+				 400000  900000
+				 800000 1050000
+				1000000 1200000
+				1200000 1300000
+			>;
 		};
 	};
 
-- 
2.0.0.rc2

