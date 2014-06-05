From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 3/4] power: max17042_battery: Fix deadlock caused by deferred
 initialization
Date: Thu, 05 Jun 2014 12:46:16 +0900
Message-ID: <1401939977-20328-4-git-send-email-jonghwa3.lee@samsung.com>
References: <1401939977-20328-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49756 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbaFEDq3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Jun 2014 23:46:29 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6O00JAGFTCWU30@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Thu, 05 Jun 2014 12:46:24 +0900 (KST)
In-reply-to: <1401939977-20328-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, Tomasz Figa <t.figa@samsung.com>

From: Tomasz Figa <t.figa@samsung.com>

There is no need to defer chip initialization from probe. In addition,
current implementation caused a deadlock, which made boot hang from time
to time.

This patch removes deffered initialization and adds chip initialization
to probe, before the power supply is registered.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/power/max17042_battery.c |   32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index cee3912..0178a32 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -76,8 +76,6 @@ struct max17042_chip {
 	enum max170xx_chip_type chip_type;
 	enum max17042_operation_mode mode;
 	struct max17042_platform_data *pdata;
-	struct work_struct work;
-	int    init_complete;
 };
 
 static enum power_supply_property max17042_battery_props[] = {
@@ -108,9 +106,6 @@ static int max17042_get_property(struct power_supply *psy,
 	int ret;
 	u32 data;
 
-	if (!chip->init_complete)
-		return -EAGAIN;
-
 	switch (psp) {
 	case POWER_SUPPLY_PROP_PRESENT:
 		ret = regmap_read(map, MAX17042_STATUS, &data);
@@ -609,7 +604,7 @@ static irqreturn_t max17042_thread_handler(int id, void *dev)
 	return IRQ_HANDLED;
 }
 
-static void max17042_init_worker(struct work_struct *work)
+static int max17042_init_worker(struct max17042_chip *chip)
 {
 	struct max17042_chip *chip = container_of(work,
 				struct max17042_chip, work);
@@ -619,10 +614,10 @@ static void max17042_init_worker(struct work_struct *work)
 	if (chip->pdata->enable_por_init && chip->pdata->config_data) {
 		ret = max17042_init_chip(chip);
 		if (ret)
-			return;
+			return ret;
 	}
 
-	chip->init_complete = 1;
+	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -738,12 +733,6 @@ static int max17042_probe(struct i2c_client *client,
 					chip->pdata->init_data[i].addr,
 					chip->pdata->init_data[i].data);
 
-	ret = power_supply_register(&client->dev, &chip->battery);
-	if (ret) {
-		dev_err(&client->dev, "failed: power supply register\n");
-		return ret;
-	}
-
 	if (client->irq) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 					NULL, max17042_thread_handler,
@@ -763,10 +752,17 @@ static int max17042_probe(struct i2c_client *client,
 
 	regmap_read(chip->regmap, MAX17042_STATUS, &val);
 	if (val & STATUS_POR_BIT) {
-		INIT_WORK(&chip->work, max17042_init_worker);
-		schedule_work(&chip->work);
-	} else {
-		chip->init_complete = 1;
+		ret = max17042_init_worker(chip);
+		if (ret) {
+			dev_err(&client->dev, "failed: init chip\n");
+			return ret;
+		}
+	}
+
+	ret = power_supply_register(&client->dev, &chip->battery);
+	if (ret) {
+		dev_err(&client->dev, "failed: power supply register\n");
+		return ret;
 	}
 
 	return 0;
-- 
1.7.9.5

