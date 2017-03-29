From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v12.1 6/9] power: bq27xxx_battery: Add chip data memory read/write support
Date: Wed, 29 Mar 2017 13:48:07 -0700
Message-ID: <20170329204810.5427-3-liam@networkimprov.net>
References: <20170329204810.5427-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36731 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932827AbdC2Usj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2017 16:48:39 -0400
Received: by mail-pg0-f65.google.com with SMTP id 81so4627959pgh.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2017 13:48:38 -0700 (PDT)
In-Reply-To: <20170329204810.5427-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org
Cc: Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Add the following to enable read/write of chip data memory (DM) RAM/NVM/flash:
  bq27xxx_battery_seal()
  bq27xxx_battery_unseal()
  bq27xxx_battery_set_cfgupdate()
  bq27xxx_battery_read_dm_block()
  bq27xxx_battery_update_dm_block()
  bq27xxx_battery_write_dm_block()
  bq27xxx_battery_checksum_dm_block()

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c | 350 +++++++++++++++++++++++++++++++++
 include/linux/power/bq27xxx_battery.h  |   2 +
 2 files changed, 352 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 5b6c1b2..3daed9d 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -65,6 +65,7 @@
 #define BQ27XXX_FLAG_DSC	BIT(0)
 #define BQ27XXX_FLAG_SOCF	BIT(1) /* State-of-Charge threshold final */
 #define BQ27XXX_FLAG_SOC1	BIT(2) /* State-of-Charge threshold 1 */
+#define BQ27XXX_FLAG_CFGUP	BIT(4)
 #define BQ27XXX_FLAG_FC		BIT(9)
 #define BQ27XXX_FLAG_OTD	BIT(14)
 #define BQ27XXX_FLAG_OTC	BIT(15)
@@ -78,6 +79,12 @@
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
@@ -108,6 +115,11 @@ enum bq27xxx_reg_index {
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
 
@@ -131,6 +143,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
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
@@ -150,6 +167,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
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
@@ -169,6 +191,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_CTRL] = 0x61,
+		[BQ27XXX_DM_CLASS] = 0x3e,
+		[BQ27XXX_DM_BLOCK] = 0x3f,
+		[BQ27XXX_DM_DATA] = 0x40,
+		[BQ27XXX_DM_CKSUM] = 0x60,
 	},
 	[BQ2751X] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -188,6 +215,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x20,
 		[BQ27XXX_REG_DCAP] = 0x2e,
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_CTRL] = 0x61,
+		[BQ27XXX_DM_CLASS] = 0x3e,
+		[BQ27XXX_DM_BLOCK] = 0x3f,
+		[BQ27XXX_DM_DATA] = 0x40,
+		[BQ27XXX_DM_CKSUM] = 0x60,
 	},
 	[BQ27500] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -207,6 +239,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x24,
+		[BQ27XXX_DM_CTRL] = 0x61,
+		[BQ27XXX_DM_CLASS] = 0x3e,
+		[BQ27XXX_DM_BLOCK] = 0x3f,
+		[BQ27XXX_DM_DATA] = 0x40,
+		[BQ27XXX_DM_CKSUM] = 0x60,
 	},
 	[BQ27510G1] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -226,6 +263,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x24,
+		[BQ27XXX_DM_CTRL] = 0x61,
+		[BQ27XXX_DM_CLASS] = 0x3e,
+		[BQ27XXX_DM_BLOCK] = 0x3f,
+		[BQ27XXX_DM_DATA] = 0x40,
+		[BQ27XXX_DM_CKSUM] = 0x60,
 	},
 	[BQ27510G2] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -245,6 +287,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x24,
+		[BQ27XXX_DM_CTRL] = 0x61,
+		[BQ27XXX_DM_CLASS] = 0x3e,
+		[BQ27XXX_DM_BLOCK] = 0x3f,
+		[BQ27XXX_DM_DATA] = 0x40,
+		[BQ27XXX_DM_CKSUM] = 0x60,
 	},
 	[BQ27510G3] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -264,6 +311,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x20,
 		[BQ27XXX_REG_DCAP] = 0x2e,
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_CTRL] = 0x61,
+		[BQ27XXX_DM_CLASS] = 0x3e,
+		[BQ27XXX_DM_BLOCK] = 0x3f,
+		[BQ27XXX_DM_DATA] = 0x40,
+		[BQ27XXX_DM_CKSUM] = 0x60,
 	},
 	[BQ27520G1] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -283,6 +335,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x24,
+		[BQ27XXX_DM_CTRL] = 0x61,
+		[BQ27XXX_DM_CLASS] = 0x3e,
+		[BQ27XXX_DM_BLOCK] = 0x3f,
+		[BQ27XXX_DM_DATA] = 0x40,
+		[BQ27XXX_DM_CKSUM] = 0x60,
 	},
 	[BQ27520G2] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -302,6 +359,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x24,
+		[BQ27XXX_DM_CTRL] = 0x61,
+		[BQ27XXX_DM_CLASS] = 0x3e,
+		[BQ27XXX_DM_BLOCK] = 0x3f,
+		[BQ27XXX_DM_DATA] = 0x40,
+		[BQ27XXX_DM_CKSUM] = 0x60,
 	},
 	[BQ27520G3] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -321,6 +383,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x24,
+		[BQ27XXX_DM_CTRL] = 0x61,
+		[BQ27XXX_DM_CLASS] = 0x3e,
+		[BQ27XXX_DM_BLOCK] = 0x3f,
+		[BQ27XXX_DM_DATA] = 0x40,
+		[BQ27XXX_DM_CKSUM] = 0x60,
 	},
 	[BQ27520G4] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -340,6 +407,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x20,
 		[BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_CTRL] = 0x61,
+		[BQ27XXX_DM_CLASS] = 0x3e,
+		[BQ27XXX_DM_BLOCK] = 0x3f,
+		[BQ27XXX_DM_DATA] = 0x40,
+		[BQ27XXX_DM_CKSUM] = 0x60,
 	},
 	[BQ27530] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -359,6 +431,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_AP] = 0x24,
+		[BQ27XXX_DM_CTRL] = 0x61,
+		[BQ27XXX_DM_CLASS] = 0x3e,
+		[BQ27XXX_DM_BLOCK] = 0x3f,
+		[BQ27XXX_DM_DATA] = 0x40,
+		[BQ27XXX_DM_CKSUM] = 0x60,
 	},
 	[BQ27541] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -378,6 +455,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x24,
+		[BQ27XXX_DM_CTRL] = 0x61,
+		[BQ27XXX_DM_CLASS] = 0x3e,
+		[BQ27XXX_DM_BLOCK] = 0x3f,
+		[BQ27XXX_DM_DATA] = 0x40,
+		[BQ27XXX_DM_CKSUM] = 0x60,
 	},
 	[BQ27545] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -397,6 +479,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
 		[BQ27XXX_REG_AP] = 0x24,
+		[BQ27XXX_DM_CTRL] = 0x61,
+		[BQ27XXX_DM_CLASS] = 0x3e,
+		[BQ27XXX_DM_BLOCK] = 0x3f,
+		[BQ27XXX_DM_DATA] = 0x40,
+		[BQ27XXX_DM_CKSUM] = 0x60,
 	},
 	[BQ27421] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -416,6 +503,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x1c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x18,
+		[BQ27XXX_DM_CTRL] = 0x61,
+		[BQ27XXX_DM_CLASS] = 0x3e,
+		[BQ27XXX_DM_BLOCK] = 0x3f,
+		[BQ27XXX_DM_DATA] = 0x40,
+		[BQ27XXX_DM_CKSUM] = 0x60,
 	},
 };
 
@@ -757,6 +849,52 @@ static struct {
 static DEFINE_MUTEX(bq27xxx_list_lock);
 static LIST_HEAD(bq27xxx_battery_devices);
 
+#define BQ27XXX_MSLEEP(i) usleep_range((i)*1000, (i)*1000+500)
+
+#define BQ27XXX_DM_SZ	32
+
+struct bq27xxx_dm_reg {
+	u8 subclass_id;
+	u8 offset;
+	u8 bytes;
+	u16 min, max;
+};
+
+struct bq27xxx_dm_buf {
+	u8 class;
+	u8 block;
+	u8 data[BQ27XXX_DM_SZ];
+	bool full, updt;
+};
+
+#define BQ27XXX_DM_BUF(di, i) { \
+	.class = (di)->dm_regs[i].subclass_id, \
+	.block = (di)->dm_regs[i].offset / BQ27XXX_DM_SZ, \
+}
+
+static inline u16* bq27xxx_dm_reg_ptr(struct bq27xxx_dm_buf *buf,
+				      struct bq27xxx_dm_reg *reg)
+{
+	if (buf->class == reg->subclass_id &&
+	    buf->block == reg->offset / BQ27XXX_DM_SZ)
+		return (u16*) (buf->data + reg->offset % BQ27XXX_DM_SZ);
+
+	return NULL;
+}
+
+enum bq27xxx_dm_reg_id {
+	BQ27XXX_DM_DESIGN_CAPACITY = 0,
+	BQ27XXX_DM_DESIGN_ENERGY,
+	BQ27XXX_DM_TERMINATE_VOLTAGE,
+};
+
+static const char* bq27xxx_dm_reg_name[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY] = "design-capacity",
+	[BQ27XXX_DM_DESIGN_ENERGY] = "design-energy",
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = "terminate-voltage",
+};
+
+
 static int poll_interval_param_set(const char *val, const struct kernel_param *kp)
 {
 	struct bq27xxx_device_info *di;
@@ -851,6 +989,218 @@ static inline int bq27xxx_write_block(struct bq27xxx_device_info *di, int reg_in
 	return ret;
 }
 
+static int bq27xxx_battery_seal(struct bq27xxx_device_info *di)
+{
+	int ret;
+
+	ret = bq27xxx_write(di, BQ27XXX_REG_CTRL, BQ27XXX_SEALED, false);
+	if (ret >= 0)
+		return 0;
+
+	dev_err(di->dev, "bus error on seal: %d\n", ret);
+	return ret;
+}
+
+static int bq27xxx_battery_unseal(struct bq27xxx_device_info *di)
+{
+	int ret;
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
+	buf->full = true;
+	buf->updt = false;
+
+	return 0;
+
+out:
+	dev_err(di->dev, "bus error reading chip memory: %d\n", ret);
+	return ret;
+}
+
+static void bq27xxx_battery_update_dm_block(struct bq27xxx_device_info *di,
+					    struct bq27xxx_dm_buf *buf,
+					    enum bq27xxx_dm_reg_id reg_id,
+					    unsigned int val)
+{
+	struct bq27xxx_dm_reg *reg = &di->dm_regs[reg_id];
+	const char* str = bq27xxx_dm_reg_name[reg_id];
+	u16 *prev = bq27xxx_dm_reg_ptr(buf, reg);
+
+	if (prev == NULL) {
+		dev_warn(di->dev, "buffer does not match %s dm spec\n", str);
+		return;
+	}
+
+	if (reg->bytes != 2) {
+		dev_warn(di->dev, "%s dm spec has unsupported byte size\n", str);
+		return;
+	}
+
+	if (!buf->full)
+		return;
+
+	if (be16_to_cpup(prev) == val) {
+		dev_info(di->dev, "%s has %u\n", str, val);
+		return;
+	}
+
+	dev_info(di->dev, "update %s to %u\n", str, val);
+
+	*prev = cpu_to_be16(val);
+	buf->updt = true;
+}
+
+static int bq27xxx_battery_set_cfgupdate(struct bq27xxx_device_info *di, u16 flag)
+{
+	const int limit = 100;
+	int ret, try = limit;
+
+	ret = bq27xxx_write(di, BQ27XXX_REG_CTRL,
+			    flag ? BQ27XXX_SET_CFGUPDATE : BQ27XXX_SOFT_RESET,
+			    false);
+	if (ret < 0)
+		goto out;
+
+	do {
+		BQ27XXX_MSLEEP(25);
+		ret = di->bus.read(di, di->regs[BQ27XXX_REG_FLAGS], false);
+		if (ret < 0)
+			goto out;
+	} while ((ret & BQ27XXX_FLAG_CFGUP) != flag && --try);
+
+	if (!try) {
+		dev_err(di->dev, "timed out waiting for cfgupdate flag %d\n", !!flag);
+		return -EINVAL;
+	}
+
+	if (limit-try > 3)
+		dev_warn(di->dev, "cfgupdate %d, retries %d\n", !!flag, limit-try);
+
+	return 0;
+
+out:
+	dev_err(di->dev, "bus error on %s: %d\n", flag ? "set_cfgupdate" : "soft_reset", ret);
+	return ret;
+}
+
+static int bq27xxx_battery_write_dm_block(struct bq27xxx_device_info *di,
+					  struct bq27xxx_dm_buf *buf)
+{
+	bool cfgup = di->chip == BQ27421; /* assume group supports cfgupdate */
+	int ret;
+
+	if (!buf->updt)
+		return 0;
+
+	if (cfgup) {
+		ret = bq27xxx_battery_set_cfgupdate(di, BQ27XXX_FLAG_CFGUP);
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
+	 * the chip. See TI bqtool for what not to do:
+	 * http://git.ti.com/bms-linux/bqtool/blobs/master/gauge.c#line328
+	 */
+
+	if (cfgup) {
+		BQ27XXX_MSLEEP(1);
+		ret = bq27xxx_battery_set_cfgupdate(di, 0);
+		if (ret < 0)
+			return ret;
+	} else {
+		BQ27XXX_MSLEEP(100); /* flash DM updates in <100ms */
+	}
+
+	buf->updt = false;
+
+	return 0;
+
+out:
+	if (cfgup)
+		bq27xxx_battery_set_cfgupdate(di, 0);
+
+	dev_err(di->dev, "bus error writing chip memory: %d\n", ret);
+	return ret;
+}
+
 /*
  * Return the battery State-of-Charge
  * Or < 0 if something fails.
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index c3369fa..227eb08 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -64,6 +64,8 @@ struct bq27xxx_device_info {
 	int id;
 	enum bq27xxx_chip chip;
 	const char *name;
+	struct bq27xxx_dm_reg *dm_regs;
+	u32 unseal_key;
 	struct bq27xxx_access_methods bus;
 	struct bq27xxx_reg_cache cache;
 	int charge_design_full;
-- 
2.9.3
