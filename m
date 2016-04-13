From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 03/12] ARM: dts: r8a7791: Add SYSC PM Domains
Date: Wed, 13 Apr 2016 16:44:43 +0200
Message-ID: <1460558692-10414-4-git-send-email-geert+renesas@glider.be>
References: <1460558692-10414-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1460558692-10414-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add a device node for the System Controller.
Hook up the Cortex-A15 CPU cores and the Cortex-A15 L2 cache/SCU to
their respective PM Domains.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - Remove "power-domains" property again from the sysc node, as the
    System Controller itself is not part of the Clock Domain,

v4:
  - Add "power-domains" property to the sysc node, to refer to the SoC's
    Clock Domain,

v3:
  - Drop power area hiearchy from DT,
  - Switch to "#power-domain-cells = <1>",
  - Drop fallback compatibility strings,

v2:
  - Change one-line summary prefix to match current arm-soc practices,
  - Update compatible values.
---
 arch/arm/boot/dts/r8a7791.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 8693888057ff3f7d..cffd7f49c01fb7a1 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/clock/r8a7791-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/power/r8a7791-sysc.h>
 
 / {
 	compatible = "renesas,r8a7791";
@@ -51,6 +52,7 @@
 			voltage-tolerance = <1>; /* 1% */
 			clocks = <&cpg_clocks R8A7791_CLK_Z>;
 			clock-latency = <300000>; /* 300 us */
+			power-domains = <&sysc R8A7791_PD_CA15_CPU0>;
 			next-level-cache = <&L2_CA15>;
 
 			/* kHz - uV - OPPs unknown yet */
@@ -67,6 +69,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1500000000>;
+			power-domains = <&sysc R8A7791_PD_CA15_CPU1>;
 			next-level-cache = <&L2_CA15>;
 		};
 	};
@@ -92,6 +95,7 @@
 
 	L2_CA15: cache-controller@0 {
 		compatible = "cache";
+		power-domains = <&sysc R8A7791_PD_CA15_SCU>;
 		cache-unified;
 		cache-level = <2>;
 	};
@@ -1491,6 +1495,12 @@
 		};
 	};
 
+	sysc: system-controller@e6180000 {
+		compatible = "renesas,r8a7791-sysc";
+		reg = <0 0xe6180000 0 0x0200>;
+		#power-domain-cells = <1>;
+	};
+
 	qspi: spi@e6b10000 {
 		compatible = "renesas,qspi-r8a7791", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
-- 
1.9.1
