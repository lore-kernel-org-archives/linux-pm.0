From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v8 3/7] arm: dts: qcom: Add power-controller device node for 8084 Krait CPUs
Date: Tue,  7 Oct 2014 15:41:42 -0600
Message-ID: <1412718106-17049-4-git-send-email-lina.iyer@linaro.org>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:51534 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102AbaJGVmE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Oct 2014 17:42:04 -0400
Received: by mail-pd0-f178.google.com with SMTP id y10so5634070pdj.23
        for <linux-pm@vger.kernel.org>; Tue, 07 Oct 2014 14:42:03 -0700 (PDT)
In-Reply-To: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>

Each Krait CPU in the QCOM 8084 SoC has an SAW power controller to
regulate the power to the cpu and aide the core in entering idle states.
Reference the SAW instance and associate the instance with the CPU core.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index e3e009a..1581b12 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -18,6 +18,7 @@
 			enable-method = "qcom,kpss-acc-v2";
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
+			qcom,saw = <&saw0>;
 		};
 
 		cpu@1 {
@@ -27,6 +28,7 @@
 			enable-method = "qcom,kpss-acc-v2";
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
+			qcom,saw = <&saw1>;
 		};
 
 		cpu@2 {
@@ -36,6 +38,7 @@
 			enable-method = "qcom,kpss-acc-v2";
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc2>;
+			qcom,saw = <&saw2>;
 		};
 
 		cpu@3 {
@@ -45,6 +48,7 @@
 			enable-method = "qcom,kpss-acc-v2";
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc3>;
+			qcom,saw = <&saw3>;
 		};
 
 		L2: l2-cache {
@@ -141,7 +145,27 @@
 			};
 		};
 
-		saw_l2: regulator@f9012000 {
+		saw0: power-controller@f9089000 {
+			compatible = "qcom,apq8084-saw2-v2.1-cpu";
+			reg = <0xf9089000 0x1000>;
+		};
+
+		saw1: power-controller@f9099000 {
+			compatible = "qcom,apq8084-saw2-v2.1-cpu";
+			reg = <0xf9099000 0x1000>;
+		};
+
+		saw2: power-controller@f90a9000 {
+			compatible = "qcom,apq8084-saw2-v2.1-cpu";
+			reg = <0xf90a9000 0x1000>;
+		};
+
+		saw3: power-controller@f90b9000 {
+			compatible = "qcom,apq8084-saw2-v2.1-cpu";
+			reg = <0xf90b9000 0x1000>;
+		};
+
+		saw_l2: power-controller@f9012000 {
 			compatible = "qcom,saw2";
 			reg = <0xf9012000 0x1000>;
 			regulator;
-- 
1.9.1

