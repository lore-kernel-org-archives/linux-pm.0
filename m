From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/6] ARM: shmobile: r8a73a4 dtsi: Add L2 cache-controller nodes
Date: Mon,  7 Dec 2015 19:24:14 +0100
Message-ID: <1449512659-16688-2-git-send-email-geert+renesas@glider.be>
References: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add device nodes for the L2 caches, and link the CPU node to its L2
cache node.

The L2 cache for the Cortex-A15 CPU cores is 1 MiB large (organized as
64 KiB x 16 ways), and located in PM domain A3SM. It requires the
following settings:
  - Tag RAM latency: 3 cycles,
  - Data RAM latency: 4 cycles.

The L2 cache for the Cortex-A7 CPU cores is 512 KiB large (organized as
64 KiB x 8 ways), and located in PM domain A3KM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
What are the DT bindings for Cortex-A15/A7 L2 cache controllers?

v2:
  - New.
---
 arch/arm/boot/dts/r8a73a4.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 86fab56cd6314df7..73f7ea3cb2209a00 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -29,6 +29,7 @@
 			reg = <0>;
 			clock-frequency = <1500000000>;
 			power-domains = <&pd_a2sl>;
+			next-level-cache = <&L2_CA15>;
 		};
 	};
 
@@ -45,6 +46,24 @@
 			     <1 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
+	L2_CA15: cache-controller@0 {
+		compatible = "cache";
+		clocks = <&cpg_clocks R8A73A4_CLK_Z>;
+		power-domains = <&pd_a3sm>;
+		arm,data-latency = <4 4 0>;
+		arm,tag-latency = <3 3 3>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
+	L2_CA7: cache-controller@1 {
+		compatible = "cache";
+		clocks = <&cpg_clocks R8A73A4_CLK_Z2>;
+		power-domains = <&pd_a3km>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
 	dbsc1: memory-controller@e6790000 {
 		compatible = "renesas,dbsc-r8a73a4";
 		reg = <0 0xe6790000 0 0x10000>;
-- 
1.9.1

