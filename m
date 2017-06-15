From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v7 02/10] power: supply: bq24735: remove incorrect le16_to_cpu calls
Date: Thu, 15 Jun 2017 21:59:30 +0800
Message-ID: <1497535178-12001-3-git-send-email-preid@electromag.com.au>
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
 drivers/power/supply/bq24735-charger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index eb01453..6931e1d 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -81,14 +81,12 @@ static int bq24735_charger_property_is_writeable(struct power_supply *psy,
 static inline int bq24735_write_word(struct i2c_client *client, u8 reg,
 				     u16 value)
 {
-	return i2c_smbus_write_word_data(client, reg, le16_to_cpu(value));
+	return i2c_smbus_write_word_data(client, reg, value);
 }
 
 static inline int bq24735_read_word(struct i2c_client *client, u8 reg)
 {
-	s32 ret = i2c_smbus_read_word_data(client, reg);
-
-	return ret < 0 ? ret : le16_to_cpu(ret);
+	return i2c_smbus_read_word_data(client, reg);
 }
 
 static int bq24735_update_word(struct i2c_client *client, u8 reg,
-- 
1.8.3.1
