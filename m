From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] sbs-battery: make writes to ManufacturerAccess optional
Date: Thu,  8 Sep 2016 19:10:00 -0700
Message-ID: <1473387000-13646-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Brian Norris <briannorris@chromium.org>
List-Id: linux-pm@vger.kernel.org

According to the Smart Battery Data Specification, the use
of ManufacturerAcess (register 0x0) is implementation-defined.
It appears that some batteries use writes to this register
in order to implement certain functionality, but others may
simply NAK all writes to it. As a result, write failures to
ManufacturerAccess should not be used as an indicator of
battery presence, nor as a failure to enter sleep mode.

The failed write access was seen with SANYO AP13J3K.

Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/power/sbs-battery.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
index 768b9fcb58ea..5621b8c048cf 100644
--- a/drivers/power/sbs-battery.c
+++ b/drivers/power/sbs-battery.c
@@ -313,21 +313,22 @@ static int sbs_get_battery_presence_and_health(
 		return ret;
 	}
 
-	/* Write to ManufacturerAccess with
-	 * ManufacturerAccess command and then
-	 * read the status */
-	ret = sbs_write_word_data(client, sbs_data[REG_MANUFACTURER_DATA].addr,
-					MANUFACTURER_ACCESS_STATUS);
+	/*
+	 * Write to ManufacturerAccess with ManufacturerAccess command
+	 * and then read the status. Do not check for error on the write
+	 * since not all batteries implement write access to this command,
+	 * while others mandate it.
+	 */
+	sbs_write_word_data(client, sbs_data[REG_MANUFACTURER_DATA].addr,
+			    MANUFACTURER_ACCESS_STATUS);
+
+	ret = sbs_read_word_data(client, sbs_data[REG_MANUFACTURER_DATA].addr);
 	if (ret < 0) {
 		if (psp == POWER_SUPPLY_PROP_PRESENT)
 			val->intval = 0; /* battery removed */
 		return ret;
 	}
 
-	ret = sbs_read_word_data(client, sbs_data[REG_MANUFACTURER_DATA].addr);
-	if (ret < 0)
-		return ret;
-
 	if (ret < sbs_data[REG_MANUFACTURER_DATA].min_value ||
 	    ret > sbs_data[REG_MANUFACTURER_DATA].max_value) {
 		val->intval = 0;
@@ -950,16 +951,16 @@ static int sbs_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sbs_info *chip = i2c_get_clientdata(client);
-	s32 ret;
 
 	if (chip->poll_time > 0)
 		cancel_delayed_work_sync(&chip->work);
 
-	/* write to manufacturer access with sleep command */
-	ret = sbs_write_word_data(client, sbs_data[REG_MANUFACTURER_DATA].addr,
+	/*
+	 * Write to manufacturer access with sleep command.
+	 * Support is manufacturer dependend, so ignore errors.
+	 */
+	sbs_write_word_data(client, sbs_data[REG_MANUFACTURER_DATA].addr,
 		MANUFACTURER_ACCESS_SLEEP);
-	if (chip->is_present && ret < 0)
-		return ret;
 
 	return 0;
 }
-- 
2.5.0
