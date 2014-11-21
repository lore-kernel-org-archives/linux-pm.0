From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v10 06/10] arm: dts: qcom: Update power-controller device node for 8064 Krait CPUs
Date: Fri, 21 Nov 2014 11:03:53 -0700
Message-ID: <1416593037-27527-7-git-send-email-lina.iyer@linaro.org>
References: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:52959 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbaKUSEO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Nov 2014 13:04:14 -0500
Received: by mail-pd0-f182.google.com with SMTP id r10so5801015pdi.27
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2014 10:04:13 -0800 (PST)
In-Reply-To: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>

Update the SAW2 DT bindings to add qcom,apq8064-saw2-v1.1-cpu compatible
binding string to configure SPM registers and allow the SPM to put the
core in deeper idle states when the core is idle.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index b3154c0..9fd24bc 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -139,26 +139,26 @@
 			reg = <0x020b8000 0x1000>, <0x02008000 0x1000>;
 		};
 
-		saw0: regulator@2089000 {
-			compatible = "qcom,saw2";
+		saw0: power-controller@2089000 {
+			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};
 
-		saw1: regulator@2099000 {
-			compatible = "qcom,saw2";
+		saw1: power-controller@2099000 {
+			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};
 
-		saw2: regulator@20a9000 {
-			compatible = "qcom,saw2";
+		saw2: power-controller@20a9000 {
+			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x020a9000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};
 
-		saw3: regulator@20b9000 {
-			compatible = "qcom,saw2";
+		saw3: power-controller@20b9000 {
+			compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
 			reg = <0x020b9000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};
-- 
2.1.0

