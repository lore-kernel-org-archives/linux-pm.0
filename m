From: Arthur Demchenkov <spinal.by@gmail.com>
Subject: [PATCH] bq27x00: use cached flags
Date: Mon, 18 Feb 2019 09:59:20 +0300
Message-ID: <20190218065920.16205-1-spinal.by@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Arthur Demchenkov <spinal.by@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The flags were just read by bq27xxx_battery_update(),
no need to read them again.

Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
---
 drivers/power/supply/bq27xxx_battery.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 6dbbe95844a3..29b3a4056865 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1555,27 +1555,14 @@ static bool bq27xxx_battery_dead(struct bq27xxx_device_info *di, u16 flags)
 		return flags & (BQ27XXX_FLAG_SOC1 | BQ27XXX_FLAG_SOCF);
 }
 
-/*
- * Read flag register.
- * Return < 0 if something fails.
- */
 static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 {
-	int flags;
-	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
-
-	flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
-	if (flags < 0) {
-		dev_err(di->dev, "error reading flag register:%d\n", flags);
-		return flags;
-	}
-
 	/* Unlikely but important to return first */
-	if (unlikely(bq27xxx_battery_overtemp(di, flags)))
+	if (unlikely(bq27xxx_battery_overtemp(di, di->cache.flags)))
 		return POWER_SUPPLY_HEALTH_OVERHEAT;
-	if (unlikely(bq27xxx_battery_undertemp(di, flags)))
+	if (unlikely(bq27xxx_battery_undertemp(di, di->cache.flags)))
 		return POWER_SUPPLY_HEALTH_COLD;
-	if (unlikely(bq27xxx_battery_dead(di, flags)))
+	if (unlikely(bq27xxx_battery_dead(di, di->cache.flags)))
 		return POWER_SUPPLY_HEALTH_DEAD;
 
 	return POWER_SUPPLY_HEALTH_GOOD;
@@ -1612,6 +1599,7 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 			cache.capacity = bq27xxx_battery_read_soc(di);
 			if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
 				cache.energy = bq27xxx_battery_read_energy(di);
+			di->cache.flags = cache.flags;
 			cache.health = bq27xxx_battery_read_health(di);
 		}
 		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
-- 
2.11.0
