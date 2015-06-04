From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 08/15] ARM: shmobile: r8a7791 dtsi: Add L1 cache information to CPU nodes
Date: Thu,  4 Jun 2015 20:53:34 +0200
Message-ID: <1433444021-22167-9-git-send-email-geert+renesas@glider.be>
References: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Describe the L1 instruction and data caches in the CPU nodes:
  - The L1 caches for the Cortex-A15 CPU cores are organized as 16 KiB x
    2 ways.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 8013223448b5b464..4e4011a2978bcfce 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -52,6 +52,16 @@
 			clocks = <&cpg_clocks R8A7791_CLK_Z>;
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
 			operating-points = <1500000 1000000>,
 					   <1312500 1000000>,
@@ -66,6 +76,16 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1500000000>;
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
 	};
 
-- 
1.9.1

