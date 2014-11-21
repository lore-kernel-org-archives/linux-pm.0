From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v10 09/10] arm: dts: qcom: Add idle states device nodes for 8084
Date: Fri, 21 Nov 2014 11:03:56 -0700
Message-ID: <1416593037-27527-10-git-send-email-lina.iyer@linaro.org>
References: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Add ARM common idle states device bindings for cpuidle support for APQ
8084.

Support standby and standalone power collapse (power down that does not
affect any SoC idle states) for each cpu.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 4466b9e..207be15 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -22,6 +22,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
+			cpu-idle-states = <&CPU_STBY &CPU_SPC>;
 		};
 
 		cpu@1 {
@@ -32,6 +33,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
+			cpu-idle-states = <&CPU_STBY &CPU_SPC>;
 		};
 
 		cpu@2 {
@@ -42,6 +44,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc2>;
 			qcom,saw = <&saw2>;
+			cpu-idle-states = <&CPU_STBY &CPU_SPC>;
 		};
 
 		cpu@3 {
@@ -52,6 +55,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc3>;
 			qcom,saw = <&saw3>;
+			cpu-idle-states = <&CPU_STBY &CPU_SPC>;
 		};
 
 		L2: l2-cache {
@@ -59,6 +63,22 @@
 			cache-level = <2>;
 			qcom,saw = <&saw_l2>;
 		};
+
+		idle-states {
+			CPU_STBY: standby {
+				compatible = "qcom,idle-state-stby", "arm,idle-state";
+				entry-latency-us = <1>;
+				exit-latency-us = <1>;
+				min-residency-us = <2>;
+			};
+
+			CPU_SPC: spc {
+				compatible = "qcom,idle-state-spc", "arm,idle-state";
+				entry-latency-us = <150>;
+				exit-latency-us = <200>;
+				min-residency-us = <2000>;
+			};
+		};
 	};
 
 	cpu-pmu {
-- 
2.1.0
