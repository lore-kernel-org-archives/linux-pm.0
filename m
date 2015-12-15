From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v6 3/7] ARM: dts: Exynos542x/5800: add CPU OPP properties
Date: Tue, 15 Dec 2015 18:33:17 +0100
Message-ID: <1450200801-24539-4-git-send-email-b.zolnierkie@samsung.com>
References: <1450200801-24539-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1450200801-24539-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Gamari <ben@smart-cactus.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>
List-Id: linux-pm@vger.kernel.org

From: Thomas Abraham <thomas.ab@samsung.com>

For Exynos542x/5800 platforms, add CPU operating points
for migrating from Exynos specific cpufreq driver to using
generic cpufreq driver.

Changes by Bartlomiej:
- split Exynos5420 support from the original patch
- merged Exynos5422 fixes from Ben

Changes by Ben Gamari:
- Port to operating-points-v2

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andreas Faerber <afaerber@suse.de>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos5420-cpus.dtsi |  10 +++
 arch/arm/boot/dts/exynos5420.dtsi      | 110 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-cpus.dtsi |  10 +++
 3 files changed, 130 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/exynos5420-cpus.dtsi
index 7aaf031..261d251 100644
--- a/arch/arm/boot/dts/exynos5420-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5420-cpus.dtsi
@@ -29,8 +29,10 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x0>;
+			clocks = <&clock CLK_ARM_CLK>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			operating-points-v2 = <&cluster_a15_opp_table>;
 		};
 
 		cpu1: cpu@1 {
@@ -39,6 +41,7 @@
 			reg = <0x1>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			operating-points-v2 = <&cluster_a15_opp_table>;
 		};
 
 		cpu2: cpu@2 {
@@ -47,6 +50,7 @@
 			reg = <0x2>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			operating-points-v2 = <&cluster_a15_opp_table>;
 		};
 
 		cpu3: cpu@3 {
@@ -55,14 +59,17 @@
 			reg = <0x3>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			operating-points-v2 = <&cluster_a15_opp_table>;
 		};
 
 		cpu4: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
+			clocks = <&clock CLK_KFC_CLK>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			operating-points-v2 = <&cluster_a7_opp_table>;
 		};
 
 		cpu5: cpu@101 {
@@ -71,6 +78,7 @@
 			reg = <0x101>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			operating-points-v2 = <&cluster_a7_opp_table>;
 		};
 
 		cpu6: cpu@102 {
@@ -79,6 +87,7 @@
 			reg = <0x102>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			operating-points-v2 = <&cluster_a7_opp_table>;
 		};
 
 		cpu7: cpu@103 {
@@ -87,6 +96,7 @@
 			reg = <0x103>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			operating-points-v2 = <&cluster_a7_opp_table>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 29b7cba..2458bdf 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -50,6 +50,116 @@
 		usbdrdphy1 = &usbdrd_phy1;
 	};
 
+	cluster_a15_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp@1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <140000>;
+		};
+		opp@1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <1212500>;
+			clock-latency-ns = <140000>;
+		};
+		opp@1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <1175000>;
+			clock-latency-ns = <140000>;
+		};
+		opp@1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <1137500>;
+			clock-latency-ns = <140000>;
+		};
+		opp@1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <1112500>;
+			clock-latency-ns = <140000>;
+		};
+		opp@1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1062500>;
+			clock-latency-ns = <140000>;
+		};
+		opp@1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1037500>;
+			clock-latency-ns = <140000>;
+		};
+		opp@1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1012500>;
+			clock-latency-ns = <140000>;
+		};
+		opp@1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = < 987500>;
+			clock-latency-ns = <140000>;
+		};
+		opp@900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = < 962500>;
+			clock-latency-ns = <140000>;
+		};
+		opp@800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = < 937500>;
+			clock-latency-ns = <140000>;
+		};
+		opp@700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = < 912500>;
+			clock-latency-ns = <140000>;
+		};
+	};
+
+	cluster_a7_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp@1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1275000>;
+			clock-latency-ns = <140000>;
+		};
+		opp@1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1212500>;
+			clock-latency-ns = <140000>;
+		};
+		opp@1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1162500>;
+			clock-latency-ns = <140000>;
+		};
+		opp@1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1112500>;
+			clock-latency-ns = <140000>;
+		};
+		opp@900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <1062500>;
+			clock-latency-ns = <140000>;
+		};
+		opp@800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1025000>;
+			clock-latency-ns = <140000>;
+		};
+		opp@700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <975000>;
+			clock-latency-ns = <140000>;
+		};
+		opp@600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <937500>;
+			clock-latency-ns = <140000>;
+		};
+	};
+
 	/*
 	 * The 'cpus' node is not present here but instead it is provided
 	 * by exynos5420-cpus.dtsi or exynos5422-cpus.dtsi.
diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
index 33028ac..9b46b9f 100644
--- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
@@ -28,8 +28,10 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
+			clocks = <&clock CLK_KFC_CLK>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			operating-points-v2 = <&cluster_a7_opp_table>;
 		};
 
 		cpu1: cpu@101 {
@@ -38,6 +40,7 @@
 			reg = <0x101>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			operating-points-v2 = <&cluster_a7_opp_table>;
 		};
 
 		cpu2: cpu@102 {
@@ -46,6 +49,7 @@
 			reg = <0x102>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			operating-points-v2 = <&cluster_a7_opp_table>;
 		};
 
 		cpu3: cpu@103 {
@@ -54,14 +58,17 @@
 			reg = <0x103>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			operating-points-v2 = <&cluster_a7_opp_table>;
 		};
 
 		cpu4: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
+			clocks = <&clock CLK_ARM_CLK>;
 			reg = <0x0>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			operating-points-v2 = <&cluster_a15_opp_table>;
 		};
 
 		cpu5: cpu@1 {
@@ -70,6 +77,7 @@
 			reg = <0x1>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			operating-points-v2 = <&cluster_a15_opp_table>;
 		};
 
 		cpu6: cpu@2 {
@@ -78,6 +86,7 @@
 			reg = <0x2>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			operating-points-v2 = <&cluster_a15_opp_table>;
 		};
 
 		cpu7: cpu@3 {
@@ -86,6 +95,7 @@
 			reg = <0x3>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			operating-points-v2 = <&cluster_a15_opp_table>;
 		};
 	};
 };
-- 
1.9.1
