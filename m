From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 04/14] clk: shmobile: rcar-gen2: Add CPG Clock Domain support
Date: Thu, 28 May 2015 20:53:29 +0200
Message-ID: <1432839219-475-5-git-send-email-geert+renesas@glider.be>
References: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:60771 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806AbbE1Sxx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2015 14:53:53 -0400
In-Reply-To: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add Clock Domain support to the R-Car Gen2 Clock Pulse Generator (CPG)
driver using the generic PM Domain.  This allows to power-manage the
module clocks of SoC devices that are part of the CPG Clock Domain using
Runtime PM, or for system suspend/resume.

SoC devices that are part of the CPG Clock Domain and can be
power-managed through an MSTP clock should be tagged in DT with a proper
"power-domains" property.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add Acked-by and Reviewed-by,
  - Move core CPG Clock Domain code from the R-Car Gen2 driver to the
    CPG MSTP Clocks driver, as it's generic, and can be used on other
    Renesas SoCs that have a CPG/MSTP block,
  - Scan for an MSTP clock instead of using the first clock tied to the
    device (con_id NULL),
  - Extract R-Car Gen2 specifics from "[PATCH/RFC 1/5] clk: shmobile:
    rcar-gen2: Add CPG Clock Domain support" into this patch.
---
 .../clock/renesas,rcar-gen2-cpg-clocks.txt         | 26 ++++++++++++++++++++--
 drivers/clk/shmobile/clk-rcar-gen2.c               |  2 ++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
index b02944fba9de4f86..aa2b94511f4d9e05 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
@@ -2,6 +2,8 @@
 
 The CPG generates core clocks for the R-Car Gen2 SoCs. It includes three PLLs
 and several fixed ratio dividers.
+The CPG also provides a Clock Domain for SoC devices, in combination with the
+CPG Module Stop (MSTP) Clocks.
 
 Required Properties:
 
@@ -20,10 +22,18 @@ Required Properties:
   - clock-output-names: The names of the clocks. Supported clocks are "main",
     "pll0", "pll1", "pll3", "lb", "qspi", "sdh", "sd0", "sd1", "z", "rcan", and
     "adsp"
+  - #power-domain-cells: Must be 0
 
+SoC devices that are part of the CPG Clock Domain and can be power-managed
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
 
 	cpg_clocks: cpg_clocks@e6150000 {
 		compatible = "renesas,r8a7790-cpg-clocks",
@@ -34,4 +44,16 @@ Example
 		clock-output-names = "main", "pll0, "pll1", "pll3",
 				     "lb", "qspi", "sdh", "sd0", "sd1", "z",
 				     "rcan", "adsp";
+		#power-domain-cells = <0>;
+	};
+
+
+  - CPG Clock Domain member device node:
+
+	thermal@e61f0000 {
+		compatible = "renesas,thermal-r8a7790", "renesas,rcar-thermal";
+		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
+		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks R8A7790_CLK_THERMAL>;
+		power-domains = <&cpg_clocks>;
 	};
diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
index c7fde69d455e38c4..9612e3145b7ea370 100644
--- a/drivers/clk/shmobile/clk-rcar-gen2.c
+++ b/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -417,6 +417,8 @@ static void __init rcar_gen2_cpg_clocks_init(struct device_node *np)
 	}
 
 	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
+
+	cpg_mstp_add_clk_domain(np);
 }
 CLK_OF_DECLARE(rcar_gen2_cpg_clks, "renesas,rcar-gen2-cpg-clocks",
 	       rcar_gen2_cpg_clocks_init);
-- 
1.9.1

