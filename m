From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 05/14] clk: shmobile: rz: Add CPG Clock Domain support
Date: Thu, 28 May 2015 20:53:30 +0200
Message-ID: <1432839219-475-6-git-send-email-geert+renesas@glider.be>
References: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:58710 "EHLO
	albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835AbbE1Sxy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2015 14:53:54 -0400
In-Reply-To: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add Clock Domain support to the RZ Clock Pulse Generator (CPG) driver
using the generic PM Domain.  This allows to power-manage the module
clocks of SoC devices that are part of the CPG Clock Domain using
Runtime PM, or for system suspend/resume.

SoC devices that are part of the CPG Clock Domain and can be
power-managed through an MSTP clock should be tagged in DT with a proper
"power-domains" property.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 .../bindings/clock/renesas,rz-cpg-clocks.txt       | 29 ++++++++++++++++++++--
 arch/arm/mach-shmobile/Kconfig                     |  1 +
 drivers/clk/shmobile/clk-rz.c                      |  3 +++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt
index 98a257492522cd45..c5666288e409ebd2 100644
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
+  - CPG Clock Domain member device node:
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
index e14fa5e87475a0d1..34eac88a98896b63 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -51,6 +51,7 @@ config ARCH_EMEV2
 
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

