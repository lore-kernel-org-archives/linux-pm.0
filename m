From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 29/47] power/reset: ltc2952-poweroff: Register with kernel poweroff handler
Date: Mon, 20 Oct 2014 21:12:45 -0700
Message-ID: <1413864783-3271-30-git-send-email-linux@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33793 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754534AbaJUEOU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Oct 2014 00:14:20 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XgQpw-002eDK-D0
	for linux-pm@vger.kernel.org; Tue, 21 Oct 2014 04:14:20 +0000
In-Reply-To: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sebastian Reichel <sre@kernel.org>

Register with kernel poweroff handler instead of setting pm_power_off
directly. Register with low priority to reflect that the original code
sets pm_power_off only if it was not already set.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added patch

 drivers/power/reset/ltc2952-poweroff.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index 116a1ce..da9abd2 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -80,6 +80,8 @@ struct ltc2952_poweroff_data {
 	 * 2: kill
 	 */
 	struct gpio_desc *gpio[3];
+
+	struct notifier_block poweroff_nb;
 };
 
 static int ltc2952_poweroff_panic;
@@ -180,9 +182,13 @@ irq_ok:
 	return IRQ_HANDLED;
 }
 
-static void ltc2952_poweroff_kill(void)
+static int ltc2952_poweroff_kill(struct notifier_block *this,
+				 unsigned long unused1, void *unused2)
+
 {
 	gpiod_set_value(ltc2952_data->gpio[POWERPATH_IO_KILL], 1);
+
+	return NOTIFY_DONE;
 }
 
 static int ltc2952_poweroff_suspend(struct platform_device *pdev,
@@ -285,12 +291,7 @@ err_io:
 
 static int ltc2952_poweroff_probe(struct platform_device *pdev)
 {
-	int ret;
-
-	if (pm_power_off) {
-		dev_err(&pdev->dev, "pm_power_off already registered");
-		return -EBUSY;
-	}
+	int i, ret;
 
 	ltc2952_data = kzalloc(sizeof(*ltc2952_data), GFP_KERNEL);
 	if (!ltc2952_data)
@@ -302,12 +303,20 @@ static int ltc2952_poweroff_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	pm_power_off = &ltc2952_poweroff_kill;
+	ltc2952_data->poweroff_nb.notifier_call = ltc2952_poweroff_kill;
+	ltc2952_data->poweroff_nb.priority = POWEROFF_PRIORITY_LOW;
+	ret = register_power_off_handler(&ltc2952_data->poweroff_nb);
+	if (ret)
+		goto err_power;
 
 	dev_info(&pdev->dev, "probe successful\n");
 
 	return 0;
 
+err_power:
+	free_irq(ltc2952_data->virq, ltc2952_data);
+	for (i = 0; i < ARRAY_SIZE(ltc2952_data->gpio); i++)
+		gpiod_put(ltc2952_data->gpio[i]);
 err:
 	kfree(ltc2952_data);
 	return ret;
@@ -317,7 +326,7 @@ static int ltc2952_poweroff_remove(struct platform_device *pdev)
 {
 	unsigned int i;
 
-	pm_power_off = NULL;
+	unregister_power_off_handler(&ltc2952_data->poweroff_nb);
 
 	if (ltc2952_data) {
 		free_irq(ltc2952_data->virq, ltc2952_data);
-- 
1.9.1

