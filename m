From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/4] ARM: shmobile: r8a7790: Add thermal clock in device tree
Date: Tue,  7 Jan 2014 19:57:14 +0100
Message-ID: <1389121036-3555-3-git-send-email-geert@linux-m68k.org>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from juliette.telenet-ops.be ([195.130.137.74]:57818 "EHLO
	juliette.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbaAGS53 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2014 13:57:29 -0500
In-Reply-To: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Add the missing thermal MSTP clock to the thermal device node.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 arch/arm/boot/dts/r8a7790.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index f48487c2a970..b53834e6a55f 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -168,6 +168,7 @@
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks R8A7790_CLK_THERMAL>;
 	};
 
 	timer {
-- 
1.7.9.5

