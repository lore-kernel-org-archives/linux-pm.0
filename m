From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 6/7] ARM: dts: Add bus nodes using VDD_INT for Exynos542x SoC
Date: Fri, 08 Apr 2016 14:00:45 +0900
Message-ID: <1460091646-28701-7-git-send-email-cw00.choi@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the AMBA bus nodes using VDD_INT for Exynos542x SoC.
Exynos542x has the following AMBA buses to translate data between
DRAM and sub-blocks.

Following list specifies the detailed correlation between sub-block and clock:
- CLK_DOUT_ACLK400_WCORE clock for WCORE's AXI
- CLK_DOUT_ACLK100_NOC for NoC (Network on Chip)'s AXI
- CLK_DOUT_PCLK200_FSYS for FSYS's APB
- CLK_DOUT_ACLK200_FSYS for FSYS's AXI
- CLK_DOUT_ACLK200_FSYS2 for FSYS2's AXI
- CLK_DOUT_ACLK333 for MFC's AXI
- CLK_DOUT_ACLK266 for GEN's AXI
- CLK_DOUT_ACLK66 for PERIC/PERIR's AXI
- CLK_DOUT_ACLK333_G2D for G2D's AXI
- CLK_DOUT_ACLK266_G2D for ACP's AXI
- CLK_DOUT_ACLK300_JPEG for JPEG's AXI
- CLK_DOUT_ACLK166 for JPEG's APB
- CLK_DOUT_ACLK300_DISP1 for FIMD's AXI
- CLK_DOUT_ACLK400_DISP1 for DISP1's AXI
- CLK_DOUT_ACLK300_GSCL for GSCL Scaler's AXI
- CLK_DOUT_ACLK400_MSCL for MSCL's AXI

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 371 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 371 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index d80f3b66f017..1340024fa882 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1224,6 +1224,377 @@
 		power-domains = <&disp_pd>;
 		#iommu-cells = <0>;
 	};
+
+	bus_wcore: bus_wcore {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK400_WCORE>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_wcore_opp_table>;
+		status = "disabled";
+	};
+
+	bus_noc: bus_noc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK100_NOC>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_noc_opp_table>;
+		status = "disabled";
+	};
+
+	bus_fsys_apb: bus_fsys_apb {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_PCLK200_FSYS>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_fsys_apb_opp_table>;
+		status = "disabled";
+	};
+
+	bus_fsys: bus_fsys {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK200_FSYS>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_fsys_apb_opp_table>;
+		status = "disabled";
+	};
+
+	bus_fsys2: bus_fsys2 {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK200_FSYS2>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_fsys2_opp_table>;
+		status = "disabled";
+	};
+
+	bus_mfc: bus_mfc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK333>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_mfc_opp_table>;
+		status = "disabled";
+	};
+
+	bus_gen: bus_gen {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK266>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_gen_opp_table>;
+		status = "disabled";
+	};
+
+	bus_peri: bus_peri {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK66>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_peri_opp_table>;
+		status = "disabled";
+	};
+
+	bus_g2d: bus_g2d {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK333_G2D>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_g2d_opp_table>;
+		status = "disabled";
+	};
+
+	bus_g2d_acp: bus_g2d_acp {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK266_G2D>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_g2d_acp_opp_table>;
+		status = "disabled";
+	};
+
+	bus_jpeg: bus_jpeg {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK300_JPEG>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_jpeg_opp_table>;
+		status = "disabled";
+	};
+
+	bus_jpeg_apb: bus_jpeg_apb {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK166>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_jpeg_apb_opp_table>;
+		status = "disabled";
+	};
+
+	bus_disp1_fimd: bus_disp1_fimd {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK300_DISP1>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_disp1_fimd_opp_table>;
+		status = "disabled";
+	};
+
+	bus_disp1: bus_disp1 {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK400_DISP1>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_disp1_opp_table>;
+		status = "disabled";
+	};
+
+	bus_gscl_scaler: bus_gscl_scaler {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK300_GSCL>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_gscl_opp_table>;
+		status = "disabled";
+	};
+
+	bus_mscl: bus_mscl {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DOUT_ACLK400_MSCL>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_mscl_opp_table>;
+		status = "disabled";
+	};
+
+	bus_wcore_opp_table: opp_table2 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <84000000>;
+			opp-microvolt = <925000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <111000000>;
+			opp-microvolt = <950000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <222000000>;
+			opp-microvolt = <950000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <333000000>;
+			opp-microvolt = <950000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <987500>;
+		};
+	};
+
+	bus_noc_opp_table: opp_table3 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <66000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <75000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <86000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+	};
+
+	bus_fsys_apb_opp_table: opp_table4 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+	};
+
+	bus_fsys2_opp_table: opp_table5 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <75000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <150000000>;
+		};
+	};
+
+	bus_mfc_opp_table: opp_table6 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <96000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <111000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <167000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <222000000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <333000000>;
+		};
+	};
+
+	bus_gen_opp_table: opp_table7 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <89000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <133000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <178000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <267000000>;
+		};
+	};
+
+	bus_peri_opp_table: opp_table8 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <67000000>;
+		};
+	};
+
+	bus_g2d_opp_table: opp_table9 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <84000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <167000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <222000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <300000000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <333000000>;
+		};
+	};
+
+	bus_g2d_acp_opp_table: opp_table10 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <67000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <133000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <178000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <267000000>;
+		};
+	};
+
+	bus_jpeg_opp_table: opp_table11 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <75000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <150000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <300000000>;
+		};
+	};
+
+	bus_jpeg_apb_opp_table: opp_table12 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <84000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <111000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <134000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <167000000>;
+		};
+	};
+
+	bus_disp1_fimd_opp_table: opp_table13 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <120000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+	};
+
+	bus_disp1_opp_table: opp_table14 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <120000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <300000000>;
+		};
+	};
+
+	bus_gscl_opp_table: opp_table15 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <150000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <300000000>;
+		};
+	};
+
+	bus_mscl_opp_table: opp_table16 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <84000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <167000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <222000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <333000000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <400000000>;
+		};
+	};
 };
 
 &dp {
-- 
1.9.1
