From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC PATCH] ARM: ux500: cpuidle: use of_compatible instead of cpu_id
Date: Thu, 27 Jun 2013 17:30:53 +0200
Message-ID: <1372347053-27739-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34257 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302Ab3F0Pak (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2013 11:30:40 -0400
Received: by mail-wi0-f178.google.com with SMTP id k10so757407wiv.17
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2013 08:30:39 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linus.walleij@linaro.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Remove the dependency on the id.h header by replacing the cpu_is_
functions by of_machine_is_compatible.

In order to have cpuidle working on these SoC, the device tree must be
enabled.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-ux500/cpuidle.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
index a45dd09..872c6e9 100644
--- a/arch/arm/mach-ux500/cpuidle.c
+++ b/arch/arm/mach-ux500/cpuidle.c
@@ -14,6 +14,7 @@
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <linux/smp.h>
+#include <linux/of.h>
 #include <linux/mfd/dbx500-prcmu.h>
 #include <linux/platform_data/arm-ux500-pm.h>
 
@@ -21,7 +22,6 @@
 #include <asm/proc-fns.h>
 
 #include "db8500-regs.h"
-#include "id.h"
 
 static atomic_t master = ATOMIC_INIT(0);
 static DEFINE_SPINLOCK(master_lock);
@@ -115,7 +115,11 @@ static struct cpuidle_driver ux500_idle_driver = {
 
 int __init ux500_idle_init(void)
 {
-	if (!(cpu_is_u8500_family() || cpu_is_ux540_family()))
+	if (!of_machine_is_compatible("st-ericsson,u8500") &&
+	    !of_machine_is_compatible("st-ericsson,u9540") &&
+	    !of_machine_is_compatible("calaosystems,snowball-a9500") &&
+	    !of_machine_is_compatible("st-ericsson,u9500") &&
+	    !of_machine_is_compatible("st-ericsson,mop500"))
 		return -ENODEV;
 
 	/* Configure wake up reasons */
-- 
1.7.9.5

