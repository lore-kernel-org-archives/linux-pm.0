From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v5 1/3] dt: bindings: add documentation for zx2967 family
 thermal sensor
Date: Wed, 18 Jan 2017 12:42:00 +0800
Message-ID: <1484714522-26651-1-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: jun.nie@linaro.org, rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, xie.baoyou@zte.com.cn, linux-kernel@vger.kernel.org, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn, baoyou.xie@linaro.org, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch adds dt-binding documentation for zx2967 family thermal sensor.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Shawn Guo <shawnguo@kernel.org>
---
 .../devicetree/bindings/thermal/zx2967-thermal.txt | 109 +++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/zx2967-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
new file mode 100644
index 0000000..a96c8b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
@@ -0,0 +1,109 @@
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
+- #thermal-sensor-cells: must be 0.
+
+Example for tempsensor:
+
+	tempsensor: tempsensor@148a000 {
+		compatible = "zte,zx296718-thermal";
+		reg = <0x0148a000 0x20>;
+		clocks = <&topcrm TEMPSENSOR_GATE>, <&audiocrm AUDIO_TS_PCLK>;
+		clock-names = "gate", "pclk";
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
