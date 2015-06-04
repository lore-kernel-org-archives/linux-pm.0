From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 07/15] ARM: shmobile: r8a7790 dtsi: Add L1 cache information to CPU nodes
Date: Thu,  4 Jun 2015 20:53:33 +0200
Message-ID: <1433444021-22167-8-git-send-email-geert+renesas@glider.be>
References: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Describe the L1 instruction and data caches in the CPU nodes:
  - The L1 caches for the Cortex-A15 CPU cores, and the L1 instruction
    caches for the Cortex-A7 CPU cores are organized as 16 KiB x 2
    ways,
  - The L1 data caches for the Cortex-A7 CPU cores are organized as 8
    KiB x 4 ways.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 80 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 729172090f865e4d..bc98bb6cff635ae5 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -53,6 +53,16 @@
 			clocks = <&cpg_clocks R8A7790_CLK_Z>;
 			clock-latency = <300000>; /* 300 us */
 
+			i-cache-size = <0x8000>;
+			i-cache-sets = <512>;
+			i-cache-block-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <512>;
+			d-cache-block-size = <32>;
+			d-cache-line-size = <32>;
+			next-level-cache = <&L2_CA15>;
+
 			/* kHz - uV - OPPs unknown yet */
 			operating-points = <1400000 1000000>,
 					   <1225000 1000000>,
@@ -67,6 +77,16 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1300000000>;
+
+			i-cache-size = <0x8000>;
+			i-cache-sets = <512>;
+			i-cache-block-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <512>;
+			d-cache-block-size = <32>;
+			d-cache-line-size = <32>;
+			next-level-cache = <&L2_CA15>;
 		};
 
 		cpu2: cpu@2 {
@@ -74,6 +94,16 @@
 			compatible = "arm,cortex-a15";
 			reg = <2>;
 			clock-frequency = <1300000000>;
+
+			i-cache-size = <0x8000>;
+			i-cache-sets = <512>;
+			i-cache-block-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <512>;
+			d-cache-block-size = <32>;
+			d-cache-line-size = <32>;
+			next-level-cache = <&L2_CA15>;
 		};
 
 		cpu3: cpu@3 {
@@ -81,6 +111,16 @@
 			compatible = "arm,cortex-a15";
 			reg = <3>;
 			clock-frequency = <1300000000>;
+
+			i-cache-size = <0x8000>;
+			i-cache-sets = <512>;
+			i-cache-block-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <512>;
+			d-cache-block-size = <32>;
+			d-cache-line-size = <32>;
+			next-level-cache = <&L2_CA15>;
 		};
 
 		cpu4: cpu@4 {
@@ -88,6 +128,16 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
 			clock-frequency = <780000000>;
+
+			i-cache-size = <0x8000>;
+			i-cache-sets = <512>;
+			i-cache-block-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <256>;
+			d-cache-block-size = <32>;
+			d-cache-line-size = <32>;
+			next-level-cache = <&L2_CA7>;
 		};
 
 		cpu5: cpu@5 {
@@ -95,6 +145,16 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x101>;
 			clock-frequency = <780000000>;
+
+			i-cache-size = <0x8000>;
+			i-cache-sets = <512>;
+			i-cache-block-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <256>;
+			d-cache-block-size = <32>;
+			d-cache-line-size = <32>;
+			next-level-cache = <&L2_CA7>;
 		};
 
 		cpu6: cpu@6 {
@@ -102,6 +162,16 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x102>;
 			clock-frequency = <780000000>;
+
+			i-cache-size = <0x8000>;
+			i-cache-sets = <512>;
+			i-cache-block-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <256>;
+			d-cache-block-size = <32>;
+			d-cache-line-size = <32>;
+			next-level-cache = <&L2_CA7>;
 		};
 
 		cpu7: cpu@7 {
@@ -109,6 +179,16 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x103>;
 			clock-frequency = <780000000>;
+
+			i-cache-size = <0x8000>;
+			i-cache-sets = <512>;
+			i-cache-block-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <256>;
+			d-cache-block-size = <32>;
+			d-cache-line-size = <32>;
+			next-level-cache = <&L2_CA7>;
 		};
 	};
 
-- 
1.9.1

