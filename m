From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v9 15/20] ARM: dts: Add bus nodes using VDD_INT for Exynos4x12
Date: Mon, 11 Apr 2016 12:57:53 +0900
Message-ID: <1460347078-15175-16-git-send-email-cw00.choi@samsung.com>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the bus nodes using VDD_INT for Exynos4x12 SoC.
Exynos4x12 has the following AXI buses to translate data between
DRAM and sub-blocks.

Following list specifies the detailed relation between DRAM and sub-blocks:
- ACLK100 clock for PERIL/PERIR/MFC(PCLK)
- ACLK160 clock for CAM/TV/LCD
: The minimum clock of ACLK160 should be over 160MHz.
  When drop the clock under 160MHz, show the broken image.
- ACLK133 clock for FSYS
- GDL clock for LEFTBUS
- GDR clock for RIGHTBUS
- SCLK_MFC clock for MFC

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
[m.reichl and linux.amoon: Tested it on exynos4412-odroidu3 board]
Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Tested-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos4x12.dtsi | 106 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 99a0f4ca3d47..e5173107ed44 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -349,6 +349,112 @@
 			opp-hz = /bits/ 64 <267000000>;
 		};
 	};
+
+	bus_leftbus: bus_leftbus {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_GDL>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_rightbus: bus_rightbus {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_GDR>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_display: bus_display {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK160>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_display_opp_table>;
+		status = "disabled";
+	};
+
+	bus_fsys: bus_fsys {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK133>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_fsys_opp_table>;
+		status = "disabled";
+	};
+
+	bus_peri: bus_peri {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK100>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_peri_opp_table>;
+		status = "disabled";
+	};
+
+	bus_mfc: bus_mfc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_SCLK_MFC>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_leftbus_opp_table: opp_table3 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <900000>;
+		};
+		opp@134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+			opp-microvolt = <925000>;
+		};
+		opp@160000000 {
+			opp-hz = /bits/ 64 <160000000>;
+			opp-microvolt = <950000>;
+		};
+		opp@200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <1000000>;
+		};
+	};
+
+	bus_display_opp_table: opp_table4 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@160000000 {
+			opp-hz = /bits/ 64 <160000000>;
+		};
+		opp@200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+	};
+
+	bus_fsys_opp_table: opp_table5 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+		opp@134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+		};
+	};
+
+	bus_peri_opp_table: opp_table6 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@50000000 {
+			opp-hz = /bits/ 64 <50000000>;
+		};
+		opp@100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+	};
 };
 
 &combiner {
-- 
1.9.1
