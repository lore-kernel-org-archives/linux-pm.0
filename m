From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] arm64: dts: r8a7796: Add SYSC PM Domains
Date: Tue, 31 May 2016 11:08:44 +0200
Message-ID: <1464685726-21611-2-git-send-email-geert+renesas@glider.be>
References: <1464685726-21611-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:57602 "EHLO
	laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756919AbcEaJIo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 05:08:44 -0400
In-Reply-To: <1464685726-21611-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <damm+renesas@opensource.se>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the System Controller.
Hook up the Cortex-A57 CPU core and L2 cache/SCU to their respective PM
Domains.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 178debf68318fde4..85f0843ddd874378 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -10,6 +10,7 @@
 
 #include <dt-bindings/clock/r8a7796-cpg-mssr.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/r8a7796-sysc.h>
 
 / {
 	compatible = "renesas,r8a7796";
@@ -30,6 +31,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x0>;
 			device_type = "cpu";
+			power-domains = <&sysc R8A7796_PD_CA57_CPU0>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 		};
@@ -37,6 +39,7 @@
 		L2_CA57: cache-controller@0 {
 			compatible = "cache";
 			reg = <0>;
+			power-domains = <&sysc R8A7796_PD_CA57_SCU>;
 			cache-unified;
 			cache-level = <2>;
 		};
@@ -104,6 +107,12 @@
 			#power-domain-cells = <0>;
 		};
 
+		sysc: system-controller@e6180000 {
+			compatible = "renesas,r8a7796-sysc";
+			reg = <0 0xe6180000 0 0x0400>;
+			#power-domain-cells = <1>;
+		};
+
 		scif2: serial@e6e88000 {
 			compatible = "renesas,scif-r8a7796",
 				     "renesas,rcar-gen3-scif", "renesas,scif";
-- 
1.9.1

