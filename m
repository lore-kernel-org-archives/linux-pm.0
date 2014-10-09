From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 10/21] thermal: cpu_cooling: dts: Define device tree bindings
 for Exynos cpu cooling functionality
Date: Thu, 09 Oct 2014 18:38:46 +0200
Message-ID: <1412872737-624-11-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Presented patch aims to move data necessary for correct CPU cooling device
configuration from exynos_tmu_data.c to device tree.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 arch/arm/boot/dts/exynos4210-trats.dts          | 15 +++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi               |  5 ++++-
 arch/arm/boot/dts/exynos4212.dtsi               |  5 ++++-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 15 +++++++++++++++
 arch/arm/boot/dts/exynos4412.dtsi               |  5 ++++-
 arch/arm/boot/dts/exynos5250.dtsi               | 20 +++++++++++++++++++-
 6 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index b59019c..d9dd9a7 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -428,6 +428,21 @@
 		status = "okay";
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			cooling-maps {
+				map0 {
+				    /* Corresponds to 800MHz at freq_table */
+				    cooling-device = <&cpu0 2 2>;
+				};
+				map1 {
+				   /* Corresponds to 200MHz at freq_table */
+				   cooling-device = <&cpu0 4 4>;
+			       };
+		       };
+		};
+	};
+
 	camera {
 		pinctrl-names = "default";
 		pinctrl-0 = <>;
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 477d455..10e8915 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -45,10 +45,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0x900>;
+			cooling-min-level = <4>;
+			cooling-max-level = <2>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu@1 {
diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 484a2da..6405954 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -26,10 +26,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA00>;
+			cooling-min-level = <13>;
+			cooling-max-level = <7>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu@1 {
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 5d4ecc3..28e7a4c 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -379,6 +379,21 @@
 		vtmu-supply = <&ldo10_reg>;
 		status = "okay";
 	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			cooling-maps {
+				map0 {
+				    /* Corresponds to 800MHz at freq_table */
+				    cooling-device = <&cpu0 7 7>;
+				};
+				map1 {
+				   /* Corresponds to 200MHz at freq_table */
+				   cooling-device = <&cpu0 13 13>;
+			       };
+		       };
+		};
+	};
 };
 
 &pinctrl_1 {
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 529fd13..9ed8925 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -26,10 +26,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA00>;
+			cooling-min-level = <13>;
+			cooling-max-level = <7>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu@1 {
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 492e1ef..c322fb9 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -58,11 +58,14 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 			clock-frequency = <1700000000>;
+			cooling-min-level = <15>;
+			cooling-max-level = <9>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 		cpu@1 {
 			device_type = "cpu";
@@ -241,6 +244,21 @@
 		clock-names = "tmu_apbif";
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			cooling-maps {
+				map0 {
+				    /* Corresponds to 800MHz at freq_table */
+				    cooling-device = <&cpu0 9 9>;
+				};
+				map1 {
+				   /* Corresponds to 200MHz at freq_table */
+				   cooling-device = <&cpu0 15 15>;
+			       };
+		       };
+		};
+	};
+
 	serial@12C00000 {
 		clocks = <&clock CLK_UART0>, <&clock CLK_SCLK_UART0>;
 		clock-names = "uart", "clk_uart_baud0";
-- 
2.0.0.rc2
