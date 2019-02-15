From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: [PATCH] max17042_battery: fix potential use-after-free on device remove
Date: Fri, 15 Feb 2019 17:03:44 -0500
Message-ID: <20190215220344.16604-1-TheSven73@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-pm@vger.kernel.org

The work which is scheduled on a POR boot is potentially left
pending or running until after the device module is removed,
which could result in a use-after-free.

Fix by registering a cancel/sync callback, which gets executed as
part of standard resource unwinding.

This issue was detected with the help of Coccinelle.

Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/power/supply/max17042_battery.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 2a8d75e5e930..581c6bd23388 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -995,6 +995,13 @@ static const struct power_supply_desc max17042_no_current_sense_psy_desc = {
 	.num_properties	= ARRAY_SIZE(max17042_battery_props) - 2,
 };
 
+static void max17042_stop_work(void *data)
+{
+	struct max17042_chip *chip = data;
+
+	cancel_work_sync(&chip->work);
+}
+
 static int max17042_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -1101,6 +1108,9 @@ static int max17042_probe(struct i2c_client *client,
 	regmap_read(chip->regmap, MAX17042_STATUS, &val);
 	if (val & STATUS_POR_BIT) {
 		INIT_WORK(&chip->work, max17042_init_worker);
+		ret = devm_add_action(&client->dev, max17042_stop_work, chip);
+		if (ret)
+			return ret;
 		schedule_work(&chip->work);
 	} else {
 		chip->init_complete = 1;
-- 
2.17.1
