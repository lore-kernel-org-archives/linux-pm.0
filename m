From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 07/15] power: supply: bq24190_charger: Add support for bq24192[i]
Date: Fri, 17 Mar 2017 10:55:19 +0100
Message-ID: <20170317095527.10487-8-hdegoede@redhat.com>
References: <20170317095527.10487-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170317095527.10487-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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

Since we do not provide an API for setting the pre-charge-current,
these differences can be ignored and we can simply use the existing
code as-is with the bq24192 and bq24192i.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq24190_charger.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 9c4b171..9014dee 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1275,7 +1275,14 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 	if (ret < 0)
 		goto out;
 
-	if (v != bdi->model) {
+	switch (v) {
+	case BQ24190_REG_VPRS_PN_24190:
+	case BQ24190_REG_VPRS_PN_24192:
+	case BQ24190_REG_VPRS_PN_24192I:
+		bdi->model = v;
+		break;
+	default:
+		dev_err(bdi->dev, "Error unknown model: 0x%02x\n", v);
 		ret = -ENODEV;
 		goto out;
 	}
@@ -1316,7 +1323,6 @@ static int bq24190_probe(struct i2c_client *client,
 
 	bdi->client = client;
 	bdi->dev = dev;
-	bdi->model = id->driver_data;
 	bdi->pdata = client->dev.platform_data;
 	strncpy(bdi->model_name, id->name, I2C_NAME_SIZE);
 	mutex_init(&bdi->f_reg_lock);
@@ -1450,6 +1456,8 @@ static SIMPLE_DEV_PM_OPS(bq24190_pm_ops, bq24190_pm_suspend, bq24190_pm_resume);
  */
 static const struct i2c_device_id bq24190_i2c_ids[] = {
 	{ "bq24190", BQ24190_REG_VPRS_PN_24190 },
+	{ "bq24192", BQ24190_REG_VPRS_PN_24192 },
+	{ "bq24192i", BQ24190_REG_VPRS_PN_24192I },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
-- 
2.9.3

