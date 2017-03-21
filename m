From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v1 4/7] power: bq24190_charger: Uniform pm_runtime_get() failure handling
Date: Tue, 21 Mar 2017 15:09:18 -0700
Message-ID: <20170321220921.5834-5-liam@networkimprov.net>
References: <20170321220921.5834-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34998 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756830AbdCUWTm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2017 18:19:42 -0400
Received: by mail-pf0-f195.google.com with SMTP id n11so12570539pfg.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Mar 2017 15:19:42 -0700 (PDT)
In-Reply-To: <20170321220921.5834-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Mark Greer <mgreer@animalcreek.com>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

On pm_runtime_get() failure, always emit error message,
and call pm_runtime_put_noidle() in irq handler.

Fixes: 13d6fa8447fa power: bq24190_charger: Use PM runtime autosuspend
Cc: Mark Greer <mgreer@animalcreek.com>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq24190_charger.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index c443988..ad09e48 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1267,12 +1267,13 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
 static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 {
 	struct bq24190_dev_info *bdi = data;
-	int ret;
+	int error;
 
 	bdi->irq_event = true;
-	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0) {
-		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", ret);
+	error = pm_runtime_get_sync(bdi->dev);
+	if (error < 0) {
+		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
+		pm_runtime_put_noidle(bdi->dev);
 		return IRQ_NONE;
 	}
 	bq24190_check_status(bdi);
@@ -1399,8 +1400,10 @@ static int bq24190_probe(struct i2c_client *client,
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, 600);
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(dev, "pm_runtime_get failed: %i\n", ret);
 		goto out1;
+	}
 
 	ret = bq24190_hw_init(bdi);
 	if (ret < 0) {
-- 
2.9.3
