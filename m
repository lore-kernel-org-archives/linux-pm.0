From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v8 14/20] ARM: dts: Add bus nodes using VDD_MIF for Exynos4x12
Date: Fri, 08 Apr 2016 13:25:03 +0900
Message-ID: <1460089509-16260-15-git-send-email-cw00.choi@samsung.com>
References: <1460089509-16260-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:33906 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756149AbcDHEZ1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2016 00:25:27 -0400
In-reply-to: <1460089509-16260-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This patch adds the bus nodes using VDD_MIF for Exynos4x12 SoC.
Exynos4x12 has the following AXI buses to translate data
between DRAM and DMC/ACP/C2C.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
[m.reichl and linux.amoon: Tested it on exynos4412-odroidu3 board]
Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Tested-by: Anand Moon <linux.amoon@gmail.com>
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

