From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/4] ARM: shmobile: sh73a0 dtsi: Add memory-controller nodes
Date: Wed, 14 Jan 2015 12:13:02 +0100
Message-ID: <1421233982-15883-5-git-send-email-geert+renesas@glider.be>
References: <1421233982-15883-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1421233982-15883-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add device nodes for the two SDRAM Bus State Controllers.
The SBSCs are located in the A4BC0 resp. A4BC1 PM domains, which must
not be powered down, else the system will crash.

References to the A4BC0 and A4BC1 PM domains will be added later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 46954ac26dd9fb41..8d9c2ce593745b1f 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -43,6 +43,22 @@
 		      <0xf0000100 0x100>;
 	};
 
+	sbsc2: memory-controller@fb400000 {
+		compatible = "renesas,sbsc-sh73a0";
+		reg = <0xfb400000 0x400>;
+		interrupts = <0 37 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 38 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "sec", "temp";
+	};
+
+	sbsc1: memory-controller@fe400000 {
+		compatible = "renesas,sbsc-sh73a0";
+		reg = <0xfe400000 0x400>;
+		interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 36 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "sec", "temp";
+	};
+
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <0 55 IRQ_TYPE_LEVEL_HIGH>,
-- 
1.9.1

