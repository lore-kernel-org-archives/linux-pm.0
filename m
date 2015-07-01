From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 03/16] clk: shmobile: r8a7779: Add CPG/MSTP Clock Domain support
Date: Wed,  1 Jul 2015 17:57:57 +0200
Message-ID: <1435766290-3005-4-git-send-email-geert+renesas@glider.be>
References: <1435766290-3005-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:53236 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647AbbGAP61 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2015 11:58:27 -0400
In-Reply-To: <1435766290-3005-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add Clock Domain support to the R-Car H1 Clock Pulse Generator (CPG)
driver using the generic PM Domain.  This allows to power-manage the
module clocks of SoC devices that are part of the CPG/MSTP Clock Domain
using Runtime PM, or for system suspend/resume.

SoC devices that are part of the CPG/MSTP Clock Domain and can be
power-managed through an MSTP clock should be tagged in DT with a proper
"power-domains" property.

Also update the reg property in the DT binding doc example to match the
actual dtsi, which uses #address-cells and #size-cells == 1, not 2.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---
v3:
  - Add Acked-by,
  - Use "CPG/MSTP Clock Domain" instead of "CPG Clock Domain",

v2:
  - New.
---
 .../bindings/clock/renesas,r8a7779-cpg-clocks.txt  | 30 +++++++++++++++++++---
 drivers/clk/shmobile/clk-r8a7779.c                 |  2 ++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
index ed3c8cb12f4eb699..8c81547c29f568e8 100644
--- a/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
@@ -1,7 +1,9 @@
 * Renesas R8A7779 Clock Pulse Generator (CPG)
 
 The CPG generates core clocks for the R8A7779. It includes one PLL and
-several fixed ratio dividers
+several fixed ratio dividers.
+The CPG also provides a Clock Domain for SoC devices, in combination with the
+CPG Module Stop (MSTP) Clocks.
 
 Required Properties:
 
@@ -12,16 +14,36 @@ Required Properties:
   - #clock-cells: Must be 1
   - clock-output-names: The names of the clocks. Supported clocks are "plla",
     "z", "zs", "s", "s1", "p", "b", "out".
+  - #power-domain-cells: Must be 0
 
+SoC devices that are part of the CPG/MSTP Clock Domain and can be power-managed
+through an MSTP clock should refer to the CPG device node in their
+"power-domains" property, as documented by the generic PM domain bindings in
+Documentation/devicetree/bindings/power/power_domain.txt.
 
-Example
--------
+
+Examples
+--------
+
+  - CPG device node:
 
 	cpg_clocks: cpg_clocks@ffc80000 {
 		compatible = "renesas,r8a7779-cpg-clocks";
-		reg = <0 0xffc80000 0 0x30>;
+		reg = <0xffc80000 0x30>;
 		clocks = <&extal_clk>;
 		#clock-cells = <1>;
 		clock-output-names = "plla", "z", "zs", "s", "s1", "p",
 		                     "b", "out";
+		#power-domain-cells = <0>;
+	};
+
+
+  - CPG/MSTP Clock Domain member device node:
+
+	sata: sata@fc600000 {
+		compatible = "renesas,sata-r8a7779", "renesas,rcar-sata";
+		reg = <0xfc600000 0x2000>;
+		interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7779_CLK_SATA>;
+		power-domains = <&cpg_clocks>;
 	};
diff --git a/drivers/clk/shmobile/clk-r8a7779.c b/drivers/clk/shmobile/clk-r8a7779.c
index 652ecacb6daf7922..e42a63a2ad251de2 100644
--- a/drivers/clk/shmobile/clk-r8a7779.c
+++ b/drivers/clk/shmobile/clk-r8a7779.c
@@ -168,6 +168,8 @@ static void __init r8a7779_cpg_clocks_init(struct device_node *np)
 	}
 
 	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
+
+	cpg_mstp_add_clk_domain(np);
 }
 CLK_OF_DECLARE(r8a7779_cpg_clks, "renesas,r8a7779-cpg-clocks",
 	       r8a7779_cpg_clocks_init);
-- 
1.9.1

