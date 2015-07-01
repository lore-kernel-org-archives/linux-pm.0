From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v3 05/16] clk: shmobile: rz: Add CPG/MSTP Clock Domain support
Date: Wed,  1 Jul 2015 17:57:59 +0200
Message-ID: <1435766290-3005-6-git-send-email-geert+renesas@glider.be>
References: <1435766290-3005-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435766290-3005-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add Clock Domain support to the RZ Clock Pulse Generator (CPG) driver
using the generic PM Domain.  This allows to power-manage the module
clocks of SoC devices that are part of the CPG/MSTP Clock Domain using
Runtime PM, or for system suspend/resume.

SoC devices that are part of the CPG/MSTP Clock Domain and can be
power-managed through an MSTP clock should be tagged in DT with a proper
"power-domains" property.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Acked-by: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
v3:
  - Add Acked-by,
  - Use "CPG/MSTP Clock Domain" instead of "CPG Clock Domain",

v2:
  - New.
---
 .../bindings/clock/renesas,rz-cpg-clocks.txt       | 29 ++++++++++++++++++++--
 arch/arm/mach-shmobile/Kconfig                     |  1 +
 drivers/clk/shmobile/clk-rz.c                      |  3 +++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt
index b0f7ddb8cdb13750..bb51a33a1fbfbc97 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt
@@ -2,6 +2,8 @@
 
 The CPG generates core clocks for the RZ SoCs. It includes the PLL, variable
 CPU and GPU clocks, and several fixed ratio dividers.
+The CPG also provides a Clock Domain for SoC devices, in combination with the
+CPG Module Stop (MSTP) Clocks.
 
 Required Properties:
 
@@ -14,10 +16,18 @@ Required Properties:
   - #clock-cells: Must be 1
   - clock-output-names: The names of the clocks. Supported clocks are "pll",
     "i", and "g"
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
 
 	cpg_clocks: cpg_clocks@fcfe0000 {
 		#clock-cells = <1>;
@@ -26,4 +36,19 @@ Example
 		reg = <0xfcfe0000 0x18>;
 		clocks = <&extal_clk>, <&usb_x1_clk>;
 		clock-output-names = "pll", "i", "g";
+		#power-domain-cells = <0>;
+	};
+
+
+  - CPG/MSTP Clock Domain member device node:
+
+	mtu2: timer@fcff0000 {
+		compatible = "renesas,mtu2-r7s72100", "renesas,mtu2";
+		reg = <0xfcff0000 0x400>;
+		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tgi0a";
+		clocks = <&mstp3_clks R7S72100_CLK_MTU2>;
+		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
 	};
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index cb525fea87367321..26a036c3ab522128 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -52,6 +52,7 @@ config ARCH_EMEV2
 
 config ARCH_R7S72100
 	bool "RZ/A1H (R7S72100)"
+	select PM_GENERIC_DOMAINS if PM
 	select SYS_SUPPORTS_SH_MTU2
 
 config ARCH_R8A73A4
diff --git a/drivers/clk/shmobile/clk-rz.c b/drivers/clk/shmobile/clk-rz.c
index 7e68e86309625c9e..9766e3cb595fd257 100644
--- a/drivers/clk/shmobile/clk-rz.c
+++ b/drivers/clk/shmobile/clk-rz.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/clk/shmobile.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
@@ -99,5 +100,7 @@ static void __init rz_cpg_clocks_init(struct device_node *np)
 	}
 
 	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
+
+	cpg_mstp_add_clk_domain(np);
 }
 CLK_OF_DECLARE(rz_cpg_clks, "renesas,rz-cpg-clocks", rz_cpg_clocks_init);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
