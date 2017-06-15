From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v7 01/10] power: supply: sbs-battery: remove incorrect le16_to_cpu calls
Date: Thu, 15 Jun 2017 21:59:29 +0800
Message-ID: <1497535178-12001-2-git-send-email-preid@electromag.com.au>
References: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, preid@electromag.com.au, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

i2c_smbus commands handle the correct byte order for smbus transactions
internally. This will currently result in incorrect operation on big
endian systems.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/power/supply/sbs-battery.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index e3a114e..cf43e38 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -199,7 +199,7 @@ static int sbs_read_word_data(struct i2c_client *client, u8 address)
 		return ret;
 	}
 
-	return le16_to_cpu(ret);
+	return ret;
 }
 
 static int sbs_read_string_data(struct i2c_client *client, u8 address,
@@ -265,7 +265,7 @@ static int sbs_read_string_data(struct i2c_client *client, u8 address,
 	memcpy(values, block_buffer + 1, block_length);
 	values[block_length] = '\0';
 
-	return le16_to_cpu(ret);
+	return ret;
 }
 
 static int sbs_write_word_data(struct i2c_client *client, u8 address,
@@ -278,8 +278,7 @@ static int sbs_write_word_data(struct i2c_client *client, u8 address,
 	retries = chip->i2c_retry_count;
 
 	while (retries > 0) {
-		ret = i2c_smbus_write_word_data(client, address,
-			le16_to_cpu(value));
+		ret = i2c_smbus_write_word_data(client, address, value);
 		if (ret >= 0)
 			break;
 		retries--;
-- 
1.8.3.1
