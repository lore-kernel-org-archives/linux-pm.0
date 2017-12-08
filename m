From: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
Subject: [PATCH v1 4/4] arm64: dts: mediatek: add mt2712 cpufreq related device nodes
Date: Fri, 8 Dec 2017 14:07:58 +0800
Message-ID: <1512713278-17807-5-git-send-email-andrew-sh.cheng@mediatek.com>
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
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts | 27 ++++++++++++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 57 +++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
index 14163b9..d47f3c7 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
@@ -26,6 +26,33 @@
 		linux,initrd-start = <0x45000000>;
 		linux,initrd-end   = <0x4a000000>;
 	};
+
+	cpus_fixed_vproc0: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vproc_buck0";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+	};
+
+	cpus_fixed_vproc1: fixedregulator@1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vproc_buck1";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+	};
+
+};
+
+&cpu0 {
+	proc-supply = <&cpus_fixed_vproc0>;
+};
+
+&cpu1 {
+	proc-supply = <&cpus_fixed_vproc0>;
+};
+
+&cpu2 {
+	proc-supply = <&cpus_fixed_vproc1>;
 };
 
 &uart0 {
diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 61dd763..fdf66f4 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -16,6 +16,48 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	cluster0_opp: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp00 {
+			opp-hz = /bits/ 64 <598000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <702000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <793000000>;
+			opp-microvolt = <1000000>;
+		};
+	};
+
+	cluster1_opp: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp00 {
+			opp-hz = /bits/ 64 <598000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <702000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <793000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <897000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1001000000>;
+			opp-microvolt = <1000000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -41,6 +83,11 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a35";
 			reg = <0x000>;
+			clocks = <&mcucfg CLK_MCU_MP0_SEL>,
+				<&topckgen CLK_TOP_F_MP0_PLL1>;
+			clock-names = "cpu", "intermediate";
+			proc-supply = <&cpus_fixed_vproc0>;
+			operating-points-v2 = <&cluster0_opp>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
@@ -49,6 +96,11 @@
 			compatible = "arm,cortex-a35";
 			reg = <0x001>;
 			enable-method = "psci";
+			clocks = <&mcucfg CLK_MCU_MP0_SEL>,
+				<&topckgen CLK_TOP_F_MP0_PLL1>;
+			clock-names = "cpu", "intermediate";
+			proc-supply = <&cpus_fixed_vproc0>;
+			operating-points-v2 = <&cluster0_opp>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
@@ -57,6 +109,11 @@
 			compatible = "arm,cortex-a72";
 			reg = <0x200>;
 			enable-method = "psci";
+			clocks = <&mcucfg CLK_MCU_MP2_SEL>,
+				<&topckgen CLK_TOP_F_BIG_PLL1>;
+			clock-names = "cpu", "intermediate";
+			proc-supply = <&cpus_fixed_vproc1>;
+			operating-points-v2 = <&cluster1_opp>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
-- 
2.6.4
