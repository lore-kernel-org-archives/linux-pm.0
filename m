From: <grygorii.strashko@linaro.org>
Subject: [PATCH] hwmon: tmp102: add hibernation callbacks
Date: Mon,  2 Feb 2015 19:14:31 +0200
Message-ID: <1422897271-24068-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:57463 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbbBBROr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Feb 2015 12:14:47 -0500
Received: by mail-la0-f48.google.com with SMTP id pv20so42995185lab.7
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2015 09:14:46 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org
Cc: sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Grygorii Strashko <Grygorii.Strashko@linaro.org>

From: Grygorii Strashko <Grygorii.Strashko@linaro.org>

Setting a dev_pm_ops suspend/resume pair but not a set of
hibernation functions means those pm functions will not be
called upon hibernation.
Fix this by using SIMPLE_DEV_PM_OPS, which appropriately
assigns the suspend and hibernation handlers.

Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
---
 drivers/hwmon/tmp102.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index 6748b45..4f790f5 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -281,17 +281,10 @@ static int tmp102_resume(struct device *dev)
 	config &= ~TMP102_CONF_SD;
 	return i2c_smbus_write_word_swapped(client, TMP102_CONF_REG, config);
 }
-
-static const struct dev_pm_ops tmp102_dev_pm_ops = {
-	.suspend	= tmp102_suspend,
-	.resume		= tmp102_resume,
-};
-
-#define TMP102_DEV_PM_OPS (&tmp102_dev_pm_ops)
-#else
-#define	TMP102_DEV_PM_OPS NULL
 #endif /* CONFIG_PM */
 
+SIMPLE_DEV_PM_OPS(tmp102_dev_pm_ops, tmp102_suspend, tmp102_resume);
+
 static const struct i2c_device_id tmp102_id[] = {
 	{ "tmp102", 0 },
 	{ }
@@ -300,7 +293,7 @@ MODULE_DEVICE_TABLE(i2c, tmp102_id);
 
 static struct i2c_driver tmp102_driver = {
 	.driver.name	= DRIVER_NAME,
-	.driver.pm	= TMP102_DEV_PM_OPS,
+	.driver.pm	= &tmp102_dev_pm_ops,
 	.probe		= tmp102_probe,
 	.remove		= tmp102_remove,
 	.id_table	= tmp102_id,
-- 
1.9.1

