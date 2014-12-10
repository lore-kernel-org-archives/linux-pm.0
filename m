From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v2 06/17] thermal: cpu_cooling: dts: Define device tree
 bindings for Exynos cpu cooling functionality
Date: Wed, 10 Dec 2014 13:09:45 +0100
Message-ID: <1418213396-743-7-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1418213396-743-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Presented patch aims to move data necessary for correct CPU cooling device
configuration from exynos_tmu_data.c to device tree.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- None
---
 arch/arm/boot/dts/exynos4210-trats.dts          | 15 ++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi               | 20 ++++++++++++++++
 arch/arm/boot/dts/exynos4212.dtsi               | 20 ++++++++++++++++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 15 ++++++++++++
 arch/arm/boot/dts/exynos4412-trats2.dts         | 15 ++++++++++++
 arch/arm/boot/dts/exynos4412.dtsi               | 32 +++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi               | 20 +++++++++++++++-
 7 files changed, 136 insertions(+), 1 deletion(-)

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
index 807bb5b..10e8915 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -41,6 +41,26 @@
 		#clock-cells = <1>;
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x900>;
+			cooling-min-level = <4>;
+			cooling-max-level = <2>;
+			#cooling-cells = <2>; /* min followed by max */
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x901>;
+		};
+	};
+
 	sysram@02020000 {
 		compatible = "mmio-sram";
 		reg = <0x02020000 0x20000>;
diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 3c00e6e..6405954 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -22,6 +22,26 @@
 / {
 	compatible = "samsung,exynos4212", "samsung,exynos4";
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xA00>;
+			cooling-min-level = <13>;
+			cooling-max-level = <7>;
+			#cooling-cells = <2>; /* min followed by max */
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xA01>;
+		};
+	};
+
 	combiner: interrupt-controller@10440000 {
 		samsung,combiner-nr = <18>;
 	};
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index eb1c08c..15d45f0 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -375,6 +375,21 @@
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
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 121430d..396c525 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -786,4 +786,19 @@
 		pulldown-ohm = <100000>; /* 100K */
 		io-channels = <&adc 2>;  /* Battery temperature */
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
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index d8bc059e..9ed8925 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -22,6 +22,38 @@
 / {
 	compatible = "samsung,exynos4412", "samsung,exynos4";
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xA00>;
+			cooling-min-level = <13>;
+			cooling-max-level = <7>;
+			#cooling-cells = <2>; /* min followed by max */
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xA01>;
+		};
+
+		cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xA02>;
+		};
+
+		cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0xA03>;
+		};
+	};
+
 	combiner: interrupt-controller@10440000 {
 		samsung,combiner-nr = <20>;
 	};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index d55c1a2..a5bbc1a 100644
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
