From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v6 1/3] dt: bindings: add documentation for zx2967 family  thermal sensor
Date: Thu,  2 Feb 2017 23:08:04 +0800
Message-ID: <1486048086-3431-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36056 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbdBBPJM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2017 10:09:12 -0500
Received: by mail-pf0-f180.google.com with SMTP id 189so5946975pfu.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2017 07:09:12 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jun.nie@linaro.org, rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shawnguo@kernel.org, baoyou.xie@linaro.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn

This patch adds dt-binding documentation for zx2967 family thermal sensor.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Shawn Guo <shawnguo@kernel.org>
---
 .../devicetree/bindings/thermal/zx2967-thermal.txt | 114 +++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/zx2967-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
new file mode 100644
index 0000000..00c4900
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
@@ -0,0 +1,114 @@
+* ZTE zx2967 family Thermal
+
+Required Properties:
+- compatible: should be one of the following.
+    * zte,zx296718-thermal
+- reg: physical base address of the controller and length of memory mapped
+    region.
+- clocks : Pairs of phandle and specifier referencing the controller's clocks.
+- clock-names: "gate" for the topcrm clock.
+	       "pclk" for the apb clock.
+- coefficients: Coefficients of thermal sensor, note that those values need to
+		be multiplied by 1000, consists of:
+		slope of calibration cure.
+		offset of calibration cure.
+- #thermal-sensor-cells: must be 0.
+
+Example for tempsensor:
+
+	tempsensor: tempsensor@148a000 {
+		compatible = "zte,zx296718-thermal";
+		reg = <0x0148a000 0x20>;
+		clocks = <&topcrm TEMPSENSOR_GATE>, <&audiocrm AUDIO_TS_PCLK>;
+		clock-names = "gate", "pclk";
+		coefficients = <1951 (-922)>;
+		#thermal-sensor-cells = <0>;
+	};
+
+Example for cooling device:
+
+	cooling_dev: cooling_dev {
+		cluster0_cooling_dev: cluster0-cooling-dev {
+			#cooling-cells = <2>;
+			cpumask = <0xf>;
+			capacitance = <1500>;
+		};
+
+	cluster1_cooling_dev: cluster1-cooling-dev {
+			#cooling-cells = <2>;
+			cpumask = <0x30>;
+			capacitance = <2000>;
+		};
+	};
+
+Example for thermal zones:
+
+	thermal-zones {
+		zx296718_thermal: zx296718_thermal {
+			polling-delay-passive = <500>;
+			polling-delay = <1000>;
+			sustainable-power = <6500>;
+
+			thermal-sensors = <&tempsensor 0>;
+
+			trips {
+				trip0: switch_on_temperature {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip1: desired_temperature {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				crit: critical_temperature {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&trip0>;
+					cooling-device = <&gpu 2 5>;
+				};
+
+				map1 {
+					trip = <&trip0>;
+					cooling-device = <&cluster0_cooling_dev 1 2>;
+				};
+
+				map2 {
+					trip = <&trip1>;
+					cooling-device = <&cluster0_cooling_dev 1 2>;
+				};
+
+				map3 {
+					trip = <&crit>;
+					cooling-device = <&cluster0_cooling_dev 1 2>;
+				};
+
+				map4 {
+					trip = <&trip0>;
+					cooling-device = <&cluster1_cooling_dev 1 2>;
+					contribution = <9000>;
+				};
+
+				map5 {
+					trip = <&trip1>;
+					cooling-device = <&cluster1_cooling_dev 1 2>;
+					contribution = <4096>;
+				};
+
+				map6 {
+					trip = <&crit>;
+					cooling-device = <&cluster1_cooling_dev 1 2>;
+					contribution = <4096>;
+				};
+			};
+		};
+	};
-- 
2.7.4

