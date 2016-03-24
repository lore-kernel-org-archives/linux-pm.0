From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v5 15/21] ARM: dts: Add bus nodes using VDD_MIF for Exynos4x12
Date: Thu, 24 Mar 2016 13:25:24 +0900
Message-ID: <1458793530-31897-16-git-send-email-cw00.choi@samsung.com>
References: <1458793530-31897-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1458793530-31897-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, tjakobi@math.uni-bielefeld.de, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the bus nodes using VDD_MIF for Exynos4x12 SoC.
Exynos4x12 has the following AXI buses to translate data
between DRAM and DMC/ACP/C2C.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4x12.dtsi | 68 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 84a23f962946..99a0f4ca3d47 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -281,6 +281,74 @@
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
+		opp@100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <900000>;
+		};
+		opp@134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+			opp-microvolt = <900000>;
+		};
+		opp@160000000 {
+			opp-hz = /bits/ 64 <160000000>;
+			opp-microvolt = <900000>;
+		};
+		opp@267000000 {
+			opp-hz = /bits/ 64 <267000000>;
+			opp-microvolt = <950000>;
+		};
+		opp@400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1050000>;
+		};
+	};
+
+	bus_acp_opp_table: opp_table2 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+		opp@134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+		};
+		opp@160000000 {
+			opp-hz = /bits/ 64 <160000000>;
+		};
+		opp@267000000 {
+			opp-hz = /bits/ 64 <267000000>;
+		};
+	};
 };
 
 &combiner {
-- 
1.9.1
