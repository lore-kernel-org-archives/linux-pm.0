From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v12 04/10] arm: dts: qcom: Add power-controller device node for 8074 Krait CPUs
Date: Wed, 26 Nov 2014 17:13:09 -0700
Message-ID: <1417047195-18978-5-git-send-email-lina.iyer@linaro.org>
References: <1417047195-18978-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:58146 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbaK0ANi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 19:13:38 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so3789753pac.8
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 16:13:38 -0800 (PST)
In-Reply-To: <1417047195-18978-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>

Each Krait CPU in the QCOM 8074/8974 SoC has an SAW power controller to
regulate the power to the cpu and aide the core in entering idle states.
Reference the SAW instance and associate the instance with the CPU core.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index e265ec1..5a41f44 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -21,6 +21,7 @@
 			reg = <0>;
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
+			qcom,saw = <&saw0>;
 		};
 
 		cpu@1 {
@@ -30,6 +31,7 @@
 			reg = <1>;
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
+			qcom,saw = <&saw1>;
 		};
 
 		cpu@2 {
@@ -39,6 +41,7 @@
 			reg = <2>;
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc2>;
+			qcom,saw = <&saw2>;
 		};
 
 		cpu@3 {
@@ -48,6 +51,7 @@
 			reg = <3>;
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc3>;
+			qcom,saw = <&saw3>;
 		};
 
 		L2: l2-cache {
@@ -144,7 +148,27 @@
 			};
 		};
 
-		saw_l2: regulator@f9012000 {
+		saw0: power-controller@f9089000 {
+			compatible = "qcom,msm8974-saw2-v2.1-cpu";
+			reg = <0xf9089000 0x1000>, <0xf9009000 0x1000>;
+		};
+
+		saw1: power-controller@f9099000 {
+			compatible = "qcom,msm8974-saw2-v2.1-cpu";
+			reg = <0xf9099000 0x1000>, <0xf9009000 0x1000>;
+		};
+
+		saw2: power-controller@f90a9000 {
+			compatible = "qcom,msm8974-saw2-v2.1-cpu";
+			reg = <0xf90a9000 0x1000>, <0xf9009000 0x1000>;
+		};
+
+		saw3: power-controller@f90b9000 {
+			compatible = "qcom,msm8974-saw2-v2.1-cpu";
+			reg = <0xf90b9000 0x1000>, <0xf9009000 0x1000>;
+		};
+
+		saw_l2: power-controller@f9012000 {
 			compatible = "qcom,saw2";
 			reg = <0xf9012000 0x1000>;
 			regulator;
-- 
2.1.0

