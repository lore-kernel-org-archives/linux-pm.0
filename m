From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] power: supply: bq25890: Use gpiod_get()
Date: Mon, 20 Feb 2017 19:12:23 +0200
Message-ID: <20170220171223.40799-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:23631 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751538AbdBTRPd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Feb 2017 12:15:33 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Since index is always 0, replace gpiod_get_index() by gpiod_get().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/power/supply/bq25890_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index f993a55cde20..8e2c41ded171 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -723,7 +723,7 @@ static int bq25890_irq_probe(struct bq25890_device *bq)
 {
 	struct gpio_desc *irq;
 
-	irq = devm_gpiod_get_index(bq->dev, BQ25890_IRQ_PIN, 0, GPIOD_IN);
+	irq = devm_gpiod_get(bq->dev, BQ25890_IRQ_PIN, GPIOD_IN);
 	if (IS_ERR(irq)) {
 		dev_err(bq->dev, "Could not probe irq pin.\n");
 		return PTR_ERR(irq);
-- 
2.11.0
