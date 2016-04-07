From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 02/12] ARM: dts: r8a7790: Add SYSC PM Domains
Date: Thu,  7 Apr 2016 14:20:25 +0200
Message-ID: <1460031635-13452-3-git-send-email-geert+renesas@glider.be>
References: <1460031635-13452-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:43996 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756206AbcDGMUb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 08:20:31 -0400
In-Reply-To: <1460031635-13452-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the System Controller, and hook it up to the
CPG/MSTP Clock Domain.
Hook up the Cortex-A15 and Cortex-A7 CPU cores and L2 caches/SCUs to
their respective PM Domains.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Add power-domains property to the sysc node, to refer to the SoC's
    Clock Domain,

v3:
  - Drop power area hiearchy from DT,
  - Switch to "#power-domain-cells = <1>",
  - Drop fallback compatibility strings,

v2:
  - Change one-line summary prefix to match current arm-soc practices,
  - Update compatible values.
---
 arch/arm/boot/dts/r8a7790.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 50e8484511893572..952059a925650bea 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/clock/r8a7790-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/power/r8a7790-sysc.h>
 
 / {
 	compatible = "renesas,r8a7790";
@@ -52,6 +53,7 @@
 			voltage-tolerance = <1>; /* 1% */
 			clocks = <&cpg_clocks R8A7790_CLK_Z>;
 			clock-latency = <300000>; /* 300 us */
+			power-domains = <&sysc R8A7790_PD_CA15_CPU0>;
 			next-level-cache = <&L2_CA15>;
 
 			/* kHz - uV - OPPs unknown yet */
@@ -68,6 +70,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1300000000>;
+			power-domains = <&sysc R8A7790_PD_CA15_CPU1>;
 			next-level-cache = <&L2_CA15>;
 		};
 
@@ -76,6 +79,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <2>;
 			clock-frequency = <1300000000>;
+			power-domains = <&sysc R8A7790_PD_CA15_CPU2>;
 			next-level-cache = <&L2_CA15>;
 		};
 
@@ -84,6 +88,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <3>;
 			clock-frequency = <1300000000>;
+			power-domains = <&sysc R8A7790_PD_CA15_CPU3>;
 			next-level-cache = <&L2_CA15>;
 		};
 
@@ -92,6 +97,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
 			clock-frequency = <780000000>;
+			power-domains = <&sysc R8A7790_PD_CA7_CPU0>;
 			next-level-cache = <&L2_CA7>;
 		};
 
@@ -100,6 +106,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x101>;
 			clock-frequency = <780000000>;
+			power-domains = <&sysc R8A7790_PD_CA7_CPU1>;
 			next-level-cache = <&L2_CA7>;
 		};
 
@@ -108,6 +115,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x102>;
 			clock-frequency = <780000000>;
+			power-domains = <&sysc R8A7790_PD_CA7_CPU2>;
 			next-level-cache = <&L2_CA7>;
 		};
 
@@ -116,6 +124,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x103>;
 			clock-frequency = <780000000>;
+			power-domains = <&sysc R8A7790_PD_CA7_CPU3>;
 			next-level-cache = <&L2_CA7>;
 		};
 	};
@@ -141,12 +150,14 @@
 
 	L2_CA15: cache-controller@0 {
 		compatible = "cache";
+		power-domains = <&sysc R8A7790_PD_CA15_SCU>;
 		cache-unified;
 		cache-level = <2>;
 	};
 
 	L2_CA7: cache-controller@1 {
 		compatible = "cache";
+		power-domains = <&sysc R8A7790_PD_CA7_SCU>;
 		cache-unified;
 		cache-level = <2>;
 	};
@@ -1471,6 +1482,13 @@
 		};
 	};
 
+	sysc: system-controller@e6180000 {
+		compatible = "renesas,r8a7790-sysc";
+		reg = <0 0xe6180000 0 0x0200>;
+		power-domains = <&cpg_clocks>;
+		#power-domain-cells = <1>;
+	};
+
 	qspi: spi@e6b10000 {
 		compatible = "renesas,qspi-r8a7790", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
-- 
1.9.1

