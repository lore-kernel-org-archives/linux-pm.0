From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v18 10/11] ARM: dts: qcom: Add idle state device nodes for 8064
Date: Wed, 25 Mar 2015 14:25:35 -0600
Message-ID: <1427315136-44321-11-git-send-email-lina.iyer@linaro.org>
References: <1427315136-44321-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34838 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbbCYU0T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2015 16:26:19 -0400
Received: by pagj7 with SMTP id j7so40004937pag.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2015 13:26:18 -0700 (PDT)
In-Reply-To: <1427315136-44321-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Add ARM common idle state device bindings for cpuidle support for APQ
8064.

Support Standalone power collapse (SPC) idle state (power down that does not
affect any SoC idle states) for each cpu.

Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 9fd24bc..592e985 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -23,6 +23,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		cpu@1 {
@@ -33,6 +34,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		cpu@2 {
@@ -43,6 +45,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc2>;
 			qcom,saw = <&saw2>;
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		cpu@3 {
@@ -53,12 +56,23 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc3>;
 			qcom,saw = <&saw3>;
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		L2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
 		};
+
+		idle-states {
+			CPU_SPC: spc {
+				compatible = "qcom,idle-state-spc",
+						"arm,idle-state";
+				entry-latency-us = <400>;
+				exit-latency-us = <900>;
+				min-residency-us = <3000>;
+			};
+		};
 	};
 
 	cpu-pmu {
-- 
2.1.0

