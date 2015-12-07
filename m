From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v4 3/8] ARM: dts: Exynos5420: add CPU OPP properties
Date: Mon, 07 Dec 2015 19:18:15 +0100
Message-ID: <1449512300-17230-4-git-send-email-b.zolnierkie@samsung.com>
References: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Gamari <ben@smart-cactus.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Doug Anderson <dianders@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Andreas Faerber <afaerber@suse.de>, Sachin Kamat <sachin.kamat@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Thomas Abraham <thomas.ab@samsung.com>

For Exynos5420 platforms, add CPU operating points for
migrating from Exynos specific cpufreq driver to using
generic cpufreq driver.

Changes by Bartlomiej:
- split Exynos5420 support from the original patch

Changes by Ben Gamari:
- Port to operating-points-v2

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 122 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 48a0a55..f8f70a5 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -50,6 +50,116 @@
 		usbdrdphy1 = &usbdrd_phy1;
 	};
 
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp00@1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <140000>;
+		};
+		opp01@1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <1212500>;
+			clock-latency-ns = <140000>;
+		};
+		opp02@1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <1175000>;
+			clock-latency-ns = <140000>;
+		};
+		opp03@1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <1137500>;
+			clock-latency-ns = <140000>;
+		};
+		opp04@1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <1112500>;
+			clock-latency-ns = <140000>;
+		};
+		opp05@1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1062500>;
+			clock-latency-ns = <140000>;
+		};
+		opp06@1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1037500>;
+			clock-latency-ns = <140000>;
+		};
+		opp07@1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1012500>;
+			clock-latency-ns = <140000>;
+		};
+		opp08@1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = < 987500>;
+			clock-latency-ns = <140000>;
+		};
+		opp09@900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = < 962500>;
+			clock-latency-ns = <140000>;
+		};
+		opp10@800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = < 937500>;
+			clock-latency-ns = <140000>;
+		};
+		opp11@700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = < 912500>;
+			clock-latency-ns = <140000>;
+		};
+	};
+
+	cpu1_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp00@1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1275000>;
+			clock-latency-ns = <140000>;
+		};
+		opp01@1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1212500>;
+			clock-latency-ns = <140000>;
+		};
+		opp02@1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1162500>;
+			clock-latency-ns = <140000>;
+		};
+		opp03@1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1112500>;
+			clock-latency-ns = <140000>;
+		};
+		opp04@900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <1062500>;
+			clock-latency-ns = <140000>;
+		};
+		opp05@800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1025000>;
+			clock-latency-ns = <140000>;
+		};
+		opp06@700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <975000>;
+			clock-latency-ns = <140000>;
+		};
+		opp07@600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <937500>;
+			clock-latency-ns = <140000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -58,8 +168,11 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x0>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu-cluster.0";
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu1: cpu@1 {
@@ -68,6 +181,7 @@
 			reg = <0x1>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu2: cpu@2 {
@@ -76,6 +190,7 @@
 			reg = <0x2>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu3: cpu@3 {
@@ -84,14 +199,18 @@
 			reg = <0x3>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu4: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
+			clocks = <&clock CLK_KFC_CLK>;
+			clock-names = "cpu-cluster.1";
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			operating-points-v2 = <&cpu1_opp_table>;
 		};
 
 		cpu5: cpu@101 {
@@ -100,6 +219,7 @@
 			reg = <0x101>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			operating-points-v2 = <&cpu1_opp_table>;
 		};
 
 		cpu6: cpu@102 {
@@ -108,6 +228,7 @@
 			reg = <0x102>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			operating-points-v2 = <&cpu1_opp_table>;
 		};
 
 		cpu7: cpu@103 {
@@ -116,6 +237,7 @@
 			reg = <0x103>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			operating-points-v2 = <&cpu1_opp_table>;
 		};
 	};
 
-- 
1.9.1
