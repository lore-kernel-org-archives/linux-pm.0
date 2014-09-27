From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v7 2/7] arm: dts: qcom: Add SPM device bindings for 8974
Date: Fri, 26 Sep 2014 18:58:10 -0600
Message-ID: <1411779495-39724-3-git-send-email-lina.iyer@linaro.org>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:57726 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbaI0A6d (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 20:58:33 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so3737345pad.29
        for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2014 17:58:33 -0700 (PDT)
In-Reply-To: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Add SPM device bindings for QCOM 8974 based cpus. SPM is the sub-system
power manager and controls the logic around the cores (cpu and L2).

Each core has an instance of SPM and controls only that core. Each cpu
SPM is configured to support WFI and SPC (standalone-power collapse).

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 69dca2a..828f5bb 100644
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
+		saw0: saw@f9089000 {
+			compatible = "qcom,msm8974-saw2-v2.1-cpu";
+			reg = <0xf9089000 0x1000>;
+		};
+
+		saw1: saw@f9099000 {
+			compatible = "qcom,msm8974-saw2-v2.1-cpu";
+			reg = <0xf9099000 0x1000>;
+		};
+
+		saw2: saw@f90a9000 {
+			compatible = "qcom,msm8974-saw2-v2.1-cpu";
+			reg = <0xf90a9000 0x1000>;
+		};
+
+		saw3: saw@f90b9000 {
+			compatible = "qcom,msm8974-saw2-v2.1-cpu";
+			reg = <0xf90b9000 0x1000>;
+		};
+
+		saw_l2: saw@f9012000 {
 			compatible = "qcom,saw2";
 			reg = <0xf9012000 0x1000>;
 			regulator;
-- 
1.9.1

