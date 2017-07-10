From: <sean.wang@mediatek.com>
Subject: [PATCH v4 3/3] dt-bindings: cpufreq: enhance MediaTek cpufreq dt-binding document
Date: Mon, 10 Jul 2017 22:23:10 +0800
Message-ID: <8489dfbfc7ad8f849605709b1632f1835f075a33.1499692967.git.sean.wang@mediatek.com>
References: <cover.1499692967.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1499692967.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com, mark.rutland@arm.com, jamesjj.liao@mediatek.com, p.zabel@pengutronix.de, shunli.wang@mediatek.com, erin.lo@mediatek.com, jdelvare@suse.de, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Update binding document with adding operating-points-v2 as the required
property and the cooling level as the optional properties and adding more
examples guiding people how to use MediaTek cpufreq driver for MediaTek
SoCs.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../bindings/cpufreq/cpufreq-mediatek.txt          | 170 ++++++++++++++++++++-
 1 file changed, 167 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
index 52b457c..f640308 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
@@ -1,4 +1,5 @@
-Device Tree Clock bindins for CPU DVFS of Mediatek MT8173 SoC
+Binding for MediaTek's CPUFreq driver
+=====================================
 
 Required properties:
 - clocks: A list of phandle + clock-specifier pairs for the clocks listed in clock names.
@@ -9,6 +10,8 @@ Required properties:
 			  transition and not stable yet.
 	Please refer to Documentation/devicetree/bindings/clk/clock-bindings.txt for
 	generic clock consumer properties.
+- operating-points-v2: Please refer to Documentation/devicetree/bindings/opp/opp.txt
+	for detail.
 - proc-supply: Regulator for Vproc of CPU cluster.
 
 Optional properties:
@@ -17,9 +20,166 @@ Optional properties:
 	       Vsram to fit SoC specific needs. When absent, the voltage scaling
 	       flow is handled by hardware, hence no software "voltage tracking" is
 	       needed.
+- #cooling-cells:
+- cooling-min-level:
+- cooling-max-level:
+	Please refer to Documentation/devicetree/bindings/thermal/thermal.txt
+	for detail.
+
+Example 1 (MT7623 SoC):
+
+	cpu_opp_table: opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-598000000 {
+			opp-hz = /bits/ 64 <598000000>;
+			opp-microvolt = <1050000>;
+		};
+
+		opp-747500000 {
+			opp-hz = /bits/ 64 <747500000>;
+			opp-microvolt = <1050000>;
+		};
+
+		opp-1040000000 {
+			opp-hz = /bits/ 64 <1040000000>;
+			opp-microvolt = <1150000>;
+		};
+
+		opp-1196000000 {
+			opp-hz = /bits/ 64 <1196000000>;
+			opp-microvolt = <1200000>;
+		};
+
+		opp-1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1300000>;
+		};
+	};
+
+	cpu0: cpu@0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x0>;
+		clocks = <&infracfg CLK_INFRA_CPUSEL>,
+			 <&apmixedsys CLK_APMIXED_MAINPLL>;
+		clock-names = "cpu", "intermediate";
+		operating-points-v2 = <&cpu_opp_table>;
+		#cooling-cells = <2>;
+		cooling-min-level = <0>;
+		cooling-max-level = <7>;
+	};
+	cpu@1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x1>;
+		operating-points-v2 = <&cpu_opp_table>;
+	};
+	cpu@2 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x2>;
+		operating-points-v2 = <&cpu_opp_table>;
+	};
+	cpu@3 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x3>;
+		operating-points-v2 = <&cpu_opp_table>;
+	};
+
+Example 2 (MT8173 SoC):
+	cpu_opp_table_a: opp_table_a {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-507000000 {
+			opp-hz = /bits/ 64 <507000000>;
+			opp-microvolt = <859000>;
+		};
+
+		opp-702000000 {
+			opp-hz = /bits/ 64 <702000000>;
+			opp-microvolt = <908000>;
+		};
+
+		opp-1001000000 {
+			opp-hz = /bits/ 64 <1001000000>;
+			opp-microvolt = <983000>;
+		};
+
+		opp-1105000000 {
+			opp-hz = /bits/ 64 <1105000000>;
+			opp-microvolt = <1009000>;
+		};
+
+		opp-1183000000 {
+			opp-hz = /bits/ 64 <1183000000>;
+			opp-microvolt = <1028000>;
+		};
+
+		opp-1404000000 {
+			opp-hz = /bits/ 64 <1404000000>;
+			opp-microvolt = <1083000>;
+		};
+
+		opp-1508000000 {
+			opp-hz = /bits/ 64 <1508000000>;
+			opp-microvolt = <1109000>;
+		};
+
+		opp-1573000000 {
+			opp-hz = /bits/ 64 <1573000000>;
+			opp-microvolt = <1125000>;
+		};
+	};
+
+	cpu_opp_table_b: opp_table_b {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-507000000 {
+			opp-hz = /bits/ 64 <507000000>;
+			opp-microvolt = <828000>;
+		};
+
+		opp-702000000 {
+			opp-hz = /bits/ 64 <702000000>;
+			opp-microvolt = <867000>;
+		};
+
+		opp-1001000000 {
+			opp-hz = /bits/ 64 <1001000000>;
+			opp-microvolt = <927000>;
+		};
+
+		opp-1209000000 {
+			opp-hz = /bits/ 64 <1209000000>;
+			opp-microvolt = <968000>;
+		};
+
+		opp-1404000000 {
+			opp-hz = /bits/ 64 <1007000000>;
+			opp-microvolt = <1028000>;
+		};
+
+		opp-1612000000 {
+			opp-hz = /bits/ 64 <1612000000>;
+			opp-microvolt = <1049000>;
+		};
+
+		opp-1807000000 {
+			opp-hz = /bits/ 64 <1807000000>;
+			opp-microvolt = <1089000>;
+		};
+
+		opp-1989000000 {
+			opp-hz = /bits/ 64 <1989000000>;
+			opp-microvolt = <1125000>;
+		};
+	};
 
-Example:
---------
 	cpu0: cpu@0 {
 		device_type = "cpu";
 		compatible = "arm,cortex-a53";
@@ -29,6 +189,7 @@ Example:
 		clocks = <&infracfg CLK_INFRA_CA53SEL>,
 			 <&apmixedsys CLK_APMIXED_MAINPLL>;
 		clock-names = "cpu", "intermediate";
+		operating-points-v2 = <&cpu_opp_table_a>;
 	};
 
 	cpu1: cpu@1 {
@@ -40,6 +201,7 @@ Example:
 		clocks = <&infracfg CLK_INFRA_CA53SEL>,
 			 <&apmixedsys CLK_APMIXED_MAINPLL>;
 		clock-names = "cpu", "intermediate";
+		operating-points-v2 = <&cpu_opp_table_a>;
 	};
 
 	cpu2: cpu@100 {
@@ -51,6 +213,7 @@ Example:
 		clocks = <&infracfg CLK_INFRA_CA57SEL>,
 			 <&apmixedsys CLK_APMIXED_MAINPLL>;
 		clock-names = "cpu", "intermediate";
+		operating-points-v2 = <&cpu_opp_table_b>;
 	};
 
 	cpu3: cpu@101 {
@@ -62,6 +225,7 @@ Example:
 		clocks = <&infracfg CLK_INFRA_CA57SEL>,
 			 <&apmixedsys CLK_APMIXED_MAINPLL>;
 		clock-names = "cpu", "intermediate";
+		operating-points-v2 = <&cpu_opp_table_b>;
 	};
 
 	&cpu0 {
-- 
2.7.4
