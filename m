From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v2 12/17] thermal: exynos: dts: Provide device tree bindings
 identical to one in exynos_tmu_data.c
Date: Wed, 10 Dec 2014 13:09:51 +0100
Message-ID: <1418213396-743-13-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1418213396-743-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Presented device tree bindings provide data already hardcoded in the
exynos_tmu_data.c file.
After this commit, it should be possible to reuse common thermal core
framework in Exynos SoCs.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- Add proper TMU entries for exynos3250.dtsi
---
 arch/arm/boot/dts/exynos3250.dtsi |  4 ++++
 arch/arm/boot/dts/exynos4.dtsi    |  5 +++++
 arch/arm/boot/dts/exynos4210.dtsi | 23 ++++++++++++++++++++++-
 arch/arm/boot/dts/exynos4x12.dtsi |  3 +++
 arch/arm/boot/dts/exynos5250.dtsi |  7 +++++--
 arch/arm/boot/dts/exynos5420.dtsi | 33 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5440.dtsi | 18 ++++++++++++++++++
 7 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 693a327..6edfa76 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -18,7 +18,9 @@
  */
 
 #include "skeleton.dtsi"
+#include "exynos4-cpu-thermal.dtsi"
 #include <dt-bindings/clock/exynos3250.h>
+#include <dt-bindings/thermal/thermal_exynos.h>
 
 / {
 	compatible = "samsung,exynos3250";
@@ -188,6 +190,8 @@
 			interrupts = <0 216 0>;
 			clocks = <&cmu CLK_TMU_APBIF>;
 			clock-names = "tmu_apbif";
+			type = <SOC_ARCH_EXYNOS3250>;
+			#include "exynos4412-tmu-sensor-conf.dtsi"
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index e0278ec..1735bb3 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -21,6 +21,7 @@
 
 #include <dt-bindings/clock/exynos4.h>
 #include <dt-bindings/clock/exynos-audss-clk.h>
+#include <dt-bindings/thermal/thermal_exynos.h>
 #include "skeleton.dtsi"
 
 / {
@@ -645,4 +646,8 @@
 		samsung,sysreg = <&sys_reg>;
 		status = "disabled";
 	};
+
+	tmu: tmu@100C0000 {
+		#include "exynos4412-tmu-sensor-conf.dtsi"
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 10e8915..1c52681 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -21,6 +21,8 @@
 
 #include "exynos4.dtsi"
 #include "exynos4210-pinctrl.dtsi"
+#include "exynos4-cpu-thermal.dtsi"
+#include <dt-bindings/thermal/thermal_exynos.h>
 
 / {
 	compatible = "samsung,exynos4210", "samsung,exynos4";
@@ -146,16 +148,35 @@
 		reg = <0x03860000 0x1000>;
 	};
 
-	tmu@100C0000 {
+	tmu: tmu@100C0000 {
 		compatible = "samsung,exynos4210-tmu";
 		interrupt-parent = <&combiner>;
 		reg = <0x100C0000 0x100>;
 		interrupts = <2 4>;
 		clocks = <&clock CLK_TMU_APBIF>;
 		clock-names = "tmu_apbif";
+		gain = <15>;
+		reference_voltage = <7>;
+		type = <SOC_ARCH_EXYNOS4210>;
 		status = "disabled";
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			trips {
+			      cpu_alert0: cpu-alert-0 {
+				      temperature = <85000>; /* millicelsius */
+			      };
+			      cpu_alert1: cpu-alert-1 {
+				      temperature = <100000>; /* millicelsius */
+			      };
+			      cpu_alert2: cpu-alert-2 {
+				      temperature = <110000>; /* millicelsius */
+			      };
+			};
+		};
+	};
+
 	g2d@12800000 {
 		compatible = "samsung,s5pv210-g2d";
 		reg = <0x12800000 0x1000>;
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 2e9f1f7..ee24d83 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -19,6 +19,8 @@
 
 #include "exynos4.dtsi"
 #include "exynos4x12-pinctrl.dtsi"
+#include "exynos4-cpu-thermal.dtsi"
+#include <dt-bindings/thermal/thermal_exynos.h>
 
 / {
 	aliases {
@@ -279,6 +281,7 @@
 		reg = <0x100C0000 0x100>;
 		clocks = <&clock 383>;
 		clock-names = "tmu_apbif";
+		type = <SOC_ARCH_EXYNOS4412>;
 		status = "disabled";
 	};
 };
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index a5bbc1a..2167394 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -20,8 +20,9 @@
 #include <dt-bindings/clock/exynos5250.h>
 #include "exynos5.dtsi"
 #include "exynos5250-pinctrl.dtsi"
-
+#include "exynos4-cpu-thermal.dtsi"
 #include <dt-bindings/clock/exynos-audss-clk.h>
+#include <dt-bindings/thermal/thermal_exynos.h>
 
 / {
 	compatible = "samsung,exynos5250", "samsung,exynos5";
@@ -236,12 +237,14 @@
 		status = "disabled";
 	};
 
-	tmu@10060000 {
+	tmu: tmu@10060000 {
 		compatible = "samsung,exynos5250-tmu";
 		reg = <0x10060000 0x100>;
 		interrupts = <0 65 0>;
 		clocks = <&clock CLK_TMU>;
 		clock-names = "tmu_apbif";
+		type = <SOC_ARCH_EXYNOS5250>;
+		#include "exynos4412-tmu-sensor-conf.dtsi"
 	};
 
 	thermal-zones {
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 8617a03..23d488b 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -756,6 +756,8 @@
 		interrupts = <0 65 0>;
 		clocks = <&clock CLK_TMU>;
 		clock-names = "tmu_apbif";
+		#include "exynos4412-tmu-sensor-conf.dtsi"
+		type = <SOC_ARCH_EXYNOS5420>;
 	};
 
 	tmu_cpu1: tmu@10064000 {
@@ -764,6 +766,8 @@
 		interrupts = <0 183 0>;
 		clocks = <&clock CLK_TMU>;
 		clock-names = "tmu_apbif";
+		#include "exynos4412-tmu-sensor-conf.dtsi"
+		type = <SOC_ARCH_EXYNOS5420>;
 	};
 
 	tmu_cpu2: tmu@10068000 {
@@ -772,6 +776,8 @@
 		interrupts = <0 184 0>;
 		clocks = <&clock CLK_TMU>, <&clock CLK_TMU>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
+		#include "exynos4412-tmu-sensor-conf.dtsi"
+		type = <SOC_ARCH_EXYNOS5420_TRIMINFO>;
 	};
 
 	tmu_cpu3: tmu@1006c000 {
@@ -780,6 +786,8 @@
 		interrupts = <0 185 0>;
 		clocks = <&clock CLK_TMU>, <&clock CLK_TMU_GPU>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
+		#include "exynos4412-tmu-sensor-conf.dtsi"
+		type = <SOC_ARCH_EXYNOS5420_TRIMINFO>;
 	};
 
 	tmu_gpu: tmu@100a0000 {
@@ -788,6 +796,31 @@
 		interrupts = <0 215 0>;
 		clocks = <&clock CLK_TMU_GPU>, <&clock CLK_TMU>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
+		#include "exynos4412-tmu-sensor-conf.dtsi"
+		type = <SOC_ARCH_EXYNOS5420_TRIMINFO>;
+	};
+
+	thermal-zones {
+		cpu0_thermal: cpu0-thermal {
+			thermal-sensors = <&tmu_cpu0>;
+			#include "exynos5420-trip-points.dtsi"
+		};
+		cpu1_thermal: cpu1-thermal {
+		       thermal-sensors = <&tmu_cpu1>;
+		       #include "exynos5420-trip-points.dtsi"
+		};
+		cpu2_thermal: cpu2-thermal {
+		       thermal-sensors = <&tmu_cpu2>;
+		       #include "exynos5420-trip-points.dtsi"
+		};
+		cpu3_thermal: cpu3-thermal {
+		       thermal-sensors = <&tmu_cpu3>;
+		       #include "exynos5420-trip-points.dtsi"
+		};
+		gpu_thermal: gpu-thermal {
+		       thermal-sensors = <&tmu_gpu>;
+		       #include "exynos5420-trip-points.dtsi"
+		};
 	};
 
         watchdog: watchdog@101D0000 {
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 8f3373c..59d9416 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -219,6 +219,7 @@
 		interrupts = <0 58 0>;
 		clocks = <&clock CLK_B_125>;
 		clock-names = "tmu_apbif";
+		#include "exynos5440-tmu-sensor-conf.dtsi"
 	};
 
 	tmuctrl_1: tmuctrl@16011C {
@@ -227,6 +228,7 @@
 		interrupts = <0 58 0>;
 		clocks = <&clock CLK_B_125>;
 		clock-names = "tmu_apbif";
+		#include "exynos5440-tmu-sensor-conf.dtsi"
 	};
 
 	tmuctrl_2: tmuctrl@160120 {
@@ -235,6 +237,22 @@
 		interrupts = <0 58 0>;
 		clocks = <&clock CLK_B_125>;
 		clock-names = "tmu_apbif";
+		#include "exynos5440-tmu-sensor-conf.dtsi"
+	};
+
+	thermal-zones {
+		cpu0_thermal: cpu0-thermal {
+			thermal-sensors = <&tmuctrl_0>;
+			#include "exynos5440-trip-points.dtsi"
+		};
+		cpu1_thermal: cpu1-thermal {
+		       thermal-sensors = <&tmuctrl_1>;
+		       #include "exynos5440-trip-points.dtsi"
+		};
+		cpu2_thermal: cpu2-thermal {
+		       thermal-sensors = <&tmuctrl_2>;
+		       #include "exynos5440-trip-points.dtsi"
+		};
 	};
 
 	sata@210000 {
-- 
2.0.0.rc2
