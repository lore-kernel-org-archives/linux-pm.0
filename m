From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v14 06/11] power: supply: bq27xxx: Add bulk transfer bus methods
Date: Wed,  7 Jun 2017 11:37:54 -0700
Message-ID: <20170607183759.20261-7-liam@networkimprov.net>
References: <20170607183759.20261-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35937 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752319AbdFGSil (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 14:38:41 -0400
Received: by mail-pf0-f193.google.com with SMTP id y7so2403914pfd.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2017 11:38:41 -0700 (PDT)
In-Reply-To: <20170607183759.20261-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org
Cc: Enric Balletbo <enric.balletbo@collabora.com>, Paul Kocialkowski <contact@paulk.fr>, Quentin Schulz <quentin.schulz@free-electrons.com>, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

From: Matt Ranostay <matt@ranostay.consulting>

Declare bus.write/read_bulk/write_bulk().
Add I2C write/read_bulk/write_bulk() to implement the above.
Add bq27xxx_write/read_block/write_block() helpers to call the above.

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
Acked-by: "Andrew F. Davis" <afd@ti.com>
---
 drivers/power/supply/bq27xxx_battery.c     | 67 +++++++++++++++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c | 82 +++++++++++++++++++++++++++++-
 include/linux/power/bq27xxx_battery.h      |  3 ++
 3 files changed, 149 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 398801a2..a11dfad7 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -794,11 +794,74 @@ MODULE_PARM_DESC(poll_interval,
 static inline int bq27xxx_read(struct bq27xxx_device_info *di, int reg_index,
 			       bool single)
 {
-	/* Reports EINVAL for invalid/missing registers */
+	int ret;
+
 	if (!di || di->regs[reg_index] == INVALID_REG_ADDR)
 		return -EINVAL;
 
-	return di->bus.read(di, di->regs[reg_index], single);
+	ret = di->bus.read(di, di->regs[reg_index], single);
+	if (ret < 0)
+		dev_dbg(di->dev, "failed to read register 0x%02x (index %d)\n",
+			di->regs[reg_index], reg_index);
+
+	return ret;
+}
+
+static inline int bq27xxx_write(struct bq27xxx_device_info *di, int reg_index,
+				u16 value, bool single)
+{
+	int ret;
+
+	if (!di || di->regs[reg_index] == INVALID_REG_ADDR)
+		return -EINVAL;
+
+	if (!di->bus.write)
+		return -EPERM;
+
+	ret = di->bus.write(di, di->regs[reg_index], value, single);
+	if (ret < 0)
+		dev_dbg(di->dev, "failed to write register 0x%02x (index %d)\n",
+			di->regs[reg_index], reg_index);
+
+	return ret;
+}
+
+static inline int bq27xxx_read_block(struct bq27xxx_device_info *di, int reg_index,
+				     u8 *data, int len)
+{
+	int ret;
+
+	if (!di || di->regs[reg_index] == INVALID_REG_ADDR)
+		return -EINVAL;
+
+	if (!di->bus.read_bulk)
+		return -EPERM;
+
+	ret = di->bus.read_bulk(di, di->regs[reg_index], data, len);
+	if (ret < 0)
+		dev_dbg(di->dev, "failed to read_bulk register 0x%02x (index %d)\n",
+			di->regs[reg_index], reg_index);
+
+	return ret;
+}
+
+static inline int bq27xxx_write_block(struct bq27xxx_device_info *di, int reg_index,
+				      u8 *data, int len)
+{
+	int ret;
+
+	if (!di || di->regs[reg_index] == INVALID_REG_ADDR)
+		return -EINVAL;
+
+	if (!di->bus.write_bulk)
+		return -EPERM;
+
+	ret = di->bus.write_bulk(di, di->regs[reg_index], data, len);
+	if (ret < 0)
+		dev_dbg(di->dev, "failed to write_bulk register 0x%02x (index %d)\n",
+			di->regs[reg_index], reg_index);
+
+	return ret;
 }
 
 /*
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index c68fbc3f..a5972214 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -38,7 +38,7 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
 {
 	struct i2c_client *client = to_i2c_client(di->dev);
 	struct i2c_msg msg[2];
-	unsigned char data[2];
+	u8 data[2];
 	int ret;
 
 	if (!client->adapter)
@@ -68,6 +68,82 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
 	return ret;
 }
 
+static int bq27xxx_battery_i2c_write(struct bq27xxx_device_info *di, u8 reg,
+				     int value, bool single)
+{
+	struct i2c_client *client = to_i2c_client(di->dev);
+	struct i2c_msg msg;
+	u8 data[4];
+	int ret;
+
+	if (!client->adapter)
+		return -ENODEV;
+
+	data[0] = reg;
+	if (single) {
+		data[1] = (u8) value;
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
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret < 0)
+		return ret;
+	if (ret != 1)
+		return -EINVAL;
+	return 0;
+}
+
+static int bq27xxx_battery_i2c_bulk_read(struct bq27xxx_device_info *di, u8 reg,
+					 u8 *data, int len)
+{
+	struct i2c_client *client = to_i2c_client(di->dev);
+	int ret;
+
+	if (!client->adapter)
+		return -ENODEV;
+
+	ret = i2c_smbus_read_i2c_block_data(client, reg, len, data);
+	if (ret < 0)
+		return ret;
+	if (ret != len)
+		return -EINVAL;
+	return 0;
+}
+
+static int bq27xxx_battery_i2c_bulk_write(struct bq27xxx_device_info *di,
+					  u8 reg, u8 *data, int len)
+{
+	struct i2c_client *client = to_i2c_client(di->dev);
+	struct i2c_msg msg;
+	u8 buf[33];
+	int ret;
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
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	if (ret < 0)
+		return ret;
+	if (ret != 1)
+		return -EINVAL;
+	return 0;
+}
+
 static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 				     const struct i2c_device_id *id)
 {
@@ -95,7 +171,11 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
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
index b312bcef..c3369fa6 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -40,6 +40,9 @@ struct bq27xxx_platform_data {
 struct bq27xxx_device_info;
 struct bq27xxx_access_methods {
 	int (*read)(struct bq27xxx_device_info *di, u8 reg, bool single);
+	int (*write)(struct bq27xxx_device_info *di, u8 reg, int value, bool single);
+	int (*read_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);
+	int (*write_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);
 };
 
 struct bq27xxx_reg_cache {
-- 
2.13.0
