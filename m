From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Subject: [PATCHv5 1/5] thermal: rcar_gen3_thermal: Document the R-Car Gen3
Date: Mon, 12 Dec 2016 15:18:01 +0100
Message-ID: <20161212141805.14946-2-niklas.soderlund@ragnatech.se>
References: <20161212141805.14946-1-niklas.soderlund@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-4.sys.kth.se ([130.237.48.193]:52457 "EHLO
        smtp-4.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752728AbcLLOUN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2016 09:20:13 -0500
In-Reply-To: <20161212141805.14946-1-niklas.soderlund@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Hien Dang <hien.dang.eb@renesas.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 .../bindings/thermal/rcar-gen3-thermal.txt         | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
new file mode 100644
index 0000000..07a9713
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

