From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v5 7/7] arm: dts: qcom: Add idle states device nodes for 8974
Date: Thu,  4 Sep 2014 16:35:32 -0600
Message-ID: <1409870132-16929-8-git-send-email-lina.iyer@linaro.org>
References: <1409870132-16929-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:63673 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000AbaIDWgf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 18:36:35 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so14494354pdb.41
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 15:36:35 -0700 (PDT)
In-Reply-To: <1409870132-16929-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org
Cc: linux-pm@vger.kernel.org, msivasub@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Add allowable C-States for each cpu using the cpu-idle-states node.
ARM spec dictates WFI as the default idle state at 0. Support standalone
power collapse (power down that does not affect any SoC idle states) for
each cpu.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 0580bc2..041c8b6 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -21,6 +21,7 @@
 			reg = <0>;
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
+			cpu-idle-states = <&CPU_WFI &CPU_SPC>;
 		};
 
 		CPU1: cpu@1 {
@@ -30,6 +31,7 @@
 			reg = <1>;
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
+			cpu-idle-states = <&CPU_WFI &CPU_SPC>;
 		};
 
 		CPU2: cpu@2 {
@@ -39,6 +41,7 @@
 			reg = <2>;
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc2>;
+			cpu-idle-states = <&CPU_WFI &CPU_SPC>;
 		};
 
 		CPU3: cpu@3 {
@@ -48,6 +51,7 @@
 			reg = <3>;
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc3>;
+			cpu-idle-states = <&CPU_WFI &CPU_SPC>;
 		};
 
 		L2: l2-cache {
@@ -55,6 +59,22 @@
 			cache-level = <2>;
 			qcom,saw = <&saw_l2>;
 		};
+
+		idle-states {
+			CPU_WFI: cpu-idle-state-0 {
+				compatible = "qcom,idle-state-wfi", "arm,idle-state";
+				entry-latency-us = <1>;
+				exit-latency-us = <1>;
+				min-residency-us = <2>;
+			};
+
+			CPU_SPC: cpu-idle-state-1 {
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

