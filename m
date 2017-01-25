From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 6/8] arm64: dts: exynos: Add AUD power domain to Exynos5433 SoC
Date: Wed, 25 Jan 2017 12:55:40 +0100
Message-ID: <1485345342-3273-7-git-send-email-m.szyprowski@samsung.com>
References: <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125115601eucas1p29decb9c2daf4c3fcb9d796392f5d69ba@eucas1p2.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50456 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbdAYL4H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2017 06:56:07 -0500
In-reply-to: <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>

This patch adds support for AUD power domain to Exynos5433 SoCs, which
contains following devices: a clock controller, a pin controller, LPASS
module, I2S controller, ADMA PL330 engine and UART #3 device.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 3487981726d9..24fc3b46cc40 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -377,6 +377,7 @@
 			#clock-cells = <1>;
 			clock-names = "oscclk", "fout_aud_pll";
 			clocks = <&xxti>, <&cmu_top CLK_FOUT_AUD_PLL>;
+			power-domains = <&pd_aud>;
 		};
 
 		cmu_bus0: clock-controller@13600000 {
@@ -553,6 +554,12 @@
 			#power-domain-cells = <0>;
 		};
 
+		pd_aud: aud-power-domain@105c40c0 {
+			compatible = "samsung,exynos5433-pd";
+			reg = <0x105c40c0 0x20>;
+			#power-domain-cells = <0>;
+		};
+
 		tmu_atlas0: tmu@10060000 {
 			compatible = "samsung,exynos5433-tmu";
 			reg = <0x10060000 0x200>;
@@ -665,6 +672,7 @@
 			compatible = "samsung,exynos5433-pinctrl";
 			reg = <0x114b0000 0x1000>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&pd_aud>;
 		};
 
 		pinctrl_cpif: pinctrl@10fe0000 {
@@ -1544,6 +1552,7 @@
 			clocks = <&cmu_aud CLK_PCLK_SFR0_CTRL>;
 			clock-names = "sfr0_ctrl";
 			samsung,pmu-syscon = <&pmu_system_controller>;
+			power-domains = <&pd_aud>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1557,6 +1566,7 @@
 				#dma-cells = <1>;
 				#dma-channels = <8>;
 				#dma-requests = <32>;
+				power-domains = <&pd_aud>;
 			};
 
 			i2s0: i2s0@11440000 {
@@ -1573,6 +1583,7 @@
 				clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
 				pinctrl-names = "default";
 				pinctrl-0 = <&i2s0_bus>;
+				power-domains = <&pd_aud>;
 				status = "disabled";
 			};
 
@@ -1585,6 +1596,7 @@
 				clock-names = "uart", "clk_uart_baud0";
 				pinctrl-names = "default";
 				pinctrl-0 = <&uart_aud_bus>;
+				power-domains = <&pd_aud>;
 				status = "disabled";
 			};
 		};
-- 
1.9.1

