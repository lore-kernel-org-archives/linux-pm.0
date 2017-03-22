From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 2/7] power: supply: bq24190_charger: Add support for bq24192i
Date: Wed, 22 Mar 2017 15:55:31 +0100
Message-ID: <20170322145536.30570-3-hdegoede@redhat.com>
References: <20170322145536.30570-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760496AbdCVOzm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 10:55:42 -0400
In-Reply-To: <20170322145536.30570-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>

The bq24192 and bq24192i are mostly identical to the bq24190, TI even
published a single datasheet for all 3 of them. The difference
between the bq24190 and bq24192[i] is the way charger-type detection
is done, the bq24190 is to be directly connected to the USB a/b lines,
where as the the bq24192[i] has a gpio which should be driven high/low
externally depending on the type of charger connected, from a register
level access pov there is no difference.

The differences between the bq24192 and bq24192i are:
1) Lower default charge rate on the bq24192i
2) Pre-charge-current can be max 640 mA on the bq24192i

On x86/ACPI systems the code which instantiates the i2c client may not
know the exact variant being used, so instead of coding the model-id
in the i2c_id struct and bailing if it does not match, check the reported
model-id matches one of the supported variants.

This commit only adds support for the bq24192i as I don't
have a bq24192 to test with, adding support for the bq24192 should
be as simple as also accepting its model-id in the model-id test.

Cc: Liam Breck <kernel@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Improve commit msg
-Drop model-id from bq24190_i2c_ids table and bdi struct
-Only add support for the bq24192i and not for the bq24192
---
 drivers/power/supply/bq24190_charger.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index fa2d2da..d74c8cc 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -149,7 +149,6 @@ struct bq24190_dev_info {
 	struct power_supply		*charger;
 	struct power_supply		*battery;
 	char				model_name[I2C_NAME_SIZE];
-	kernel_ulong_t			model;
 	bool				initialized;
 	bool				irq_event;
 	struct mutex			f_reg_lock;
@@ -1291,8 +1290,11 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 	if (ret < 0)
 		return ret;
 
-	if (v != bdi->model)
+	if (v != BQ24190_REG_VPRS_PN_24190 &&
+	    v != BQ24190_REG_VPRS_PN_24192I) {
+		dev_err(bdi->dev, "Error unknown model: 0x%02x\n", v);
 		return -ENODEV;
+	}
 
 	ret = bq24190_register_reset(bdi);
 	if (ret < 0)
@@ -1327,7 +1329,6 @@ static int bq24190_probe(struct i2c_client *client,
 
 	bdi->client = client;
 	bdi->dev = dev;
-	bdi->model = id->driver_data;
 	strncpy(bdi->model_name, id->name, I2C_NAME_SIZE);
 	mutex_init(&bdi->f_reg_lock);
 	bdi->f_reg = 0;
@@ -1526,13 +1527,9 @@ static const struct dev_pm_ops bq24190_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(bq24190_pm_suspend, bq24190_pm_resume)
 };
 
-/*
- * Only support the bq24190 right now.  The bq24192, bq24192i, and bq24193
- * are similar but not identical so the driver needs to be extended to
- * support them.
- */
 static const struct i2c_device_id bq24190_i2c_ids[] = {
-	{ "bq24190", BQ24190_REG_VPRS_PN_24190 },
+	{ "bq24190" },
+	{ "bq24192i" },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
-- 
2.9.3
