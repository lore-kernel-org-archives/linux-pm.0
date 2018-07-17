From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH 5/5] ARM: dts: exynos: add tmu aliases nodes
Date: Tue, 17 Jul 2018 10:12:22 +0000
Message-ID: <1531822342-4293-5-git-send-email-linux.amoon@gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
List-Id: linux-pm@vger.kernel.org

add tmuctrl aliases node for exynos542x

CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |  8 ++++----
 arch/arm/boot/dts/exynos5420.dtsi                  | 20 ++++++++++++--------
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  8 ++++----
 arch/arm/boot/dts/exynos5422-odroidhc1.dts         |  8 ++++----
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  8 ++++----
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |  8 ++++----
 6 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 57c2332..ff79f0b 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -1061,19 +1061,19 @@
 	status = "okay";
 };
 
-&tmu_cpu0 {
+&tmu_cpu_0 {
 	vtmu-supply = <&ldo10_reg>;
 };
 
-&tmu_cpu1 {
+&tmu_cpu_1 {
 	vtmu-supply = <&ldo10_reg>;
 };
 
-&tmu_cpu2 {
+&tmu_cpu_2 {
 	vtmu-supply = <&ldo10_reg>;
 };
 
-&tmu_cpu3 {
+&tmu_cpu_3 {
 	vtmu-supply = <&ldo10_reg>;
 };
 
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index f4e8c58..c0441ca 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -35,6 +35,10 @@
 		spi0 = &spi_0;
 		spi1 = &spi_1;
 		spi2 = &spi_2;
+		tmuctrl0 = &tmu_cpu_0;
+		tmuctrl1 = &tmu_cpu_1;
+		tmuctrl2 = &tmu_cpu_2;
+		tmuctrl3 = &tmu_cpu_3;
 	};
 
 	/*
@@ -732,7 +736,7 @@
 			interrupt-parent = <&gic>;
 		};
 
-		tmu_cpu0: tmu@10060000 {
+		tmu_cpu_0: tmu@10060000 {
 			compatible = "samsung,exynos5420-tmu";
 			reg = <0x10060000 0x100>;
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
@@ -741,7 +745,7 @@
 			#include "exynos5420-tmu-sensor-conf.dtsi"
 		};
 
-		tmu_cpu1: tmu@10064000 {
+		tmu_cpu_1: tmu@10064000 {
 			compatible = "samsung,exynos5420-tmu";
 			reg = <0x10064000 0x100>;
 			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
@@ -750,7 +754,7 @@
 			#include "exynos5420-tmu-sensor-conf.dtsi"
 		};
 
-		tmu_cpu2: tmu@10068000 {
+		tmu_cpu_2: tmu@10068000 {
 			compatible = "samsung,exynos5420-tmu-ext-triminfo";
 			reg = <0x10068000 0x100>, <0x1006c000 0x4>;
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
@@ -759,7 +763,7 @@
 			#include "exynos5420-tmu-sensor-conf.dtsi"
 		};
 
-		tmu_cpu3: tmu@1006c000 {
+		tmu_cpu_3: tmu@1006c000 {
 			compatible = "samsung,exynos5420-tmu-ext-triminfo";
 			reg = <0x1006c000 0x100>, <0x100a0000 0x4>;
 			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
@@ -1341,19 +1345,19 @@
 
 	thermal-zones {
 		cpu0_thermal: cpu0-thermal {
-			thermal-sensors = <&tmu_cpu0>;
+			thermal-sensors = <&tmu_cpu_0>;
 			#include "exynos5420-trip-points.dtsi"
 		};
 		cpu1_thermal: cpu1-thermal {
-		       thermal-sensors = <&tmu_cpu1>;
+		       thermal-sensors = <&tmu_cpu_1>;
 		       #include "exynos5420-trip-points.dtsi"
 		};
 		cpu2_thermal: cpu2-thermal {
-		       thermal-sensors = <&tmu_cpu2>;
+		       thermal-sensors = <&tmu_cpu_2>;
 		       #include "exynos5420-trip-points.dtsi"
 		};
 		cpu3_thermal: cpu3-thermal {
-		       thermal-sensors = <&tmu_cpu3>;
+		       thermal-sensors = <&tmu_cpu_3>;
 		       #include "exynos5420-trip-points.dtsi"
 		};
 		gpu_thermal: gpu-thermal {
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 2f4f408..e28091f 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -397,19 +397,19 @@
 	};
 };
 
-&tmu_cpu0 {
+&tmu_cpu_0 {
 	vtmu-supply = <&ldo7_reg>;
 };
 
-&tmu_cpu1 {
+&tmu_cpu_1 {
 	vtmu-supply = <&ldo7_reg>;
 };
 
-&tmu_cpu2 {
+&tmu_cpu_2 {
 	vtmu-supply = <&ldo7_reg>;
 };
 
-&tmu_cpu3 {
+&tmu_cpu_3 {
 	vtmu-supply = <&ldo7_reg>;
 };
 
diff --git a/arch/arm/boot/dts/exynos5422-odroidhc1.dts b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
index 8f332be..310222f 100644
--- a/arch/arm/boot/dts/exynos5422-odroidhc1.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
@@ -29,7 +29,7 @@
 
 	thermal-zones {
 		cpu0_thermal: cpu0-thermal {
-			thermal-sensors = <&tmu_cpu0 0>;
+			thermal-sensors = <&tmu_cpu_0 0>;
 			trips {
 				cpu0_alert0: cpu-alert-0 {
 					temperature = <70000>; /* millicelsius */
@@ -78,7 +78,7 @@
 			};
 		};
 		cpu1_thermal: cpu1-thermal {
-			thermal-sensors = <&tmu_cpu1 0>;
+			thermal-sensors = <&tmu_cpu_1 0>;
 			trips {
 				cpu1_alert0: cpu-alert-0 {
 					temperature = <70000>;
@@ -116,7 +116,7 @@
 			};
 		};
 		cpu2_thermal: cpu2-thermal {
-			thermal-sensors = <&tmu_cpu2 0>;
+			thermal-sensors = <&tmu_cpu_2 0>;
 			trips {
 				cpu2_alert0: cpu-alert-0 {
 					temperature = <70000>;
@@ -154,7 +154,7 @@
 			};
 		};
 		cpu3_thermal: cpu3-thermal {
-			thermal-sensors = <&tmu_cpu3 0>;
+			thermal-sensors = <&tmu_cpu_3 0>;
 			trips {
 				cpu3_alert0: cpu-alert-0 {
 					temperature = <70000>;
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 96e281c..36af2ea 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -52,7 +52,7 @@
 
 	thermal-zones {
 		cpu0_thermal: cpu0-thermal {
-			thermal-sensors = <&tmu_cpu0 0>;
+			thermal-sensors = <&tmu_cpu_0 0>;
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 			trips {
@@ -135,7 +135,7 @@
 			};
 		};
 		cpu1_thermal: cpu1-thermal {
-			thermal-sensors = <&tmu_cpu1 0>;
+			thermal-sensors = <&tmu_cpu_1 0>;
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 			trips {
@@ -202,7 +202,7 @@
 			};
 		};
 		cpu2_thermal: cpu2-thermal {
-			thermal-sensors = <&tmu_cpu2 0>;
+			thermal-sensors = <&tmu_cpu_2 0>;
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 			trips {
@@ -269,7 +269,7 @@
 			};
 		};
 		cpu3_thermal: cpu3-thermal {
-			thermal-sensors = <&tmu_cpu3 0>;
+			thermal-sensors = <&tmu_cpu_3 0>;
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 			trips {
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index d80ab90..c976d02 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -1030,19 +1030,19 @@
 	status = "okay";
 };
 
-&tmu_cpu0 {
+&tmu_cpu_0 {
 	vtmu-supply = <&ldo10_reg>;
 };
 
-&tmu_cpu1 {
+&tmu_cpu_1 {
 	vtmu-supply = <&ldo10_reg>;
 };
 
-&tmu_cpu2 {
+&tmu_cpu_2 {
 	vtmu-supply = <&ldo10_reg>;
 };
 
-&tmu_cpu3 {
+&tmu_cpu_3 {
 	vtmu-supply = <&ldo10_reg>;
 };
 
-- 
2.7.4
