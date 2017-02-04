From: Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v8 1/3] dt: bindings: add documentation for zx2967 family  thermal sensor
Date: Sat,  4 Feb 2017 11:39:55 +0800
Message-ID: <1486179597-30953-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, xie.baoyou-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, chen.chaokai-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, wang.qiang01-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch adds dt-binding documentation for zx2967 family thermal sensor.

Signed-off-by: Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Reviewed-by: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/thermal/zx2967-thermal.txt | 116 +++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/zx2967-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
new file mode 100644
index 0000000..0810644
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
@@ -0,0 +1,116 @@
+* ZTE zx2967 family Thermal
+
+Required Properties:
+- compatible: should be one of the following.
+    * zte,zx296718-thermal
+- reg: physical base address of the controller and length of memory mapped
+    region.
+- clocks : Pairs of phandle and specifier referencing the controller's clocks.
+- clock-names: "topcrm" for the topcrm clock.
+	       "apb" for the apb clock.
+- #thermal-sensor-cells: must be 0.
+
+Please note: coefficients defined in thermal-zones section need to be
+multiplied by 1000.
+
+Example for tempsensor:
+
+	tempsensor: tempsensor@148a000 {
+		compatible = "zte,zx296718-thermal";
+		reg = <0x0148a000 0x20>;
+		clocks = <&topcrm TEMPSENSOR_GATE>, <&audiocrm AUDIO_TS_PCLK>;
+		clock-names = "topcrm", "apb";
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
+			/*
+			 * slope need to be multiplied by 1000.
+			 */
+			coefficients = <1951 (-922)>;
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
