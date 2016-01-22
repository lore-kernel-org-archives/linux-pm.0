From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: [RFC PATCH 2/5] cpufreq: mt8173: Remove platform device registration code
Date: Fri, 22 Jan 2016 16:40:26 +0800
Message-ID: <1453452029-20843-3-git-send-email-pi-cheng.chen@linaro.org>
References: <1453452029-20843-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34647 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbcAVIkz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2016 03:40:55 -0500
Received: by mail-pf0-f179.google.com with SMTP id q63so39722886pfb.1
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2016 00:40:54 -0800 (PST)
In-Reply-To: <1453452029-20843-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: Kevin Hilman <khilman@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

For MT8173 platform requirement, to make SVS (Smart Voltage Scaling)
work correctly, the initialization of SVS engine should be later then
thermal controller and prior to cpufreq driver. Remove the platform
device registration code of mt8173-cpufreq and it will be later added
in SVS driver code after SVS initialization done to ensure the platform
specific initialization flow.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
---
 drivers/cpufreq/mt8173-cpufreq.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index 1efba34..1ede917 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -577,7 +577,6 @@ static struct platform_driver mt8173_cpufreq_platdrv = {
 
 static int mt8173_cpufreq_driver_init(void)
 {
-	struct platform_device *pdev;
 	int err;
 
 	if (!of_machine_is_compatible("mediatek,mt8173"))
@@ -587,18 +586,6 @@ static int mt8173_cpufreq_driver_init(void)
 	if (err)
 		return err;
 
-	/*
-	 * Since there's no place to hold device registration code and no
-	 * device tree based way to match cpufreq driver yet, both the driver
-	 * and the device registration codes are put here to handle defer
-	 * probing.
-	 */
-	pdev = platform_device_register_simple("mt8173-cpufreq", -1, NULL, 0);
-	if (IS_ERR(pdev)) {
-		pr_err("failed to register mtk-cpufreq platform device\n");
-		return PTR_ERR(pdev);
-	}
-
 	return 0;
 }
 device_initcall(mt8173_cpufreq_driver_init);
-- 
1.9.1

