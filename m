From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/2] cpuidle: mvebu: clean up multiple platform drivers
Date: Fri, 23 Oct 2015 13:54:57 +0200
Message-ID: <1445601298-31138-1-git-send-email-daniel.lezcano@linaro.org>
References: <562A1FE0.1060302@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37789 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbbJWLzH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2015 07:55:07 -0400
Received: by wicfv8 with SMTP id fv8so28482749wic.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2015 04:55:06 -0700 (PDT)
In-Reply-To: <562A1FE0.1060302@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

From: Russell King <rmk+kernel@arm.linux.org.uk>

There's no need to use multiple platform drivers, especially when we
want to do something different in the probe, but we still use a common
probe function.

We can use the platform ID system to only register one platform driver,
but have it match several devices, and give us the CPU idle driver via
the ID's driver_data.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-mvebu-v7.c | 45 +++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
index 980151f..facd7d3 100644
--- a/drivers/cpuidle/cpuidle-mvebu-v7.c
+++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
@@ -99,44 +99,39 @@ static struct cpuidle_driver armada38x_idle_driver = {
 
 static int mvebu_v7_cpuidle_probe(struct platform_device *pdev)
 {
-	mvebu_v7_cpu_suspend = pdev->dev.platform_data;
+	const struct platform_device_id *id = pdev->id_entry;
 
-	if (!strcmp(pdev->dev.driver->name, "cpuidle-armada-xp"))
-		return cpuidle_register(&armadaxp_idle_driver, NULL);
-	else if (!strcmp(pdev->dev.driver->name, "cpuidle-armada-370"))
-		return cpuidle_register(&armada370_idle_driver, NULL);
-	else if (!strcmp(pdev->dev.driver->name, "cpuidle-armada-38x"))
-		return cpuidle_register(&armada38x_idle_driver, NULL);
-	else
+	if (!id)
 		return -EINVAL;
-}
 
-static struct platform_driver armadaxp_cpuidle_plat_driver = {
-	.driver = {
-		.name = "cpuidle-armada-xp",
-	},
-	.probe = mvebu_v7_cpuidle_probe,
-};
+	mvebu_v7_cpu_suspend = pdev->dev.platform_data;
 
-module_platform_driver(armadaxp_cpuidle_plat_driver);
+	return cpuidle_register((struct cpuidle_driver *)id->driver_data, NULL);
+}
 
-static struct platform_driver armada370_cpuidle_plat_driver = {
-	.driver = {
+static const struct platform_device_id mvebu_cpuidle_ids[] = {
+	{
+		.name = "cpuidle-armada-xp",
+		.driver_data = (unsigned long)&armadaxp_idle_driver,
+	}, {
 		.name = "cpuidle-armada-370",
+		.driver_data = (unsigned long)&armada370_idle_driver,
+	}, {
+		.name = "cpuidle-armada-38x",
+		.driver_data = (unsigned long)&armada38x_idle_driver,
 	},
-	.probe = mvebu_v7_cpuidle_probe,
+	{}
 };
 
-module_platform_driver(armada370_cpuidle_plat_driver);
-
-static struct platform_driver armada38x_cpuidle_plat_driver = {
+static struct platform_driver mvebu_cpuidle_driver = {
+	.probe = mvebu_v7_cpuidle_probe,
 	.driver = {
-		.name = "cpuidle-armada-38x",
+		.name = "cpuidle-mbevu",
 	},
-	.probe = mvebu_v7_cpuidle_probe,
+	.id_table = mvebu_cpuidle_ids,
 };
 
-module_platform_driver(armada38x_cpuidle_plat_driver);
+module_platform_driver(mvebu_cpuidle_driver);
 
 MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
 MODULE_DESCRIPTION("Marvell EBU v7 cpuidle driver");
-- 
1.9.1

