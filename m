From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 03/19] ARM: dts: Add DMC bus node for Exynos3250
Date: Wed, 09 Dec 2015 13:07:55 +0900
Message-ID: <1449634091-1842-4-git-send-email-cw00.choi@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:59167 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbbLIEIU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 23:08:20 -0500
In-reply-to: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

This patch adds the DMC (Dynamic Memory Controller) bus node for Exynos3250 SoC.
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
index 2f30d632f1cc..7214c5e42150 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -687,6 +687,40 @@
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
+		bus_dmc_opp_table: opp_table1 {
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
+				opp-hz = /bits/ 64 <134000000>;
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

