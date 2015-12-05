From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: [PATCH 2/2] ARM64: dts: mt8173: Add CPU OPP, clock and regulator supply properties
Date: Sat,  5 Dec 2015 16:53:04 +0800
Message-ID: <1449305584-414-3-git-send-email-pi-cheng.chen@linaro.org>
References: <1449305584-414-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36858 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898AbbLEIxT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 5 Dec 2015 03:53:19 -0500
Received: by pfdd184 with SMTP id d184so38252946pfd.3
        for <linux-pm@vger.kernel.org>; Sat, 05 Dec 2015 00:53:18 -0800 (PST)
In-Reply-To: <1449305584-414-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-mediatek@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Add operating-points-v2, clock, and regulator supply properties
required by mt8173-cpufreq driver to enable it.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
---
This patch is based on the patch[1] that adds underlying clock MUX for
MT8173 which is needed by mt8173-cpufreq driver but not yet picked.

[1] http://article.gmane.org/gmane.linux.kernel.clk/325
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 18 ++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 90 +++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 811cb76..5b6321b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -405,6 +405,24 @@
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
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 4dd5f93..fce1e48 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -24,6 +24,80 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	cluster0_opp: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp00 {
+			opp-hz = /bits/ 64 <507000000>;
+			opp-microvolt = <859000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <702000000>;
+			opp-microvolt = <908000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <1001000000>;
+			opp-microvolt = <983000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1105000000>;
+			opp-microvolt = <1009000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1183000000>;
+			opp-microvolt = <1028000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <1404000000>;
+			opp-microvolt = <1083000>;
+		};
+		opp06 {
+			opp-hz = /bits/ 64 <1508000000>;
+			opp-microvolt = <1109000>;
+		};
+		opp07 {
+			opp-hz = /bits/ 64 <1573000000>;
+			opp-microvolt = <1125000>;
+		};
+	};
+
+	cluster1_opp: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp00 {
+			opp-hz = /bits/ 64 <507000000>;
+			opp-microvolt = <828000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <702000000>;
+			opp-microvolt = <867000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <1001000000>;
+			opp-microvolt = <927000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1209000000>;
+			opp-microvolt = <968000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1404000000>;
+			opp-microvolt = <1007000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <1612000000>;
+			opp-microvolt = <1049000>;
+		};
+		opp06 {
+			opp-hz = /bits/ 64 <1807000000>;
+			opp-microvolt = <1089000>;
+		};
+		opp07 {
+			opp-hz = /bits/ 64 <1989000000>;
+			opp-microvolt = <1125000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -54,6 +128,10 @@
 			reg = <0x000>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			clocks = <&infracfg CLK_INFRA_CA53SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu1: cpu@1 {
@@ -62,6 +140,10 @@
 			reg = <0x001>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			clocks = <&infracfg CLK_INFRA_CA53SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu2: cpu@100 {
@@ -70,6 +152,10 @@
 			reg = <0x100>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			clocks = <&infracfg CLK_INFRA_CA57SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		cpu3: cpu@101 {
@@ -78,6 +164,10 @@
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
1.9.1

