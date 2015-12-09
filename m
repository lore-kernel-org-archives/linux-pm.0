From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 13/19] ARM: dts: Add bus nodes using VDD_MIF for Exynos4x12
Date: Wed, 09 Dec 2015 13:08:05 +0900
Message-ID: <1449634091-1842-14-git-send-email-cw00.choi@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the bus noes using VDD_MIF for Exynos4x12 SoC.
Exynos4x12 has the following AXI buses to translate data
between DRAM and DMC/ACP/C2C.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos4x12.dtsi | 72 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index b77dac61ffb5..3bcf0939755e 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -282,6 +282,78 @@
 		clocks = <&clock CLK_SMMU_LITE1>, <&clock CLK_FIMC_LITE1>;
 		#iommu-cells = <0>;
 	};
+
+	bus_dmc: bus_dmc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_DMC>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_dmc_opp_table>;
+		status = "disabled";
+	};
+
+	bus_acp: bus_acp {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_ACP>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_acp_opp_table>;
+		status = "disabled";
+	};
+
+	bus_c2c: bus_c2c {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_C2C>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_dmc_opp_table>;
+		status = "disabled";
+	};
+
+	bus_dmc_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <900000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <134000000>;
+			opp-microvolt = <900000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <160000000>;
+			opp-microvolt = <900000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <950000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1050000>;
+		};
+	};
+
+	bus_acp_opp_table: opp_table2 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <900000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <134000000>;
+			opp-microvolt = <900000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <160000000>;
+			opp-microvolt = <900000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <950000>;
+		};
+	};
 };
 
 &combiner {
-- 
1.9.1
