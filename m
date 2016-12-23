From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 9/9] ARM: dts: exynos: Add audio power domain support to
 Exynos542x SoCs
Date: Fri, 23 Dec 2016 13:24:49 +0100
Message-ID: <1482495889-6201-10-git-send-email-m.szyprowski@samsung.com>
References: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161223122546epcas5p2ebbcb8ca510646698bbd1ddbe0a0e889@epcas5p2.samsung.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-reply-to: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Audio power domain includes following hardware modules: Pin controller
for GPZ bank, AudioSS clock controller, PL330 ADMA device and Exynos I2S
controller.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 0a7ecdd4c5de..1b6bd9aa42d1 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -188,6 +188,7 @@
 			clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MAU_EPLL>,
 				 <&clock CLK_SCLK_MAUDIO0>, <&clock CLK_SCLK_MAUPCM0>;
 			clock-names = "pll_ref", "pll_in", "sclk_audio", "sclk_pcm_in";
+			power-domains = <&mau_pd>;
 		};
 
 		mfc: codec@11000000 {
@@ -317,6 +318,12 @@
 			clock-names = "oscclk", "clk0", "clk1", "clk2", "asb0", "asb1";
 		};
 
+		mau_pd: power-domain@100440E0 {
+			compatible = "samsung,exynos4210-pd";
+			reg = <0x100440E0 0x20>;
+			#power-domain-cells = <0>;
+		};
+
 		pinctrl_0: pinctrl@13400000 {
 			compatible = "samsung,exynos5420-pinctrl";
 			reg = <0x13400000 0x1000>;
@@ -356,6 +363,7 @@
 			reg = <0x03860000 0x1000>;
 			interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
 			samsung,pmu-syscon = <&pmu_system_controller>;
+			power-domains = <&mau_pd>;
 		};
 
 		amba {
@@ -374,6 +382,7 @@
 				#dma-cells = <1>;
 				#dma-channels = <6>;
 				#dma-requests = <16>;
+				power-domains = <&mau_pd>;
 			};
 
 			pdma0: pdma@121A0000 {
@@ -447,6 +456,7 @@
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2s0_bus>;
 			pinctrl-1 = <&i2s0_bus_slp>;
+			power-domains = <&mau_pd>;
 			status = "disabled";
 		};
 
-- 
1.9.1

