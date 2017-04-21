From: Rahul Bedarkar <rahulbedarkar89@gmail.com>
Subject: [PATCH] power: supply: generic-adc-battery: use SIMPLE_DEV_PM_OPS helper macro
Date: Fri, 21 Apr 2017 16:37:57 +0530
Message-ID: <1492772877-11983-1-git-send-email-rahulbedarkar89@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:32960 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1037895AbdDULIk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Apr 2017 07:08:40 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rahul Bedarkar <rahulbedarkar89@gmail.com>

Replace ifdefs with SIMPLE_DEV_PM_OPS helper macro.

Signed-off-by: Rahul Bedarkar <rahulbedarkar89@gmail.com>
---
 drivers/power/supply/generic-adc-battery.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index edb36bf..37e5233 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -383,8 +383,7 @@ static int gab_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int gab_suspend(struct device *dev)
+static int __maybe_unused gab_suspend(struct device *dev)
 {
 	struct gab *adc_bat = dev_get_drvdata(dev);
 
@@ -393,7 +392,7 @@ static int gab_suspend(struct device *dev)
 	return 0;
 }
 
-static int gab_resume(struct device *dev)
+static int __maybe_unused gab_resume(struct device *dev)
 {
 	struct gab *adc_bat = dev_get_drvdata(dev);
 	struct gab_platform_data *pdata = adc_bat->pdata;
@@ -407,20 +406,12 @@ static int gab_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops gab_pm_ops = {
-	.suspend        = gab_suspend,
-	.resume         = gab_resume,
-};
-
-#define GAB_PM_OPS       (&gab_pm_ops)
-#else
-#define GAB_PM_OPS       (NULL)
-#endif
+static SIMPLE_DEV_PM_OPS(gab_pm_ops, gab_suspend, gab_resume);
 
 static struct platform_driver gab_driver = {
 	.driver		= {
 		.name	= "generic-adc-battery",
-		.pm	= GAB_PM_OPS
+		.pm	= &gab_pm_ops,
 	},
 	.probe		= gab_probe,
 	.remove		= gab_remove,
-- 
2.7.4
