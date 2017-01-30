From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 5/5] arm: dts: exynos: Add labels to all existing power
 domains
Date: Mon, 30 Jan 2017 13:19:00 +0100
Message-ID: <1485778740-30337-6-git-send-email-m.szyprowski@samsung.com>
References: <1485778740-30337-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170130121915eucas1p1ee68039795d5ee4a05990fe6e27c5fcc@eucas1p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:29055 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752776AbdA3MTX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jan 2017 07:19:23 -0500
In-reply-to: <1485778740-30337-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>

Provide human readable names for all power domains defined in Exynos SoCs.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi    | 7 +++++++
 arch/arm/boot/dts/exynos4210.dtsi | 1 +
 arch/arm/boot/dts/exynos4412.dtsi | 1 +
 arch/arm/boot/dts/exynos5250.dtsi | 3 +++
 arch/arm/boot/dts/exynos5420.dtsi | 5 +++++
 5 files changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 8fb0e00dd1be..18def1c774d5 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -102,18 +102,21 @@
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023C40 0x20>;
 		#power-domain-cells = <0>;
+		label = "MFC";
 	};
 
 	pd_g3d: g3d-power-domain@10023C60 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023C60 0x20>;
 		#power-domain-cells = <0>;
+		label = "G3D";
 	};
 
 	pd_lcd0: lcd0-power-domain@10023C80 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023C80 0x20>;
 		#power-domain-cells = <0>;
+		label = "LCD0";
 	};
 
 	pd_tv: tv-power-domain@10023C20 {
@@ -121,24 +124,28 @@
 		reg = <0x10023C20 0x20>;
 		#power-domain-cells = <0>;
 		power-domains = <&pd_lcd0>;
+		label = "TV";
 	};
 
 	pd_cam: cam-power-domain@10023C00 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023C00 0x20>;
 		#power-domain-cells = <0>;
+		label = "CAM";
 	};
 
 	pd_gps: gps-power-domain@10023CE0 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023CE0 0x20>;
 		#power-domain-cells = <0>;
+		label = "GPS";
 	};
 
 	pd_gps_alive: gps-alive-power-domain@10023D00 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023D00 0x20>;
 		#power-domain-cells = <0>;
+		label = "GPS alive";
 	};
 
 	gic: interrupt-controller@10490000 {
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 7f3a18c8f60f..f9408188f97f 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -86,6 +86,7 @@
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023CA0 0x20>;
 		#power-domain-cells = <0>;
+		label = "LCD1";
 	};
 
 	l2c: l2-cache-controller@10502000 {
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 4f7b5a1a848c..235bbb69ad7c 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -172,6 +172,7 @@
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023CA0 0x20>;
 		#power-domain-cells = <0>;
+		label = "ISP";
 	};
 
 	l2c: l2-cache-controller@10502000 {
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 0e04460a815a..79c9c885613a 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -115,18 +115,21 @@
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10044000 0x20>;
 			#power-domain-cells = <0>;
+			label = "GSC";
 		};
 
 		pd_mfc: mfc-power-domain@10044040 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10044040 0x20>;
 			#power-domain-cells = <0>;
+			label = "MFC";
 		};
 
 		pd_disp1: disp1-power-domain@100440A0 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x100440A0 0x20>;
 			#power-domain-cells = <0>;
+			label = "DISP1";
 			clocks = <&clock CLK_FIN_PLL>,
 				 <&clock CLK_MOUT_ACLK200_DISP1_SUB>,
 				 <&clock CLK_MOUT_ACLK300_DISP1_SUB>;
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 0154c2e373f8..7dc9dc82afd8 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -277,6 +277,7 @@
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10044000 0x20>;
 			#power-domain-cells = <0>;
+			label = "GSC";
 			clocks = <&clock CLK_FIN_PLL>,
 				 <&clock CLK_MOUT_USER_ACLK300_GSCL>,
 				 <&clock CLK_GSCL0>, <&clock CLK_GSCL1>;
@@ -287,6 +288,7 @@
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10044020 0x20>;
 			#power-domain-cells = <0>;
+			label = "ISP";
 		};
 
 		mfc_pd: power-domain@10044060 {
@@ -297,18 +299,21 @@
 				 <&clock CLK_ACLK333>;
 			clock-names = "oscclk", "clk0","asb0";
 			#power-domain-cells = <0>;
+			label = "MFC";
 		};
 
 		msc_pd: power-domain@10044120 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10044120 0x20>;
 			#power-domain-cells = <0>;
+			label = "MSC";
 		};
 
 		disp_pd: power-domain@100440C0 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x100440C0 0x20>;
 			#power-domain-cells = <0>;
+			label = "DISP";
 			clocks = <&clock CLK_FIN_PLL>,
 				 <&clock CLK_MOUT_USER_ACLK200_DISP1>,
 				 <&clock CLK_MOUT_USER_ACLK300_DISP1>,
-- 
1.9.1

