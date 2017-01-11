From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v2 1/3] dt: bindings: add documentation for zx2967 family thermal sensor
Date: Wed, 11 Jan 2017 18:14:09 +0800
Message-ID: <1484129651-17531-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, jun.nie@linaro.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org, baoyou.xie@linaro.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
List-Id: linux-pm@vger.kernel.org

This patch adds dt-binding documentation for zx2967 family thermal sensor.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 .../devicetree/bindings/thermal/zx2967-thermal.txt  | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/zx2967-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
new file mode 100644
index 0000000..86f941c
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
@@ -0,0 +1,21 @@
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
+Example:
+
+	tempsensor: tempsensor@148a000 {
+		compatible = "zte,zx296718-thermal";
+		reg = <0x0148a000 0x20>;
+		clocks = <&topcrm TEMPSENSOR_GATE>, <&audiocrm AUDIO_TS_PCLK>;
+		clock-names = "gate", "pclk";
+		#thermal-sensor-cells = <0>;
+	};
-- 
2.7.4
