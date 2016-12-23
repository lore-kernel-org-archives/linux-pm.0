From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/9] ARM: dts: exynos: Add pinctrl sleep state for 542x i2s
 module
Date: Fri, 23 Dec 2016 13:24:42 +0100
Message-ID: <1482495889-6201-3-git-send-email-m.szyprowski@samsung.com>
References: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161223122520epcas1p443154371ae2f94b89e738051780a8e6b@epcas1p4.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:51553 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761190AbcLWMZW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Dec 2016 07:25:22 -0500
In-reply-to: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Add a special "sleep" state for Exynos I2S module. This state will be used
to let I2S driver to notify pin controller that it is ready for turning
power off, so the pin controller can also change its runtime state to
suspended and in the result let power domain to turn off.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi | 11 +++++++++++
 arch/arm/boot/dts/exynos5420.dtsi         |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
index 3924b4fafe72..52983b6a6859 100644
--- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
@@ -720,4 +720,15 @@
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
+
+	i2s0_bus_slp: i2s0-bus-slp {
+		samsung,pins = "gpz-0", "gpz-1", "gpz-2", "gpz-3",
+				"gpz-4", "gpz-5", "gpz-6";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+		samsung,pin-con-pdn = <EXYNOS_PIN_PDN_INPUT>;
+		samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_NONE>;
+		samsung,off-state;
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 832cb56c514e..0a7ecdd4c5de 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -444,8 +444,9 @@
 			clock-output-names = "i2s_cdclk0";
 			#sound-dai-cells = <1>;
 			samsung,idma-addr = <0x03000000>;
-			pinctrl-names = "default";
+			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2s0_bus>;
+			pinctrl-1 = <&i2s0_bus_slp>;
 			status = "disabled";
 		};
 
-- 
1.9.1

