From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v3 1/7] power: supply: tps65217: Use 'poll_task' on unloading the module
Date: Sun, 18 Dec 2016 11:54:26 +0900
Message-ID: <20161218025432.20780-2-woogyom.kim@gmail.com>
References: <20161218025432.20780-1-woogyom.kim@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35233 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759425AbcLRCyz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Dec 2016 21:54:55 -0500
In-Reply-To: <20161218025432.20780-1-woogyom.kim@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>

Use the task_struct variable for running polling thread. If polling task
is activated, then use it to stop running thread.
This is a preceding step of supporting two interrupts of TPS65217 charger,
so checking single IRQ number is not appropriate when the module is removed.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/power/supply/tps65217_charger.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 9fd019f9b88c..4fe71abe1bd3 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -200,6 +200,7 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	struct tps65217 *tps = dev_get_drvdata(pdev->dev.parent);
 	struct tps65217_charger *charger;
 	struct power_supply_config cfg = {};
+	struct task_struct *poll_task;
 	int irq;
 	int ret;
 
@@ -250,14 +251,16 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 		/* Check current state */
 		tps65217_charger_irq(irq, charger);
 	} else {
-		charger->poll_task = kthread_run(tps65217_charger_poll_task,
-						charger, "ktps65217charger");
-		if (IS_ERR(charger->poll_task)) {
-			ret = PTR_ERR(charger->poll_task);
+		poll_task = kthread_run(tps65217_charger_poll_task,
+					charger, "ktps65217charger");
+		if (IS_ERR(poll_task)) {
+			ret = PTR_ERR(poll_task);
 			dev_err(charger->dev,
 				"Unable to run kthread err %d\n", ret);
 			return ret;
 		}
+
+		charger->poll_task = poll_task;
 	}
 
 	return 0;
@@ -267,7 +270,7 @@ static int tps65217_charger_remove(struct platform_device *pdev)
 {
 	struct tps65217_charger *charger = platform_get_drvdata(pdev);
 
-	if (charger->irq == -ENXIO)
+	if (charger->poll_task)
 		kthread_stop(charger->poll_task);
 
 	return 0;
-- 
2.11.0

