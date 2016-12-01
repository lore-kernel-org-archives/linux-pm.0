From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 1/4] thermal: rcar_gen3_thermal: Document the R-Car Gen3
Date: Thu,  1 Dec 2016 23:04:39 +0100
Message-ID: <20161201220442.22057-2-wsa+renesas@sang-engineering.com>
References: <20161201220442.22057-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:56256 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753435AbcLAWE4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Dec 2016 17:04:56 -0500
In-Reply-To: <20161201220442.22057-1-wsa+renesas@sang-engineering.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Hien Dang <hien.dang.eb@renesas.com>

Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../bindings/thermal/rcar-gen3-thermal.txt         | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
new file mode 100644
index 00000000000000..07a9713ae6a757
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
@@ -0,0 +1,56 @@
+* DT bindings for Renesas R-Car Gen3 Thermal Sensor driver
+
+On R-Car Gen3 SoCs, the thermal sensor controllers (TSC) control the thermal
+sensors (THS) which are the analog circuits for measuring temperature (Tj)
+inside the LSI.
+
+Required properties:
+- compatible		: "renesas,<soctype>-thermal",
+			  Examples with soctypes are:
+			    - "renesas,r8a7795-thermal" (R-Car H3)
+			    - "renesas,r8a7796-thermal" (R-Car M3-W)
+- reg			: Address ranges of the thermal registers. Each sensor
+			  needs one address range. Sorting must be done in
+			  increasing order according to datasheet, i.e.
+			  TSC1, TSC2, ...
+- clocks		: Must contain a reference to the functional clock.
+- #thermal-sensor-cells : must be <1>.
+
+Optional properties:
+
+- interrupts           : interrupts routed to the TSC (3 for H3 and M3-W)
+- power-domain		: Must contain a reference to the power domain. This
+			  property is mandatory if the thermal sensor instance
+			  is part of a controllable power domain.
+
+Example:
+
+	tsc: thermal@e6198000 {
+		compatible = "renesas,r8a7795-thermal";
+		reg = <0 0xe6198000 0 0x68>,
+		      <0 0xe61a0000 0 0x5c>,
+		      <0 0xe61a8000 0 0x5c>;
+		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg CPG_MOD 522>;
+		power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+		#thermal-sensor-cells = <1>;
+		status = "okay";
+	};
+
+	thermal-zones {
+		sensor_thermal1: sensor-thermal1 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsc 0>;
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
2.10.2

