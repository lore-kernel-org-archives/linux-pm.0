From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/2] sbs-battery: export manufacturer and model name to sysfs
Date: Mon,  4 Aug 2014 13:47:45 +0200
Message-ID: <1407152866-31790-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1407152866-31790-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1407152866-31790-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Simon Que <sque@chromium.org>, cychiang <cychiang@chromium.org>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>
List-Id: linux-pm@vger.kernel.org

From: cychiang <cychiang@chromium.org>

This CL supports two power_supply_property items for smart battery:
POWER_SUPPLY_PROP_MANUFACTURER and POWER_SUPPLY_PROP_MODEL_NAME such
that battery information 'manufacturer' and 'model_name' can be exported
to sysfs.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Reviewed-by: Olof Johansson <olofj@chromium.org>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/power/sbs-battery.c | 115 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
index b5f2a76..08feb38 100644
--- a/drivers/power/sbs-battery.c
+++ b/drivers/power/sbs-battery.c
@@ -49,6 +49,8 @@ enum {
 	REG_DESIGN_CAPACITY,
 	REG_DESIGN_CAPACITY_CHARGE,
 	REG_DESIGN_VOLTAGE,
+	REG_MANUFACTURER,
+	REG_MODEL_NAME,
 };
 
 /* Battery Mode defines */
@@ -68,6 +70,7 @@ enum sbs_battery_mode {
 #define BATTERY_FULL_CHARGED		0x20
 #define BATTERY_FULL_DISCHARGED		0x10
 
+/* min_value and max_value are only valid for numerical data */
 #define SBS_DATA(_psp, _addr, _min_value, _max_value) { \
 	.psp = _psp, \
 	.addr = _addr, \
@@ -115,6 +118,11 @@ static const struct chip_data {
 		SBS_DATA(POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN, 0x19, 0, 65535),
 	[REG_SERIAL_NUMBER] =
 		SBS_DATA(POWER_SUPPLY_PROP_SERIAL_NUMBER, 0x1C, 0, 65535),
+	/* Properties of type `const char *' */
+	[REG_MANUFACTURER] =
+		SBS_DATA(POWER_SUPPLY_PROP_MANUFACTURER, 0x20, 0, 65535),
+	[REG_MODEL_NAME] =
+		SBS_DATA(POWER_SUPPLY_PROP_MODEL_NAME, 0x21, 0, 65535)
 };
 
 static enum power_supply_property sbs_properties[] = {
@@ -137,6 +145,9 @@ static enum power_supply_property sbs_properties[] = {
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	/* Properties of type `const char *' */
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_MODEL_NAME
 };
 
 struct sbs_info {
@@ -153,6 +164,9 @@ struct sbs_info {
 	int				ignore_changes;
 };
 
+static char model_name[I2C_SMBUS_BLOCK_MAX + 1];
+static char manufacturer[I2C_SMBUS_BLOCK_MAX + 1];
+
 static int sbs_read_word_data(struct i2c_client *client, u8 address)
 {
 	struct sbs_info *chip = i2c_get_clientdata(client);
@@ -179,6 +193,74 @@ static int sbs_read_word_data(struct i2c_client *client, u8 address)
 	return le16_to_cpu(ret);
 }
 
+static int sbs_read_string_data(struct i2c_client *client, u8 address,
+				char *values)
+{
+	struct sbs_info *chip = i2c_get_clientdata(client);
+	s32 ret = 0, block_length = 0;
+	int retries_length = 1, retries_block = 1;
+	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
+
+	if (chip->pdata) {
+		retries_length = max(chip->pdata->i2c_retry_count + 1, 1);
+		retries_block = max(chip->pdata->i2c_retry_count + 1, 1);
+	}
+
+	/* Adapter needs to support these two functions */
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_I2C_BLOCK)){
+		return -ENODEV;
+	}
+
+	/* Get the length of block data */
+	while (retries_length > 0) {
+		ret = i2c_smbus_read_byte_data(client, address);
+		if (ret >= 0)
+			break;
+		retries_length--;
+	}
+
+	if (ret < 0) {
+		dev_dbg(&client->dev,
+			"%s: i2c read at address 0x%x failed\n",
+			__func__, address);
+		return ret;
+	}
+
+	/* block_length does not include NULL terminator */
+	block_length = ret;
+	if (block_length > I2C_SMBUS_BLOCK_MAX) {
+		dev_err(&client->dev,
+			"%s: Returned block_length is longer than 0x%x\n",
+			__func__, I2C_SMBUS_BLOCK_MAX);
+		return -EINVAL;
+	}
+
+	/* Get the block data */
+	while (retries_block > 0) {
+		ret = i2c_smbus_read_i2c_block_data(
+				client, address,
+				block_length + 1, block_buffer);
+		if (ret >= 0)
+			break;
+		retries_block--;
+	}
+
+	if (ret < 0) {
+		dev_dbg(&client->dev,
+			"%s: i2c read at address 0x%x failed\n",
+			__func__, address);
+		return ret;
+	}
+
+	/* block_buffer[0] == block_length */
+	memcpy(values, block_buffer + 1, block_length);
+	values[block_length] = '\0';
+
+	return le16_to_cpu(ret);
+}
+
 static int sbs_write_word_data(struct i2c_client *client, u8 address,
 	u16 value)
 {
@@ -318,6 +400,19 @@ static int sbs_get_battery_property(struct i2c_client *client,
 	return 0;
 }
 
+static int sbs_get_battery_string_property(struct i2c_client *client,
+	int reg_offset, enum power_supply_property psp, char *val)
+{
+	s32 ret;
+
+	ret = sbs_read_string_data(client, sbs_data[reg_offset].addr, val);
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static void  sbs_unit_adjustment(struct i2c_client *client,
 	enum power_supply_property psp, union power_supply_propval *val)
 {
@@ -505,6 +600,26 @@ static int sbs_get_property(struct power_supply *psy,
 		ret = sbs_get_battery_property(client, ret, psp, val);
 		break;
 
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		ret = sbs_get_property_index(client, psp);
+		if (ret < 0)
+			break;
+
+		ret = sbs_get_battery_string_property(client, ret, psp,
+						      model_name);
+		val->strval = model_name;
+		break;
+
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		ret = sbs_get_property_index(client, psp);
+		if (ret < 0)
+			break;
+
+		ret = sbs_get_battery_string_property(client, ret, psp,
+						      manufacturer);
+		val->strval = manufacturer;
+		break;
+
 	default:
 		dev_err(&client->dev,
 			"%s: INVALID property\n", __func__);
-- 
2.0.0.rc2
