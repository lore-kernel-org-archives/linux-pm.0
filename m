From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 05/15] power: supply: bq24190_charger: Limit charging voltage to 4.3V
Date: Fri, 17 Mar 2017 10:55:17 +0100
Message-ID: <20170317095527.10487-6-hdegoede@redhat.com>
References: <20170317095527.10487-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170317095527.10487-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When the platform data asks us to not reset the charger to its default
values and instead trust the firmware set values check the charging
voltage and clamp it to 4.304V.

Some firmwares set really too high voltages, e.g. the GPD-win I've been
working on uses 4.384V. New LiHV (High Voltage) batteries may be charged
upto 4.35V but that significantly impacts their lifetime, limit charging
to 4.304V for safety and lifetime reasons.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq24190_charger.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index c92a40e4..7bca8d0 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -504,11 +504,32 @@ static int bq24190_set_mode_host(struct bq24190_dev_info *bdi)
 
 static int bq24190_register_reset(struct bq24190_dev_info *bdi)
 {
-	int ret, limit = 100;
+	int ret, voltage, limit = 100;
 	u8 v;
 
-	if (bdi->pdata && bdi->pdata->no_register_reset)
-		return 0;
+	if (bdi->pdata && bdi->pdata->no_register_reset) {
+		/*
+		 * We've been asked to keep the firmware settings as is, but
+		 * some firmwares set really too high voltages (e.g. 4.384V).
+		 * New LiHV (High Voltage) batteries may be charged upto 4.35V
+		 * but that significantly impacts their lifetime, limit
+		 * charging to 4.304V for safety and lifetime reasons.
+		 */
+		ret = bq24190_get_field_val(bdi, BQ24190_REG_CVC,
+			BQ24190_REG_CVC_VREG_MASK, BQ24190_REG_CVC_VREG_SHIFT,
+			bq24190_cvc_vreg_values,
+			ARRAY_SIZE(bq24190_cvc_vreg_values), &voltage);
+		if (ret < 0)
+			return ret;
+
+		if (voltage <= 4304000)
+			return 0;
+
+		return bq24190_set_field_val(bdi, BQ24190_REG_CVC,
+			BQ24190_REG_CVC_VREG_MASK, BQ24190_REG_CVC_VREG_SHIFT,
+			bq24190_cvc_vreg_values,
+			ARRAY_SIZE(bq24190_cvc_vreg_values), 4304000);
+	}
 
 	/* Reset the registers */
 	ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
-- 
2.9.3
