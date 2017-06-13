From: Shawn Nematbakhsh <shawnn@chromium.org>
Subject: [PATCH 1/2] power: supply: sbs-battery: Prevent CAPACITY_MODE races
Date: Tue, 13 Jun 2017 10:53:25 -0700
Message-ID: <1497376406-86470-1-git-send-email-shawnn@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35110 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753653AbdFMRxv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2017 13:53:51 -0400
Received: by mail-pf0-f177.google.com with SMTP id l89so71380772pfi.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2017 10:53:51 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: shawnn@chromium.org
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org

A subset of smart battery commands return charge or energy depending on
the CAPACITY_MODE bit setting of BatteryMode(). In order to
unambiguously read a charge or energy value, it is necessary to ensure
that CAPACITY_MODE is set as desired, and not changed for the duration
of the attribute read.

Signed-off-by: Shawn Nematbakhsh <shawnn@chromium.org>
---
 drivers/power/supply/sbs-battery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index e3a114e60f1a..d7e68fd97099 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -171,6 +171,7 @@ struct sbs_info {
 	u32				i2c_retry_count;
 	u32				poll_retry_count;
 	struct delayed_work		work;
+	struct mutex			mode_lock;
 };
 
 static char model_name[I2C_SMBUS_BLOCK_MAX + 1];
@@ -623,7 +624,13 @@ static int sbs_get_property(struct power_supply *psy,
 		if (ret < 0)
 			break;
 
+		/* sbs_get_battery_capacity() will change the battery mode
+		 * temporarily to read the requested attribute. Ensure we stay
+		 * in the desired mode for the duration of the attribute read.
+		 */
+		mutex_lock(&chip->mode_lock);
 		ret = sbs_get_battery_capacity(client, ret, psp, val);
+		mutex_unlock(&chip->mode_lock);
 		break;
 
 	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
@@ -808,6 +815,7 @@ static int sbs_probe(struct i2c_client *client,
 	psy_cfg.of_node = client->dev.of_node;
 	psy_cfg.drv_data = chip;
 	chip->last_state = POWER_SUPPLY_STATUS_UNKNOWN;
+	mutex_init(&chip->mode_lock);
 
 	/* use pdata if available, fall back to DT properties,
 	 * or hardcoded defaults if not
-- 
2.13.1.508.gb3defc5cc-goog
