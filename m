From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 4/8] arm64: dts: exynos: Add MSCL power domain to Exynos 5433
 SoC
Date: Wed, 25 Jan 2017 12:55:38 +0100
Message-ID: <1485345342-3273-5-git-send-email-m.szyprowski@samsung.com>
References: <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125115600eucas1p1df640bb3f1033a103f7dea3d384c3b4e@eucas1p1.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds support for MSCL power domain to Exynos 5433 SoCs, which
contains following devices: a clock controller, JPEG codec device and its
SYSMMU.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index a84b44cea2a8..5778fdbd5763 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -458,6 +458,7 @@
 			clocks = <&xxti>,
 				<&cmu_top CLK_SCLK_JPEG_MSCL>,
 				<&cmu_top CLK_ACLK_MSCL_400>;
+			power-domains = <&pd_mscl>;
 		};
 
 		cmu_mfc: clock-controller@15280000 {
@@ -533,6 +534,12 @@
 			#power-domain-cells = <0>;
 		};
 
+		pd_mscl: mscl-power-domain@105c4040 {
+			compatible = "samsung,exynos5433-pd";
+			reg = <0x105c4040 0x20>;
+			#power-domain-cells = <0>;
+		};
+
 		pd_disp: disp-power-domain@105c4080 {
 			compatible = "samsung,exynos5433-pd";
 			reg = <0x105c4080 0x20>;
@@ -951,6 +958,7 @@
 				 <&cmu_mscl CLK_ACLK_XIU_MSCLX>,
 				 <&cmu_mscl CLK_SCLK_JPEG>;
 			iommus = <&sysmmu_jpeg>;
+			power-domains = <&pd_mscl>;
 		};
 
 		mfc: codec@152E0000 {
@@ -1050,6 +1058,7 @@
 			clocks = <&cmu_mscl CLK_PCLK_SMMU_JPEG>,
 				 <&cmu_mscl CLK_ACLK_SMMU_JPEG>;
 			#iommu-cells = <0>;
+			power-domains = <&pd_mscl>;
 		};
 
 		sysmmu_mfc_0: sysmmu@15200000 {
-- 
1.9.1
