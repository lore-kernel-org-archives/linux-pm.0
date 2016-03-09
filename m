From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 5/6] ARM: dts: r8a7794: Add SYSC PM domains
Date: Wed,  9 Mar 2016 20:18:54 +0100
Message-ID: <1457551135-22078-6-git-send-email-geert+renesas@glider.be>
References: <1457551135-22078-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1457551135-22078-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add a device node for the System Controller.
Hook up the Cortex-A7 CPU cores and the Cortex-A7 L2 cache/SCU to their
respective PM domains.

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
 arch/arm/boot/dts/r8a7794.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index eacb2b291361ec5c..0d0b728f86d14886 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/clock/r8a7794-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/power/r8a7794-sysc.h>
 
 / {
 	compatible = "renesas,r8a7794";
@@ -40,6 +41,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0>;
 			clock-frequency = <1000000000>;
+			power-domains = <&sysc R8A7794_PD_CA7_CPU0>;
 			next-level-cache = <&L2_CA7>;
 		};
 
@@ -48,12 +50,14 @@
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
@@ -1165,6 +1169,12 @@
 		};
 	};
 
+	sysc: system-controller@e6180000 {
+		compatible = "renesas,r8a7794-sysc";
+		reg = <0 0xe6180000 0 0x0200>;
+		#power-domain-cells = <1>;
+	};
+
 	ipmmu_sy0: mmu@e6280000 {
 		compatible = "renesas,ipmmu-r8a7794", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6280000 0 0x1000>;
-- 
1.9.1
