From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH v12 2/5] dt-bindings: document Rockchip thermal
Date: Mon, 20 Oct 2014 17:53:47 +0800
Message-ID: <1413798830-23435-3-git-send-email-caesar.wang@rock-chips.com>
References: <1413798830-23435-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1413798830-23435-1-git-send-email-caesar.wang@rock-chips.com>
Sender: linux-doc-owner@vger.kernel.org
To: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com
Cc: zyf@rock-chips.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, cf@rock-chips.com, dmitry.torokhov@gmail.com, dbasehore@chromium.org, huangtao@rock-chips.com, cjf@rock-chips.com, zhengsq@rock-chips.com, vladimir_zapolskiy@mentor.com, Caesar Wang <caesar.wang@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

This add the necessary binding documentation for the thermal
found on Rockchip SoCs

Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 .../bindings/thermal/rockchip-thermal.txt          | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
new file mode 100644
index 0000000..d5ff410
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
@@ -0,0 +1,45 @@
+* Temperature Sensor ADC (TSADC) on rockchip SoCs
+
+Required properties:
+- compatible: "rockchip,rk3288-tsadc"
+- reg: physical base address of the controller and length of memory mapped
+       region.
+- interrupts: The interrupt number to the cpu. The interrupt specifier format
+	      depends on the interrupt controller.
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names: Shall be "tsadc" for the converter-clock, and "apb_pclk" for
+	       the peripheral clock.
+- #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
+
+Exiample:
+tsadc: tsadc@ff280000 {
+	compatible = "rockchip,rk3288-tsadc";
+	reg = <0xff280000 0x100>;
+	interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+	clock-names = "tsadc", "apb_pclk";
+};
+
+Example: referring to thermal sensors:
+thermal-zones {
+       cpu_thermal: cpu_thermal {
+	        polling-delay-passive = <500>; /* milliseconds */
+	        polling-delay = <1000>; /* milliseconds */
+
+			        /* sensor	ID */
+	        thermal-sensors = <&tsadc	1>;
+
+	        trips {
+		        cpu_alert0: cpu_alert {
+			        temperature = <80000>; /* millicelsius */
+			        hysteresis = <2000>; /* millicelsius */
+			        type = "passive";
+		        };
+		        cpu_crit: cpu_crit {
+			        temperature = <125000>; /* millicelsius */
+			        hysteresis = <2000>; /* millicelsius */
+			    type = "critical";
+		        };
+	        };
+       };
+};
-- 
1.9.1


