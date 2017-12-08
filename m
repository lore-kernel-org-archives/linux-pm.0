From: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
Subject: [PATCH v1 3/4] arm64: dts: mediatek: add mt8173 cpufreq related device nodes
Date: Fri, 8 Dec 2017 14:07:57 +0800
Message-ID: <1512713278-17807-4-git-send-email-andrew-sh.cheng@mediatek.com>
References: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, matthias.bgg@gmail.com, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, robh+dt@kernel.org, devicetree@vger.kernel.org, Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
List-Id: linux-pm@vger.kernel.org

Add opp v2 information,
and also add clocks, regulators and opp information into cpu nodes

Signed-off-by: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 18 ++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 90 +++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 1c3634f..369dfcd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -74,6 +74,24 @@
 	status = "okay";
 };
 
+&cpu0 {
+	proc-supply = <&mt6397_vpca15_reg>;
+};
+
+&cpu1 {
+	proc-supply = <&mt6397_vpca15_reg>;
+};
+
+&cpu2 {
+	proc-supply = <&da9211_vcpu_reg>;
+	sram-supply = <&mt6397_vsramca7_reg>;
+};
+
+&cpu3 {
+	proc-supply = <&da9211_vcpu_reg>;
+	sram-supply = <&mt6397_vsramca7_reg>;
+};
+
 &dpi0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 26396ef..31bc593 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -51,6 +51,80 @@
 		mdp_wrot1 = &mdp_wrot1;
 	};
 
+	cluster0_opp: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp-507000000 {
+			opp-hz = /bits/ 64 <507000000>;
+			opp-microvolt = <859000>;
+		};
+		opp-702000000 {
+			opp-hz = /bits/ 64 <702000000>;
+			opp-microvolt = <908000>;
+		};
+		opp-1001000000 {
+			opp-hz = /bits/ 64 <1001000000>;
+			opp-microvolt = <983000>;
+		};
+		opp-1105000000 {
+			opp-hz = /bits/ 64 <1105000000>;
+			opp-microvolt = <1009000>;
+		};
+		opp-1209000000 {
+			opp-hz = /bits/ 64 <1209000000>;
+			opp-microvolt = <1034000>;
+		};
+		opp-1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1057000>;
+		};
+		opp-1508000000 {
+			opp-hz = /bits/ 64 <1508000000>;
+			opp-microvolt = <1109000>;
+		};
+		opp-1703000000 {
+			opp-hz = /bits/ 64 <1703000000>;
+			opp-microvolt = <1125000>;
+		};
+	};
+
+	cluster1_opp: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp-507000000 {
+			opp-hz = /bits/ 64 <507000000>;
+			opp-microvolt = <828000>;
+		};
+		opp-702000000 {
+			opp-hz = /bits/ 64 <702000000>;
+			opp-microvolt = <867000>;
+		};
+		opp-1001000000 {
+			opp-hz = /bits/ 64 <1001000000>;
+			opp-microvolt = <927000>;
+		};
+		opp-1209000000 {
+			opp-hz = /bits/ 64 <1209000000>;
+			opp-microvolt = <968000>;
+		};
+		opp-1404000000 {
+			opp-hz = /bits/ 64 <1404000000>;
+			opp-microvolt = <1007000>;
+		};
+		opp-1612000000 {
+			opp-hz = /bits/ 64 <1612000000>;
+			opp-microvolt = <1049000>;
+		};
+		opp-1807000000 {
+			opp-hz = /bits/ 64 <1807000000>;
+			opp-microvolt = <1089000>;
+		};
+		opp-2106000000 {
+			opp-hz = /bits/ 64 <2106000000>;
+			opp-microvolt = <1125000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -81,6 +155,10 @@
 			reg = <0x000>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			clocks = <&infracfg CLK_INFRA_CA53SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu1: cpu@1 {
@@ -89,6 +167,10 @@
 			reg = <0x001>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			clocks = <&infracfg CLK_INFRA_CA53SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu2: cpu@100 {
@@ -97,6 +179,10 @@
 			reg = <0x100>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			clocks = <&infracfg CLK_INFRA_CA57SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		cpu3: cpu@101 {
@@ -105,6 +191,10 @@
 			reg = <0x101>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			clocks = <&infracfg CLK_INFRA_CA57SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		idle-states {
-- 
2.6.4
