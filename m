From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 03/14] clk: shmobile: r8a7779: Add CPG Clock Domain support
Date: Thu, 28 May 2015 20:53:28 +0200
Message-ID: <1432839219-475-4-git-send-email-geert+renesas@glider.be>
References: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432839219-475-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add Clock Domain support to the R-Car H1 Clock Pulse Generator (CPG)
driver using the generic PM Domain.  This allows to power-manage the
module clocks of SoC devices that are part of the CPG Clock Domain using
Runtime PM, or for system suspend/resume.

SoC devices that are part of the CPG Clock Domain and can be
power-managed through an MSTP clock should be tagged in DT with a proper
"power-domains" property.

Also update the reg property in the DT binding doc example to match the
actual dtsi, which uses #address-cells and #size-cells == 1, not 2.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v2:
  - New.
---
 .../bindings/clock/renesas,r8a7779-cpg-clocks.txt  | 30 +++++++++++++++++++---
 drivers/clk/shmobile/clk-r8a7779.c                 |  2 ++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
index ed3c8cb12f4eb699..ded99abb4b6435ee 100644
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
+  - CPG Clock Domain member device node:
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
