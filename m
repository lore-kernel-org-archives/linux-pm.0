From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v12 10/10] arm: dts: qcom: Add idle state device nodes for 8064
Date: Wed, 26 Nov 2014 17:13:15 -0700
Message-ID: <1417047195-18978-11-git-send-email-lina.iyer@linaro.org>
References: <1417047195-18978-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:52792 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbaK0ANu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 19:13:50 -0500
Received: by mail-pd0-f176.google.com with SMTP id y10so3759818pdj.21
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 16:13:50 -0800 (PST)
In-Reply-To: <1417047195-18978-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>

Add ARM common idle state device bindings for cpuidle support for APQ
8064.

Support Standby and Standalone power collapse (power down that does not
affect any SoC idle states) for each cpu.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 9fd24bc..ab21dba 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -23,6 +23,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
+			cpu-idle-states = <&CPU_STBY &CPU_SPC>;
 		};
 
 		cpu@1 {
@@ -33,6 +34,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
+			cpu-idle-states = <&CPU_STBY &CPU_SPC>;
 		};
 
 		cpu@2 {
@@ -43,6 +45,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc2>;
 			qcom,saw = <&saw2>;
+			cpu-idle-states = <&CPU_STBY &CPU_SPC>;
 		};
 
 		cpu@3 {
@@ -53,12 +56,29 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc3>;
 			qcom,saw = <&saw3>;
+			cpu-idle-states = <&CPU_STBY &CPU_SPC>;
 		};
 
 		L2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
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
+				entry-latency-us = <400>;
+				exit-latency-us = <900>;
+				min-residency-us = <3000>;
+			};
+		};
 	};
 
 	cpu-pmu {
-- 
2.1.0

