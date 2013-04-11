From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [V2 patch 10/19] ARM: s3c64xx: cpuidle: use init/exit common routine
Date: Thu, 11 Apr 2013 22:42:40 +0200
Message-ID: <1365712969-7541-11-git-send-email-daniel.lezcano@linaro.org>
References: <1365712969-7541-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:50470 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765104Ab3DKUnV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Apr 2013 16:43:21 -0400
Received: by mail-we0-f182.google.com with SMTP id k14so1596798wer.13
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2013 13:43:20 -0700 (PDT)
In-Reply-To: <1365712969-7541-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

Remove the duplicated code and use the cpuidle common code for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-s3c64xx/cpuidle.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-s3c64xx/cpuidle.c
index 852ff16..3c8ab07 100644
--- a/arch/arm/mach-s3c64xx/cpuidle.c
+++ b/arch/arm/mach-s3c64xx/cpuidle.c
@@ -40,8 +40,6 @@ static int s3c64xx_enter_idle(struct cpuidle_device *dev,
 	return index;
 }
 
-static DEFINE_PER_CPU(struct cpuidle_device, s3c64xx_cpuidle_device);
-
 static struct cpuidle_driver s3c64xx_cpuidle_driver = {
 	.name	= "s3c64xx_cpuidle",
 	.owner  = THIS_MODULE,
@@ -60,16 +58,6 @@ static struct cpuidle_driver s3c64xx_cpuidle_driver = {
 
 static int __init s3c64xx_init_cpuidle(void)
 {
-	int ret;
-
-	cpuidle_register_driver(&s3c64xx_cpuidle_driver);
-
-	ret = cpuidle_register_device(&s3c64xx_cpuidle_device);
-	if (ret) {
-		pr_err("Failed to register cpuidle device: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
+	return cpuidle_register(&s3c64xx_cpuidle_driver, NULL);
 }
 device_initcall(s3c64xx_init_cpuidle);
-- 
1.7.9.5

