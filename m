From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [RFC PATCH 03/15] ARM: dts: Add DMC bus node for Exynos3250
Date: Thu, 26 Nov 2015 22:47:27 +0900
Message-ID: <1448545659-32287-4-git-send-email-cw00.choi@samsung.com>
References: <1448545659-32287-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:40834 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbbKZNrr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2015 08:47:47 -0500
In-reply-to: <1448545659-32287-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, k.kozlowski@samsung.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

This patch adds the DMC (DRAM memory controller) bus node for Exynos3250 SoC.
The DMC is an AMBA AXI-compliant slave to interface external JEDEC standard
SDRAM devices. The bus includes the OPP tables and the source clock for DMC
block.

Following list specifies the detailed relation between the clock and DMC block:
- The source clock of DMC block : div_dmc

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index be0bb32c2d8c..45809f83c628 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -700,6 +700,40 @@
 			clock-names = "ppmu";
 			status = "disabled";
 		};
+
+		bus_dmc: bus_dmc {
+			compatible = "samsung,exynos-bus";
+			clocks = <&cmu_dmc CLK_DIV_DMC>;
+			clock-names = "bus";
+			operating-points-v2 = <&bus_dmc_opp_table>;
+			status = "disabled";
+		};
+
+		bus_dmc_opp_table: opp_table0 {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp00 {
+				opp-hz = /bits/ 64 <50000000>;
+				opp-microvolt = <800000>;
+			};
+			opp01 {
+				opp-hz = /bits/ 64 <100000000>;
+				opp-microvolt = <800000>;
+			};
+			opp02 {
+				opp-hz = /bits/ 64 <133000000>;
+				opp-microvolt = <800000>;
+			};
+			opp03 {
+				opp-hz = /bits/ 64 <200000000>;
+				opp-microvolt = <800000>;
+			};
+			opp04 {
+				opp-hz = /bits/ 64 <400000000>;
+				opp-microvolt = <875000>;
+			};
+		};
 	};
 };
 
-- 
1.9.1

