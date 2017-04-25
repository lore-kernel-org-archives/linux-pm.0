From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 1/2] power: supply: sbs-battery: Don't ignore the first external power change
Date: Tue, 25 Apr 2017 17:09:04 +0200
Message-ID: <20170425150905.4185-1-contact@paulk.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:51599 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1949263AbdDYPPv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2017 11:15:51 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>

A mechanism to ignore the first external power change notification was
put in place years ago to ignore the power_supply_register notification.

However, this doesn't apply to the current situation anymore, as the
first notification is always the result of a legitimate power change.

This removes this deprecated mechanism, which puts back the driver's
state machine to a sane state (an ignored first notification previously
caused a charging/discharging status inversion).

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/power/supply/sbs-battery.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 8bb2eb38eb1c..3e7125c8e4d1 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -171,7 +171,6 @@ struct sbs_info {
 	u32				i2c_retry_count;
 	u32				poll_retry_count;
 	struct delayed_work		work;
-	int				ignore_changes;
 };
 
 static char model_name[I2C_SMBUS_BLOCK_MAX + 1];
@@ -694,11 +693,6 @@ static void sbs_external_power_changed(struct power_supply *psy)
 {
 	struct sbs_info *chip = power_supply_get_drvdata(psy);
 
-	if (chip->ignore_changes > 0) {
-		chip->ignore_changes--;
-		return;
-	}
-
 	/* cancel outstanding work */
 	cancel_delayed_work_sync(&chip->work);
 
@@ -775,10 +769,6 @@ static int sbs_probe(struct i2c_client *client,
 	chip->enable_detection = false;
 	psy_cfg.of_node = client->dev.of_node;
 	psy_cfg.drv_data = chip;
-	/* ignore first notification of external change, it is generated
-	 * from the power_supply_register call back
-	 */
-	chip->ignore_changes = 1;
 	chip->last_state = POWER_SUPPLY_STATUS_UNKNOWN;
 
 	/* use pdata if available, fall back to DT properties,
-- 
2.12.2
