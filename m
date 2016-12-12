From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Subject: [PATCHv5 4/5] arm64: dts: r8a7796: Add R-Car Gen3 thermal support
Date: Mon, 12 Dec 2016 15:18:04 +0100
Message-ID: <20161212141805.14946-5-niklas.soderlund@ragnatech.se>
References: <20161212141805.14946-1-niklas.soderlund@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161212141805.14946-1-niklas.soderlund@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Hien Dang <hien.dang.eb@renesas.com>, Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: linux-pm@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
Signed-off-by: Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>
Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 58 ++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 9217da9..5261f0f 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -251,5 +251,63 @@
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
+
+		tsc: thermal@e6198000 {
+			compatible = "renesas,r8a7796-thermal";
+			reg = <0 0xe6198000 0 0x68>,
+			      <0 0xe61a0000 0 0x5c>,
+			      <0 0xe61a8000 0 0x5c>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 522>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			#thermal-sensor-cells = <1>;
+			status = "okay";
+		};
+
+		thermal-zones {
+			sensor_thermal1: sensor-thermal1 {
+				polling-delay-passive = <250>;
+				polling-delay = <1000>;
+				thermal-sensors = <&tsc 0>;
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
+				polling-delay = <1000>;
+				thermal-sensors = <&tsc 1>;
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
+				polling-delay = <1000>;
+				thermal-sensors = <&tsc 2>;
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
2.10.2
