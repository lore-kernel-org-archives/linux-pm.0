From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 4/7] power: supply: bq24190_charger: Never reset the charger chip
Date: Wed, 22 Mar 2017 15:55:33 +0100
Message-ID: <20170322145536.30570-5-hdegoede@redhat.com>
References: <20170322145536.30570-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759512AbdCVOzq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 10:55:46 -0400
In-Reply-To: <20170322145536.30570-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>

Resetting the charger should never be necessary it should always have
sane values programmed. If it is running with invalid values while we
are not running (system turned off or suspended) there is a big problem
as that may lead to overcharging the battery.

The reset in suspend() is meant to put the charger back into default
mode, but this is not necessary and not a good idea. If the charger has
been programmed with a higher max charge_current / charge_voltage then
putting it back in default-mode will reset those to the safe power-on
defaults, leading to slower charging, or charging to a lower voltage
(and thus not using the full capacity) while suspended which is
undesirable. Reprogramming the max charge_current / charge_voltage
after the reset will not help here as that will put the charger back
in host mode and start the i2c watchdog if the host then does not do
anything for 40s (iow if we're suspended for more then 40s) the watchdog
expires resetting the device to default-mode, including resetting all
the registers to there safe power-on defaults. So the only way to keep
using custom charge settings while suspending is to keep the charger in
its normal running state with the i2c watchdog disabled. This is fine
as the charger will still automatically switch from constant current
to constant voltage and stop charging when the battery is full.

Besides never being necessary resetting the charger also causes problems
on systems where the charge voltage limit is set higher then the reset
value, if this is the case and the charger is reset while charging and
the battery voltage is between the 2 voltages, then about half the time
the charger gets confused and claims to be charging (REG08 contains 0x64)
but in reality the charger has decoupled itself from VBUS (Q1 off) and
is drawing 0A from VBUS, leaving the system running from the battery.

Cc: Liam Breck <kernel@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-This is a new patch in v2 of this patch-set
---
 drivers/power/supply/bq24190_charger.c | 58 ----------------------------------
 1 file changed, 58 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 7a2a496..b535f24 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -526,40 +526,6 @@ static int bq24190_set_mode_host(struct bq24190_dev_info *bdi)
 	return bq24190_write(bdi, BQ24190_REG_CTTC, v);
 }
 
-static int bq24190_register_reset(struct bq24190_dev_info *bdi)
-{
-	int ret, limit = 100;
-	u8 v;
-
-	/* Reset the registers */
-	ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
-			BQ24190_REG_POC_RESET_MASK,
-			BQ24190_REG_POC_RESET_SHIFT,
-			0x1);
-	if (ret < 0)
-		return ret;
-
-	/* Reset bit will be cleared by hardware so poll until it is */
-	do {
-		ret = bq24190_read_mask(bdi, BQ24190_REG_POC,
-				BQ24190_REG_POC_RESET_MASK,
-				BQ24190_REG_POC_RESET_SHIFT,
-				&v);
-		if (ret < 0)
-			return ret;
-
-		if (!v)
-			break;
-
-		udelay(10);
-	} while (--limit);
-
-	if (!limit)
-		return -EIO;
-
-	return 0;
-}
-
 /* Charger power supply property routines */
 
 static int bq24190_charger_get_charge_type(struct bq24190_dev_info *bdi,
@@ -1380,10 +1346,6 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 		return -ENODEV;
 	}
 
-	ret = bq24190_register_reset(bdi);
-	if (ret < 0)
-		return ret;
-
 	ret = bq24190_set_mode_host(bdi);
 	if (ret < 0)
 		return ret;
@@ -1534,7 +1496,6 @@ static int bq24190_remove(struct i2c_client *client)
 		pm_runtime_put_noidle(bdi->dev);
 	}
 
-	bq24190_register_reset(bdi);
 	bq24190_sysfs_remove_group(bdi);
 	power_supply_unregister(bdi->battery);
 	power_supply_unregister(bdi->charger);
@@ -1577,23 +1538,6 @@ static __maybe_unused int bq24190_runtime_resume(struct device *dev)
 
 static __maybe_unused int bq24190_pm_suspend(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
-	int error;
-
-	error = pm_runtime_get_sync(bdi->dev);
-	if (error < 0) {
-		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
-		pm_runtime_put_noidle(bdi->dev);
-	}
-
-	bq24190_register_reset(bdi);
-
-	if (error >= 0) {
-		pm_runtime_mark_last_busy(bdi->dev);
-		pm_runtime_put_autosuspend(bdi->dev);
-	}
-
 	return 0;
 }
 
@@ -1612,8 +1556,6 @@ static __maybe_unused int bq24190_pm_resume(struct device *dev)
 		pm_runtime_put_noidle(bdi->dev);
 	}
 
-	bq24190_register_reset(bdi);
-	bq24190_set_mode_host(bdi);
 	bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
 
 	if (error >= 0) {
-- 
2.9.3
