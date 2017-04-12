From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 2/3] power: supply: bq24190_charger: Do not reset the charger on probe by default
Date: Wed, 12 Apr 2017 20:18:07 +0200
Message-ID: <20170412181808.31768-3-hdegoede@redhat.com>
References: <20170412181808.31768-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51867 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752286AbdDLSSP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Apr 2017 14:18:15 -0400
In-Reply-To: <20170412181808.31768-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

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

For all the above reasons this commit disables reset on probe and on
suspend / resume. If a specific setup really needs / wants to do a rest
in these cases, this can be requested by setting a reset-on-probe device
property on the device.

Cc: Liam Breck <kernel@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-This is a new patch in v2 of this patch-set
Changes in v3:
-Disable the reset code by default, but leave it around guarded by
 a check for a reset-on-probe device-property
Changes in v4:
-Rebase on top of current power-supply/next
---
 drivers/power/supply/bq24190_charger.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index bd9e5c3..ad429b7 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1382,9 +1382,11 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 		return -ENODEV;
 	}
 
-	ret = bq24190_register_reset(bdi);
-	if (ret < 0)
-		return ret;
+	if (device_property_read_bool(bdi->dev, "reset-on-probe")) {
+		ret = bq24190_register_reset(bdi);
+		if (ret < 0)
+			return ret;
+	}
 
 	ret = bq24190_set_mode_host(bdi);
 	if (ret < 0)
@@ -1547,7 +1549,8 @@ static int bq24190_remove(struct i2c_client *client)
 		pm_runtime_put_noidle(bdi->dev);
 	}
 
-	bq24190_register_reset(bdi);
+	if (device_property_read_bool(bdi->dev, "reset-on-probe"))
+		bq24190_register_reset(bdi);
 	bq24190_sysfs_remove_group(bdi);
 	power_supply_unregister(bdi->battery);
 	power_supply_unregister(bdi->charger);
@@ -1600,7 +1603,8 @@ static __maybe_unused int bq24190_pm_suspend(struct device *dev)
 		pm_runtime_put_noidle(bdi->dev);
 	}
 
-	bq24190_register_reset(bdi);
+	if (device_property_read_bool(bdi->dev, "reset-on-probe"))
+		bq24190_register_reset(bdi);
 
 	if (error >= 0) {
 		pm_runtime_mark_last_busy(bdi->dev);
@@ -1625,8 +1629,10 @@ static __maybe_unused int bq24190_pm_resume(struct device *dev)
 		pm_runtime_put_noidle(bdi->dev);
 	}
 
-	bq24190_register_reset(bdi);
-	bq24190_set_mode_host(bdi);
+	if (device_property_read_bool(bdi->dev, "reset-on-probe")) {
+		bq24190_register_reset(bdi);
+		bq24190_set_mode_host(bdi);
+	}
 	bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
 
 	if (error >= 0) {
-- 
2.9.3
