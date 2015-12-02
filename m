From: Ben Gamari <ben@smart-cactus.org>
Subject: [PATCH 03/12] ARM: dts: Exynos5420: add CPU OPP and regulator supply
 property
Date: Wed,  2 Dec 2015 22:19:18 +0100
Message-ID: <1449091167-20758-4-git-send-email-ben@smart-cactus.org>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>, Ben Gamari <ben@smart-cactus.org>, Lukasz Majewski <l.majewski@samsung.com>, Kevin Hilman <khilman@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, b.zolnierkie@samsung.com, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Andreas Faerber <afaerber@suse.de>, Javier Martinez Canillas <javier@dowhile0.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sachin Kamat <sachin.kamat@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Thomas Abraham <thomas.ab@samsung.com>

For Exynos5420 platforms, add CPU operating points and CPU
regulator supply properties for migrating from Exynos specific
cpufreq driver to using generic cpufreq driver.

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
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
---
 arch/arm/boot/dts/exynos5420.dtsi | 122 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 1b3d6c7..262a7d8 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -50,6 +50,116 @@
 		usbdrdphy1 = &usbdrd_phy1;
 	};
 
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp00 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <140000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <1212500>;
+			clock-latency-ns = <140000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <1175000>;
+			clock-latency-ns = <140000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <1137500>;
+			clock-latency-ns = <140000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <1112500>;
+			clock-latency-ns = <140000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1062500>;
+			clock-latency-ns = <140000>;
+		};
+		opp06 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1037500>;
+			clock-latency-ns = <140000>;
+		};
+		opp07 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1012500>;
+			clock-latency-ns = <140000>;
+		};
+		opp08 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = < 987500>;
+			clock-latency-ns = <140000>;
+		};
+		opp09 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = < 962500>;
+			clock-latency-ns = <140000>;
+		};
+		opp10 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = < 937500>;
+			clock-latency-ns = <140000>;
+		};
+		opp11 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = < 912500>;
+			clock-latency-ns = <140000>;
+		};
+	};
+
+	cpu1_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp00 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1275000>;
+			clock-latency-ns = <140000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <1140000000>;
+			opp-microvolt = <1212500>;
+			clock-latency-ns = <140000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1162500>;
+			clock-latency-ns = <140000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1112500>;
+			clock-latency-ns = <140000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <1062500>;
+			clock-latency-ns = <140000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1025000>;
+			clock-latency-ns = <140000>;
+		};
+		opp06 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <975000>;
+			clock-latency-ns = <140000>;
+		};
+		opp07 {
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
2.6.2
