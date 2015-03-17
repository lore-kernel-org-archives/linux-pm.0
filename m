From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] ARM: shmobile: cpuidle: Remove the pointless default driver
Date: Tue, 17 Mar 2015 15:34:52 +0100
Message-ID: <1426602892-17208-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:35878 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718AbbCQOe4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2015 10:34:56 -0400
Received: by wetk59 with SMTP id k59so9205589wet.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2015 07:34:54 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: horms@verge.net.au, magnus.damm@gmail.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

The default idle driver uses one state with the WFI instruction.
The default idle routine invokes WFI when no cpuidle driver is present.

The default cpuidle driver is pointless and does not give more than the
default idle routine and moreover it pulls all the mathematics tied with
the cpuidle governor for nothing, hence consuming more energy.

Remove the default driver, the related code and register the driver directly.

[compiled only - no board - no test]

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-shmobile/common.h    |  3 ---
 arch/arm/mach-shmobile/cpuidle.c   | 37 -------------------------------------
 arch/arm/mach-shmobile/pm-sh7372.c |  2 +-
 3 files changed, 1 insertion(+), 41 deletions(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 309025e..29b3088 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -23,8 +23,6 @@ struct clk;
 extern int shmobile_clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
 extern struct platform_suspend_ops shmobile_suspend_ops;
-struct cpuidle_driver;
-extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
 
 #ifdef CONFIG_SUSPEND
 int shmobile_suspend_init(void);
@@ -51,7 +49,6 @@ extern void __iomem *shmobile_scu_base;
 static inline void __init shmobile_init_late(void)
 {
 	shmobile_suspend_init();
-	shmobile_cpuidle_init();
 	shmobile_cpufreq_init();
 }
 
diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
index 0afeb5c..e69de29 100644
--- a/arch/arm/mach-shmobile/cpuidle.c
+++ b/arch/arm/mach-shmobile/cpuidle.c
@@ -1,37 +0,0 @@
-/*
- * CPUIdle support code for SH-Mobile ARM
- *
- *  Copyright (C) 2011 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/pm.h>
-#include <linux/cpuidle.h>
-#include <linux/suspend.h>
-#include <linux/module.h>
-#include <linux/err.h>
-#include <asm/cpuidle.h>
-#include <asm/io.h>
-
-static struct cpuidle_driver shmobile_cpuidle_default_driver = {
-	.name			= "shmobile_cpuidle",
-	.owner			= THIS_MODULE,
-	.states[0]		= ARM_CPUIDLE_WFI_STATE,
-	.safe_state_index	= 0, /* C1 */
-	.state_count		= 1,
-};
-
-static struct cpuidle_driver *cpuidle_drv = &shmobile_cpuidle_default_driver;
-
-void __init shmobile_cpuidle_set_driver(struct cpuidle_driver *drv)
-{
-	cpuidle_drv = drv;
-}
-
-int __init shmobile_cpuidle_init(void)
-{
-	return cpuidle_register(cpuidle_drv, NULL);
-}
diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
index c0293ae..9f19052 100644
--- a/arch/arm/mach-shmobile/pm-sh7372.c
+++ b/arch/arm/mach-shmobile/pm-sh7372.c
@@ -462,7 +462,7 @@ static struct cpuidle_driver sh7372_cpuidle_driver = {
 
 static void __init sh7372_cpuidle_init(void)
 {
-	shmobile_cpuidle_set_driver(&sh7372_cpuidle_driver);
+	return cpuidle_register(cpuidle_drv, NULL);
 }
 #else
 static void __init sh7372_cpuidle_init(void) {}
-- 
1.9.1

