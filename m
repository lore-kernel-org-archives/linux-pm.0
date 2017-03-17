From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 04/15] power: supply: bq24190_charger: Add no_register_reset pdata flag
Date: Fri, 17 Mar 2017 10:55:16 +0100
Message-ID: <20170317095527.10487-5-hdegoede@redhat.com>
References: <20170317095527.10487-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170317095527.10487-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On some platforms the register have been setup with platform specific
values by the firmware and should not be reset.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq24190_charger.c | 5 +++++
 include/linux/power/bq24190_charger.h  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index a4f0849..c92a40e4 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -151,6 +151,7 @@ struct bq24190_dev_info {
 	struct device			*dev;
 	struct power_supply		*charger;
 	struct power_supply		*battery;
+	struct bq24190_platform_data	*pdata;
 	char				model_name[I2C_NAME_SIZE];
 	kernel_ulong_t			model;
 	unsigned int			gpio_int;
@@ -506,6 +507,9 @@ static int bq24190_register_reset(struct bq24190_dev_info *bdi)
 	int ret, limit = 100;
 	u8 v;
 
+	if (bdi->pdata && bdi->pdata->no_register_reset)
+		return 0;
+
 	/* Reset the registers */
 	ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
 			BQ24190_REG_POC_RESET_MASK,
@@ -1339,6 +1343,7 @@ static int bq24190_probe(struct i2c_client *client,
 	bdi->client = client;
 	bdi->dev = dev;
 	bdi->model = id->driver_data;
+	bdi->pdata = client->dev.platform_data;
 	strncpy(bdi->model_name, id->name, I2C_NAME_SIZE);
 	mutex_init(&bdi->f_reg_lock);
 	bdi->f_reg = 0;
diff --git a/include/linux/power/bq24190_charger.h b/include/linux/power/bq24190_charger.h
index 9f02837..cb49717 100644
--- a/include/linux/power/bq24190_charger.h
+++ b/include/linux/power/bq24190_charger.h
@@ -11,6 +11,7 @@
 
 struct bq24190_platform_data {
 	unsigned int	gpio_int;	/* GPIO pin that's connected to INT# */
+	bool no_register_reset;
 };
 
 #endif
-- 
2.9.3
