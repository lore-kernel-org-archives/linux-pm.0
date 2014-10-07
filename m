From: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 7/7] arm: dts: qcom: Add idle states device nodes for 8084
Date: Tue,  7 Oct 2014 15:31:25 -0600
Message-ID: <1412717485-16892-7-git-send-email-lina.iyer@linaro.org>
References: <1412717485-16892-1-git-send-email-lina.iyer@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412717485-16892-1-git-send-email-lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, msivasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add allowable C-States for each cpu using the cpu-idle-states node.
Support standby and standalone power collapse (power down that does not
affect any SoC idle states) for each cpu.

Signed-off-by: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 1581b12..68eb4bb1 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -19,6 +19,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
+			cpu-idle-states = <&CPU_STBY &CPU_SPC>;
 		};
 
 		cpu@1 {
@@ -29,6 +30,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
+			cpu-idle-states = <&CPU_STBY &CPU_SPC>;
 		};
 
 		cpu@2 {
@@ -39,6 +41,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc2>;
 			qcom,saw = <&saw2>;
+			cpu-idle-states = <&CPU_STBY &CPU_SPC>;
 		};
 
 		cpu@3 {
@@ -49,6 +52,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc3>;
 			qcom,saw = <&saw3>;
+			cpu-idle-states = <&CPU_STBY &CPU_SPC>;
 		};
 
 		L2: l2-cache {
@@ -56,6 +60,22 @@
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
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
