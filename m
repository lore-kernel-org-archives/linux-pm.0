From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v6 06/18] arm: dts: Adding CPU cooling binding for Exynos SoCs
Date: Fri, 23 Jan 2015 13:09:59 +0100
Message-ID: <1422015010-11918-7-git-send-email-l.majewski@samsung.com>
References: <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
 <1422015010-11918-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1422015010-11918-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Presented patch aims to move data necessary for correct CPU cooling device
configuration from exynos_tmu_data.c to device tree.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- None
Changes for v3:
- Adjust CPU's DT nodes to work with newest ti-soc-thermal/next branch
- Patch title has been changed from "thermal: cpu_cooling: dts: ..."
Changes for v4:
- Spaces and tabs cleanup
Changes for v5:
- None
Changes for v6:
- None
---
 arch/arm/boot/dts/exynos4210-trats.dts          | 15 +++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi               |  5 ++++-
 arch/arm/boot/dts/exynos4212.dtsi               |  5 ++++-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 15 +++++++++++++++
 arch/arm/boot/dts/exynos4412-trats2.dts         | 15 +++++++++++++++
 arch/arm/boot/dts/exynos4412.dtsi               |  5 ++++-
 arch/arm/boot/dts/exynos5250.dtsi               | 20 +++++++++++++++++++-
 7 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 61009f4..e3879c0 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -428,6 +428,21 @@
 		status = "okay";
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			cooling-maps {
+				map0 {
+				     /* Corresponds to 800MHz at freq_table */
+				     cooling-device = <&cpu0 2 2>;
+				};
+				map1 {
+				     /* Corresponds to 200MHz at freq_table */
+				     cooling-device = <&cpu0 4 4>;
+			       };
+		       };
+		};
+	};
+
 	camera {
 		pinctrl-names = "default";
 		pinctrl-0 = <>;
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index bcc9e63..2e66df8 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -35,10 +35,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@900 {
+		cpu0: cpu@900 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0x900>;
+			cooling-min-level = <4>;
+			cooling-max-level = <2>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu@901 {
diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index dd0a43e..5be03288 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -26,10 +26,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@A00 {
+		cpu0: cpu@A00 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA00>;
+			cooling-min-level = <13>;
+			cooling-max-level = <7>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu@A01 {
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index c7517fc..25b4f7d 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -401,6 +401,21 @@
 		vtmu-supply = <&ldo10_reg>;
 		status = "okay";
 	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			cooling-maps {
+				map0 {
+				     /* Corresponds to 800MHz at freq_table */
+				     cooling-device = <&cpu0 7 7>;
+				};
+				map1 {
+				     /* Corresponds to 200MHz at freq_table */
+				     cooling-device = <&cpu0 13 13>;
+			       };
+		       };
+		};
+	};
 };
 
 &pinctrl_1 {
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 29231b4..52a7771 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -863,6 +863,21 @@
 		pulldown-ohm = <100000>; /* 100K */
 		io-channels = <&adc 2>;  /* Battery temperature */
 	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			cooling-maps {
+				map0 {
+				     /* Corresponds to 800MHz at freq_table */
+				     cooling-device = <&cpu0 7 7>;
+				};
+				map1 {
+				     /* Corresponds to 200MHz at freq_table */
+				     cooling-device = <&cpu0 13 13>;
+			       };
+		       };
+		};
+	};
 };
 
 &pinctrl_0 {
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 0f6ec93..68ad43b 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -26,10 +26,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@A00 {
+		cpu0: cpu@A00 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA00>;
+			cooling-min-level = <13>;
+			cooling-max-level = <7>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu@A01 {
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 0a229fc..4641d3c 100644
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
+				     /* Corresponds to 800MHz at freq_table */
+				     cooling-device = <&cpu0 9 9>;
+				};
+				map1 {
+				     /* Corresponds to 200MHz at freq_table */
+				     cooling-device = <&cpu0 15 15>;
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
