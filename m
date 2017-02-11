From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v6 8/8] power: bq27xxx_battery_i2c: Add I2C bulk read/write functions
Date: Fri, 10 Feb 2017 18:43:40 -0800
Message-ID: <20170211024340.19491-9-liam@networkimprov.net>
References: <20170211024340.19491-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36062 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbdBKCo2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Feb 2017 21:44:28 -0500
Received: by mail-pg0-f67.google.com with SMTP id 75so4336767pgf.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2017 18:44:27 -0800 (PST)
In-Reply-To: <20170211024340.19491-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F . Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

From: Matt Ranostay <matt@ranostay.consulting>

write(), read_bulk(), write_bulk() are required by bq27xxx_battery
devicetree code.

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery_i2c.c | 65 ++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index d7da535..c1638ad 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -68,6 +68,67 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
 	return ret;
 }
 
+static int bq27xxx_battery_i2c_write(struct bq27xxx_device_info *di, u8 reg,
+				     int value, bool single)
+{
+	struct i2c_client *client = to_i2c_client(di->dev);
+	struct i2c_msg msg;
+	unsigned char data[4];
+
+	if (!client->adapter)
+		return -ENODEV;
+
+	data[0] = reg;
+	if (single) {
+		data[1] = (unsigned char) value;
+		msg.len = 2;
+	} else {
+		put_unaligned_le16(value, &data[1]);
+		msg.len = 3;
+	}
+
+	msg.buf = data;
+	msg.addr = client->addr;
+	msg.flags = 0;
+
+	return i2c_transfer(client->adapter, &msg, 1) == 1 ?
+		0 : -EINVAL;
+}
+
+static int bq27xxx_battery_i2c_bulk_read(struct bq27xxx_device_info *di, u8 reg,
+					 u8 *data, int len)
+{
+	struct i2c_client *client = to_i2c_client(di->dev);
+
+	if (!client->adapter)
+		return -ENODEV;
+
+	return i2c_smbus_read_i2c_block_data(client, reg, len, data) == len ?
+		0 : -EINVAL;
+}
+
+static int bq27xxx_battery_i2c_bulk_write(struct bq27xxx_device_info *di,
+					  u8 reg, u8 *data, int len)
+{
+	struct i2c_client *client = to_i2c_client(di->dev);
+	struct i2c_msg msg;
+	u8 buf[33];
+
+	if (!client->adapter)
+		return -ENODEV;
+
+	buf[0] = reg;
+	memcpy(&buf[1], data, len);
+
+	msg.buf = buf;
+	msg.addr = client->addr;
+	msg.flags = 0;
+	msg.len = len + 1;
+
+	return i2c_transfer(client->adapter, &msg, 1) == 1 ?
+		0 : -EINVAL;
+}
+
 static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 				     const struct i2c_device_id *id)
 {
@@ -95,7 +156,11 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 	di->dev = &client->dev;
 	di->chip = id->driver_data;
 	di->name = name;
+
 	di->bus.read = bq27xxx_battery_i2c_read;
+	di->bus.write = bq27xxx_battery_i2c_write;
+	di->bus.read_bulk = bq27xxx_battery_i2c_bulk_read;
+	di->bus.write_bulk = bq27xxx_battery_i2c_bulk_write;
 
 	ret = bq27xxx_battery_setup(di);
 	if (ret)
-- 
2.9.3

