From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 03/12] ARM: dts: r8a7791: Add SYSC PM Domains
Date: Thu,  7 Apr 2016 14:20:26 +0200
Message-ID: <1460031635-13452-4-git-send-email-geert+renesas@glider.be>
References: <1460031635-13452-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:58980 "EHLO
	laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756188AbcDGMUa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 08:20:30 -0400
In-Reply-To: <1460031635-13452-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the System Controller, and hook it up to the
CPG/MSTP Clock Domain.
Hook up the Cortex-A15 CPU cores and the Cortex-A15 L2 cache/SCU to
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
 arch/arm/boot/dts/r8a7791.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 8693888057ff3f7d..b7f69a538223ee53 100644
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
@@ -1491,6 +1495,13 @@
 		};
 	};
 
+	sysc: system-controller@e6180000 {
+		compatible = "renesas,r8a7791-sysc";
+		reg = <0 0xe6180000 0 0x0200>;
+		power-domains = <&cpg_clocks>;
+		#power-domain-cells = <1>;
+	};
+
 	qspi: spi@e6b10000 {
 		compatible = "renesas,qspi-r8a7791", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
-- 
1.9.1

