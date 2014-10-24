From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v9 8/9] arm: dts: qcom: Add idle states device nodes for 8084
Date: Fri, 24 Oct 2014 17:40:23 -0600
Message-ID: <1414194024-55547-9-git-send-email-lina.iyer@linaro.org>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:38359 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932850AbaJXXlB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Oct 2014 19:41:01 -0400
Received: by mail-pd0-f169.google.com with SMTP id w10so2279037pde.14
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2014 16:41:01 -0700 (PDT)
In-Reply-To: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>

Add allowable C-States for each cpu using the cpu-idle-states node.
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

