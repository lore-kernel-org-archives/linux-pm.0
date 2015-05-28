From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 12/14] drivers: sh: Stop using pm_runtime.c for multi-platform shmobile with genpd
Date: Thu, 28 May 2015 20:53:37 +0200
Message-ID: <1432839219-475-13-git-send-email-geert+renesas@glider.be>
References: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:52826 "EHLO
	laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821AbbE1Sxy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2015 14:53:54 -0400
In-Reply-To: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Now most multi-platform ARM shmobile platforms (SH-Mobile, R-Mobile,
R-Car, RZ) use the CPG Clock Domain to take care of PM runtime
management of the module clocks, we no longer need the legacy default PM
domain hack, which also prevented registering the real PM domain.

EMMA Mobile EV2 doesn't have MSTP clocks and doesn't use the CPG Clock
Domain. But all its device drivers manage clocks explicitly, without
relying on Runtime PM, so it doesn't need the legacy default PM hack
neither.

Hence do not compile it when running an ARM multi-platform kernel with
genpd support.

The default PM domain is still needed:
  - for legacy SuperH,
  - for legacy (non-DT) ARM/shmobile platforms
      - without genpd support (r8a7778, r8a7779),
      - with genpd support, for devices in the "C5" always-on power
	area (r8a7740, sh73a0),
  - for the CONFIG_PM=n case.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
v2:
  - Add Reviewed-by,
  - Just stop compiling pm_runtime.c instead of using a runtime check,
    as no multi-platform ARM platforms need this anymore.
---
 drivers/sh/Makefile     |  4 ++++
 drivers/sh/pm_runtime.c | 18 ------------------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/sh/Makefile b/drivers/sh/Makefile
index 114203f32843216f..786924c34436085e 100644
--- a/drivers/sh/Makefile
+++ b/drivers/sh/Makefile
@@ -8,4 +8,8 @@ endif
 obj-$(CONFIG_MAPLE)			+= maple/
 obj-$(CONFIG_SUPERHYWAY)		+= superhyway/
 
+obj-$(CONFIG_ARCH_SHMOBILE_LEGACY)	+= pm_runtime.o
+obj-$(CONFIG_SUPERH)			+= pm_runtime.o
+ifneq ($(CONFIG_PM),y)
 obj-y					+= pm_runtime.o
+endif
diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index d3d1891cda3cf9a8..c887ecdaf19b7c10 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -34,24 +34,6 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
 
 static int __init sh_pm_runtime_init(void)
 {
-	if (IS_ENABLED(CONFIG_ARCH_SHMOBILE_MULTI)) {
-		if (!of_machine_is_compatible("renesas,emev2") &&
-		    !of_machine_is_compatible("renesas,r7s72100") &&
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
-			return 0;
-	}
-
 	pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
 	return 0;
 }
-- 
1.9.1

