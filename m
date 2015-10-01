From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH] arm: dts: qcom: Add #power-domain-cells property
Date: Thu,  1 Oct 2015 14:56:02 +0530
Message-ID: <1443691562-16963-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54168 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756459AbbJAJ0S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2015 05:26:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: agross@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>

clock controller nodes which also support power domains (gdscs') need
to have a #power-domain-cells property. Add these for gcc and mmcc
nodes of msm8974, gcc of apq8084 and msm8916.
Also update gcc and mmcc bindings for it.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
Andy, the rest of the power domain (gdsc) support patches are
pulled in by Stephen into clk-next. Can you please pull the dts
changes in for 4.4.

 Documentation/devicetree/bindings/clock/qcom,gcc.txt  | 4 ++++
 Documentation/devicetree/bindings/clock/qcom,mmcc.txt | 4 ++++
 arch/arm/boot/dts/qcom-apq8084.dtsi                   | 1 +
 arch/arm/boot/dts/qcom-msm8974.dtsi                   | 2 ++
 arch/arm64/boot/dts/qcom/msm8916.dtsi                 | 1 +
 5 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.txt b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
index 54c23f3..152dfaa 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
@@ -18,10 +18,14 @@ Required properties :
 - #clock-cells : shall contain 1
 - #reset-cells : shall contain 1
 
+Optional properties :
+- #power-domain-cells : shall contain 1
+
 Example:
 	clock-controller@900000 {
 		compatible = "qcom,gcc-msm8960";
 		reg = <0x900000 0x4000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
+		#power-domain-cells = <1>;
 	};
diff --git a/Documentation/devicetree/bindings/clock/qcom,mmcc.txt b/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
index 29ebf84..34e7614 100644
--- a/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
@@ -14,10 +14,14 @@ Required properties :
 - #clock-cells : shall contain 1
 - #reset-cells : shall contain 1
 
+Optional properties :
+- #power-domain-cells : shall contain 1
+
 Example:
 	clock-controller@4000000 {
 		compatible = "qcom,mmcc-msm8960";
 		reg = <0x4000000 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
+		#power-domain-cells = <1>;
 	};
diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 0554fbd..fcffeca 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -221,6 +221,7 @@
 			compatible = "qcom,gcc-apq8084";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#power-domain-cells = <1>;
 			reg = <0xfc400000 0x4000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index ab8e572..ab8473b 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -228,6 +228,7 @@
 			compatible = "qcom,gcc-msm8974";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#power-domain-cells = <1>;
 			reg = <0xfc400000 0x4000>;
 		};
 
@@ -240,6 +241,7 @@
 			compatible = "qcom,mmcc-msm8974";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#power-domain-cells = <1>;
 			reg = <0xfd8c0000 0x6000>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 5911de0..ac006e8 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -99,6 +99,7 @@
 			compatible = "qcom,gcc-msm8916";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#power-domain-cells = <1>;
 			reg = <0x1800000 0x80000>;
 		};
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

