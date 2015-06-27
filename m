From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC v2 15/16] arm: dts: Add power domain device bindings for APQ8084
Date: Fri, 26 Jun 2015 21:02:35 -0600
Message-ID: <1435374156-19214-16-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34388 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbbF0DDI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 23:03:08 -0400
Received: by pabvl15 with SMTP id vl15so77504826pab.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 20:03:08 -0700 (PDT)
In-Reply-To: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Define L2 SAW as the power domain provider and individual cpus are the
power domain consumers.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 900ef1f..4a61f8d 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -23,6 +23,7 @@
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&saw_l2>;
 		};
 
 		cpu@1 {
@@ -34,6 +35,7 @@
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&saw_l2>;
 		};
 
 		cpu@2 {
@@ -45,6 +47,7 @@
 			qcom,acc = <&acc2>;
 			qcom,saw = <&saw2>;
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&saw_l2>;
 		};
 
 		cpu@3 {
@@ -56,6 +59,7 @@
 			qcom,acc = <&acc3>;
 			qcom,saw = <&saw3>;
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&saw_l2>;
 		};
 
 		L2: l2-cache {
@@ -183,9 +187,11 @@
 		};
 
 		saw_l2: power-controller@f9012000 {
-			compatible = "qcom,apq8084-saw2-v2.1-l2", "qcom,saw2";
+			compatible = "qcom,apq8084-saw2-v2.1-l2", "qcom,saw2",
+					 "arm,pd";
 			reg = <0xf9012000 0x1000>;
 			regulator;
+			#power-domain-cells = <0>;
 		};
 
 		acc0: clock-controller@f9088000 {
-- 
2.1.4

