From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 3/8] arm64: dts: exynos: Add DISP power domain to Exynos 5433
 SoC
Date: Wed, 25 Jan 2017 12:55:37 +0100
Message-ID: <1485345342-3273-4-git-send-email-m.szyprowski@samsung.com>
References: <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125115600eucas1p1e9b1adbb62380568f94793d1de17cdc2@eucas1p1.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds support for DISP power domain to Exynos 5433 SoCs, which
contains following devices: a clock controller, two display controllers
(DECON and DECON TV), their SYSMMUs, MIC, DSI and HDMI video devices.

OCSigned-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 74c767d756ac..a84b44cea2a8 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -368,6 +368,7 @@
 				<&cmu_mif CLK_SCLK_DECON_ECLK_DISP>,
 				<&cmu_mif CLK_SCLK_DECON_TV_VCLK_DISP>,
 				<&cmu_mif CLK_ACLK_DISP_333>;
+			power-domains = <&pd_disp>;
 		};
 
 		cmu_aud: clock-controller@114c0000 {
@@ -532,6 +533,12 @@
 			#power-domain-cells = <0>;
 		};
 
+		pd_disp: disp-power-domain@105c4080 {
+			compatible = "samsung,exynos5433-pd";
+			reg = <0x105c4080 0x20>;
+			#power-domain-cells = <0>;
+		};
+
 		tmu_atlas0: tmu@10060000 {
 			compatible = "samsung,exynos5433-tmu";
 			reg = <0x10060000 0x200>;
@@ -735,6 +742,7 @@
 			clock-names = "pclk", "aclk_decon", "aclk_smmu_decon0x",
 				"aclk_xiu_decon0x", "pclk_smmu_decon0x",
 				"sclk_decon_vclk", "sclk_decon_eclk";
+			power-domains = <&pd_disp>;
 			interrupt-names = "fifo", "vsync", "lcd_sys";
 			interrupts = <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
@@ -772,6 +780,7 @@
 				      "aclk_xiu_decon0x", "pclk_smmu_decon0x",
 				      "sclk_decon_vclk", "sclk_decon_eclk";
 			samsung,disp-sysreg = <&syscon_disp>;
+			power-domains = <&pd_disp>;
 			interrupt-names = "fifo", "vsync", "lcd_sys";
 			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
@@ -797,6 +806,7 @@
 					"phyclk_mipidphy0_rxclkesc0",
 					"sclk_rgb_vclk_to_dsim0",
 					"sclk_mipi";
+			power-domains = <&pd_disp>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -820,6 +830,7 @@
 			clocks = <&cmu_disp CLK_PCLK_MIC0>,
 				<&cmu_disp CLK_SCLK_RGB_VCLK_TO_MIC0>;
 			clock-names = "pclk_mic0", "sclk_rgb_vclk_to_mic0";
+			power-domains = <&pd_disp>;
 			samsung,disp-syscon = <&syscon_disp>;
 			status = "disabled";
 
@@ -961,6 +972,7 @@
 			clock-names = "pclk", "aclk";
 			clocks = <&cmu_disp CLK_PCLK_SMMU_DECON0X>,
 				<&cmu_disp CLK_ACLK_SMMU_DECON0X>;
+			power-domains = <&pd_disp>;
 			#iommu-cells = <0>;
 		};
 
@@ -972,6 +984,7 @@
 			clocks = <&cmu_disp CLK_PCLK_SMMU_DECON1X>,
 				<&cmu_disp CLK_ACLK_SMMU_DECON1X>;
 			#iommu-cells = <0>;
+			power-domains = <&pd_disp>;
 		};
 
 		sysmmu_tv0x: sysmmu@13a20000 {
@@ -982,6 +995,7 @@
 			clocks = <&cmu_disp CLK_PCLK_SMMU_TV0X>,
 				<&cmu_disp CLK_ACLK_SMMU_TV0X>;
 			#iommu-cells = <0>;
+			power-domains = <&pd_disp>;
 		};
 
 		sysmmu_tv1x: sysmmu@13a30000 {
@@ -992,6 +1006,7 @@
 			clocks = <&cmu_disp CLK_PCLK_SMMU_TV1X>,
 				<&cmu_disp CLK_ACLK_SMMU_TV1X>;
 			#iommu-cells = <0>;
+			power-domains = <&pd_disp>;
 		};
 
 		sysmmu_gscl0: sysmmu@13c80000 {
-- 
1.9.1
