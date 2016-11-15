From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH 2/5] power: supply: tps65217: Remove IRQ data from driver data
Date: Tue, 15 Nov 2016 22:18:52 +0900
Message-ID: <20161115131855.4175-3-woogyom.kim@gmail.com>
References: <20161115131855.4175-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161115131855.4175-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-pm@vger.kernel.org

IRQ number is only used on requesting the interrupt, so no need to keep
it inside the driver data.
In case of polling, poll_task is valid only when polling thread is
activated.

Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/power/supply/tps65217_charger.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 04f8322..55a4f34 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -46,8 +46,6 @@ struct tps65217_charger {
 	int	prev_ac_online;
 
 	struct task_struct	*poll_task;
-
-	int	irq;
 };
 
 static enum power_supply_property tps65217_ac_props[] = {
@@ -198,6 +196,7 @@ static const struct power_supply_desc tps65217_charger_desc = {
 static int tps65217_charger_request_interrupt(struct platform_device *pdev)
 {
 	struct tps65217_charger *charger = platform_get_drvdata(pdev);
+	struct task_struct *poll_task;
 	int irq;
 	int ret;
 
@@ -205,8 +204,6 @@ static int tps65217_charger_request_interrupt(struct platform_device *pdev)
 	if (irq < 0)
 		irq = -ENXIO;
 
-	charger->irq = irq;
-
 	if (irq != -ENXIO) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						tps65217_charger_irq, 0,
@@ -222,13 +219,16 @@ static int tps65217_charger_request_interrupt(struct platform_device *pdev)
 		return 0;
 	}
 
-	charger->poll_task = kthread_run(tps65217_charger_poll_task, charger,
-					 "ktps65217charger");
-	if (IS_ERR(charger->poll_task)) {
-		ret = PTR_ERR(charger->poll_task);
+	poll_task = kthread_run(tps65217_charger_poll_task, charger,
+				"ktps65217charger");
+	if (IS_ERR(poll_task)) {
+		ret = PTR_ERR(poll_task);
 		dev_err(charger->dev, "Unable to run kthread err %d\n", ret);
+		return ret;
 	}
 
+	charger->poll_task = poll_task;
+
 	return 0;
 }
 
@@ -273,7 +273,7 @@ static int tps65217_charger_remove(struct platform_device *pdev)
 {
 	struct tps65217_charger *charger = platform_get_drvdata(pdev);
 
-	if (charger->irq == -ENXIO)
+	if (charger->poll_task)
 		kthread_stop(charger->poll_task);
 
 	return 0;
-- 
2.9.3
