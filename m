From: Liu Xiang <liuxiang_1999@126.com>
Subject: [PATCH] power: max17040: Change register transaction length from 8 bits to 16 bits
Date: Wed, 21 Sep 2016 22:17:34 +0800
Message-ID: <1474467454-4958-1-git-send-email-liuxiang_1999@126.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org, Liu Xiang <liuxiang_1999@126.com>, Liu Xiang <liu.xiang6@zte.com.cn>
List-Id: linux-pm@vger.kernel.org

According to the datasheet, MAX17040 has six 16-bit registers.
Register reads and writes are only valid if all 16 bits are transferred.
Any write command that is terminated early is ignored.
So it's better to change register transacton length from 8 bits to 16 bits.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 drivers/power/max17040_battery.c | 52 ++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/drivers/power/max17040_battery.c b/drivers/power/max17040_battery.c
index 8689c80..e7c3649 100644
--- a/drivers/power/max17040_battery.c
+++ b/drivers/power/max17040_battery.c
@@ -21,18 +21,13 @@
 #include <linux/max17040_battery.h>
 #include <linux/slab.h>
 
-#define MAX17040_VCELL_MSB	0x02
-#define MAX17040_VCELL_LSB	0x03
-#define MAX17040_SOC_MSB	0x04
-#define MAX17040_SOC_LSB	0x05
-#define MAX17040_MODE_MSB	0x06
-#define MAX17040_MODE_LSB	0x07
-#define MAX17040_VER_MSB	0x08
-#define MAX17040_VER_LSB	0x09
-#define MAX17040_RCOMP_MSB	0x0C
-#define MAX17040_RCOMP_LSB	0x0D
-#define MAX17040_CMD_MSB	0xFE
-#define MAX17040_CMD_LSB	0xFF
+#define MAX17040_VCELL	0x02
+#define MAX17040_SOC	0x04
+#define MAX17040_MODE	0x06
+#define MAX17040_VER	0x08
+#define MAX17040_RCOMP	0x0C
+#define MAX17040_CMD	0xFE
+
 
 #define MAX17040_DELAY		1000
 #define MAX17040_BATTERY_FULL	95
@@ -78,11 +73,11 @@ static int max17040_get_property(struct power_supply *psy,
 	return 0;
 }
 
-static int max17040_write_reg(struct i2c_client *client, int reg, u8 value)
+static int max17040_write_reg(struct i2c_client *client, int reg, u16 value)
 {
 	int ret;
 
-	ret = i2c_smbus_write_byte_data(client, reg, value);
+	ret = i2c_smbus_write_word_swapped(client, reg, value);
 
 	if (ret < 0)
 		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
@@ -94,7 +89,7 @@ static int max17040_read_reg(struct i2c_client *client, int reg)
 {
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(client, reg);
+	ret = i2c_smbus_read_word_swapped(client, reg);
 
 	if (ret < 0)
 		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
@@ -104,43 +99,36 @@ static int max17040_read_reg(struct i2c_client *client, int reg)
 
 static void max17040_reset(struct i2c_client *client)
 {
-	max17040_write_reg(client, MAX17040_CMD_MSB, 0x54);
-	max17040_write_reg(client, MAX17040_CMD_LSB, 0x00);
+	max17040_write_reg(client, MAX17040_CMD, 0x0054);
 }
 
 static void max17040_get_vcell(struct i2c_client *client)
 {
 	struct max17040_chip *chip = i2c_get_clientdata(client);
-	u8 msb;
-	u8 lsb;
+	u16 vcell;
 
-	msb = max17040_read_reg(client, MAX17040_VCELL_MSB);
-	lsb = max17040_read_reg(client, MAX17040_VCELL_LSB);
+	vcell = max17040_read_reg(client, MAX17040_VCELL);
 
-	chip->vcell = (msb << 4) + (lsb >> 4);
+	chip->vcell = vcell;
 }
 
 static void max17040_get_soc(struct i2c_client *client)
 {
 	struct max17040_chip *chip = i2c_get_clientdata(client);
-	u8 msb;
-	u8 lsb;
+	u16 soc;
 
-	msb = max17040_read_reg(client, MAX17040_SOC_MSB);
-	lsb = max17040_read_reg(client, MAX17040_SOC_LSB);
+	soc = max17040_read_reg(client, MAX17040_SOC);
 
-	chip->soc = msb;
+	chip->soc = (soc >> 8);
 }
 
 static void max17040_get_version(struct i2c_client *client)
 {
-	u8 msb;
-	u8 lsb;
+	u16 version;
 
-	msb = max17040_read_reg(client, MAX17040_VER_MSB);
-	lsb = max17040_read_reg(client, MAX17040_VER_LSB);
+	version = max17040_read_reg(client, MAX17040_VER);
 
-	dev_info(&client->dev, "MAX17040 Fuel-Gauge Ver %d%d\n", msb, lsb);
+	dev_info(&client->dev, "MAX17040 Fuel-Gauge Ver 0x%x\n", version);
 }
 
 static void max17040_get_online(struct i2c_client *client)
-- 
1.9.1
