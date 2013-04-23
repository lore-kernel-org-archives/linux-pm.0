From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [V4 patch 14/15] ARM: davinci: cpuidle: use init/exit common routine
Date: Tue, 23 Apr 2013 10:54:44 +0200
Message-ID: <1366707285-12179-15-git-send-email-daniel.lezcano@linaro.org>
References: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:46485 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756536Ab3DWIz0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2013 04:55:26 -0400
Received: by mail-wi0-f180.google.com with SMTP id h11so429216wiv.7
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2013 01:55:25 -0700 (PDT)
In-Reply-To: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: andrew@lunn.ch, khilman@deeprootsystems.com, nsekhar@ti.com, josephl@nvidia.com, kgene.kim@samsung.com, patches@linaro.org, magnus.damm@gmail.com, tony@atomide.com, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, swarren@wwwdotorg.org, rob.herring@calxeda.com, horms@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, linux-pm@vger.kernel.org, lethal@linux-sh.org, kernel@pengutronix.de

Remove the duplicated code and use the cpuidle common code for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Sekhar Nori <nsekhar@ti.com>
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

