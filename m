From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 5/7] arm64: dts: Add power-controller device bindings for QCOM 8916 SoC
Date: Fri, 17 Apr 2015 17:49:07 -0600
Message-ID: <1429314549-6730-6-git-send-email-lina.iyer@linaro.org>
References: <1429314549-6730-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1429314549-6730-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: arnd@arndb.de, catalin.marinas@arm.com, mark.rutland@arm.com, Will.Deacon@arm.com, lorenzo.pieralisi@arm.com
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, mlocke@codeaurora.org, bryanh@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

CPUs on the MSM8916 SoC has a power controller for each cpu that aids in
regualting power during active and idle usecase. Add SAW device bindings
for each cpu and L2.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index ac4b3e5..a3232be 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -51,6 +51,7 @@
 			enable-method = "qcom,arm-cortex-acc";
 			qcom,acc = <&acc0>;
 			next-level-cache = <&L2_0>;
+			qcom,saw = <&saw0>;
 			L2_0: l2-cache {
 			      compatible = "arm,arch-cache";
 			      cache-level = <2>;
@@ -65,6 +66,7 @@
 			enable-method = "qcom,arm-cortex-acc";
 			qcom,acc = <&acc1>;
 			next-level-cache = <&L2_0>;
+			qcom,saw = <&saw1>;
 		};
 
 		CPU2: cpu@2 {
@@ -74,6 +76,7 @@
 			enable-method = "qcom,arm-cortex-acc";
 			qcom,acc = <&acc2>;
 			next-level-cache = <&L2_0>;
+			qcom,saw = <&saw2>;
 		};
 
 		CPU3: cpu@3 {
@@ -83,6 +86,7 @@
 			enable-method = "qcom,arm-cortex-acc";
 			qcom,acc = <&acc3>;
 			next-level-cache = <&L2_0>;
+			qcom,saw = <&saw3>;
 		};
 	};
 
@@ -254,5 +258,25 @@
 			reg = <0x0b0b8000 0x1000>,
 			      <0x0b008000 0x1000>;
 		};
+
+		saw0: power-controller@B089000 {
+			compatible = "qcom,msm8916-saw2-v3.0-cpu";
+			reg = <0xB089000 0x1000>, <0xB009000 0x1000>;
+		};
+
+		saw1: power-controller@B099000 {
+			compatible = "qcom,msm8916-saw2-v3.0-cpu";
+			reg = <0xB099000 0x1000>, <0xB009000 0x1000>;
+		};
+
+		saw2: power-controller@B0A9000 {
+			compatible = "qcom,msm8916-saw2-v3.0-cpu";
+			reg = <0xB0A9000 0x1000>, <0xB009000 0x1000>;
+		};
+
+		saw3: power-controller@B0B9000 {
+			compatible = "qcom,msm8916-saw2-v3.0-cpu";
+			reg = <0xB0B9000 0x1000>, <0xB009000 0x1000>;
+		};
 	};
 };
-- 
2.1.0
