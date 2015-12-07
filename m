From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 4/6] ARM: shmobile: r8a7793 dtsi: Add L2 cache-controller node
Date: Mon,  7 Dec 2015 19:24:17 +0100
Message-ID: <1449512659-16688-5-git-send-email-geert+renesas@glider.be>
References: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from [195.130.137.89] ([195.130.137.89]:43894 "EHLO
	laurent.telenet-ops.be" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755695AbbLGSY5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2015 13:24:57 -0500
In-Reply-To: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the L2 cache, and link the CPU node to it.

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
  - Integrate linking CPU to L2 cache into this patch,
  - Extracted from series "[PATCH/RFC 00/15] ARM: shmobile: R-Car: Add
    SYSC PM Domain DT Support".
---
 arch/arm/boot/dts/r8a7793.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 33205ecb2a596979..59f8a4fcda1dee95 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -42,9 +42,18 @@
 					   < 937500 1000000>,
 					   < 750000 1000000>,
 					   < 375000 1000000>;
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

