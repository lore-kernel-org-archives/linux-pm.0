From: Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH v4 6/8] power: bq27xxx_battery: add i2c bulk read/write functions
Date: Sat, 21 Jan 2017 23:14:02 -0800
Message-ID: <20170122071404.9654-7-matt@ranostay.consulting>
References: <20170122071404.9654-1-matt@ranostay.consulting>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34075 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751080AbdAVHOK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jan 2017 02:14:10 -0500
Received: by mail-pg0-f43.google.com with SMTP id 14so35621521pgg.1
        for <linux-pm@vger.kernel.org>; Sat, 21 Jan 2017 23:14:10 -0800 (PST)
In-Reply-To: <20170122071404.9654-1-matt@ranostay.consulting>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: sre@kernel.org, tony@atomide.com, Matt Ranostay <matt@ranostay.consulting>

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
 drivers/power/supply/bq27xxx_battery_i2c.c | 62 ++++++++++++++++++++++++++++++
 include/linux/power/bq27xxx_battery.h      |  4 ++
 2 files changed, 66 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 2ea2d0b06948..feeb04ed88c8 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -68,6 +68,64 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
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
+	return i2c_transfer(client->adapter, &msg, 1) == 1 ? 0 : -EINVAL;
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
+	return i2c_smbus_read_i2c_block_data(client, reg, len, data);
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
+	return i2c_transfer(client->adapter, &msg, 1) == 1 ? 0 : -EINVAL;
+}
+
 static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 				     const struct i2c_device_id *id)
 {
@@ -95,7 +153,11 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
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
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 3f265dbf11af..581402380d6e 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -41,6 +41,9 @@ struct bq27xxx_platform_data {
 struct bq27xxx_device_info;
 struct bq27xxx_access_methods {
 	int (*read)(struct bq27xxx_device_info *di, u8 reg, bool single);
+	int (*write)(struct bq27xxx_device_info *di, u8 reg, int value, bool single);
+	int (*read_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);
+	int (*write_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);
 };
 
 struct bq27xxx_reg_cache {
@@ -71,6 +74,7 @@ struct bq27xxx_device_info {
 	struct list_head list;
 	struct mutex lock;
 	u8 *regs;
+	u8 buffer[32];
 };
 
 void bq27xxx_battery_update(struct bq27xxx_device_info *di);
-- 
2.10.2

