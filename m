From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/8] arm64: dts: exynos: Add GSCL power domain to Exynos 5433
 SoC
Date: Wed, 25 Jan 2017 12:55:36 +0100
Message-ID: <1485345342-3273-3-git-send-email-m.szyprowski@samsung.com>
References: <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125115559eucas1p1a219b6ae0fef16bbdb68645328b61a5e@eucas1p1.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds support for GSCL power domain to Exynos 5433 SoCs, which
contains following devices: a clock controller, three GSCL video scalers and
their SYSMMUs.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 16072c1c3ed3..74c767d756ac 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -425,6 +425,7 @@
 			clocks = <&xxti>,
 				<&cmu_top CLK_ACLK_GSCL_111>,
 				<&cmu_top CLK_ACLK_GSCL_333>;
+			power-domains = <&pd_gscl>;
 		};
 
 		cmu_apollo: clock-controller@11900000 {
@@ -525,6 +526,12 @@
 				<&cmu_top CLK_ACLK_CAM1_552>;
 		};
 
+		pd_gscl: gscl-power-domain@105c4000 {
+			compatible = "samsung,exynos5433-pd";
+			reg = <0x105c4000 0x20>;
+			#power-domain-cells = <0>;
+		};
+
 		tmu_atlas0: tmu@10060000 {
 			compatible = "samsung,exynos5433-tmu";
 			reg = <0x10060000 0x200>;
@@ -892,6 +899,7 @@
 				 <&cmu_gscl CLK_ACLK_XIU_GSCLX>,
 				 <&cmu_gscl CLK_ACLK_GSCLBEND_333>;
 			iommus = <&sysmmu_gscl0>;
+			power-domains = <&pd_gscl>;
 		};
 
 		gsc_1: video-scaler@13C10000 {
@@ -905,6 +913,7 @@
 				 <&cmu_gscl CLK_ACLK_XIU_GSCLX>,
 				 <&cmu_gscl CLK_ACLK_GSCLBEND_333>;
 			iommus = <&sysmmu_gscl1>;
+			power-domains = <&pd_gscl>;
 		};
 
 		gsc_2: video-scaler@13C20000 {
@@ -918,6 +927,7 @@
 				 <&cmu_gscl CLK_ACLK_XIU_GSCLX>,
 				 <&cmu_gscl CLK_ACLK_GSCLBEND_333>;
 			iommus = <&sysmmu_gscl2>;
+			power-domains = <&pd_gscl>;
 		};
 
 		jpeg: codec@15020000 {
@@ -992,6 +1002,7 @@
 			clocks = <&cmu_gscl CLK_ACLK_SMMU_GSCL0>,
 				 <&cmu_gscl CLK_PCLK_SMMU_GSCL0>;
 			#iommu-cells = <0>;
+			power-domains = <&pd_gscl>;
 		};
 
 		sysmmu_gscl1: sysmmu@13c90000 {
@@ -1002,6 +1013,7 @@
 			clocks = <&cmu_gscl CLK_ACLK_SMMU_GSCL1>,
 				 <&cmu_gscl CLK_PCLK_SMMU_GSCL1>;
 			#iommu-cells = <0>;
+			power-domains = <&pd_gscl>;
 		};
 
 		sysmmu_gscl2: sysmmu@13ca0000 {
@@ -1012,6 +1024,7 @@
 			clocks = <&cmu_gscl CLK_ACLK_SMMU_GSCL2>,
 				 <&cmu_gscl CLK_PCLK_SMMU_GSCL2>;
 			#iommu-cells = <0>;
+			power-domains = <&pd_gscl>;
 		};
 
 		sysmmu_jpeg: sysmmu@15060000 {
-- 
1.9.1
