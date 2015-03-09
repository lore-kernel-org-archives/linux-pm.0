From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v15 07/11] ARM: dts: qcom: Update power-controller device node for 8064 Krait CPUs
Date: Mon,  9 Mar 2015 09:16:42 -0600
Message-ID: <1425914206-22295-8-git-send-email-lina.iyer@linaro.org>
References: <1425914206-22295-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34125 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778AbbCIPRb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2015 11:17:31 -0400
Received: by pdno5 with SMTP id o5so21494135pdn.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2015 08:17:30 -0700 (PDT)
In-Reply-To: <1425914206-22295-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>

Update the SAW2 DT bindings to add qcom,apq8064-saw2-v1.1-cpu compatible
binding string to configure SPM registers and allow the SPM to put the
core in deeper idle states when the core is idle.

Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
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

