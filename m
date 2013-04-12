From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [V3 patch 01/19] ARM: shmobile: cpuidle: remove shmobile_enter_wfi function
Date: Fri, 12 Apr 2013 14:35:47 +0200
Message-ID: <1365770165-27096-2-git-send-email-daniel.lezcano@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:56359 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456Ab3DLMgO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2013 08:36:14 -0400
Received: by mail-wg0-f43.google.com with SMTP id f12so2669159wgh.22
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2013 05:36:12 -0700 (PDT)
In-Reply-To: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

Remove the shmobile_enter_wfi function which is the same as the
common WFI enter function from the arm cpuidle driver defined
with the ARM_CPUIDLE_WFI_STATE macro.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-shmobile/pm-sh7372.c |    1 -
 1 file changed, 1 deletion(-)

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

