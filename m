From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 12/15] ARM: shmobile: r8a7790 dtsi: Add SYSC PM domains
Date: Thu,  4 Jun 2015 20:53:38 +0200
Message-ID: <1433444021-22167-13-git-send-email-geert+renesas@glider.be>
References: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add a device node for the System Controller, with subnodes that
represent the hardware power area hierarchy.
Hook up the Cortex-A15 and Cortex-A7 CPU cores and L2 caches/SCUs to
their respective PM domains.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 89 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index bc98bb6cff635ae5..ccae1e6d4b12ecc5 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -52,6 +52,7 @@
 			voltage-tolerance = <1>; /* 1% */
 			clocks = <&cpg_clocks R8A7790_CLK_Z>;
 			clock-latency = <300000>; /* 300 us */
+			power-domains = <&pd_ca15_cpu0>;
 
 			i-cache-size = <0x8000>;
 			i-cache-sets = <512>;
@@ -77,6 +78,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1300000000>;
+			power-domains = <&pd_ca15_cpu1>;
 
 			i-cache-size = <0x8000>;
 			i-cache-sets = <512>;
@@ -94,6 +96,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <2>;
 			clock-frequency = <1300000000>;
+			power-domains = <&pd_ca15_cpu2>;
 
 			i-cache-size = <0x8000>;
 			i-cache-sets = <512>;
@@ -111,6 +114,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <3>;
 			clock-frequency = <1300000000>;
+			power-domains = <&pd_ca15_cpu3>;
 
 			i-cache-size = <0x8000>;
 			i-cache-sets = <512>;
@@ -128,6 +132,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
 			clock-frequency = <780000000>;
+			power-domains = <&pd_ca7_cpu0>;
 
 			i-cache-size = <0x8000>;
 			i-cache-sets = <512>;
@@ -145,6 +150,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x101>;
 			clock-frequency = <780000000>;
+			power-domains = <&pd_ca7_cpu1>;
 
 			i-cache-size = <0x8000>;
 			i-cache-sets = <512>;
@@ -162,6 +168,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x102>;
 			clock-frequency = <780000000>;
+			power-domains = <&pd_ca7_cpu2>;
 
 			i-cache-size = <0x8000>;
 			i-cache-sets = <512>;
@@ -179,6 +186,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x103>;
 			clock-frequency = <780000000>;
+			power-domains = <&pd_ca7_cpu3>;
 
 			i-cache-size = <0x8000>;
 			i-cache-sets = <512>;
@@ -194,6 +202,7 @@
 
 	L2_CA15: cache-controller@0 {
 		compatible = "cache";
+		power-domains = <&pd_ca15_scu>;
 
 		arm,data-latency = <4 4 1>;
 		arm,tag-latency = <3 3 3>;
@@ -207,6 +216,7 @@
 
 	L2_CA7: cache-controller@1 {
 		compatible = "cache";
+		power-domains = <&pd_ca7_scu>;
 
 		cache-unified;
 		cache-level = <2>;
@@ -1476,6 +1486,85 @@
 		};
 	};
 
+	sysc: system-controller@e6180000 {
+		compatible = "renesas,sysc-r8a7790", "renesas,sysc-rcar";
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
+
+				pd_ca15_cpu2: cpu@2 {
+					reg = <2 0x42>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_ca15_cpu3: cpu@3 {
+					reg = <3 0x43>;
+					#power-domain-cells = <0>;
+				};
+			};
+
+			pd_ca7_scu: scu@21 {
+				reg = <21 0x100>;
+				#address-cells = <2>;
+				#size-cells = <0>;
+				#power-domain-cells = <0>;
+
+				pd_ca7_cpu0: cpu@5 {
+					reg = <5 0x1c0>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_ca7_cpu1: cpu@6 {
+					reg = <6 0x1c1>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_ca7_cpu2: cpu@7 {
+					reg = <7 0x1c2>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_ca7_cpu3: cpu@8 {
+					reg = <8 0x1c3>;
+					#power-domain-cells = <0>;
+				};
+			};
+
+			pd_sh: sh@16 {
+				reg = <16 0x80>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_rgx: rgx@20 {
+				reg = <20 0xc0>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_imp: imp@24 {
+				reg = <24 0x140>;
+				#power-domain-cells = <0>;
+			};
+		};
+	};
+
 	qspi: spi@e6b10000 {
 		compatible = "renesas,qspi-r8a7790", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
-- 
1.9.1
