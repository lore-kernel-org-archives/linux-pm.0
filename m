From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 2/5] power: supply: bq27xxx: Register power supply with devm
Date: Sun, 30 Apr 2017 20:27:24 +0200
Message-ID: <20170430182727.24412-2-contact@paulk.fr>
References: <20170430182727.24412-1-contact@paulk.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:58646 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969127AbdD3S2q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Apr 2017 14:28:46 -0400
In-Reply-To: <20170430182727.24412-1-contact@paulk.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>, Paul Kocialkowski <contact@paulk.fr>

This uses the managed devices resources version of the
power_supply_register_no_ws function to register the power supply.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/power/supply/bq27xxx_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 6ef95442a918..be476e0bc85d 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1371,7 +1371,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	psy_desc->get_property = bq27xxx_battery_get_property;
 	psy_desc->external_power_changed = bq27xxx_external_power_changed;
 
-	di->bat = power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
+	di->bat = devm_power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(di->bat)) {
 		dev_err(di->dev, "failed to register battery\n");
 		return PTR_ERR(di->bat);
-- 
2.12.2
