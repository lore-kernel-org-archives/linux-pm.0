From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v2 2/8] power: supply: tps65217: Use 'poll_task' on unloading the module
Date: Fri,  9 Dec 2016 16:49:00 +0900
Message-ID: <20161209074906.27545-3-woogyom.kim@gmail.com>
References: <20161209074906.27545-1-woogyom.kim@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33878 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932667AbcLIHt3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2016 02:49:29 -0500
In-Reply-To: <20161209074906.27545-1-woogyom.kim@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>

TPS65217 has two interrupt numbers so checking single IRQ number is not
appropriate when the module is removed.
Use the task_struct variable for running polling thread. If polling task
is activated, then use it to stop running thread.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/power/supply/tps65217_charger.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 2000e59..55371d6 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -202,6 +202,7 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	struct tps65217 *tps = dev_get_drvdata(pdev->dev.parent);
 	struct tps65217_charger *charger;
 	struct power_supply_config cfg = {};
+	struct task_struct *poll_task;
 	int irq[NUM_CHARGER_IRQS];
 	int ret;
 	int i;
@@ -238,15 +239,16 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 
 	/* Create a polling thread if an interrupt is invalid */
 	if (irq[0] < 0 || irq[1] < 0) {
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
 
+		charger->poll_task = poll_task;
 		return 0;
 	}
 
@@ -274,7 +276,7 @@ static int tps65217_charger_remove(struct platform_device *pdev)
 {
 	struct tps65217_charger *charger = platform_get_drvdata(pdev);
 
-	if (charger->irq == -ENXIO)
+	if (charger->poll_task)
 		kthread_stop(charger->poll_task);
 
 	return 0;
-- 
2.9.3

