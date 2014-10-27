From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 23/47] power/reset: gpio-poweroff: Register with kernel power-off handler
Date: Mon, 27 Oct 2014 08:55:30 -0700
Message-ID: <1414425354-10359-24-git-send-email-linux@roeck-us.net>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50127 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946AbaJ0P5A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Oct 2014 11:57:00 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XimfD-000cRO-O1
	for linux-pm@vger.kernel.org; Mon, 27 Oct 2014 15:56:59 +0000
In-Reply-To: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>

Register with kernel power-off handler instead of setting pm_power_off
directly. Register with low priority to reflect that the original code
only sets pm_power_off if it was not already set.

Other changes:

Drop note that there can not be an additional instance of this driver.
The original reason no longer applies, it should be obvious that there
can only be one instance of the driver if static variables are used to
reflect its state, and support for multiple instances can now be added
easily if needed by avoiding static variables.

Do not create an error message if another power-off handler has already
been registered. This is perfectly normal and acceptable.

Drop remove function since it is no longer needed.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Acked-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2;
- Use define to specify poweroff handler priority
- Use devm_register_power_off_handler
- Drop remove function as it is no longer needed

 drivers/power/reset/gpio-poweroff.c | 40 ++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c
index ce849bc..814c37b 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -14,18 +14,18 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/notifier.h>
+#include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of_platform.h>
 #include <linux/module.h>
 
-/*
- * Hold configuration here, cannot be more than one instance of the driver
- * since pm_power_off itself is global.
- */
 static struct gpio_desc *reset_gpio;
 
-static void gpio_poweroff_do_poweroff(void)
+static int gpio_poweroff_do_poweroff(struct notifier_block *this,
+				     unsigned long unused1, void *unused2)
+
 {
 	BUG_ON(!reset_gpio);
 
@@ -43,19 +43,19 @@ static void gpio_poweroff_do_poweroff(void)
 	mdelay(3000);
 
 	WARN_ON(1);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block gpio_power_off_nb = {
+	.notifier_call = gpio_poweroff_do_poweroff,
+	.priority = POWER_OFF_PRIORITY_LOW,
+};
+
 static int gpio_poweroff_probe(struct platform_device *pdev)
 {
 	bool input = false;
-
-	/* If a pm_power_off function has already been added, leave it alone */
-	if (pm_power_off != NULL) {
-		dev_err(&pdev->dev,
-			"%s: pm_power_off function already registered",
-		       __func__);
-		return -EBUSY;
-	}
+	int err;
 
 	reset_gpio = devm_gpiod_get(&pdev->dev, NULL);
 	if (IS_ERR(reset_gpio))
@@ -77,16 +77,11 @@ static int gpio_poweroff_probe(struct platform_device *pdev)
 		}
 	}
 
-	pm_power_off = &gpio_poweroff_do_poweroff;
-	return 0;
-}
-
-static int gpio_poweroff_remove(struct platform_device *pdev)
-{
-	if (pm_power_off == &gpio_poweroff_do_poweroff)
-		pm_power_off = NULL;
+	err = devm_register_power_off_handler(&pdev->dev, &gpio_power_off_nb);
+	if (err)
+		dev_err(&pdev->dev, "Failed to register power-off handler\n");
 
-	return 0;
+	return err;
 }
 
 static const struct of_device_id of_gpio_poweroff_match[] = {
@@ -96,7 +91,6 @@ static const struct of_device_id of_gpio_poweroff_match[] = {
 
 static struct platform_driver gpio_poweroff_driver = {
 	.probe = gpio_poweroff_probe,
-	.remove = gpio_poweroff_remove,
 	.driver = {
 		.name = "poweroff-gpio",
 		.owner = THIS_MODULE,
-- 
1.9.1

