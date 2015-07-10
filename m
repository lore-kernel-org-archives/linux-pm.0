From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] power_supply: Drop owner assignment from i2c_driver
Date: Fri, 10 Jul 2015 14:39:22 +0900
Message-ID: <1436506762-29166-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60390 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbbGJFjX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2015 01:39:23 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

i2c_driver does not need to set an owner because i2c_register_driver()
will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/power/bq24190_charger.c | 1 -
 drivers/power/bq24735-charger.c | 1 -
 drivers/power/pm2301_charger.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/power/bq24190_charger.c b/drivers/power/bq24190_charger.c
index 052db78c3736..703ebecaf38b 100644
--- a/drivers/power/bq24190_charger.c
+++ b/drivers/power/bq24190_charger.c
@@ -1534,7 +1534,6 @@ static struct i2c_driver bq24190_driver = {
 	.id_table	= bq24190_i2c_ids,
 	.driver = {
 		.name		= "bq24190-charger",
-		.owner		= THIS_MODULE,
 		.pm		= &bq24190_pm_ops,
 		.of_match_table	= of_match_ptr(bq24190_of_match),
 	},
diff --git a/drivers/power/bq24735-charger.c b/drivers/power/bq24735-charger.c
index 961a18930027..b0174379713c 100644
--- a/drivers/power/bq24735-charger.c
+++ b/drivers/power/bq24735-charger.c
@@ -409,7 +409,6 @@ MODULE_DEVICE_TABLE(of, bq24735_match_ids);
 static struct i2c_driver bq24735_charger_driver = {
 	.driver = {
 		.name = "bq24735-charger",
-		.owner = THIS_MODULE,
 		.of_match_table = bq24735_match_ids,
 	},
 	.probe = bq24735_charger_probe,
diff --git a/drivers/power/pm2301_charger.c b/drivers/power/pm2301_charger.c
index cc0893ffbf7e..3a45cc0c4dce 100644
--- a/drivers/power/pm2301_charger.c
+++ b/drivers/power/pm2301_charger.c
@@ -1244,7 +1244,6 @@ static struct i2c_driver pm2xxx_charger_driver = {
 	.remove = pm2xxx_wall_charger_remove,
 	.driver = {
 		.name = "pm2xxx-wall_charger",
-		.owner = THIS_MODULE,
 		.pm = PM2XXX_PM_OPS,
 	},
 	.id_table = pm2xxx_id,
-- 
1.9.1

