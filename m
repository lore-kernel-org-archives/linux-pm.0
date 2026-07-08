Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A7939A05C;
	Wed,  8 Jul 2026 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505740; cv=none; b=Ry3gEeVKKeHPz+4KmkfsrOJp+jJGGWBjGYtKYo+uxmbSb8Tl8+OjY/uxxvJbo4aR/mbpdgvmA7KTT7Wo4wAkSyb0dm9dzMELF6jGrCxzLYmrdlcli+vpP9DMU0ensHV6zVsQWfx0hkPsliic+62npLw5RreCMXRo5Bf/CyrmnOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505740; c=relaxed/simple;
	bh=+syV3gIX9hmYe5vMQtHOWI/l2prZArUyTv5TbH4+y8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpWPUMRYn7rg5R5/JSAnDE/RT3buFciWj5/xcn9B4U4z7JlKcVMAaSOTyrIt5VUYfDMrOMZe/j+AERMEpzXP+pOfwGOK2TBiBTWc4x3jRjoHku6laX0vhrl6VNIV7aPPpcn9GKpgdTvnAcZ//Y8EvTX8P+QIMmM286ZtNE5PZaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A56D1F000E9;
	Wed,  8 Jul 2026 10:15:35 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 5/6] arm64: dts: renesas: r8a78000: Add CPG node
Date: Wed,  8 Jul 2026 12:15:10 +0200
Message-ID: <b3beaabd77ec73d3dea43cc603f2cae31290e273.1783505142.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783505142.git.geert+renesas@glider.be>
References: <cover.1783505142.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a device node for the Clock Pulse Generator (CPG) on the R-Car X5H
(R8A78000) SoC.

Convert all (H)SCIF serial ports from dummy to CPG clocks, removing the
need for any dummy clocks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Split in separate CPG and MDLC patches.
---
 arch/arm64/boot/dts/renesas/r8a78000.dtsi | 59 +++++++++++++----------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000.dtsi b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
index fb71974ef390509d..1fe078c7822c01a5 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
@@ -5,6 +5,7 @@
  * Copyright (C) 2025 Renesas Electronics Corp.
  */
 
+#include <dt-bindings/clock/renesas,r8a78000-cpg.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
@@ -668,23 +669,6 @@ L3_CA720_7: cache-controller-37 {
 		};
 	};
 
-	/*
-	 * In the early phase, there is no clock control support,
-	 * so assume that the clocks are enabled by default.
-	 * Therefore, dummy clocks are used.
-	 */
-	dummy_clk_sgasyncd16: dummy-clk-sgasyncd16 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <66666000>;
-	};
-
-	dummy_clk_sgasyncd4: dummy-clk-sgasyncd4 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <266660000>;
-	};
-
 	extal_clk: extal-clk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -882,7 +866,9 @@ scif0: serial@c0700000 {
 				     "renesas,rcar-gen5-scif", "renesas,scif";
 			reg = <0 0xc0700000 0 0x40>;
 			interrupts = <GIC_ESPI 10 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&dummy_clk_sgasyncd16>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
+			clocks = <&cpg R8A78000_CPG_SGASYNCD16_PERW_BUS>,
+				 <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
+				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
 		};
@@ -892,7 +878,9 @@ scif1: serial@c0704000 {
 				     "renesas,rcar-gen5-scif", "renesas,scif";
 			reg = <0 0xc0704000 0 0x40>;
 			interrupts = <GIC_ESPI 11 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&dummy_clk_sgasyncd16>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
+			clocks = <&cpg R8A78000_CPG_SGASYNCD16_PERW_BUS>,
+				 <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
+				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
 		};
@@ -902,7 +890,9 @@ scif3: serial@c0708000 {
 				     "renesas,rcar-gen5-scif", "renesas,scif";
 			reg = <0 0xc0708000 0 0x40>;
 			interrupts = <GIC_ESPI 12 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&dummy_clk_sgasyncd16>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
+			clocks = <&cpg R8A78000_CPG_SGASYNCD16_PERW_BUS>,
+				 <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
+				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
 		};
@@ -912,7 +902,9 @@ scif4: serial@c070c000 {
 				     "renesas,rcar-gen5-scif", "renesas,scif";
 			reg = <0 0xc070c000 0 0x40>;
 			interrupts = <GIC_ESPI 13 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&dummy_clk_sgasyncd16>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
+			clocks = <&cpg R8A78000_CPG_SGASYNCD16_PERW_BUS>,
+				 <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
+				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
 		};
@@ -922,7 +914,9 @@ hscif0: serial@c0710000 {
 				     "renesas,rcar-gen5-hscif", "renesas,hscif";
 			reg = <0 0xc0710000 0 0x60>;
 			interrupts = <GIC_ESPI 14 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&dummy_clk_sgasyncd4>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
+			clocks = <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
+				 <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
+				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
 		};
@@ -932,7 +926,9 @@ hscif1: serial@c0714000 {
 				     "renesas,rcar-gen5-hscif", "renesas,hscif";
 			reg = <0 0xc0714000 0 0x60>;
 			interrupts = <GIC_ESPI 15 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&dummy_clk_sgasyncd4>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
+			clocks = <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
+				 <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
+				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
 		};
@@ -942,7 +938,9 @@ hscif2: serial@c0718000 {
 				     "renesas,rcar-gen5-hscif", "renesas,hscif";
 			reg = <0 0xc0718000 0 0x60>;
 			interrupts = <GIC_ESPI 16 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&dummy_clk_sgasyncd4>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
+			clocks = <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
+				 <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
+				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
 		};
@@ -952,7 +950,9 @@ hscif3: serial@c071c000 {
 				     "renesas,rcar-gen5-hscif", "renesas,hscif";
 			reg = <0 0xc071c000 0 0x60>;
 			interrupts = <GIC_ESPI 17 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&dummy_clk_sgasyncd4>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
+			clocks = <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
+				 <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
+				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
 		};
@@ -965,6 +965,15 @@ stcm_transport: sram@c1060000 {
 			ranges = <0 0x0 0xc1060000 0x1c00>;
 			/* actual transport nodes must be set per board file */
 		};
+
+		cpg: clock-controller@c1320000 {
+			compatible = "renesas,r8a78000-cpg";
+			reg = <0 0xc1320000 0 0x10000>;
+			clocks = <&extal_clk>, <&extalr_clk>;
+			clock-names = "extal", "extalr";
+			#clock-cells = <1>;
+			bootph-all;
+		};
 	};
 
 	timer {
-- 
2.43.0

