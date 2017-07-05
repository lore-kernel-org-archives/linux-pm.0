From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 1/2] dt-bindings: thermal: add binding documentation for UniPhier thermal monitor
Date: Wed,  5 Jul 2017 20:50:18 +0900
Message-ID: <1499255419-31684-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1499255419-31684-1-git-send-email-hayashi.kunihiko@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499255419-31684-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, yamada.masahiro@socionext.com, masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
List-Id: linux-pm@vger.kernel.org

Add devicetree binding documentation for thermal monitor implemented on
Socionext UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/thermal/uniphier-thermal.txt          | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/uniphier-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/uniphier-thermal.txt b/Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
new file mode 100644
index 0000000..686c0b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
@@ -0,0 +1,64 @@
+* UniPhier Thermal bindings
+
+This describes the devicetree bindings for thermal monitor supported by
+PVT(Process, Voltage and Temperature) monitoring unit implemented on Socionext
+UniPhier SoCs.
+
+Required properties:
+- compatible :
+  - "socionext,uniphier-pxs2-thermal" : For UniPhier PXs2 SoC
+  - "socionext,uniphier-ld20-thermal" : For UniPhier LD20 SoC
+- interrupts : IRQ for the temperature alarm
+- #thermal-sensor-cells : Should be 0. See ./thermal.txt for details.
+
+Optional properties:
+- socionext,tmod-calibration: A pair of calibrated values referred from PVT,
+                              in case that the values aren't set on SoC,
+                              like a reference board.
+
+Example:
+
+	sysctrl@61840000 {
+		compatible = "socionext,uniphier-ld20-sysctrl",
+			     "simple-mfd", "syscon";
+		reg = <0x61840000 0x10000>;
+		...
+		pvtctl: pvtctl {
+			compatible = "socionext,uniphier-ld20-thermal";
+			interrupts = <0 3 1>;
+			#thermal-sensor-cells = <0>;
+		};
+		...
+	};
+
+	thermal-zones {
+		cpu_thermal {
+			polling-delay-passive = <250>;	/* 250ms */
+			polling-delay = <1000>;		/* 1000ms */
+			thermal-sensors = <&pvtctl>;
+
+			trips {
+				cpu_crit: cpu_crit {
+					temperature = <110000>;	/* 110C */
+					hysteresis = <2000>;
+					type = "critical";
+				};
+				cpu_alert: cpu_alert {
+					temperature = <100000>;	/* 100C */
+					hysteresis = <2000>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert>;
+					cooling-device = <&cpu0 (-1) (-1)>;
+				};
+				map1 {
+					trip = <&cpu_alert>;
+					cooling-device = <&cpu2 (-1) (-1)>;
+				};
+			};
+		};
+	};
-- 
2.7.4
