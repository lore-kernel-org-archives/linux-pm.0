From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v7 11/20] ARM: dts: Add DMC bus node for Exynos3250
Date: Thu, 31 Mar 2016 18:05:56 +0900
Message-ID: <1459415165-32613-12-git-send-email-cw00.choi@samsung.com>
References: <1459415165-32613-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1459415165-32613-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the DMC (Dynamic Memory Controller) bus node for Exynos3250 SoC.
The DMC is an AMBA AXI-compliant slave to interface external JEDEC standard
SDRAM devices. The bus includes the OPP tables and the source clock for DMC
block.

Following list specifies the detailed relation between the clock and DMC block:
- The source clock of DMC block : div_dmc

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 137f9015d4e8..1ae72c4fa55e 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -688,6 +688,40 @@
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
+			opp@50000000 {
+				opp-hz = /bits/ 64 <50000000>;
+				opp-microvolt = <800000>;
+			};
+			opp@100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+				opp-microvolt = <800000>;
+			};
+			opp@134000000 {
+				opp-hz = /bits/ 64 <134000000>;
+				opp-microvolt = <800000>;
+			};
+			opp@200000000 {
+				opp-hz = /bits/ 64 <200000000>;
+				opp-microvolt = <825000>;
+			};
+			opp@400000000 {
+				opp-hz = /bits/ 64 <400000000>;
+				opp-microvolt = <875000>;
+			};
+		};
 	};
 };
 
-- 
1.9.1
