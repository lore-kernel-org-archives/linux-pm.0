From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 7/8] arm64: dts: exynos: Add FSYS power domain to Exynos5433 SoC
Date: Wed, 25 Jan 2017 12:55:41 +0100
Message-ID: <1485345342-3273-8-git-send-email-m.szyprowski@samsung.com>
References: <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125115601eucas1p1e90bdf34ae4cb71f4d7c58232fff1a13@eucas1p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:47030 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbdAYL4F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2017 06:56:05 -0500
In-reply-to: <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>

This patch adds support for FSYS power domain to Exynos 5433 SoCs, which
contains following devices: a clock controller, a pin controller, three MSHC
controllers, two DWC USB 3.0 controllers and their PHYs.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 24fc3b46cc40..0e18e9aeb4ce 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -330,6 +330,7 @@
 				<&cmu_top CLK_SCLK_MMC0_FSYS>,
 				<&cmu_top CLK_SCLK_USBHOST30_FSYS>,
 				<&cmu_top CLK_SCLK_USBDRD30_FSYS>;
+			power-domains = <&pd_fsys>;
 		};
 
 		cmu_g2d: clock-controller@12460000 {
@@ -560,6 +561,12 @@
 			#power-domain-cells = <0>;
 		};
 
+		pd_fsys: fsys-power-domain@105c40e0 {
+			compatible = "samsung,exynos5433-pd";
+			reg = <0x105c40e0 0x20>;
+			#power-domain-cells = <0>;
+		};
+
 		tmu_atlas0: tmu@10060000 {
 			compatible = "samsung,exynos5433-tmu";
 			reg = <0x10060000 0x200>;
@@ -697,6 +704,7 @@
 			compatible = "samsung,exynos5433-pinctrl";
 			reg = <0x15690000 0x1000>;
 			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&pd_fsys>;
 		};
 
 		pinctrl_imem: pinctrl@11090000 {
@@ -1417,6 +1425,7 @@
 			clocks = <&cmu_fsys CLK_ACLK_USBDRD30>,
 				<&cmu_fsys CLK_SCLK_USBDRD30>;
 			clock-names = "usbdrd30", "usbdrd30_susp_clk";
+			power-domains = <&pd_fsys>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1442,6 +1451,7 @@
 					"itp";
 			#phy-cells = <1>;
 			samsung,pmu-syscon = <&pmu_system_controller>;
+			power-domains = <&pd_fsys>;
 			status = "disabled";
 		};
 
@@ -1456,6 +1466,7 @@
 					"itp";
 			#phy-cells = <1>;
 			samsung,pmu-syscon = <&pmu_system_controller>;
+			power-domains = <&pd_fsys>;
 			status = "disabled";
 		};
 
@@ -1464,6 +1475,7 @@
 			clocks = <&cmu_fsys CLK_ACLK_USBHOST30>,
 				<&cmu_fsys CLK_SCLK_USBHOST30>;
 			clock-names = "usbdrd30", "usbdrd30_susp_clk";
+			power-domains = <&pd_fsys>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1488,6 +1500,7 @@
 				<&cmu_fsys CLK_SCLK_MMC0>;
 			clock-names = "biu", "ciu";
 			fifo-depth = <0x40>;
+			power-domains = <&pd_fsys>;
 			status = "disabled";
 		};
 
@@ -1501,6 +1514,7 @@
 				<&cmu_fsys CLK_SCLK_MMC1>;
 			clock-names = "biu", "ciu";
 			fifo-depth = <0x40>;
+			power-domains = <&pd_fsys>;
 			status = "disabled";
 		};
 
@@ -1514,6 +1528,7 @@
 				<&cmu_fsys CLK_SCLK_MMC2>;
 			clock-names = "biu", "ciu";
 			fifo-depth = <0x40>;
+			power-domains = <&pd_fsys>;
 			status = "disabled";
 		};
 
-- 
1.9.1

