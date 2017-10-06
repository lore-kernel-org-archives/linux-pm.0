From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] ARM: ux500: Fix regression while init PM domains
Date: Fri,  6 Oct 2017 06:20:25 +0200
Message-ID: <1507263625-16756-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:44087 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdJFEUi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Oct 2017 00:20:38 -0400
Received: by mail-lf0-f45.google.com with SMTP id l196so19059092lfl.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Oct 2017 21:20:37 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, arm@kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>, Thara Gopinath <thara.gopinath@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

The commit afece3ab9a36 ("PM / Domains: Add time accounting to various
genpd states") causes a boot regression for ux500.

The problem occurs when the ux500 machine code calls pm_genpd_init(), which
since the above change triggers a call to ktime_get(). More precisely,
because ux500 initializes PM domains in the init_IRQ() phase of the boot,
timekeeping has not yet been initialized.

Fix the problem by moving the initialization of the PM domains to after
timekeeping has been initialized.

Fixes: afece3ab9a36 ("PM / Domains: Add time accounting to various genpd..")
Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Note, since the commit afece3ab9a36 ("PM / Domains: Add time accounting to
various genpd states") potentially could cause similar problems for other SoCs,
I have walked through the callers of pm_genpd_init(). At this point I couldn't
find any other SoC having these problems.

Kind regards
Uffe

---
 arch/arm/mach-ux500/cpu-db8500.c | 4 ++++
 arch/arm/mach-ux500/pm.c         | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 71a34e8..57058ac 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -32,6 +32,7 @@
 #include <asm/mach/arch.h>
 
 #include "db8500-regs.h"
+#include "pm_domains.h"
 
 static int __init ux500_l2x0_unlock(void)
 {
@@ -157,6 +158,9 @@ static const struct of_device_id u8500_local_bus_nodes[] = {
 
 static void __init u8500_init_machine(void)
 {
+	/* Initialize ux500 power domains */
+	ux500_pm_domains_init();
+
 	/* automatically probe child nodes of dbx5x0 devices */
 	if (of_machine_is_compatible("st-ericsson,u8540"))
 		of_platform_populate(NULL, u8500_local_bus_nodes,
diff --git a/arch/arm/mach-ux500/pm.c b/arch/arm/mach-ux500/pm.c
index a970e7f..f6c33a0 100644
--- a/arch/arm/mach-ux500/pm.c
+++ b/arch/arm/mach-ux500/pm.c
@@ -19,7 +19,6 @@
 #include <linux/of_address.h>
 
 #include "db8500-regs.h"
-#include "pm_domains.h"
 
 /* ARM WFI Standby signal register */
 #define PRCM_ARM_WFI_STANDBY    (prcmu_base + 0x130)
@@ -203,7 +202,4 @@ void __init ux500_pm_init(u32 phy_base, u32 size)
 
 	/* Set up ux500 suspend callbacks. */
 	suspend_set_ops(UX500_SUSPEND_OPS);
-
-	/* Initialize ux500 power domains */
-	ux500_pm_domains_init();
 }
-- 
2.7.4
