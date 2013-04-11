From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [V2 patch 01/19] ARM: shmobile: cpuidle: remove shmobile_enter_wfi function
Date: Thu, 11 Apr 2013 22:42:31 +0200
Message-ID: <1365712969-7541-2-git-send-email-daniel.lezcano@linaro.org>
References: <1365712969-7541-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:57181 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161005Ab3DKUm5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Apr 2013 16:42:57 -0400
Received: by mail-we0-f178.google.com with SMTP id z53so1556533wey.37
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2013 13:42:56 -0700 (PDT)
In-Reply-To: <1365712969-7541-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

Remove the shmobile_enter_wfi function which is the same as the
common WFI enter function from the arm cpuidle driver defined
with the ARM_CPUIDLE_WFI_STATE macro.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-shmobile/include/mach/common.h |    3 ---
 arch/arm/mach-shmobile/pm-sh7372.c           |    1 -
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index e48606d..362f9b2 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -13,9 +13,6 @@ extern int shmobile_clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
 extern struct platform_suspend_ops shmobile_suspend_ops;
 struct cpuidle_driver;
-struct cpuidle_device;
-extern int shmobile_enter_wfi(struct cpuidle_device *dev,
-			      struct cpuidle_driver *drv, int index);
 extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
 
 extern void sh7372_init_irq(void);
diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
index f6b14ca..fbef7b9 100644
--- a/arch/arm/mach-shmobile/pm-sh7372.c
+++ b/arch/arm/mach-shmobile/pm-sh7372.c
@@ -414,7 +414,6 @@ static struct cpuidle_driver sh7372_cpuidle_driver = {
 	.state_count		= 5,
 	.safe_state_index	= 0, /* C1 */
 	.states[0] = ARM_CPUIDLE_WFI_STATE,
-	.states[0].enter = shmobile_enter_wfi,
 	.states[1] = {
 		.name = "C2",
 		.desc = "Core Standby Mode",
-- 
1.7.9.5

