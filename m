From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: thermal: add binding document for h6 thermal controller
Date: Thu, 16 May 2019 13:26:33 -0400
Message-ID: <20190516172633.12607-3-tiny.windzz@gmail.com>
References: <20190516172633.12607-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190516172633.12607-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org, davem@davemloft.net, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, linus.walleij@linaro.org, Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

This patch adds binding document for allwinner h6 thermal controller.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../bindings/thermal/sun8i-thermal.txt        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/sun8i-thermal.txt b/Documentation/devicetree/bindings/thermal/sun8i-thermal.txt
new file mode 100644
index 000000000000..bd417260501f
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sun8i-thermal.txt
@@ -0,0 +1,34 @@
+* Allwinner Thermal
+
+This describes the device tree binding for the Allwinner thermal controller
+which measures the on-SoC temperatures.
+
+Required properties:
+- compatible:
+  - "allwinner,sun50i-h6-ths" : For H6
+- reg: Address range of the thermal controller
+- clocks, clock-names: Clocks needed for the thermal controller.
+		       The required clocks for h6 are: "bus".
+- resets: Reference to the reset controller controlling the thermal controller.
+- interrupts: IRQ for the thermal controller
+- #thermal-sensor-cells : For H6 Should be 1.
+			  See ./thermal.txt for a description.
+
+Optional properties:
+- nvmem-cells: A phandle to the calibration data provided by a nvmem device. If
+	       unspecified default values shall be used.
+- nvmem-cell-names: Should be "calib".
+
+Example:
+
+	ths: ths@1c25000 {
+		compatible = "allwinner,sun50i-h6-ths";
+		reg = <0x05070400 0x100>;
+		clocks = <&ccu CLK_BUS_THS>;
+		clock-names = "bus";
+		resets = <&ccu RST_BUS_THS>;
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+		nvmem-cells = <&tsen_calib>;
+		nvmem-cell-names = "calib";
+		#thermal-sensor-cells = <1>;
+	};
-- 
2.17.0
