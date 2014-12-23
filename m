From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 1/2] power: collie_battery: support generating wakeup event
Date: Tue, 23 Dec 2014 12:51:25 +0300
Message-ID: <1419328286-29729-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:56114 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbaLWJvm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Dec 2014 04:51:42 -0500
Received: by mail-pd0-f180.google.com with SMTP id w10so7451334pde.25
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2014 01:51:41 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org

Teach collie_battery driver to communicate to the kernel that it can
generate wakeup events. Handle enabling/disabling wakeup on battery full
event in suspend/resume callbacks.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/power/collie_battery.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/power/collie_battery.c b/drivers/power/collie_battery.c
index d02ae02..086f17b 100644
--- a/drivers/power/collie_battery.c
+++ b/drivers/power/collie_battery.c
@@ -26,6 +26,7 @@
 static DEFINE_MUTEX(bat_lock); /* protects gpio pins */
 static struct work_struct bat_work;
 static struct ucb1x00 *ucb;
+static int wakeup_enabled;
 
 struct collie_bat {
 	int status;
@@ -291,11 +292,19 @@ static int collie_bat_suspend(struct ucb1x00_dev *dev)
 {
 	/* flush all pending status updates */
 	flush_work(&bat_work);
+
+	if (device_may_wakeup(&dev->ucb->dev) &&
+	    collie_bat_main.status == POWER_SUPPLY_STATUS_CHARGING)
+		wakeup_enabled = !enable_irq_wake(gpio_to_irq(COLLIE_GPIO_CO));
+
 	return 0;
 }
 
 static int collie_bat_resume(struct ucb1x00_dev *dev)
 {
+	if (wakeup_enabled)
+		disable_irq_wake(gpio_to_irq(COLLIE_GPIO_CO));
+
 	/* things may have changed while we were away */
 	schedule_work(&bat_work);
 	return 0;
@@ -334,10 +343,15 @@ static int collie_bat_probe(struct ucb1x00_dev *dev)
 				collie_bat_gpio_isr,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 				"main full", &collie_bat_main);
-	if (!ret) {
-		schedule_work(&bat_work);
-		return 0;
-	}
+	if (ret)
+		goto err_irq;
+
+	device_init_wakeup(&ucb->dev, 1);
+	schedule_work(&bat_work);
+
+	return 0;
+
+err_irq:
 	power_supply_unregister(&collie_bat_bu.psy);
 err_psy_reg_bu:
 	power_supply_unregister(&collie_bat_main.psy);
-- 
2.1.3

