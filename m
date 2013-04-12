From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [V3 patch 02/19] ARM: shmobile: cpuidle: remove shmobile_enter_wfi prototype
Date: Fri, 12 Apr 2013 14:35:48 +0200
Message-ID: <1365770165-27096-3-git-send-email-daniel.lezcano@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:47303 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608Ab3DLMgR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2013 08:36:17 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr17so517643wib.5
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2013 05:36:16 -0700 (PDT)
In-Reply-To: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

Commit 688036b538974de32ce55be8b0e013b003992abc removed the function
'shmobile_enter_wfi' but we forgot to remove the definition in the header file.

Note this function is just an alias to 'cpu_do_idle()' wrapped into a cpuidle
function callback prototype which already exists with the default WFI state
and the arm_simple_enter function.

Remove the function prototype.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-shmobile/include/mach/common.h |    3 ---
 1 file changed, 3 deletions(-)

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
-- 
1.7.9.5

