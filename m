From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v6 15/18] thermal: exynos: dts: Provide device tree bindings
 identical to the one in exynos_tmu_data.c
Date: Fri, 23 Jan 2015 13:10:07 +0100
Message-ID: <1422015010-11918-15-git-send-email-l.majewski@samsung.com>
References: <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
 <1422015010-11918-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1422015010-11918-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Presented device tree bindings provide data already hardcoded in the
exynos_tmu_data.c file.
After this commit, it should be possible to reuse common thermal core
framework in Exynos SoCs.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- Add proper TMU entries for exynos3250.dtsi
Changes for v3:
- Remove "type" DT properties, which will be extracted from compatible
- "samsung,tmu_" prefix for TMU specific properties has been added
Changes for v4:
- Providing mandatory properties for thermal-zones (Exynos4210 and Exynos5250)
Changes for v5:
- None
Changes for v6:
- None
---
 arch/arm/boot/dts/exynos3250.dtsi |  2 ++
 arch/arm/boot/dts/exynos4.dtsi    |  4 ++++
 arch/arm/boot/dts/exynos4210.dtsi | 25 ++++++++++++++++++++++++-
 arch/arm/boot/dts/exynos4x12.dtsi |  1 +
 arch/arm/boot/dts/exynos5250.dtsi |  9 +++++++--
 arch/arm/boot/dts/exynos5420.dtsi | 28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5440.dtsi | 18 ++++++++++++++++++
 7 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 2246549..8cc078c 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -18,6 +18,7 @@
  */
 
 #include "skeleton.dtsi"
+#include "exynos4-cpu-thermal.dtsi"
 #include <dt-bindings/clock/exynos3250.h>
 
 / {
@@ -188,6 +189,7 @@
 			interrupts = <0 216 0>;
 			clocks = <&cmu CLK_TMU_APBIF>;
 			clock-names = "tmu_apbif";
+			#include "exynos4412-tmu-sensor-conf.dtsi"
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index b8168f1..f18d746 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -645,4 +645,8 @@
 		samsung,sysreg = <&sys_reg>;
 		status = "disabled";
 	};
+
+	tmu: tmu@100C0000 {
+		#include "exynos4412-tmu-sensor-conf.dtsi"
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 2e66df8..78a43b0 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -21,6 +21,7 @@
 
 #include "exynos4.dtsi"
 #include "exynos4210-pinctrl.dtsi"
+#include "exynos4-cpu-thermal.dtsi"
 
 / {
 	compatible = "samsung,exynos4210", "samsung,exynos4";
@@ -146,16 +147,38 @@
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
+		samsung,tmu_gain = <15>;
+		samsung,tmu_reference_voltage = <7>;
 		status = "disabled";
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu 0>;
+
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
index 93b7040..3ee2031 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -19,6 +19,7 @@
 
 #include "exynos4.dtsi"
 #include "exynos4x12-pinctrl.dtsi"
+#include "exynos4-cpu-thermal.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 4641d3c..90211c0 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -20,7 +20,7 @@
 #include <dt-bindings/clock/exynos5250.h>
 #include "exynos5.dtsi"
 #include "exynos5250-pinctrl.dtsi"
-
+#include "exynos4-cpu-thermal.dtsi"
 #include <dt-bindings/clock/exynos-audss-clk.h>
 
 / {
@@ -236,16 +236,21 @@
 		status = "disabled";
 	};
 
-	tmu@10060000 {
+	tmu: tmu@10060000 {
 		compatible = "samsung,exynos5250-tmu";
 		reg = <0x10060000 0x100>;
 		interrupts = <0 65 0>;
 		clocks = <&clock CLK_TMU>;
 		clock-names = "tmu_apbif";
+		#include "exynos4412-tmu-sensor-conf.dtsi"
 	};
 
 	thermal-zones {
 		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tmu 0>;
+
 			cooling-maps {
 				map0 {
 				     /* Corresponds to 800MHz at freq_table */
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 517e50f..f5771e5 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -761,6 +761,7 @@
 		interrupts = <0 65 0>;
 		clocks = <&clock CLK_TMU>;
 		clock-names = "tmu_apbif";
+		#include "exynos4412-tmu-sensor-conf.dtsi"
 	};
 
 	tmu_cpu1: tmu@10064000 {
@@ -769,6 +770,7 @@
 		interrupts = <0 183 0>;
 		clocks = <&clock CLK_TMU>;
 		clock-names = "tmu_apbif";
+		#include "exynos4412-tmu-sensor-conf.dtsi"
 	};
 
 	tmu_cpu2: tmu@10068000 {
@@ -777,6 +779,7 @@
 		interrupts = <0 184 0>;
 		clocks = <&clock CLK_TMU>, <&clock CLK_TMU>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
+		#include "exynos4412-tmu-sensor-conf.dtsi"
 	};
 
 	tmu_cpu3: tmu@1006c000 {
@@ -785,6 +788,7 @@
 		interrupts = <0 185 0>;
 		clocks = <&clock CLK_TMU>, <&clock CLK_TMU_GPU>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
+		#include "exynos4412-tmu-sensor-conf.dtsi"
 	};
 
 	tmu_gpu: tmu@100a0000 {
@@ -793,6 +797,30 @@
 		interrupts = <0 215 0>;
 		clocks = <&clock CLK_TMU_GPU>, <&clock CLK_TMU>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
+		#include "exynos4412-tmu-sensor-conf.dtsi"
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
