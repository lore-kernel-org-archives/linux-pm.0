From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v7 7/7] arm: dts: qcom: Add idle states device nodes for 8084
Date: Fri, 26 Sep 2014 18:58:15 -0600
Message-ID: <1411779495-39724-8-git-send-email-lina.iyer@linaro.org>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35855 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbaI0A6o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 20:58:44 -0400
Received: by mail-pa0-f51.google.com with SMTP id eu11so12706380pac.38
        for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2014 17:58:44 -0700 (PDT)
In-Reply-To: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Add allowable C-States for each cpu using the cpu-idle-states node.
ARM spec dictates WFI as the default idle state at 0. Support standalone
power collapse (power down that does not affect any SoC idle states) for
each cpu.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 3dda230..a1ea1c0 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -19,6 +19,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
+			cpu-idle-states = <&CPU_WFI &CPU_SPC>;
 		};
 
 		cpu@1 {
@@ -29,6 +30,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
+			cpu-idle-states = <&CPU_WFI &CPU_SPC>;
 		};
 
 		cpu@2 {
@@ -39,6 +41,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc2>;
 			qcom,saw = <&saw2>;
+			cpu-idle-states = <&CPU_WFI &CPU_SPC>;
 		};
 
 		cpu@3 {
@@ -49,6 +52,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc3>;
 			qcom,saw = <&saw3>;
+			cpu-idle-states = <&CPU_WFI &CPU_SPC>;
 		};
 
 		L2: l2-cache {
@@ -56,6 +60,22 @@
 			cache-level = <2>;
 			qcom,saw = <&saw_l2>;
 		};
+
+		idle-states {
+			CPU_WFI: wfi {
+				compatible = "qcom,idle-state-wfi", "arm,idle-state";
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

