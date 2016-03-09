From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 4/6] ARM: dts: r8a7793: Add SYSC PM domains
Date: Wed,  9 Mar 2016 20:18:53 +0100
Message-ID: <1457551135-22078-5-git-send-email-geert+renesas@glider.be>
References: <1457551135-22078-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1457551135-22078-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add a device node for the System Controller.
Hook up the first Cortex-A15 CPU core and the Cortex-A15 L2 cache/SCU to
their respective PM domains.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Drop power area hiearchy from DT,
  - Switch to "#power-domain-cells = <1>",
  - Drop fallback compatibility strings,

v2:
  - Change one-line summary prefix to match current arm-soc practices,
  - Update compatible values.
---
 arch/arm/boot/dts/r8a7793.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index b482159452412601..0956cd5f2d545ebc 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/r8a7793-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/power/r8a7793-sysc.h>
 
 / {
 	compatible = "renesas,r8a7793";
@@ -43,6 +44,7 @@
 			voltage-tolerance = <1>; /* 1% */
 			clocks = <&cpg_clocks R8A7793_CLK_Z>;
 			clock-latency = <300000>; /* 300 us */
+			power-domains = <&sysc R8A7793_PD_CA15_CPU0>;
 
 			/* kHz - uV - OPPs unknown yet */
 			operating-points = <1500000 1000000>,
@@ -76,6 +78,7 @@
 
 	L2_CA15: cache-controller@0 {
 		compatible = "cache";
+		power-domains = <&sysc R8A7793_PD_CA15_SCU>;
 		cache-unified;
 		cache-level = <2>;
 	};
@@ -1166,6 +1169,12 @@
 		};
 	};
 
+	sysc: system-controller@e6180000 {
+		compatible = "renesas,r8a7793-sysc";
+		reg = <0 0xe6180000 0 0x0200>;
+		#power-domain-cells = <1>;
+	};
+
 	ipmmu_sy0: mmu@e6280000 {
 		compatible = "renesas,ipmmu-r8a7793", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6280000 0 0x1000>;
-- 
1.9.1
