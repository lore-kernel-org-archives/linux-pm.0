From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/6] ARM: shmobile: r8a7791 dtsi: Add L2 cache-controller node
Date: Mon,  7 Dec 2015 19:24:16 +0100
Message-ID: <1449512659-16688-4-git-send-email-geert+renesas@glider.be>
References: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from [195.130.132.52] ([195.130.132.52]:55250 "EHLO
	xavier.telenet-ops.be" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755752AbbLGSZA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2015 13:25:00 -0500
In-Reply-To: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the L2 cache, and link the CPU nodes to it.

The L2 cache for the Cortex-A15 CPU cores is 1 MiB large (organized as
64 KiB x 16 ways), and requires the following settings:
  - Tag RAM latency: 3 cycles,
  - Data RAM latency: 4 cycles,
  - Data RAM setup: 0 cycles.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
What are the DT bindings for a Cortex-A15 L2 cache controller?

v2:
  - Drop (incorrect) optional cache-{size,sets,{block,line}-size}
    properties, as this information is auto-detected,
  - Integrate linking CPUs to L2 cache into this patch,
  - Extracted from series "[PATCH/RFC 00/15] ARM: shmobile: R-Car: Add
    SYSC PM Domain DT Support".
---
 arch/arm/boot/dts/r8a7791.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 1487d92e1b21a175..24e036b51647bb6f 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -51,6 +51,7 @@
 			voltage-tolerance = <1>; /* 1% */
 			clocks = <&cpg_clocks R8A7791_CLK_Z>;
 			clock-latency = <300000>; /* 300 us */
+			next-level-cache = <&L2_CA15>;
 
 			/* kHz - uV - OPPs unknown yet */
 			operating-points = <1500000 1000000>,
@@ -66,9 +67,18 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1500000000>;
+			next-level-cache = <&L2_CA15>;
 		};
 	};
 
+	L2_CA15: cache-controller@0 {
+		compatible = "cache";
+		arm,data-latency = <4 4 0>;
+		arm,tag-latency = <3 3 3>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
 	gic: interrupt-controller@f1001000 {
 		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
-- 
1.9.1

