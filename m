From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 01/12] ARM: dts: r8a7779: Add SYSC PM Domains
Date: Wed, 13 Apr 2016 16:44:41 +0200
Message-ID: <1460558692-10414-2-git-send-email-geert+renesas@glider.be>
References: <1460558692-10414-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:46499 "EHLO
	albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758848AbcDMOoq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2016 10:44:46 -0400
In-Reply-To: <1460558692-10414-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the System Controller.
Hook up ARM CPU cores 1-3 to their respective PM Domains.
Note that ARM CPU core 0 cannot be shut off.

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

v2:
  - Correct sysc "reg" property (#address/size-cells = 1, not 2),
  - Change one-line summary prefix to match current arm-soc practices,
  - Update compatible values.
---
 arch/arm/boot/dts/r8a7779.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 5c1d48d712a18652..e02875a8c040f304 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/r8a7779-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/power/r8a7779-sysc.h>
 
 / {
 	compatible = "renesas,r8a7779";
@@ -34,18 +35,21 @@
 			compatible = "arm,cortex-a9";
 			reg = <1>;
 			clock-frequency = <1000000000>;
+			power-domains = <&sysc R8A7779_PD_ARM1>;
 		};
 		cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
 			clock-frequency = <1000000000>;
+			power-domains = <&sysc R8A7779_PD_ARM2>;
 		};
 		cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
 			clock-frequency = <1000000000>;
+			power-domains = <&sysc R8A7779_PD_ARM3>;
 		};
 	};
 
@@ -586,4 +590,10 @@
 				"mmc1", "mmc0";
 		};
 	};
+
+	sysc: system-controller@ffd85000 {
+		compatible = "renesas,r8a7779-sysc";
+		reg = <0xffd85000 0x0200>;
+		#power-domain-cells = <1>;
+	};
 };
-- 
1.9.1

