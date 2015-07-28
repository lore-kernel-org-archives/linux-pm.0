From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v7 13/13] arm: dts: qcom: Add #power-domain-cells property
Date: Tue, 28 Jul 2015 15:04:06 +0530
Message-ID: <1438076046-4706-14-git-send-email-rnayak@codeaurora.org>
References: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

msm8974 has gcc and mmcc nodes, and apq8084 has a gcc node which
implement gdsc powerdomains. Add the #power-domain-cells property
to them.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi   | 1 +
 arch/arm/boot/dts/qcom-msm8974.dtsi   | 2 ++
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 7084010..1cdb568 100644
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
index 37b47b5..8a2dfa6 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -217,6 +217,7 @@
 			compatible = "qcom,gcc-msm8974";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#power-domain-cells = <1>;
 			reg = <0xfc400000 0x4000>;
 		};
 
@@ -224,6 +225,7 @@
 			compatible = "qcom,mmcc-msm8974";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#power-domain-cells = <1>;
 			reg = <0xfd8c0000 0x6000>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 0f49ebd..3b0645a 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -120,6 +120,7 @@
 			compatible = "qcom,gcc-msm8916";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#power-domain-cells = <1>;
 			reg = <0x1800000 0x80000>;
 		};
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
