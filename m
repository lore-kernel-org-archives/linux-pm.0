From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 02/16] clk: shmobile: r8a7778: Add CPG/MSTP Clock Domain support
Date: Tue,  4 Aug 2015 14:28:03 +0200
Message-ID: <1438691297-29235-3-git-send-email-geert+renesas@glider.be>
References: <1438691297-29235-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1438691297-29235-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add Clock Domain support to the R-Car M1A Clock Pulse Generator (CPG)
driver using the generic PM Domain.  This allows to power-manage the
module clocks of SoC devices that are part of the CPG/MSTP Clock Domain
using Runtime PM, or for system suspend/resume.

SoC devices that are part of the CPG/MSTP Clock Domain and can be
power-managed through an MSTP clock should be tagged in DT with a proper
"power-domains" property.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
v4:
  - Add Reviewed-by,

v3:
  - Add Acked-by,
  - Use "CPG/MSTP Clock Domain" instead of "CPG Clock Domain",

v2:
  - New.
---
 .../bindings/clock/renesas,r8a7778-cpg-clocks.txt  | 29 +++++++++++++++++++---
 arch/arm/mach-shmobile/Kconfig                     |  1 +
 drivers/clk/shmobile/clk-r8a7778.c                 |  2 ++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
index 2f3747fdcf1c5305..e4cdaf1cb3333012 100644
--- a/Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
@@ -1,7 +1,9 @@
 * Renesas R8A7778 Clock Pulse Generator (CPG)
 
 The CPG generates core clocks for the R8A7778. It includes two PLLs and
-several fixed ratio dividers
+several fixed ratio dividers.
+The CPG also provides a Clock Domain for SoC devices, in combination with the
+CPG Module Stop (MSTP) Clocks.
 
 Required Properties:
 
@@ -10,10 +12,18 @@ Required Properties:
   - #clock-cells: Must be 1
   - clock-output-names: The names of the clocks. Supported clocks are
     "plla", "pllb", "b", "out", "p", "s", and "s1".
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
 		compatible = "renesas,r8a7778-cpg-clocks";
@@ -22,4 +32,17 @@ Example
 		clocks = <&extal_clk>;
 		clock-output-names = "plla", "pllb", "b",
 				     "out", "p", "s", "s1";
+		#power-domain-cells = <0>;
+	};
+
+
+  - CPG/MSTP Clock Domain member device node:
+
+	sdhi0: sd@ffe4c000 {
+		compatible = "renesas,sdhi-r8a7778";
+		reg = <0xffe4c000 0x100>;
+		interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7778_CLK_SDHI0>;
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
 	};
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index aa38a438af8990ef..5b1f9eca7c871aee 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -4,6 +4,7 @@ config ARCH_SHMOBILE
 
 config PM_RCAR
 	bool
+	select PM_GENERIC_DOMAINS if PM
 
 config PM_RMOBILE
 	bool
diff --git a/drivers/clk/shmobile/clk-r8a7778.c b/drivers/clk/shmobile/clk-r8a7778.c
index e97e28fcfc13d102..87c1d2f2fb57a46c 100644
--- a/drivers/clk/shmobile/clk-r8a7778.c
+++ b/drivers/clk/shmobile/clk-r8a7778.c
@@ -124,6 +124,8 @@ static void __init r8a7778_cpg_clocks_init(struct device_node *np)
 	}
 
 	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
+
+	cpg_mstp_add_clk_domain(np);
 }
 
 CLK_OF_DECLARE(r8a7778_cpg_clks, "renesas,r8a7778-cpg-clocks",
-- 
1.9.1

