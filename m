From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH v19 1/5] dt-bindings: document Rockchip thermal
Date: Mon, 24 Nov 2014 12:58:58 +0800
Message-ID: <1416805142-27304-2-git-send-email-caesar.wang@rock-chips.com>
References: <1416805142-27304-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1416805142-27304-1-git-send-email-caesar.wang@rock-chips.com>
Sender: linux-doc-owner@vger.kernel.org
To: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com
Cc: zyf@rock-chips.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, cf@rock-chips.com, dmitry.torokhov@gmail.com, huangtao@rock-chips.com, fzf@rock-chips.com, caesar.wang@rock-chips.com
List-Id: linux-pm@vger.kernel.org

This add the necessary binding documentation for the thermal
found on Rockchip SoCs

Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../bindings/thermal/rockchip-thermal.txt          | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
new file mode 100644
index 0000000..ef802de
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
@@ -0,0 +1,68 @@
+* Temperature Sensor ADC (TSADC) on rockchip SoCs
+
+Required properties:
+- compatible : "rockchip,rk3288-tsadc"
+- reg : physical base address of the controller and length of memory mapped
+	region.
+- interrupts : The interrupt number to the cpu. The interrupt specifier format
+	       depends on the interrupt controller.
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : Shall be "tsadc" for the converter-clock, and "apb_pclk" for
+		the peripheral clock.
+- resets : Must contain an entry for each entry in reset-names.
+	   See ../reset/reset.txt for details.
+- reset-names : Must include the name "tsadc-apb".
+- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
+- rockchip,hw-tshut-temp : The hardware-controlled shutdown temperature value.
+- rockchip,hw-tshut-mode : The hardware-controlled shutdown mode 0:CRU 1:GPIO.
+- rockchip,hw-tshut-polarity : The hardware-controlled active polarity 0:LOW
+			       1:HIGH.
+
+Exiample:
+tsadc: tsadc@ff280000 {
+	compatible = "rockchip,rk3288-tsadc";
+	reg = <0xff280000 0x100>;
+	interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+	clock-names = "tsadc", "apb_pclk";
+	resets = <&cru SRST_TSADC>;
+	reset-names = "tsadc-apb";
+	pinctrl-names = "default";
+	pinctrl-0 = <&otp_out>;
+	#thermal-sensor-cells = <1>;
+	rockchip,hw-tshut-temp = <95000>;
+	rockchip,hw-tshut-mode = <0>;
+	rockchip,hw-tshut-polarity = <0>;
+};
+
+Example: referring to thermal sensors:
+thermal-zones {
+	cpu_thermal: cpu_thermal {
+		polling-delay-passive = <1000>; /* milliseconds */
+		polling-delay = <5000>; /* milliseconds */
+
+		/* sensor	ID */
+		thermal-sensors = <&tsadc	1>;
+
+		trips {
+			cpu_alert0: cpu_alert {
+				temperature = <70000>; /* millicelsius */
+				hysteresis = <2000>; /* millicelsius */
+				type = "passive";
+			};
+			cpu_crit: cpu_crit {
+				temperature = <90000>; /* millicelsius */
+				hysteresis = <2000>; /* millicelsius */
+				type = "critical";
+			};
+		};
+
+		cooling-maps {
+			map0 {
+				trip = <&cpu_alert0>;
+				cooling-device =
+				    <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+		};
+	};
+};
-- 
1.9.1


