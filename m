From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 05/12] ARM: dts: r8a7794: Add SYSC PM Domains
Date: Thu,  7 Apr 2016 14:20:28 +0200
Message-ID: <1460031635-13452-6-git-send-email-geert+renesas@glider.be>
References: <1460031635-13452-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:43988 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756211AbcDGMUb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 08:20:31 -0400
In-Reply-To: <1460031635-13452-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the System Controller, and hook it up to the
CPG/MSTP Clock Domain.
Hook up the Cortex-A7 CPU cores and the Cortex-A7 L2 cache/SCU to their
respective PM Domains.

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
 arch/arm/boot/dts/r8a7794.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 29a0a001f1b21a9e..722430ee58f2b3e7 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/clock/r8a7794-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/power/r8a7794-sysc.h>
 
 / {
 	compatible = "renesas,r8a7794";
@@ -42,6 +43,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0>;
 			clock-frequency = <1000000000>;
+			power-domains = <&sysc R8A7794_PD_CA7_CPU0>;
 			next-level-cache = <&L2_CA7>;
 		};
 
@@ -50,12 +52,14 @@
 			compatible = "arm,cortex-a7";
 			reg = <1>;
 			clock-frequency = <1000000000>;
+			power-domains = <&sysc R8A7794_PD_CA7_CPU1>;
 			next-level-cache = <&L2_CA7>;
 		};
 	};
 
 	L2_CA7: cache-controller@1 {
 		compatible = "cache";
+		power-domains = <&sysc R8A7794_PD_CA7_SCU>;
 		cache-unified;
 		cache-level = <2>;
 	};
@@ -1244,6 +1248,13 @@
 		};
 	};
 
+	sysc: system-controller@e6180000 {
+		compatible = "renesas,r8a7794-sysc";
+		reg = <0 0xe6180000 0 0x0200>;
+		power-domains = <&cpg_clocks>;
+		#power-domain-cells = <1>;
+	};
+
 	ipmmu_sy0: mmu@e6280000 {
 		compatible = "renesas,ipmmu-r8a7794", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6280000 0 0x1000>;
-- 
1.9.1

