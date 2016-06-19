From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Subject: [PATCH 1/4] thermal: rcar_gen3_thermal: Document the R-Car Gen3
 thermal bindings
Date: Sun, 19 Jun 2016 10:33:36 +0700
Message-ID: <57661290.9000501@rvc.renesas.com>
References: <57661211.7010900@rvc.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57661211.7010900@rvc.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <damm+renesas@opensource.se>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Thao Phuong Le. Nguyen" <thao.nguyen.yb@rvc.renesas.com>, "Hien Duy. Dang" <hien.dang.eb@rvc.renesas.com>, Toru Oishi <toru.oishi.zj@rvc.renesas.com>, "Khiem Trong. Nguyen" <khiem.nguyen.xt@rvc.renesas.com>
List-Id: linux-pm@vger.kernel.org


Signed-off-by: Hien Dang <hien.dang.eb@rvc.renesas.com>
Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
---
 .../bindings/thermal/rcar-gen3-thermal.txt         | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
new file mode 100644
index 0000000..ed6ce45
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
@@ -0,0 +1,79 @@
+* DT bindings for Renesas R-Car Gen3 Thermal Sensor driver
+
+Required properties:
+- compatible		: "renesas,thermal-<soctype>",
+			  Examples with soctypes are:
+			    - "renesas,thermal-r8a7795" (R-Car H3)
+			    - "renesas,thermal-r8a7796" (R-Car M3)
+			    - "renesas,rcar-gen3-thermal" as fallback
+- reg			: Address range of the thermal registers.
+- clocks		: Must contain a reference to the functional clock.
+- #thermal-sensor-cells : Please see ./thermal.txt
+
+Option properties:
+
+- interrupts		: Use interrupt
+- power-domain		: Must contain a reference to the power domain. This property is
+			  mandatory if the thermal sensor instance is part of a controllable power
+			  domain.
+
+Example (non interrupt support):
+
+	tsc1: thermal@e6198000 {
+		compatible = "renesas,thermal-r8a7795",
+			"renesas,rcar-gen3-thermal";
+		reg = <0 0xe6198000 0 0x5c>;
+		clocks = <&cpg CPG_MOD 522>;
+		power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+		#thermal-sensor-cells = <0>;
+		status = "okay";
+	};
+
+	thermal-zones {
+		sensor_thermal1: sensor-thermal1 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			/* sensor ID */
+			thermal-sensors = <&tsc1>;
+
+			trips {
+				sensor1_crit: sensor1-crit {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
+Example (interrupt support):
+
+	tsc1: thermal@e6198000 {
+		compatible = "renesas,thermal-r8a7795",
+			"renesas,rcar-gen3-thermal";
+		reg = <0 0xe6198000 0 0x5c>;
+		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg CPG_MOD 522>;
+		power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+		#thermal-sensor-cells = <0>;
+		status = "okay";
+	};
+
+	thermal-zones {
+		sensor_thermal1: sensor-thermal1 {
+			polling-delay-passive = <250>;
+			polling-delay = <0>;
+
+			/* sensor ID */
+			thermal-sensors = <&tsc1>;
+
+			trips {
+				sensor1_crit: sensor1-crit {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
-- 
1.9.1
