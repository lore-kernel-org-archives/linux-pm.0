From: Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH RFC 8/9] arm64: dts: qcom: sdm845: Add cpu OPP tables
Date: Thu, 28 Mar 2019 20:58:21 +0530
Message-ID: <20190328152822.532-9-sibis@codeaurora.org>
References: <20190328152822.532-1-sibis@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328152822.532-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, andy.gross@linaro.org, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org, georgi.djakov@linaro.org
Cc: bjorn.andersson@linaro.org, david.brown@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org, rnayak@codeaurora.org, cw00.choi@samsung.com, linux-pm@vger.kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org, dianders@chromium.org, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Add a OPP tables for the cpu nodes.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 182 +++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cd8ac481381b..072563f6b6cb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -193,6 +193,7 @@
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&cpu0_opp_table>;
 			L2_0: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -210,6 +211,7 @@
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_100>;
+			operating-points-v2 = <&cpu0_opp_table>;
 			L2_100: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -224,6 +226,7 @@
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_200>;
+			operating-points-v2 = <&cpu0_opp_table>;
 			L2_200: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -238,6 +241,7 @@
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_300>;
+			operating-points-v2 = <&cpu0_opp_table>;
 			L2_300: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -252,6 +256,7 @@
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_400>;
+			operating-points-v2 = <&cpu4_opp_table>;
 			L2_400: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -266,6 +271,7 @@
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_500>;
+			operating-points-v2 = <&cpu4_opp_table>;
 			L2_500: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -280,6 +286,7 @@
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_600>;
+			operating-points-v2 = <&cpu4_opp_table>;
 			L2_600: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -294,6 +301,7 @@
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_700>;
+			operating-points-v2 = <&cpu4_opp_table>;
 			L2_700: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -301,6 +309,180 @@
 		};
 	};
 
+	cpu0_opp_table: cpu0_opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu0_opp1: opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+		};
+
+		cpu0_opp2: opp-403200000 {
+			opp-hz = /bits/ 64 <403200000>;
+		};
+
+		cpu0_opp3: opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+		};
+
+		cpu0_opp4: opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+		};
+
+		cpu0_opp5: opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+		};
+
+		cpu0_opp6: opp-748800000 {
+			opp-hz = /bits/ 64 <748800000>;
+		};
+
+		cpu0_opp7: opp-825600000 {
+			opp-hz = /bits/ 64 <825600000>;
+		};
+
+		cpu0_opp8: opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+		};
+
+		cpu0_opp9: opp-979200000 {
+			opp-hz = /bits/ 64 <979200000>;
+		};
+
+		cpu0_opp10: opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+		};
+
+		cpu0_opp11: opp-1132800000 {
+			opp-hz = /bits/ 64 <1132800000>;
+		};
+
+		cpu0_opp12: opp-1228800000 {
+			opp-hz = /bits/ 64 <1228800000>;
+		};
+
+		cpu0_opp13: opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+		};
+
+		cpu0_opp14: opp-1420800000 {
+			opp-hz = /bits/ 64 <1420800000>;
+		};
+
+		cpu0_opp15: opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+		};
+
+		cpu0_opp16: opp-1612800000 {
+			opp-hz = /bits/ 64 <1612800000>;
+		};
+
+		cpu0_opp17: opp-1689600000 {
+			opp-hz = /bits/ 64 <1689600000>;
+		};
+
+		cpu0_opp18: opp-1766400000 {
+			opp-hz = /bits/ 64 <1766400000>;
+		};
+	};
+
+	cpu4_opp_table: cpu4_opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu4_opp1: opp-825600000 {
+			opp-hz = /bits/ 64 <825600000>;
+		};
+
+		cpu4_opp2: opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+		};
+
+		cpu4_opp3: opp-979200000 {
+			opp-hz = /bits/ 64 <979200000>;
+		};
+
+		cpu4_opp4: opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+		};
+
+		cpu4_opp5: opp-1209600000 {
+			opp-hz = /bits/ 64 <1209600000>;
+		};
+
+		cpu4_opp6: opp-1286400000 {
+			opp-hz = /bits/ 64 <1286400000>;
+		};
+
+		cpu4_opp7: opp-1363200000 {
+			opp-hz = /bits/ 64 <1363200000>;
+		};
+
+		cpu4_opp8: opp-1459200000 {
+			opp-hz = /bits/ 64 <1459200000>;
+		};
+
+		cpu4_opp9: opp-1536000000 {
+			opp-hz = /bits/ 64 <1536000000>;
+		};
+
+		cpu4_opp10: opp-1612800000 {
+			opp-hz = /bits/ 64 <1612800000>;
+		};
+
+		cpu4_opp11: opp-1689600000 {
+			opp-hz = /bits/ 64 <1689600000>;
+		};
+
+		cpu4_opp12: opp-1766400000 {
+			opp-hz = /bits/ 64 <1766400000>;
+		};
+
+		cpu4_opp13: opp-1843200000 {
+			opp-hz = /bits/ 64 <1843200000>;
+		};
+
+		cpu4_opp14: opp-1920000000 {
+			opp-hz = /bits/ 64 <1920000000>;
+		};
+
+		cpu4_opp15: opp-1996800000 {
+			opp-hz = /bits/ 64 <1996800000>;
+		};
+
+		cpu4_opp16: opp-2092800000 {
+			opp-hz = /bits/ 64 <2092800000>;
+		};
+
+		cpu4_opp17: opp-2169600000 {
+			opp-hz = /bits/ 64 <2169600000>;
+		};
+
+		cpu4_opp18: opp-2246400000 {
+			opp-hz = /bits/ 64 <2246400000>;
+		};
+
+		cpu4_opp19: opp-2323200000 {
+			opp-hz = /bits/ 64 <2323200000>;
+		};
+
+		cpu4_opp20: opp-2400000000 {
+			opp-hz = /bits/ 64 <2400000000>;
+		};
+
+		cpu4_opp21: opp-2476800000 {
+			opp-hz = /bits/ 64 <2476800000>;
+		};
+
+		cpu4_opp22: opp-2553600000 {
+			opp-hz = /bits/ 64 <2553600000>;
+		};
+
+		cpu4_opp23: opp-2649600000 {
+			opp-hz = /bits/ 64 <2649600000>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
