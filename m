From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] power: ds2782_battery: Simplify the PM hooks
Date: Thu,  9 Oct 2014 19:50:26 -0300
Message-ID: <1412895026-1717-1-git-send-email-festevam@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:61991 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbaJIWuk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 18:50:40 -0400
Received: by mail-yh0-f42.google.com with SMTP id t59so1225028yho.29
        for <linux-pm@vger.kernel.org>; Thu, 09 Oct 2014 15:50:40 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dbaryshkov@gmail.com
Cc: anton@enomsg.org, linux-pm@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

The SIMPLE_DEV_PM_OPS() macro already takes care of the CONFIG_PM_SLEEP=n case,
so we can simplify the code a little bit.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/power/ds2782_battery.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/power/ds2782_battery.c b/drivers/power/ds2782_battery.c
index 041f9b6..3969488 100644
--- a/drivers/power/ds2782_battery.c
+++ b/drivers/power/ds2782_battery.c
@@ -351,13 +351,9 @@ static int ds278x_resume(struct device *dev)
 	schedule_delayed_work(&info->bat_work, DS278x_DELAY);
 	return 0;
 }
+#endif /* CONFIG_PM_SLEEP */
 
 static SIMPLE_DEV_PM_OPS(ds278x_battery_pm_ops, ds278x_suspend, ds278x_resume);
-#define DS278X_BATTERY_PM_OPS (&ds278x_battery_pm_ops)
-
-#else
-#define DS278X_BATTERY_PM_OPS NULL
-#endif /* CONFIG_PM_SLEEP */
 
 enum ds278x_num_id {
 	DS2782 = 0,
@@ -460,7 +456,7 @@ MODULE_DEVICE_TABLE(i2c, ds278x_id);
 static struct i2c_driver ds278x_battery_driver = {
 	.driver 	= {
 		.name	= "ds2782-battery",
-		.pm	= DS278X_BATTERY_PM_OPS,
+		.pm	= &ds278x_battery_pm_ops,
 	},
 	.probe		= ds278x_battery_probe,
 	.remove		= ds278x_battery_remove,
-- 
1.9.1

