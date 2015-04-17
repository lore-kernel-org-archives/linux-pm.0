From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 6/7] arm64: dts: Add cpu idle states for 8916
Date: Fri, 17 Apr 2015 17:49:08 -0600
Message-ID: <1429314549-6730-7-git-send-email-lina.iyer@linaro.org>
References: <1429314549-6730-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36054 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070AbbDQXth (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Apr 2015 19:49:37 -0400
Received: by pabsx10 with SMTP id sx10so140274995pab.3
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2015 16:49:37 -0700 (PDT)
In-Reply-To: <1429314549-6730-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: arnd@arndb.de, catalin.marinas@arm.com, mark.rutland@arm.com, Will.Deacon@arm.com, lorenzo.pieralisi@arm.com
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, mlocke@codeaurora.org, bryanh@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Add ARM common idle states device bindings for cpuidle support for 8916
SOC.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index a3232be..3c46898 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -52,6 +52,7 @@
 			qcom,acc = <&acc0>;
 			next-level-cache = <&L2_0>;
 			qcom,saw = <&saw0>;
+			cpu-idle-states = <&CPU_SPC>;
 			L2_0: l2-cache {
 			      compatible = "arm,arch-cache";
 			      cache-level = <2>;
@@ -67,6 +68,7 @@
 			qcom,acc = <&acc1>;
 			next-level-cache = <&L2_0>;
 			qcom,saw = <&saw1>;
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		CPU2: cpu@2 {
@@ -77,6 +79,7 @@
 			qcom,acc = <&acc2>;
 			next-level-cache = <&L2_0>;
 			qcom,saw = <&saw2>;
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		CPU3: cpu@3 {
@@ -87,6 +90,17 @@
 			qcom,acc = <&acc3>;
 			next-level-cache = <&L2_0>;
 			qcom,saw = <&saw3>;
+			cpu-idle-states = <&CPU_SPC>;
+		};
+
+		idle-states {
+			CPU_SPC: spc {
+				compatible = "qcom,idle-state-spc",
+						"arm,idle-state";
+				entry-latency-us = <130>;
+				exit-latency-us = <150>;
+				min-residency-us = <2000>;
+			};
 		};
 	};
 
-- 
2.1.0

