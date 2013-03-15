From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC patch 05/11] cpuidle / davinci : use common ARM driver
Date: Fri, 15 Mar 2013 15:27:04 +0100
Message-ID: <1363357630-22214-6-git-send-email-daniel.lezcano@linaro.org>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43007 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769Ab3COO11 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Mar 2013 10:27:27 -0400
Received: by mail-wi0-f172.google.com with SMTP id ez12so565988wid.17
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2013 07:27:26 -0700 (PDT)
In-Reply-To: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, rjw@sisk.pl, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-davinci/cpuidle.c |   20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index 5ac9e93..9968aeb 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -25,7 +25,6 @@
 
 #define DAVINCI_CPUIDLE_MAX_STATES	2
 
-static DEFINE_PER_CPU(struct cpuidle_device, davinci_cpuidle_device);
 static void __iomem *ddr2_reg_base;
 static bool ddr2_pdown;
 
@@ -81,12 +80,8 @@ static struct cpuidle_driver davinci_idle_driver = {
 
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
@@ -96,20 +91,7 @@ static int __init davinci_cpuidle_probe(struct platform_device *pdev)
 
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
+	return arm_idle_init(&davinci_idle_driver);
 }
 
 static struct platform_driver davinci_cpuidle_driver = {
-- 
1.7.9.5

