From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/3] power: supply: sbs-battery: remove superfluous variable init
Date: Sun, 29 Oct 2017 16:35:43 +0100
Message-ID: <20171029153545.3947-2-wsa@the-dreams.de>
References: <20171029153545.3947-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20171029153545.3947-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Phil Reid <preid@electromag.com.au>, sre@kernel.org, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-pm@vger.kernel.org

Those variables are immediately assigned a value afterwards.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/power/supply/sbs-battery.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 8dd4bd70c561cc..fb61da370947f4 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -177,10 +177,8 @@ static bool force_load;
 static int sbs_read_word_data(struct i2c_client *client, u8 address)
 {
 	struct sbs_info *chip = i2c_get_clientdata(client);
+	int retries = chip->i2c_retry_count;
 	s32 ret = 0;
-	int retries = 1;
-
-	retries = chip->i2c_retry_count;
 
 	while (retries > 0) {
 		ret = i2c_smbus_read_word_data(client, address);
@@ -204,7 +202,7 @@ static int sbs_read_string_data(struct i2c_client *client, u8 address,
 {
 	struct sbs_info *chip = i2c_get_clientdata(client);
 	s32 ret = 0, block_length = 0;
-	int retries_length = 1, retries_block = 1;
+	int retries_length, retries_block;
 	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
 
 	retries_length = chip->i2c_retry_count;
@@ -269,10 +267,8 @@ static int sbs_write_word_data(struct i2c_client *client, u8 address,
 	u16 value)
 {
 	struct sbs_info *chip = i2c_get_clientdata(client);
+	int retries = chip->i2c_retry_count;
 	s32 ret = 0;
-	int retries = 1;
-
-	retries = chip->i2c_retry_count;
 
 	while (retries > 0) {
 		ret = i2c_smbus_write_word_data(client, address, value);
-- 
2.11.0
