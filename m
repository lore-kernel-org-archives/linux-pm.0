From: Khiem Nguyen <khiem.nguyen.xt-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>
Subject: [PATCH 3/4] arm64: dts: r8a7795: Add R-Car Gen3 thermal support
Date: Sun, 19 Jun 2016 10:35:53 +0700
Message-ID: <57661319.7040308@rvc.renesas.com>
References: <57661211.7010900@rvc.renesas.com>
 <576612DE.3070204@rvc.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <576612DE.3070204-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Thao Phuong Le. Nguyen" <thao.nguyen.yb-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>, "Hien Duy. Dang" <hien.dang.eb-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>, Toru Oishi <toru.oishi.zj-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


Signed-off-by: Hien Dang <hien.dang.eb-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>
Signed-off-by: Thao Nguyen <thao.nguyen.yb-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>
Signed-off-by: Khiem Nguyen <khiem.nguyen.xt-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 86 ++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index c14e89a..db203db 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -25,6 +25,9 @@
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
 		i2c6 = &i2c6;
+		tsc0 = &tsc1;
+		tsc1 = &tsc2;
+		tsc2 = &tsc3;
 	};
 
 	psci {
@@ -1620,5 +1623,88 @@
 			clocks = <&cpg CPG_MOD 613>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
 		};
+
+		tsc1: thermal@e6198000 {
+			compatible = "renesas,thermal-r8a7795",
+				"renesas,rcar-gen3-thermal";
+			reg = <0 0xe6198000 0 0x5c>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 522>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			#thermal-sensor-cells = <0>;
+			status = "okay";
+		};
+
+		tsc2: thermal@e61a0000 {
+			compatible = "renesas,thermal-r8a7795",
+				"renesas,rcar-gen3-thermal";
+			reg = <0 0xe61a0000 0 0x5c>;
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 522>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			#thermal-sensor-cells = <0>;
+			status = "okay";
+		};
+
+		tsc3: thermal@e61a8000 {
+			compatible = "renesas,thermal-r8a7795",
+				"renesas,rcar-gen3-thermal";
+			reg = <0 0xe61a8000 0 0x5c>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 522>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			#thermal-sensor-cells = <0>;
+			status = "okay";
+		};
+
+		thermal-zones {
+			sensor_thermal1: sensor-thermal1 {
+				polling-delay-passive = <250>;
+				polling-delay = <0>;
+
+				/* sensor ID */
+				thermal-sensors = <&tsc1>;
+
+				trips {
+					sensor1_crit: sensor1-crit {
+						temperature = <90000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+			};
+
+			sensor_thermal2: sensor-thermal2 {
+				polling-delay-passive = <250>;
+				polling-delay = <0>;
+
+				/* sensor ID */
+				thermal-sensors = <&tsc2>;
+
+				trips {
+					sensor2_crit: sensor2-crit {
+						temperature = <90000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+			};
+
+			sensor_thermal3: sensor-thermal3 {
+				polling-delay-passive = <250>;
+				polling-delay = <0>;
+
+				/* sensor ID */
+				thermal-sensors = <&tsc3>;
+
+				trips {
+					sensor3_crit: sensor3-crit {
+						temperature = <90000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+			};
+		};
 	};
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
