From: Narendran Rajan <nrajan@codeaurora.org>
Subject: [PATCH] dt-bindings: document qcom tsens thermal
Date: Mon, 26 Jan 2015 20:08:07 -0800
Message-ID: <1422331687-19535-1-git-send-email-nrajan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Linux ARM MSM <linux-arm-msm@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Narendran Rajan <nrajan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Add binding documentation for the QCOM tsens device tree node
---
 .../devicetree/bindings/thermal/qcom-thermal.txt   | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/qcom-thermal.txt b/Documentation/devicetree/bindings/thermal/qcom-thermal.txt
new file mode 100644
index 0000000..d2e99d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-thermal.txt
@@ -0,0 +1,58 @@
+* QCOM SoC Temperature Sensor (TSENS)
+
+Required properties:
+- compatible : "qcom,ipq806x-tsens"
+- interrupts : The interrupt number to the cpu. The interrupt specifier format
+	       depends on the interrupt controller.
+- qcom,imem : Must contain phandle to imem syscon node
+- qcom,tsens-base : Must contain phandle to clock controller node
+- qcom,calib-offsets : Must contain offsets to primary and secondary
+			calibration data within imem
+- qcom,tsens-slopes : Must contain slope value for each of the sensors controlled
+			by this device
+- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
+
+Exiample:
+tsens: tsens-msm8960 {
+		compatible = "qcom,ipq806x-tsens";
+		interrupts = <0 178 1>;
+		qcom,imem = <&imem>;
+		qcom,tsens-base = <&gcc>;
+		qcom,calib-offsets = <0x400 0x410>;
+		qcom,tsens-slopes = <1176 1176 1154 1176 1111
+				1132 1132 1199 1132 1199
+				1132>;
+		#thermal-sensor-cells = <1>;
+	};
+
+Example: referring to thermal sensors:
+thermal-zones {
+	cpu_thermal: cpu_thermal {
+		polling-delay-passive = <1000>; /* milliseconds */
+		polling-delay = <5000>; /* milliseconds */
+
+		/* sensor	ID */
+		thermal-sensors = <&tsens	1>;
+
+		trips {
+			cpu_alert0: cpu_alert {
+				temperature = <80000>; /* millicelsius */
+				hysteresis = <2000>; /* millicelsius */
+				type = "passive";
+			};
+			cpu_crit: cpu_crit {
+				temperature = <120000>; /* millicelsius */
+				hysteresis = <2000>; /* millicelsius */
+				type = "critical";
+			};
+		};
+
+		cooling-maps {
+			map0 {
+				trip = <&cpu_alert0>;
+				cooling-device =
+					<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+		};
+	};
+};
-- 
Qualcomm Innovation Center, Inc. The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
