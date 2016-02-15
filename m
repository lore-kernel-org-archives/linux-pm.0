From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2 08/11] ARM: dts: r8a7791: Add SYSC PM domains
Date: Mon, 15 Feb 2016 22:16:57 +0100
Message-ID: <1455571020-18968-9-git-send-email-geert+renesas@glider.be>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add a device node for the System Controller, with subnodes that
represent the hardware power area hierarchy.
Hook up the Cortex-A15 CPU cores and the Cortex-A15 L2 cache/SCU to
their respective PM domains.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Change one-line summary prefix to match current arm-soc practices,
  - Update compatible values.
---
 arch/arm/boot/dts/r8a7791.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index a65910ed5884edfd..a194273eb2b7951e 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -51,6 +51,7 @@
 			voltage-tolerance = <1>; /* 1% */
 			clocks = <&cpg_clocks R8A7791_CLK_Z>;
 			clock-latency = <300000>; /* 300 us */
+			power-domains = <&pd_ca15_cpu0>;
 			next-level-cache = <&L2_CA15>;
 
 			/* kHz - uV - OPPs unknown yet */
@@ -67,12 +68,14 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1500000000>;
+			power-domains = <&pd_ca15_cpu1>;
 			next-level-cache = <&L2_CA15>;
 		};
 	};
 
 	L2_CA15: cache-controller@0 {
 		compatible = "cache";
+		power-domains = <&pd_ca15_scu>;
 		cache-unified;
 		cache-level = <2>;
 	};
@@ -1473,6 +1476,43 @@
 		};
 	};
 
+	sysc: system-controller@e6180000 {
+		compatible = "renesas,r8a7791-sysc", "renesas,rcar-gen2-sysc";
+		reg = <0 0xe6180000 0 0x0200>;
+
+		pm-domains {
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			pd_ca15_scu: scu@12 {
+				reg = <12 0x180>;
+				#address-cells = <2>;
+				#size-cells = <0>;
+				#power-domain-cells = <0>;
+
+				pd_ca15_cpu0: cpu@0 {
+					reg = <0 0x40>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_ca15_cpu1: cpu@1 {
+					reg = <1 0x41>;
+					#power-domain-cells = <0>;
+				};
+			};
+
+			pd_sh: sh@16 {
+				reg = <16 0x80>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_sgx: sgx@20 {
+				reg = <20 0xc0>;
+				#power-domain-cells = <0>;
+			};
+		};
+	};
+
 	qspi: spi@e6b10000 {
 		compatible = "renesas,qspi-r8a7791", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
-- 
1.9.1
