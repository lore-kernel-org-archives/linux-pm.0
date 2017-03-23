From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v11.1] power: bq27xxx_battery: un/seal in set_config()
Date: Thu, 23 Mar 2017 00:36:50 -0700
Message-ID: <20170323073650.12334-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33575 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753679AbdCWHgy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 03:36:54 -0400
Received: by mail-pf0-f194.google.com with SMTP id p189so24887823pfp.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 00:36:43 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org

Minor polishing; probably no functional difference.
This will be squashed into an existing patch in v12.

---
 drivers/power/supply/bq27xxx_battery.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index ccc74e6..3decdb0 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1092,6 +1092,9 @@ static void bq27xxx_battery_set_config(struct bq27xxx_device_info *di,
 	struct bq27xxx_dm_buf bd = BQ27XXX_DM_BUF(di, BQ27XXX_DM_DESIGN_CAPACITY);
 	struct bq27xxx_dm_buf bt = BQ27XXX_DM_BUF(di, BQ27XXX_DM_TERMINATE_VOLTAGE);
 
+	if (bq27xxx_battery_set_seal_state(di, false) < 0)
+		return;
+
 	if (info->charge_full_design_uah != -EINVAL
 	 && info->energy_full_design_uwh != -EINVAL) {
 		bq27xxx_battery_read_dm_block(di, &bd);
@@ -1116,6 +1119,8 @@ static void bq27xxx_battery_set_config(struct bq27xxx_device_info *di,
 	bq27xxx_battery_write_dm_block(di, &bd);
 	bq27xxx_battery_write_dm_block(di, &bt);
 
+	bq27xxx_battery_set_seal_state(di, true);
+
 	if (di->chip != BQ27421) { /* not a cfgupdate chip, so reset */
 		bq27xxx_write(di, BQ27XXX_REG_CTRL, BQ27XXX_RESET, false);
 		BQ27XXX_MSLEEP(300); /* reset time is not documented */
@@ -1128,19 +1133,11 @@ void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
 	struct power_supply_battery_info info = {};
 	unsigned int min, max;
 
-	/* functions don't exist for writing data so abort */
-	if (!di->bus.write || !di->bus.write_bulk)
-		return;
-
-	/* no settings to be set for this chipset so abort */
 	if (!di->dm_regs)
 		return;
 
-	if (bq27xxx_battery_set_seal_state(di, false) < 0)
-		return;
-
 	if (power_supply_get_battery_info(di->bat, &info) < 0)
-		goto out;
+		return;
 
 	if (info.energy_full_design_uwh != info.charge_full_design_uah) {
 		if (info.energy_full_design_uwh == -EINVAL)
@@ -1184,9 +1181,6 @@ void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
 	  && info.charge_full_design_uah != -EINVAL)
 	  || info.voltage_min_design_uv  != -EINVAL)
 		bq27xxx_battery_set_config(di, &info);
-
-out:
-	bq27xxx_battery_set_seal_state(di, true);
 }
 
 /*
-- 
2.9.3
