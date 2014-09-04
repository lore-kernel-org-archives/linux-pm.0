From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v5 4/7] arm: dts: qcom: Add SPM device bindings for 8974
Date: Thu,  4 Sep 2014 16:35:29 -0600
Message-ID: <1409870132-16929-5-git-send-email-lina.iyer@linaro.org>
References: <1409870132-16929-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1409870132-16929-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org
Cc: linux-pm@vger.kernel.org, msivasub@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Add SPM device bindings for QCOM 8974 based cpus. SPM is the sub-system
power manager and controls the logic around the cores (cpu and L2).

Each core has an instance of SPM and controls only that core. Each cpu
SPM is configured to support WFI and SPC (standalone-power collapse).

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974-pm.dtsi | 69 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi    | 10 +++--
 2 files changed, 75 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-msm8974-pm.dtsi

diff --git a/arch/arm/boot/dts/qcom-msm8974-pm.dtsi b/arch/arm/boot/dts/qcom-msm8974-pm.dtsi
new file mode 100644
index 0000000..bbfb1d5
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-msm8974-pm.dtsi
@@ -0,0 +1,69 @@
+/* Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+&soc {
+	spm@f9089000 {
+		compatible = "qcom,spm-v2.1";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xf9089000 0x1000>;
+		qcom,cpu = <&CPU0>;
+		qcom,saw2-clk-div = <0x01>;
+		qcom,saw2-delays = <0x3C102800>;
+		qcom,saw2-enable = <0x01>;
+		qcom,saw2-spm-cmd-wfi = [03 0b 0f];
+		qcom,saw2-spm-cmd-spc = [00 20 80 10 E8 5B 03 3B E8 5B 82 10 0B
+			30 06 26 30 0F];
+	};
+
+	spm@f9099000 {
+		compatible = "qcom,spm-v2.1";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xf9099000 0x1000>;
+		qcom,cpu = <&CPU1>;
+		qcom,saw2-clk-div = <0x01>;
+		qcom,saw2-delays = <0x3C102800>;
+		qcom,saw2-enable = <0x01>;
+		qcom,saw2-spm-cmd-wfi = [03 0b 0f];
+		qcom,saw2-spm-cmd-spc = [00 20 80 10 E8 5B 03 3B E8 5B 82 10 0B
+			30 06 26 30 0F];
+	};
+
+	spm@f90a9000 {
+		compatible = "qcom,spm-v2.1";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xf90a9000 0x1000>;
+		qcom,cpu = <&CPU2>;
+		qcom,saw2-clk-div = <0x01>;
+		qcom,saw2-delays = <0x3C102800>;
+		qcom,saw2-enable = <0x01>;
+		qcom,saw2-spm-cmd-wfi = [03 0b 0f];
+		qcom,saw2-spm-cmd-spc = [00 20 80 10 E8 5B 03 3B E8 5B 82 10 0B
+			30 06 26 30 0F];
+	};
+
+	spm@f90b9000 {
+		compatible = "qcom,spm-v2.1";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xf90b9000 0x1000>;
+		qcom,cpu = <&CPU3>;
+		qcom,saw2-clk-div = <0x01>;
+		qcom,saw2-delays = <0x3C102800>;
+		qcom,saw2-enable = <0x01>;
+		qcom,saw2-spm-cmd-wfi = [03 0b 0f];
+		qcom,saw2-spm-cmd-spc = [00 20 80 10 E8 5B 03 3B E8 5B 82 10 0B
+			30 06 26 30 0F];
+	};
+};
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 69dca2a..0580bc2 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -14,7 +14,7 @@
 		#size-cells = <0>;
 		interrupts = <1 9 0xf04>;
 
-		cpu@0 {
+		CPU0: cpu@0 {
 			compatible = "qcom,krait";
 			enable-method = "qcom,kpss-acc-v2";
 			device_type = "cpu";
@@ -23,7 +23,7 @@
 			qcom,acc = <&acc0>;
 		};
 
-		cpu@1 {
+		CPU1: cpu@1 {
 			compatible = "qcom,krait";
 			enable-method = "qcom,kpss-acc-v2";
 			device_type = "cpu";
@@ -32,7 +32,7 @@
 			qcom,acc = <&acc1>;
 		};
 
-		cpu@2 {
+		CPU2: cpu@2 {
 			compatible = "qcom,krait";
 			enable-method = "qcom,kpss-acc-v2";
 			device_type = "cpu";
@@ -41,7 +41,7 @@
 			qcom,acc = <&acc2>;
 		};
 
-		cpu@3 {
+		CPU3: cpu@3 {
 			compatible = "qcom,krait";
 			enable-method = "qcom,kpss-acc-v2";
 			device_type = "cpu";
@@ -238,3 +238,5 @@
 		};
 	};
 };
+
+#include "qcom-msm8974-pm.dtsi"
-- 
1.9.1
