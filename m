From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 3/3] dt-bindings: thermal: add binding document for h6 thermal controller
Date: Sun, 12 May 2019 04:26:14 -0400
Message-ID: <20190512082614.9045-4-tiny.windzz@gmail.com>
References: <20190512082614.9045-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190512082614.9045-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tiny.windzz@gmail.com, rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org, catalin.marinas@arm.com, will.deacon@arm.com, davem@davemloft.net, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com, paulmck@linux.ibm.com, andy.gross@linaro.org, olof@lixom.net, bjorn.andersson@linaro.org, jagan@amarulasolutions.com, marc.w.gonzalez@free.fr, stefan.wahren@i2se.com, enric.balletbo@collabora.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds binding document for allwinner h6 thermal controller.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../bindings/thermal/sun50i-thermal.txt       | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun50i-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/sun50i-thermal.txt b/Documentation/devicetree/bindings/thermal/sun50i-thermal.txt
new file mode 100644
index 000000000000..67eda7794262
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sun50i-thermal.txt
@@ -0,0 +1,32 @@
+Binding for Thermal Sensor of Allwinner SOC.
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
+- resets, reset-names: Reference to the reset controller controlling
+		       the thermal controller.
+- nvmem-cells: A phandle to the calibration data provided by a nvmem device. If
+	       unspecified default values shall be used.
+- nvmem-cell-names: Should be "calib"
+- #thermal-sensor-cells : For H6 Should be 1.
+			  See ./thermal.txt for a description.
+
+Example:
+
+	ths: ths@1c25000 {
+		compatible = "allwinner,sun50i-h6-ths";
+		reg = <0x05070400 0x100>;
+		clocks = <&ccu CLK_BUS_THS>;
+		clock-names = "bus";
+		resets = <&ccu RST_BUS_THS>;
+		reset-names = "bus";
+		nvmem-cells = <&tsen_calib>;
+		nvmem-cell-names = "calib";
+		#thermal-sensor-cells = <1>;
+	};
-- 
2.17.0
