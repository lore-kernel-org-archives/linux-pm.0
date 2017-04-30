From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 5/5] power: supply: bq27xxx: Correct supply status with current draw
Date: Sun, 30 Apr 2017 20:27:27 +0200
Message-ID: <20170430182727.24412-5-contact@paulk.fr>
References: <20170430182727.24412-1-contact@paulk.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:53854 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162962AbdD3S3G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Apr 2017 14:29:06 -0400
In-Reply-To: <20170430182727.24412-1-contact@paulk.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>, Paul Kocialkowski <contact@paulk.fr>

The status reported directly by the battery controller is not always
reliable and should be corrected based on the current draw information.

This implements such a correction with a dedicated function, called
when retrieving the supply status.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/power/supply/bq27xxx_battery.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index cade00df6162..f7694e775e68 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1171,8 +1171,22 @@ static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
 				  union power_supply_propval *val)
 {
 	int status;
+	int curr;
+	int flags;
+
+	curr = bq27xxx_read(di, BQ27XXX_REG_AI, false);
+	if (curr < 0) {
+		dev_err(di->dev, "error reading current\n");
+		return curr;
+	}
 
 	if (di->chip == BQ27000 || di->chip == BQ27010) {
+		flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, true);
+		if (flags & BQ27000_FLAG_CHGS) {
+			dev_dbg(di->dev, "negative current!\n");
+			curr = -curr;
+		}
+
 		if (di->cache.flags & BQ27000_FLAG_FC)
 			status = POWER_SUPPLY_STATUS_FULL;
 		else if (di->cache.flags & BQ27000_FLAG_CHGS)
@@ -1182,6 +1196,8 @@ static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
 		else
 			status = POWER_SUPPLY_STATUS_DISCHARGING;
 	} else {
+		curr = (int)((s16)curr) * 1000;
+
 		if (di->cache.flags & BQ27XXX_FLAG_FC)
 			status = POWER_SUPPLY_STATUS_FULL;
 		else if (di->cache.flags & BQ27XXX_FLAG_DSC)
@@ -1190,6 +1206,18 @@ static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
 			status = POWER_SUPPLY_STATUS_CHARGING;
 	}
 
+
+	if (curr == 0 && status != POWER_SUPPLY_STATUS_NOT_CHARGING)
+		status = POWER_SUPPLY_STATUS_FULL;
+
+	if (status == POWER_SUPPLY_STATUS_FULL) {
+		/* Drawing or providing current when full */
+		if (curr > 0)
+			status = POWER_SUPPLY_STATUS_CHARGING;
+		else if (curr < 0)
+			status = POWER_SUPPLY_STATUS_DISCHARGING;
+	}
+
 	if (di->status_retry == 0 && di->status_change_reference != status) {
 		di->status_change_reference = status;
 		power_supply_changed(di->bat);
-- 
2.12.2
