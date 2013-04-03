From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 8/9] ARM: omap3: cpuidle: enable time keeping
Date: Wed,  3 Apr 2013 14:15:21 +0200
Message-ID: <1364991322-20585-8-git-send-email-daniel.lezcano@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:57384 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760764Ab3DCMPs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Apr 2013 08:15:48 -0400
Received: by mail-wi0-f176.google.com with SMTP id hm14so3551829wib.9
        for <linux-pm@vger.kernel.org>; Wed, 03 Apr 2013 05:15:47 -0700 (PDT)
In-Reply-To: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com, swarren@wwwdotorg.org, linux-tegra@vger.kernel.org, horms+renesas@verge.net.au, santosh.shilimkar@ti.com, arnd@arndb.de, lenb@kernel.org, nsekhar@ti.com, josephl@nvidia.com, deepthi@linux.vnet.ibm.com

The TIME_VALID flag is specified for the different states but
the time residency computation is not done, no tk flag, no time
computation in the idle function.

Set the en_core_tk_irqen flag to activate it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 80392fc..4f67a5b 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -274,8 +274,9 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 static DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
 
 static struct cpuidle_driver omap3_idle_driver = {
-	.name =		"omap3_idle",
-	.owner =	THIS_MODULE,
+	.name             = "omap3_idle",
+	.owner            = THIS_MODULE,
+	.en_core_tk_irqen = 1,
 	.states = {
 		{
 			.enter		  = omap3_enter_idle_bm,
-- 
1.7.9.5

