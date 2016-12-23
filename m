From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/9] ARM: dts: exynos: Add PMU syscon to pinctrl nodes
Date: Fri, 23 Dec 2016 13:24:41 +0100
Message-ID: <1482495889-6201-2-git-send-email-m.szyprowski@samsung.com>
References: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161223122516epcas5p41c9d3f1e805293ee7f000d614452ba6f@epcas5p4.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Access to PMU regmap is needed to properly release pad retention after
suspend/resume cycle.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 2 ++
 arch/arm/boot/dts/exynos4210.dtsi | 3 +++
 arch/arm/boot/dts/exynos4x12.dtsi | 3 +++
 arch/arm/boot/dts/exynos5250.dtsi | 4 ++++
 arch/arm/boot/dts/exynos5420.dtsi | 5 +++++
 5 files changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index ba17ee1eb749..3614b7953fac 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -260,6 +260,7 @@
 			compatible = "samsung,exynos3250-pinctrl";
 			reg = <0x11000000 0x1000>;
 			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
 
 			wakeup-interrupt-controller {
 				compatible = "samsung,exynos4210-wakeup-eint";
@@ -271,6 +272,7 @@
 			compatible = "samsung,exynos3250-pinctrl";
 			reg = <0x11400000 0x1000>;
 			interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
 		};
 
 		jpeg: codec@11830000 {
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 7f3a18c8f60f..c719aaf50f3b 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -128,12 +128,14 @@
 		compatible = "samsung,exynos4210-pinctrl";
 		reg = <0x11400000 0x1000>;
 		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+		samsung,pmu-syscon = <&pmu_system_controller>;
 	};
 
 	pinctrl_1: pinctrl@11000000 {
 		compatible = "samsung,exynos4210-pinctrl";
 		reg = <0x11000000 0x1000>;
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+		samsung,pmu-syscon = <&pmu_system_controller>;
 
 		wakup_eint: wakeup-interrupt-controller {
 			compatible = "samsung,exynos4210-wakeup-eint";
@@ -145,6 +147,7 @@
 	pinctrl_2: pinctrl@03860000 {
 		compatible = "samsung,exynos4210-pinctrl";
 		reg = <0x03860000 0x1000>;
+		samsung,pmu-syscon = <&pmu_system_controller>;
 	};
 
 	tmu: tmu@100C0000 {
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 85a7122658f1..54b65c4accd6 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -546,12 +546,14 @@
 	compatible = "samsung,exynos4x12-pinctrl";
 	reg = <0x11400000 0x1000>;
 	interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+	samsung,pmu-syscon = <&pmu_system_controller>;
 };
 
 &pinctrl_1 {
 	compatible = "samsung,exynos4x12-pinctrl";
 	reg = <0x11000000 0x1000>;
 	interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+	samsung,pmu-syscon = <&pmu_system_controller>;
 
 	wakup_eint: wakeup-interrupt-controller {
 		compatible = "samsung,exynos4210-wakeup-eint";
@@ -565,6 +567,7 @@
 	reg = <0x03860000 0x1000>;
 	interrupt-parent = <&combiner>;
 	interrupts = <10 0>;
+	samsung,pmu-syscon = <&pmu_system_controller>;
 };
 
 &pinctrl_3 {
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index b6d7444d8585..ffff28f89589 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -196,6 +196,7 @@
 			compatible = "samsung,exynos5250-pinctrl";
 			reg = <0x11400000 0x1000>;
 			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
 
 			wakup_eint: wakeup-interrupt-controller {
 				compatible = "samsung,exynos4210-wakeup-eint";
@@ -208,18 +209,21 @@
 			compatible = "samsung,exynos5250-pinctrl";
 			reg = <0x13400000 0x1000>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
 		};
 
 		pinctrl_2: pinctrl@10d10000 {
 			compatible = "samsung,exynos5250-pinctrl";
 			reg = <0x10d10000 0x1000>;
 			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
 		};
 
 		pinctrl_3: pinctrl@03860000 {
 			compatible = "samsung,exynos5250-pinctrl";
 			reg = <0x03860000 0x1000>;
 			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
 		};
 
 		pmu_system_controller: system-controller@10040000 {
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 906a1a42a7ea..832cb56c514e 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -321,6 +321,7 @@
 			compatible = "samsung,exynos5420-pinctrl";
 			reg = <0x13400000 0x1000>;
 			interrupts = <0 45 IRQ_TYPE_LEVEL_HIGH>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
 
 			wakeup-interrupt-controller {
 				compatible = "samsung,exynos4210-wakeup-eint";
@@ -333,24 +334,28 @@
 			compatible = "samsung,exynos5420-pinctrl";
 			reg = <0x13410000 0x1000>;
 			interrupts = <0 78 IRQ_TYPE_LEVEL_HIGH>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
 		};
 
 		pinctrl_2: pinctrl@14000000 {
 			compatible = "samsung,exynos5420-pinctrl";
 			reg = <0x14000000 0x1000>;
 			interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
 		};
 
 		pinctrl_3: pinctrl@14010000 {
 			compatible = "samsung,exynos5420-pinctrl";
 			reg = <0x14010000 0x1000>;
 			interrupts = <0 50 IRQ_TYPE_LEVEL_HIGH>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
 		};
 
 		pinctrl_4: pinctrl@03860000 {
 			compatible = "samsung,exynos5420-pinctrl";
 			reg = <0x03860000 0x1000>;
 			interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
 		};
 
 		amba {
-- 
1.9.1
