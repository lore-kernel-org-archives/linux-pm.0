From: Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 2/2] ARM: dts: r8a7743: Add thermal device to DT
Date: Wed, 13 Dec 2017 10:57:53 +0000
Message-ID: <1513162673-31531-3-git-send-email-biju.das@bp.renesas.com>
References: <1513162673-31531-1-git-send-email-biju.das@bp.renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513162673-31531-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>
List-Id: linux-pm@vger.kernel.org

This patch instantiates the thermal sensor module with thermal-zone
support.

This patch is based on the commit cac68a56e34b
("ARM: dts: r8a7791: enable to use thermal-zone") by Kuninori Morimoto.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 0e2834a..e056bc5 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -250,6 +250,38 @@
 			resets = <&cpg 407>;
 		};
 
+		thermal: thermal@e61f0000 {
+			compatible = "renesas,thermal-r8a7743",
+				     "renesas,rcar-gen2-thermal",
+				     "renesas,rcar-thermal";
+			reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 522>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 522>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		thermal-zones {
+			cpu_thermal: cpu-thermal {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&thermal>;
+
+				trips {
+					cpu-crit {
+						temperature = <95000>;
+						hysteresis = <0>;
+						type = "critical";
+					};
+				};
+
+				cooling-maps {
+				};
+			};
+		};
+
 		timer {
 			compatible = "arm,armv7-timer";
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
-- 
1.9.1
