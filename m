From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [V2 patch 18/19] ARM: davinci: cpuidle: use init/exit common routine
Date: Thu, 11 Apr 2013 22:42:48 +0200
Message-ID: <1365712969-7541-19-git-send-email-daniel.lezcano@linaro.org>
References: <1365712969-7541-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:52799 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422633Ab3DKUnm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Apr 2013 16:43:42 -0400
Received: by mail-we0-f173.google.com with SMTP id t57so1534691wey.32
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2013 13:43:41 -0700 (PDT)
In-Reply-To: <1365712969-7541-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

Remove the duplicated code and use the cpuidle common code for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-davinci/cpuidle.c |   20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index c2887c5..36aef3a 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -25,7 +25,6 @@
 
 #define DAVINCI_CPUIDLE_MAX_STATES	2
 
-static DEFINE_PER_CPU(struct cpuidle_device, davinci_cpuidle_device);
 static void __iomem *ddr2_reg_base;
 static bool ddr2_pdown;
 
@@ -76,12 +75,8 @@ static struct cpuidle_driver davinci_idle_driver = {
 
 static int __init davinci_cpuidle_probe(struct platform_device *pdev)
 {
-	int ret;
-	struct cpuidle_device *device;
 	struct davinci_cpuidle_config *pdata = pdev->dev.platform_data;
 
-	device = &per_cpu(davinci_cpuidle_device, smp_processor_id());
-
 	if (!pdata) {
 		dev_err(&pdev->dev, "cannot get platform data\n");
 		return -ENOENT;
@@ -91,20 +86,7 @@ static int __init davinci_cpuidle_probe(struct platform_device *pdev)
 
 	ddr2_pdown = pdata->ddr2_pdown;
 
-	ret = cpuidle_register_driver(&davinci_idle_driver);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register driver\n");
-		return ret;
-	}
-
-	ret = cpuidle_register_device(device);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register device\n");
-		cpuidle_unregister_driver(&davinci_idle_driver);
-		return ret;
-	}
-
-	return 0;
+	return cpuidle_register(&davinci_idle_driver, NULL);
 }
 
 static struct platform_driver davinci_cpuidle_driver = {
-- 
1.7.9.5

