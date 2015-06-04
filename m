From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 05/15] ARM: shmobile: r8a7793 dtsi: Add L2 cache-controller node
Date: Thu,  4 Jun 2015 20:53:31 +0200
Message-ID: <1433444021-22167-6-git-send-email-geert+renesas@glider.be>
References: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:42415 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbbFDSxo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 14:53:44 -0400
In-Reply-To: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the L2 cache:
  - The L2 cache for the Cortex-A15 CPU cores is 1 MiB large (organized
    as 64 KiB x 16 ways), and requires the following settings:
      - Tag RAM latency: 3 cycles,
      - Data RAM latency: 4 cycles,
      - Data RAM setup: 0 cycles.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
What are the DT bindings for a Cortex-A15 L2 cache controller?
---
 arch/arm/boot/dts/r8a7793.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index f337634888de7800..cf153b9c2367a211 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -41,6 +41,19 @@
 		};
 	};
 
+	L2_CA15: cache-controller@0 {
+		compatible = "cache";
+
+		arm,data-latency = <4 4 0>;
+		arm,tag-latency = <3 3 3>;
+		cache-unified;
+		cache-level = <2>;
+		cache-size = <0x100000>;
+		cache-sets = <2048>;
+		cache-block-size = <32>;
+		cache-line-size = <32>;
+	};
+
 	gic: interrupt-controller@f1001000 {
 		compatible = "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
-- 
1.9.1

