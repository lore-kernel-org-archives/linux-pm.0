From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/6] ARM: shmobile: r8a7790 dtsi: Add L2 cache-controller nodes
Date: Mon,  7 Dec 2015 19:24:15 +0100
Message-ID: <1449512659-16688-3-git-send-email-geert+renesas@glider.be>
References: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add device nodes for the L2 caches, and link the CPU nodes to them.

The L2 cache for the Cortex-A15 CPU cores is 2 MiB large (organized as
128 KiB x 16 ways), and requires the following settings:
  - Tag RAM latency: 3 cycles,
  - Data RAM latency: 4 cycles,
  - Data RAM setup: 1 cycle.

The L2 cache for the Cortex-A7 CPU cores is 512 KiB large (organized as
64 KiB x 8 ways).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
What are the DT bindings for Cortex-A15/A7 L2 cache controllers?

v2:
  - Drop (incorrect) optional cache-{size,sets,{block,line}-size}
    properties, as this information is auto-detected,
  - Integrate linking CPUs to L2 caches into this patch,
  - Extracted from series "[PATCH/RFC 00/15] ARM: shmobile: R-Car: Add
    SYSC PM Domain DT Support".
---
 arch/arm/boot/dts/r8a7790.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 6cfd0dc79bbec067..ef5d46faef0c5975 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -52,6 +52,7 @@
 			voltage-tolerance = <1>; /* 1% */
 			clocks = <&cpg_clocks R8A7790_CLK_Z>;
 			clock-latency = <300000>; /* 300 us */
+			next-level-cache = <&L2_CA15>;
 
 			/* kHz - uV - OPPs unknown yet */
 			operating-points = <1400000 1000000>,
@@ -67,6 +68,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1300000000>;
+			next-level-cache = <&L2_CA15>;
 		};
 
 		cpu2: cpu@2 {
@@ -74,6 +76,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <2>;
 			clock-frequency = <1300000000>;
+			next-level-cache = <&L2_CA15>;
 		};
 
 		cpu3: cpu@3 {
@@ -81,6 +84,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <3>;
 			clock-frequency = <1300000000>;
+			next-level-cache = <&L2_CA15>;
 		};
 
 		cpu4: cpu@4 {
@@ -88,6 +92,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
 			clock-frequency = <780000000>;
+			next-level-cache = <&L2_CA7>;
 		};
 
 		cpu5: cpu@5 {
@@ -95,6 +100,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x101>;
 			clock-frequency = <780000000>;
+			next-level-cache = <&L2_CA7>;
 		};
 
 		cpu6: cpu@6 {
@@ -102,6 +108,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x102>;
 			clock-frequency = <780000000>;
+			next-level-cache = <&L2_CA7>;
 		};
 
 		cpu7: cpu@7 {
@@ -109,9 +116,24 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x103>;
 			clock-frequency = <780000000>;
+			next-level-cache = <&L2_CA7>;
 		};
 	};
 
+	L2_CA15: cache-controller@0 {
+		compatible = "cache";
+		arm,data-latency = <4 4 1>;
+		arm,tag-latency = <3 3 3>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
+	L2_CA7: cache-controller@1 {
+		compatible = "cache";
+		cache-unified;
+		cache-level = <2>;
+	};
+
 	gic: interrupt-controller@f1001000 {
 		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
-- 
1.9.1

