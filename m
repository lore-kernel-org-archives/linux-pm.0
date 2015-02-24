From: Narendran Rajan <nrajan@codeaurora.org>
Subject: [v3 2/2] ARM: qcom: dts: Add tsens thermal data
Date: Mon, 23 Feb 2015 22:47:22 -0800
Message-ID: <1424760442-12564-3-git-send-email-nrajan@codeaurora.org>
References: <1424760442-12564-1-git-send-email-nrajan@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41323 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbbBXGsF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Feb 2015 01:48:05 -0500
In-Reply-To: <1424760442-12564-1-git-send-email-nrajan@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Linux ARM MSM <linux-arm-msm@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Narendran Rajan <nrajan@codeaurora.org>

This patch adds dtsi file to contain thermal data for
tsens sensors present in qcom A family chipsets (msm8660,
ipq8064 etc). The data enables cooling with CPUfreq cooling
device at 60C and thermal shutdown at 100C

This thermal data can be resued across qcom A family chipsets

Signed-off-by: Narendran Rajan <nrajan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 27 +++++++++++++++++++--
 arch/arm/boot/dts/qcom-msm8660.dtsi | 27 +++++++++++++++++++--
 arch/arm/boot/dts/qcom-msm8960.dtsi | 28 ++++++++++++++++++++--
 arch/arm/boot/dts/qcom-thermal.dtsi | 47 +++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-thermal.dtsi

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index cb225da..661ed46 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -13,7 +13,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			compatible = "qcom,krait";
 			enable-method = "qcom,kpss-acc-v1";
 			device_type = "cpu";
@@ -23,7 +23,7 @@
 			qcom,saw = <&saw0>;
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			compatible = "qcom,krait";
 			enable-method = "qcom,kpss-acc-v1";
 			device_type = "cpu";
@@ -273,11 +273,34 @@
 			qcom,controller-type = "pmic-arbiter";
 		};
 
+		imem: memory@700000 {
+			compatible = "qcom,qfprom", "syscon";
+			reg = <0x00700000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			stride = <1>;
+			ranges = <0x0 0x00700000 0x1000>;
+		};
+
+		thermal-zones {
+			#include "qcom-thermal.dtsi"
+		};
+
 		gcc: clock-controller@900000 {
 			compatible = "qcom,gcc-ipq8064";
 			reg = <0x00900000 0x4000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			tsens: tsens-ipq8064 {
+				compatible = "qcom,qcom-tsens";
+				qcom,calib-offsets = <0x400 0x410>;
+				qcom,tsens-slopes = <1176 1176 1154 1176 1111
+						     1132 1132 1199 1132 1199
+						     1132>;
+				qcom,qfprom = <&imem 0x400 11>, <&imem 0x410 11>;
+				qcom,qfprom-names = "calib", "backup_calib";
+				#thermal-sensor-cells = <1>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 0affd61..4eb002c 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -15,7 +15,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			compatible = "qcom,scorpion";
 			enable-method = "qcom,gcc-msm8660";
 			device_type = "cpu";
@@ -23,7 +23,7 @@
 			next-level-cache = <&L2>;
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			compatible = "qcom,scorpion";
 			enable-method = "qcom,gcc-msm8660";
 			device_type = "cpu";
@@ -73,11 +73,34 @@
 			#interrupt-cells = <2>;
 		};
 
+		imem: memory@700000 {
+			compatible = "qcom,qfprom", "syscon";
+			reg = <0x00700000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			stride = <1>;
+			ranges = <0x0 0x00700000 0x1000>;
+		};
+
+		thermal-zones {
+			#include "qcom-thermal.dtsi"
+		};
+
 		gcc: clock-controller@900000 {
 			compatible = "qcom,gcc-msm8660";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			reg = <0x900000 0x4000>;
+			tsens: tsens-msm8660 {
+				compatible = "qcom,qcom-tsens";
+				qcom,calib-offsets = <0x400 0x410>;
+				qcom,tsens-slopes = <1176 1176 1154 1176 1111
+						     1132 1132 1199 1132 1199
+						     1132>;
+				qcom,qfprom = <&imem 0x400 11>, <&imem 0x410 11>;
+				qcom,qfprom-names = "calib", "backup_calib";
+				#thermal-sensor-cells = <1>;
+			};
 		};
 
 		gsbi12: gsbi@19c00000 {
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index e1b0d5c..3722816 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -16,7 +16,7 @@
 		#size-cells = <0>;
 		interrupts = <1 14 0x304>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			compatible = "qcom,krait";
 			enable-method = "qcom,kpss-acc-v1";
 			device_type = "cpu";
@@ -26,7 +26,7 @@
 			qcom,saw = <&saw0>;
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			compatible = "qcom,krait";
 			enable-method = "qcom,kpss-acc-v1";
 			device_type = "cpu";
@@ -84,11 +84,35 @@
 			reg = <0x800000 0x4000>;
 		};
 
+		imem: memory@700000 {
+			compatible = "qcom,qfprom", "syscon";
+			reg = <0x00700000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			stride = <1>;
+			ranges = <0x0 0x00700000 0x1000>;
+		};
+
+		thermal-zones {
+			#include "qcom-thermal.dtsi"
+		};
+
 		gcc: clock-controller@900000 {
 			compatible = "qcom,gcc-msm8960";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			reg = <0x900000 0x4000>;
+
+			tsens: tsens-msm8960 {
+				compatible = "qcom,qcom-tsens";
+				qcom,calib-offsets = <0x400 0x410>;
+				qcom,tsens-slopes = <1176 1176 1154 1176 1111
+						     1132 1132 1199 1132 1199
+						     1132>;
+				qcom,qfprom = <&imem 0x400 11>, <&imem 0x410 11>;
+				qcom,qfprom-names = "calib", "backup_calib";
+				#thermal-sensor-cells = <1>;
+			};
 		};
 
 		clock-controller@4000000 {
diff --git a/arch/arm/boot/dts/qcom-thermal.dtsi b/arch/arm/boot/dts/qcom-thermal.dtsi
new file mode 100644
index 0000000..963a597
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-thermal.dtsi
@@ -0,0 +1,47 @@
+/*
+ * Device Tree Source for ipq8064 SoC thermal
+ *
+ * Copyright (c) 2015 The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <dt-bindings/thermal/thermal.h>
+
+cpu_thermal0: cpu_thermal0 {
+	polling-delay-passive = <2000>; /* milliseconds */
+	polling-delay = <5000>; /* milliseconds */
+
+			/* sensor	ID */
+	thermal-sensors = <&tsens	0>;
+	linux,hwmon;
+
+	trips {
+		thermal0_cpu_alert: thermal0_cpu_alert {
+			temperature = <60000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "passive";
+		};
+		thermal0_cpu_crit: thermal0_cpu_crit {
+			temperature = <100000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "critical";
+		};
+	};
+
+	cooling-maps {
+			map0 {
+				trip = <&thermal0_cpu_alert>;
+				cooling-device =
+					<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+	};
+};
-- 
Qualcomm Innovation Center, Inc. The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

