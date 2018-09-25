From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 08/14] ARM64: dts: hisilicon: Add tsensor interrupt name
Date: Tue, 25 Sep 2018 11:03:06 +0200
Message-ID: <1537866192-12320-9-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, leo.yan@linaro.org, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wei Xu <xuwei5@hisilicon.com>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/HISILICON SOC
        SUPPORT" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Add the interrupt names for the sensors, so the code can rely on them
instead of dealing with index which are prone to error.

The name comes from the Hisilicon documentation found on internet.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../bindings/thermal/hisilicon-thermal.txt         |  3 ++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          | 63 +++++++++++-----------
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  1 +
 3 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
index cef716a..3edfae3 100644
--- a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
@@ -7,6 +7,7 @@
   region.
 - interrupt: The interrupt number to the cpu. Defines the interrupt used
   by /SOCTHERM/tsensor.
+- interrupt-names: The interrupt names for the different sensors
 - clock-names: Input clock name, should be 'thermal_clk'.
 - clocks: phandles for clock specified in "clock-names" property.
 - #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
@@ -18,6 +19,7 @@ for Hi6220:
 		compatible = "hisilicon,tsensor";
 		reg = <0x0 0xf7030700 0x0 0x1000>;
 		interrupts = <0 7 0x4>;
+		interrupt-names = "tsensor_intr";
 		clocks = <&sys_ctrl HI6220_TSENSOR_CLK>;
 		clock-names = "thermal_clk";
 		#thermal-sensor-cells = <1>;
@@ -28,5 +30,6 @@ for Hi3660:
 		compatible = "hisilicon,hi3660-tsensor";
 		reg = <0x0 0xfff30000 0x0 0x1000>;
 		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tsensor_a73";
 		#thermal-sensor-cells = <1>;
 	};
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index f432b0a..bf8a479 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1081,46 +1081,47 @@
 			compatible = "hisilicon,hi3660-tsensor";
 			reg = <0x0 0xfff30000 0x0 0x1000>;
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tsensor_a73";
 			#thermal-sensor-cells = <1>;
 		};
 
-		thermal-zones {
+                thermal-zones {
 
-			cls0: cls0 {
-				polling-delay = <1000>;
-				polling-delay-passive = <100>;
-				sustainable-power = <4500>;
+                        cls0: cls0 {
+                                polling-delay = <1000>;
+                                polling-delay-passive = <100>;
+                                sustainable-power = <4500>;
 
-				/* sensor ID */
-				thermal-sensors = <&tsensor 1>;
+                                /* sensor ID */
+                                thermal-sensors = <&tsensor 1>;
 
-				trips {
-					threshold: trip-point@0 {
-						temperature = <65000>;
-						hysteresis = <1000>;
-						type = "passive";
-					};
+                                trips {
+                                        threshold: trip-point@0 {
+                                                temperature = <65000>;
+                                                hysteresis = <1000>;
+                                                type = "passive";
+                                        };
 
-					target: trip-point@1 {
-						temperature = <75000>;
-						hysteresis = <1000>;
-						type = "passive";
-					};
-				};
+                                        target: trip-point@1 {
+                                                temperature = <75000>;
+                                                hysteresis = <1000>;
+                                                type = "passive";
+                                        };
+                                };
 
-				cooling-maps {
+                                cooling-maps {
 					map0 {
-						trip = <&target>;
-						contribution = <1024>;
-						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-					};
+                                                trip = <&target>;
+                                                contribution = <1024>;
+                                                cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+                                        };
 					map1 {
-						trip = <&target>;
-						contribution = <512>;
-						cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-					};
-				};
-			};
-		};
+                                                trip = <&target>;
+                                                contribution = <512>;
+                                                cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+                                        };
+                                };
+                        };
+                };
 	};
 };
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 247024d..9eae986 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -841,6 +841,7 @@
 			compatible = "hisilicon,tsensor";
 			reg = <0x0 0xf7030700 0x0 0x1000>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tsensor_intr";
 			clocks = <&sys_ctrl 22>;
 			clock-names = "thermal_clk";
 			#thermal-sensor-cells = <1>;
-- 
2.7.4
