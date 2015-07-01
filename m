From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 14/16] drivers: sh: Disable PM runtime for multi-platform ARM with genpd
Date: Wed,  1 Jul 2015 17:58:08 +0200
Message-ID: <1435766290-3005-15-git-send-email-geert+renesas@glider.be>
References: <1435766290-3005-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:53249 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657AbbGAP61 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2015 11:58:27 -0400
In-Reply-To: <1435766290-3005-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

If the default PM Domain using PM_CLK is used for PM runtime, the real
Clock Domain cannot be registered from DT later.

Hence do not enable it when running a multi-platform kernel with genpd
support on R-Car or RZ.  The CPG/MSTP Clock Domain driver will take care
of PM runtime management of the module clocks.

Now most multi-platform ARM shmobile platforms (SH-Mobile, R-Mobile,
R-Car, RZ) use DT-based PM Domains to take care of PM runtime management
of the module clocks, simplify the platform logic by replacing the
explicit SoC checks by a single check for the presence of MSTP clocks in
DT.

Backwards-compatiblity with old DTs (mainly for R-Car Gen2) is provided
by checking for the presence of a "#power-domain-cells" property in DT.

The default PM Domain is still needed for:
  - backwards-compatibility with old DTs that lack PM Domain properties,
  - the CONFIG_PM=n case,
  - legacy (non-DT) ARM/shmobile platforms without genpd support
    (r8a7778, r8a7779),
  - legacy SuperH.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
v3:
  - The runtime check must stay for the ARM multiplatform CONFIG_PM=n
    case, to prevent the code from running on non-shmobile machines,
  - Provide backwards-compatibility with old DTs,
  - Extract EMMA Mobile EV2 removal into a separate patch,
  - Replace explicit platform checks by a check for the presence of MSTP
    clocks,
  - Drop references to legacy r8a7740/sh73a0, which are gone,
  - Rephrase description,

v2:
  - Add Reviewed-by,
  - Just stop compiling pm_runtime.c instead of using a runtime check,
    as no multi-platform ARM platforms need this anymore.
---
 drivers/sh/pm_runtime.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index ad9188138ed56ffb..25abd4eb7d102113 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -35,19 +35,11 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
 static int __init sh_pm_runtime_init(void)
 {
 	if (IS_ENABLED(CONFIG_ARCH_SHMOBILE_MULTI)) {
-		if (!of_machine_is_compatible("renesas,r7s72100") &&
-#ifndef CONFIG_PM_GENERIC_DOMAINS_OF
-		    !of_machine_is_compatible("renesas,r8a73a4") &&
-		    !of_machine_is_compatible("renesas,r8a7740") &&
-		    !of_machine_is_compatible("renesas,sh73a0") &&
-#endif
-		    !of_machine_is_compatible("renesas,r8a7778") &&
-		    !of_machine_is_compatible("renesas,r8a7779") &&
-		    !of_machine_is_compatible("renesas,r8a7790") &&
-		    !of_machine_is_compatible("renesas,r8a7791") &&
-		    !of_machine_is_compatible("renesas,r8a7792") &&
-		    !of_machine_is_compatible("renesas,r8a7793") &&
-		    !of_machine_is_compatible("renesas,r8a7794"))
+		if (!of_find_compatible_node(NULL, NULL,
+					     "renesas,cpg-mstp-clocks"))
+			return 0;
+		if (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS_OF) &&
+		    of_find_node_with_property(NULL, "#power-domain-cells"))
 			return 0;
 	}
 
-- 
1.9.1

