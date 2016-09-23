From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] power: supply: bq24910_charger: reset first_time check
Date: Thu, 22 Sep 2016 20:32:29 -0700
Message-ID: <1474601549-23719-1-git-send-email-matt@ranostay.consulting>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36496 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757713AbcIWDcd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Sep 2016 23:32:33 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Matt Ranostay <matt@ranostay.consulting>

bq24190_register_reset() function needs to reset the bdi->first_time
condition every time to avoid spurious interrupts in suspend/resume.

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
 drivers/power/supply/bq24190_charger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index f5746b9f4e83..cc1dbdb1737f 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -513,6 +513,8 @@ static int bq24190_register_reset(struct bq24190_dev_info *bdi)
 	int ret, limit = 100;
 	u8 v;
 
+	bdi->first_time = true;
+
 	/* Reset the registers */
 	ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
 			BQ24190_REG_POC_RESET_MASK,
@@ -1375,7 +1377,6 @@ static int bq24190_probe(struct i2c_client *client,
 	bdi->model = id->driver_data;
 	strncpy(bdi->model_name, id->name, I2C_NAME_SIZE);
 	mutex_init(&bdi->f_reg_lock);
-	bdi->first_time = true;
 	bdi->charger_health_valid = false;
 	bdi->battery_health_valid = false;
 	bdi->battery_status_valid = false;
-- 
2.7.4

