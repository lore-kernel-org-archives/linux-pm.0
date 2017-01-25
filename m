From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 8/8] arm64: dts: exynos: Add remaining power domains to
 Exynos5433 SoC
Date: Wed, 25 Jan 2017 12:55:42 +0100
Message-ID: <1485345342-3273-9-git-send-email-m.szyprowski@samsung.com>
References: <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125115602eucas1p13feedded6c2e7efc7ff621141ef5e4c1@eucas1p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:13049 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdAYL4G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2017 06:56:06 -0500
In-reply-to: <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>

This patch adds support for G2D, G3D, CAM0, CAM1, ISP, HVEC power domains
to Exynos5433 SoCs. Currently only clock controllers for those domains are
defined. CAM1 is a parent of CAM0 power domain and CAM0 is a parent of ISP
power domain.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 44 ++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 0e18e9aeb4ce..e45f6e4683b3 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -344,6 +344,7 @@
 			clocks = <&xxti>,
 				<&cmu_top CLK_ACLK_G2D_266>,
 				<&cmu_top CLK_ACLK_G2D_400>;
+			power-domains = <&pd_g2d>;
 		};
 
 		cmu_disp: clock-controller@13b90000 {
@@ -415,6 +416,7 @@
 
 			clock-names = "oscclk", "aclk_g3d_400";
 			clocks = <&xxti>, <&cmu_top CLK_ACLK_G3D_400>;
+			power-domains = <&pd_g3d>;
 		};
 
 		cmu_gscl: clock-controller@13cf0000 {
@@ -480,6 +482,7 @@
 
 			clock-names = "oscclk", "aclk_hevc_400";
 			clocks = <&xxti>, <&cmu_top CLK_ACLK_HEVC_400>;
+			power-domains = <&pd_hevc>;
 		};
 
 		cmu_isp: clock-controller@146d0000 {
@@ -493,6 +496,7 @@
 			clocks = <&xxti>,
 				<&cmu_top CLK_ACLK_ISP_DIS_400>,
 				<&cmu_top CLK_ACLK_ISP_400>;
+			power-domains = <&pd_isp>;
 		};
 
 		cmu_cam0: clock-controller@120d0000 {
@@ -508,6 +512,7 @@
 				<&cmu_top CLK_ACLK_CAM0_333>,
 				<&cmu_top CLK_ACLK_CAM0_400>,
 				<&cmu_top CLK_ACLK_CAM0_552>;
+			power-domains = <&pd_cam0>;
 		};
 
 		cmu_cam1: clock-controller@145d0000 {
@@ -529,6 +534,7 @@
 				<&cmu_top CLK_ACLK_CAM1_333>,
 				<&cmu_top CLK_ACLK_CAM1_400>,
 				<&cmu_top CLK_ACLK_CAM1_552>;
+			power-domains = <&pd_cam1>;
 		};
 
 		pd_gscl: gscl-power-domain@105c4000 {
@@ -555,6 +561,38 @@
 			#power-domain-cells = <0>;
 		};
 
+		pd_cam0: cam0-power-domain@105c4020 {
+			compatible = "samsung,exynos5433-pd";
+			reg = <0x105c4020 0x20>;
+			#power-domain-cells = <0>;
+			power-domains = <&pd_cam1>;
+		};
+
+		pd_cam1: cam1-power-domain@105c40a0 {
+			compatible = "samsung,exynos5433-pd";
+			reg = <0x105c40a0 0x20>;
+			#power-domain-cells = <0>;
+		};
+
+		pd_isp: isp-power-domain@105c4140 {
+			compatible = "samsung,exynos5433-pd";
+			reg = <0x105c4140 0x20>;
+			#power-domain-cells = <0>;
+			power-domains = <&pd_cam0>;
+		};
+
+		pd_g2d: g2d-power-domain@105c4120 {
+			compatible = "samsung,exynos5433-pd";
+			reg = <0x105c4120 0x20>;
+			#power-domain-cells = <0>;
+		};
+
+		pd_g3d: g3d-power-domain@105c4060 {
+			compatible = "samsung,exynos5433-pd";
+			reg = <0x105c4060 0x20>;
+			#power-domain-cells = <0>;
+		};
+
 		pd_aud: aud-power-domain@105c40c0 {
 			compatible = "samsung,exynos5433-pd";
 			reg = <0x105c40c0 0x20>;
@@ -567,6 +605,12 @@
 			#power-domain-cells = <0>;
 		};
 
+		pd_hevc: hevc-power-domain@105c41c0 {
+			compatible = "samsung,exynos5433-pd";
+			reg = <0x105c41c0 0x20>;
+			#power-domain-cells = <0>;
+		};
+
 		tmu_atlas0: tmu@10060000 {
 			compatible = "samsung,exynos5433-tmu";
 			reg = <0x10060000 0x200>;
-- 
1.9.1

