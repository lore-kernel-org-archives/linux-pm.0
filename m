From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v14 07/11] power: supply: bq27xxx: Add chip data memory read/write support
Date: Wed,  7 Jun 2017 11:37:55 -0700
Message-ID: <20170607183759.20261-8-liam@networkimprov.net>
References: <20170607183759.20261-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33907 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752277AbdFGSih (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 14:38:37 -0400
Received: by mail-pg0-f67.google.com with SMTP id v14so2163068pgn.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2017 11:38:37 -0700 (PDT)
In-Reply-To: <20170607183759.20261-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org
Cc: Enric Balletbo <enric.balletbo@collabora.com>, Paul Kocialkowski <contact@paulk.fr>, Quentin Schulz <quentin.schulz@free-electrons.com>, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Add these to enable read/write of chip data memory RAM/NVM/flash:
  bq27xxx_battery_seal()
  bq27xxx_battery_unseal()
  bq27xxx_battery_set_cfgupdate()
  bq27xxx_battery_soft_reset()
  bq27xxx_battery_read_dm_block()
  bq27xxx_battery_write_dm_block()
  bq27xxx_battery_checksum_dm_block()

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c | 265 +++++++++++++++++++++++++++++++++
 include/linux/power/bq27xxx_battery.h  |   1 +
 2 files changed, 266 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index a11dfad7..6a4ac14c 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2008 Eurotech S.p.A. <info@eurotech.it>
  * Copyright (C) 2010-2011 Lars-Peter Clausen <lars@metafoo.de>
  * Copyright (C) 2011 Pali Rohár <pali.rohar@gmail.com>
+ * Copyright (C) 2017 Liam Breck <kernel@networkimprov.net>
  *
  * Based on a previous work by Copyright (C) 2008 Texas Instruments, Inc.
  *
@@ -65,6 +66,7 @@
 #define BQ27XXX_FLAG_DSC	BIT(0)
 #define BQ27XXX_FLAG_SOCF	BIT(1) /* State-of-Charge threshold final */
 #define BQ27XXX_FLAG_SOC1	BIT(2) /* State-of-Charge threshold 1 */
+#define BQ27XXX_FLAG_CFGUP	BIT(4)
 #define BQ27XXX_FLAG_FC		BIT(9)
 #define BQ27XXX_FLAG_OTD	BIT(14)
 #define BQ27XXX_FLAG_OTC	BIT(15)
@@ -78,6 +80,12 @@
 #define BQ27000_FLAG_FC		BIT(5)
 #define BQ27000_FLAG_CHGS	BIT(7) /* Charge state flag */
 
+/* control register params */
+#define BQ27XXX_SEALED			0x20
+#define BQ27XXX_SET_CFGUPDATE		0x13
+#define BQ27XXX_SOFT_RESET		0x42
+#define BQ27XXX_RESET			0x41
+
 #define BQ27XXX_RS			(20) /* Resistor sense mOhm */
 #define BQ27XXX_POWER_CONSTANT		(29200) /* 29.2 µV^2 * 1000 */
 #define BQ27XXX_CURRENT_CONSTANT	(3570) /* 3.57 µV * 1000 */
@@ -108,9 +116,21 @@ enum bq27xxx_reg_index {
 	BQ27XXX_REG_SOC,	/* State-of-Charge */
 	BQ27XXX_REG_DCAP,	/* Design Capacity */
 	BQ27XXX_REG_AP,		/* Average Power */
+	BQ27XXX_DM_CTRL,	/* Block Data Control */
+	BQ27XXX_DM_CLASS,	/* Data Class */
+	BQ27XXX_DM_BLOCK,	/* Data Block */
+	BQ27XXX_DM_DATA,	/* Block Data */
+	BQ27XXX_DM_CKSUM,	/* Block Data Checksum */
 	BQ27XXX_REG_MAX,	/* sentinel */
 };
 
+#define BQ27XXX_DM_REG_ROWS \
+	[BQ27XXX_DM_CTRL] = 0x61,  \
+	[BQ27XXX_DM_CLASS] = 0x3e, \
+	[BQ27XXX_DM_BLOCK] = 0x3f, \
+	[BQ27XXX_DM_DATA] = 0x40,  \
+	[BQ27XXX_DM_CKSUM] = 0x60
+
 /* Register mappings */
 static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 	[BQ27000] = {
@@ -131,6 +151,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x0b,
 		[BQ27XXX_REG_DCAP] = 0x76,
 		[BQ27XXX_REG_AP] = 0x24,
+		[BQ27XXX_DM_CTRL] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_CLASS] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_BLOCK] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_DATA] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_CKSUM] = INVALID_REG_ADDR,
 	},
 	[BQ27010] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -150,6 +175,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x0b,
 		[BQ27XXX_REG_DCAP] = 0x76,
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_CTRL] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_CLASS] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_BLOCK] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_DATA] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_CKSUM] = INVALID_REG_ADDR,
 	},
 	[BQ2750X] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -169,6 +199,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
+		BQ27XXX_DM_REG_ROWS,
 	},
 	[BQ2751X] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -188,6 +219,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x20,
 		[BQ27XXX_REG_DCAP] = 0x2e,
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
+		BQ27XXX_DM_REG_ROWS,
 	},
 	[BQ27500] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -207,6 +239,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x24,
+		BQ27XXX_DM_REG_ROWS,
 	},
 	[BQ27510G1] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -226,6 +259,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x24,
+		BQ27XXX_DM_REG_ROWS,
 	},
 	[BQ27510G2] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -245,6 +279,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x24,
+		BQ27XXX_DM_REG_ROWS,
 	},
 	[BQ27510G3] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -264,6 +299,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x20,
 		[BQ27XXX_REG_DCAP] = 0x2e,
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
+		BQ27XXX_DM_REG_ROWS,
 	},
 	[BQ27520G1] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -283,6 +319,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x24,
+		BQ27XXX_DM_REG_ROWS,
 	},
 	[BQ27520G2] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -302,6 +339,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x24,
+		BQ27XXX_DM_REG_ROWS,
 	},
 	[BQ27520G3] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -321,6 +359,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x24,
+		BQ27XXX_DM_REG_ROWS,
 	},
 	[BQ27520G4] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -340,6 +379,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x20,
 		[BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
+		BQ27XXX_DM_REG_ROWS,
 	},
 	[BQ27530] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -359,6 +399,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_AP] = 0x24,
+		BQ27XXX_DM_REG_ROWS,
 	},
 	[BQ27541] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -378,6 +419,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x24,
+		BQ27XXX_DM_REG_ROWS,
 	},
 	[BQ27545] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -397,6 +439,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_AP] = 0x24,
+		BQ27XXX_DM_REG_ROWS,
 	},
 	[BQ27421] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -416,6 +459,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x1c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x18,
+		BQ27XXX_DM_REG_ROWS,
 	},
 };
 
@@ -757,6 +801,28 @@ static struct {
 static DEFINE_MUTEX(bq27xxx_list_lock);
 static LIST_HEAD(bq27xxx_battery_devices);
 
+#define BQ27XXX_MSLEEP(i) usleep_range((i)*1000, (i)*1000+500)
+
+#define BQ27XXX_DM_SZ	32
+
+/**
+ * struct bq27xxx_dm_buf - chip data memory buffer
+ * @class: data memory subclass_id
+ * @block: data memory block number
+ * @data: data from/for the block
+ * @has_data: true if data has been filled by read
+ * @dirty: true if data has changed since last read/write
+ *
+ * Encapsulates info required to manage chip data memory blocks.
+ */
+struct bq27xxx_dm_buf {
+	u8 class;
+	u8 block;
+	u8 data[BQ27XXX_DM_SZ];
+	bool has_data, dirty;
+};
+
+
 static int poll_interval_param_set(const char *val, const struct kernel_param *kp)
 {
 	struct bq27xxx_device_info *di;
@@ -864,6 +930,205 @@ static inline int bq27xxx_write_block(struct bq27xxx_device_info *di, int reg_in
 	return ret;
 }
 
+static int bq27xxx_battery_seal(struct bq27xxx_device_info *di)
+{
+	int ret;
+
+	ret = bq27xxx_write(di, BQ27XXX_REG_CTRL, BQ27XXX_SEALED, false);
+	if (ret < 0) {
+		dev_err(di->dev, "bus error on seal: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int bq27xxx_battery_unseal(struct bq27xxx_device_info *di)
+{
+	int ret;
+
+	if (di->unseal_key == 0) {
+		dev_err(di->dev, "unseal failed due to missing key\n");
+		return -EINVAL;
+	}
+
+	ret = bq27xxx_write(di, BQ27XXX_REG_CTRL, (u16)(di->unseal_key >> 16), false);
+	if (ret < 0)
+		goto out;
+
+	ret = bq27xxx_write(di, BQ27XXX_REG_CTRL, (u16)di->unseal_key, false);
+	if (ret < 0)
+		goto out;
+
+	return 0;
+
+out:
+	dev_err(di->dev, "bus error on unseal: %d\n", ret);
+	return ret;
+}
+
+static u8 bq27xxx_battery_checksum_dm_block(struct bq27xxx_dm_buf *buf)
+{
+	u16 sum = 0;
+	int i;
+
+	for (i = 0; i < BQ27XXX_DM_SZ; i++)
+		sum += buf->data[i];
+	sum &= 0xff;
+
+	return 0xff - sum;
+}
+
+static int bq27xxx_battery_read_dm_block(struct bq27xxx_device_info *di,
+					 struct bq27xxx_dm_buf *buf)
+{
+	int ret;
+
+	buf->has_data = false;
+
+	ret = bq27xxx_write(di, BQ27XXX_DM_CLASS, buf->class, true);
+	if (ret < 0)
+		goto out;
+
+	ret = bq27xxx_write(di, BQ27XXX_DM_BLOCK, buf->block, true);
+	if (ret < 0)
+		goto out;
+
+	BQ27XXX_MSLEEP(1);
+
+	ret = bq27xxx_read_block(di, BQ27XXX_DM_DATA, buf->data, BQ27XXX_DM_SZ);
+	if (ret < 0)
+		goto out;
+
+	ret = bq27xxx_read(di, BQ27XXX_DM_CKSUM, true);
+	if (ret < 0)
+		goto out;
+
+	if ((u8)ret != bq27xxx_battery_checksum_dm_block(buf)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	buf->has_data = true;
+	buf->dirty = false;
+
+	return 0;
+
+out:
+	dev_err(di->dev, "bus error reading chip memory: %d\n", ret);
+	return ret;
+}
+
+static int bq27xxx_battery_cfgupdate_priv(struct bq27xxx_device_info *di, bool active)
+{
+	const int limit = 100;
+	u16 cmd = active ? BQ27XXX_SET_CFGUPDATE : BQ27XXX_SOFT_RESET;
+	int ret, try = limit;
+
+	ret = bq27xxx_write(di, BQ27XXX_REG_CTRL, cmd, false);
+	if (ret < 0)
+		return ret;
+
+	do {
+		BQ27XXX_MSLEEP(25);
+		ret = bq27xxx_read(di, BQ27XXX_REG_FLAGS, false);
+		if (ret < 0)
+			return ret;
+	} while (!!(ret & BQ27XXX_FLAG_CFGUP) != active && --try);
+
+	if (!try) {
+		dev_err(di->dev, "timed out waiting for cfgupdate flag %d\n", active);
+		return -EINVAL;
+	}
+
+	if (limit - try > 3)
+		dev_warn(di->dev, "cfgupdate %d, retries %d\n", active, limit - try);
+
+	return 0;
+}
+
+static inline int bq27xxx_battery_set_cfgupdate(struct bq27xxx_device_info *di)
+{
+	int ret = bq27xxx_battery_cfgupdate_priv(di, true);
+	if (ret < 0 && ret != -EINVAL)
+		dev_err(di->dev, "bus error on set_cfgupdate: %d\n", ret);
+
+	return ret;
+}
+
+static inline int bq27xxx_battery_soft_reset(struct bq27xxx_device_info *di)
+{
+	int ret = bq27xxx_battery_cfgupdate_priv(di, false);
+	if (ret < 0 && ret != -EINVAL)
+		dev_err(di->dev, "bus error on soft_reset: %d\n", ret);
+
+	return ret;
+}
+
+static int bq27xxx_battery_write_dm_block(struct bq27xxx_device_info *di,
+					  struct bq27xxx_dm_buf *buf)
+{
+	bool cfgup = di->chip == BQ27421; /* assume related chips need cfgupdate */
+	int ret;
+
+	if (!buf->dirty)
+		return 0;
+
+	if (cfgup) {
+		ret = bq27xxx_battery_set_cfgupdate(di);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = bq27xxx_write(di, BQ27XXX_DM_CTRL, 0, true);
+	if (ret < 0)
+		goto out;
+
+	ret = bq27xxx_write(di, BQ27XXX_DM_CLASS, buf->class, true);
+	if (ret < 0)
+		goto out;
+
+	ret = bq27xxx_write(di, BQ27XXX_DM_BLOCK, buf->block, true);
+	if (ret < 0)
+		goto out;
+
+	BQ27XXX_MSLEEP(1);
+
+	ret = bq27xxx_write_block(di, BQ27XXX_DM_DATA, buf->data, BQ27XXX_DM_SZ);
+	if (ret < 0)
+		goto out;
+
+	ret = bq27xxx_write(di, BQ27XXX_DM_CKSUM,
+			    bq27xxx_battery_checksum_dm_block(buf), true);
+	if (ret < 0)
+		goto out;
+
+	/* DO NOT read BQ27XXX_DM_CKSUM here to verify it! That may cause NVM
+	 * corruption on the '425 chip (and perhaps others), which can damage
+	 * the chip.
+	 */
+
+	if (cfgup) {
+		BQ27XXX_MSLEEP(1);
+		ret = bq27xxx_battery_soft_reset(di);
+		if (ret < 0)
+			return ret;
+	} else {
+		BQ27XXX_MSLEEP(100); /* flash DM updates in <100ms */
+	}
+
+	buf->dirty = false;
+
+	return 0;
+
+out:
+	if (cfgup)
+		bq27xxx_battery_soft_reset(di);
+
+	dev_err(di->dev, "bus error writing chip memory: %d\n", ret);
+	return ret;
+}
+
 /*
  * Return the battery State-of-Charge
  * Or < 0 if something fails.
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index c3369fa6..b1defb86 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -64,6 +64,7 @@ struct bq27xxx_device_info {
 	int id;
 	enum bq27xxx_chip chip;
 	const char *name;
+	u32 unseal_key;
 	struct bq27xxx_access_methods bus;
 	struct bq27xxx_reg_cache cache;
 	int charge_design_full;
-- 
2.13.0
