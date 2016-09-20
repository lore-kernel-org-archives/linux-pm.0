From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v2 1/1] power: supply: sbs-battery: Cleanup removal of chip->pdata
Date: Tue, 20 Sep 2016 09:01:12 +0800
Message-ID: <1474333272-13980-1-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 203-59-230-133.perm.iinet.net.au ([203.59.230.133]:55292 "EHLO
        preid-centos7.electromag.com.au" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752611AbcITBBh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Sep 2016 21:01:37 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, preid@electromag.com.au, arnd@arndb.de, linux-pm@vger.kernel.org

There where still a few lingering references to pdata after commit
power: supply: sbs-battery: simplify DT parsing.

Remove pdata from struct·sbs_info and conditional checks to ser if this
was set from the i2c read / write functions.
Instead of call max in each function for incrementing poll_retry_count
do it once in the probe function.
Fixup null pointer dereference in to pdata in sbs_external_power_changed.
Change retry counts to u32 to avoid need for max.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---

Notes:
    Changes from v1:
    - I missed a couple of max / '+1' removals.
    - Change counts to unsigned to remove need for max.

 drivers/power/supply/sbs-battery.c | 22 +++++++++-------------
 include/linux/power/sbs-battery.h  |  4 ++--
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 248a5dd..d15ce9e 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -163,14 +163,13 @@ static enum power_supply_property sbs_properties[] = {
 struct sbs_info {
 	struct i2c_client		*client;
 	struct power_supply		*power_supply;
-	struct sbs_platform_data	*pdata;
 	bool				is_present;
 	struct gpio_desc		*gpio_detect;
 	bool				enable_detection;
 	int				last_state;
 	int				poll_time;
-	int				i2c_retry_count;
-	int				poll_retry_count;
+	u32				i2c_retry_count;
+	u32				poll_retry_count;
 	struct delayed_work		work;
 	int				ignore_changes;
 };
@@ -185,8 +184,7 @@ static int sbs_read_word_data(struct i2c_client *client, u8 address)
 	s32 ret = 0;
 	int retries = 1;
 
-	if (chip->pdata)
-		retries = max(chip->i2c_retry_count + 1, 1);
+	retries = chip->i2c_retry_count;
 
 	while (retries > 0) {
 		ret = i2c_smbus_read_word_data(client, address);
@@ -213,10 +211,8 @@ static int sbs_read_string_data(struct i2c_client *client, u8 address,
 	int retries_length = 1, retries_block = 1;
 	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
 
-	if (chip->pdata) {
-		retries_length = max(chip->i2c_retry_count + 1, 1);
-		retries_block = max(chip->i2c_retry_count + 1, 1);
-	}
+	retries_length = chip->i2c_retry_count;
+	retries_block = chip->i2c_retry_count;
 
 	/* Adapter needs to support these two functions */
 	if (!i2c_check_functionality(client->adapter,
@@ -280,8 +276,7 @@ static int sbs_write_word_data(struct i2c_client *client, u8 address,
 	s32 ret = 0;
 	int retries = 1;
 
-	if (chip->pdata)
-		retries = max(chip->i2c_retry_count + 1, 1);
+	retries = chip->i2c_retry_count;
 
 	while (retries > 0) {
 		ret = i2c_smbus_write_word_data(client, address,
@@ -707,7 +702,7 @@ static void sbs_external_power_changed(struct power_supply *psy)
 	cancel_delayed_work_sync(&chip->work);
 
 	schedule_delayed_work(&chip->work, HZ);
-	chip->poll_time = chip->pdata->poll_retry_count;
+	chip->poll_time = chip->poll_retry_count;
 }
 
 static void sbs_delayed_work(struct work_struct *work)
@@ -791,7 +786,7 @@ static int sbs_probe(struct i2c_client *client,
 	rc = of_property_read_u32(client->dev.of_node, "sbs,i2c-retry-count",
 				  &chip->i2c_retry_count);
 	if (rc)
-		chip->i2c_retry_count = 1;
+		chip->i2c_retry_count = 0;
 
 	rc = of_property_read_u32(client->dev.of_node, "sbs,poll-retry-count",
 				  &chip->poll_retry_count);
@@ -802,6 +797,7 @@ static int sbs_probe(struct i2c_client *client,
 		chip->poll_retry_count = pdata->poll_retry_count;
 		chip->i2c_retry_count  = pdata->i2c_retry_count;
 	}
+	chip->i2c_retry_count = chip->i2c_retry_count + 1;
 
 	chip->gpio_detect = devm_gpiod_get_optional(&client->dev,
 			"sbs,battery-detect", GPIOD_IN);
diff --git a/include/linux/power/sbs-battery.h b/include/linux/power/sbs-battery.h
index 811f1a0..519b8b4 100644
--- a/include/linux/power/sbs-battery.h
+++ b/include/linux/power/sbs-battery.h
@@ -31,8 +31,8 @@
  *				external change notification
  */
 struct sbs_platform_data {
-	int i2c_retry_count;
-	int poll_retry_count;
+	u32 i2c_retry_count;
+	u32 poll_retry_count;
 };
 
 #endif
-- 
1.8.3.1

