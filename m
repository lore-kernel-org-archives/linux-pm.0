From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v7 16/20] ARM: dts: Add bus nodes using VDD_MIF for Exynos4210
Date: Thu, 31 Mar 2016 18:06:01 +0900
Message-ID: <1459415165-32613-17-git-send-email-cw00.choi@samsung.com>
References: <1459415165-32613-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1459415165-32613-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the bus nodes for Exynos4210 SoC. Exynos4210 SoC has
one power line for all buses to translate data between DRAM and sub-blocks.

Following list specifies the detailed relation between DRAM and sub-blocks:
- DMC/ACP clock for DMC (Dynamic Memory Controller)
- ACLK200 clock for LCD0
- ACLK100 clock for PERIL/PERIR/MFC(PCLK)
- ACLK160 clock for CAM/TV/LCD0/LCD1
- ACLK133 clock for FSYS/GPS
- GDL/GDR clock for LEFTBUS/RIGHTBUS
- SCLK_MFC clock for MFC

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 159 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index c1cb8df6da07..2d9b02967105 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -257,6 +257,165 @@
 		power-domains = <&pd_lcd1>;
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
+	bus_peri: bus_peri {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK100>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_peri_opp_table>;
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
+	bus_display: bus_display {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK160>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_display_opp_table>;
+		status = "disabled";
+	};
+
+	bus_lcd0: bus_lcd0 {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK200>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
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
+	bus_mfc: bus_mfc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_SCLK_MFC>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_dmc_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+			opp-microvolt = <1025000>;
+		};
+		opp@267000000 {
+			opp-hz = /bits/ 64 <267000000>;
+			opp-microvolt = <1050000>;
+		};
+		opp@400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1150000>;
+		};
+	};
+
+	bus_acp_opp_table: opp_table2 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+		};
+		opp@160000000 {
+			opp-hz = /bits/ 64 <160000000>;
+		};
+		opp@200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+	};
+
+	bus_peri_opp_table: opp_table3 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@5000000 {
+			opp-hz = /bits/ 64 <5000000>;
+		};
+		opp@100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+	};
+
+	bus_fsys_opp_table: opp_table4 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@10000000 {
+			opp-hz = /bits/ 64 <10000000>;
+		};
+		opp@134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+		};
+	};
+
+	bus_display_opp_table: opp_table5 {
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
+	};
+
+	bus_leftbus_opp_table: opp_table6 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+		opp@160000000 {
+			opp-hz = /bits/ 64 <160000000>;
+		};
+		opp@200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+	};
 };
 
 &gic {
-- 
1.9.1
