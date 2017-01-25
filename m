From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 5/8] arm64: dts: exynos: Add MFC power domain to Exynos 5433 SoC
Date: Wed, 25 Jan 2017 12:55:39 +0100
Message-ID: <1485345342-3273-6-git-send-email-m.szyprowski@samsung.com>
References: <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125115601eucas1p28fcaf437e629723875767873f015458b@eucas1p2.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds support for MFC power domain to Exynos 5433 SoCs, which
contains following devices: a clock controller, MFC codec device and its
SYSMMUs.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 5778fdbd5763..3487981726d9 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -468,6 +468,7 @@
 
 			clock-names = "oscclk", "aclk_mfc_400";
 			clocks = <&xxti>, <&cmu_top CLK_ACLK_MFC_400>;
+			power-domains = <&pd_mfc>;
 		};
 
 		cmu_hevc: clock-controller@14f80000 {
@@ -546,6 +547,12 @@
 			#power-domain-cells = <0>;
 		};
 
+		pd_mfc: mfc-power-domain@105c4180 {
+			compatible = "samsung,exynos5433-pd";
+			reg = <0x105c4180 0x20>;
+			#power-domain-cells = <0>;
+		};
+
 		tmu_atlas0: tmu@10060000 {
 			compatible = "samsung,exynos5433-tmu";
 			reg = <0x10060000 0x200>;
@@ -971,6 +978,7 @@
 				 <&cmu_mfc CLK_ACLK_XIU_MFCX>;
 			iommus = <&sysmmu_mfc_0>, <&sysmmu_mfc_1>;
 			iommu-names = "left", "right";
+			power-domains = <&pd_mfc>;
 		};
 
 		sysmmu_decon0x: sysmmu@13a00000 {
@@ -1069,6 +1077,7 @@
 			clocks = <&cmu_mfc CLK_PCLK_SMMU_MFC_0>,
 				 <&cmu_mfc CLK_ACLK_SMMU_MFC_0>;
 			#iommu-cells = <0>;
+			power-domains = <&pd_mfc>;
 		};
 
 		sysmmu_mfc_1: sysmmu@15210000 {
@@ -1079,6 +1088,7 @@
 			clocks = <&cmu_mfc CLK_PCLK_SMMU_MFC_1>,
 				 <&cmu_mfc CLK_ACLK_SMMU_MFC_1>;
 			#iommu-cells = <0>;
+			power-domains = <&pd_mfc>;
 		};
 
 		serial_0: serial@14c10000 {
-- 
1.9.1
