From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v8 7/9] power: bq27xxx_battery: Add power_supply_battery_info support
Date: Sun, 26 Feb 2017 23:11:15 -0800
Message-ID: <20170227071117.18934-8-liam@networkimprov.net>
References: <20170227071117.18934-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32861 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751636AbdB0HNp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Feb 2017 02:13:45 -0500
Received: by mail-pf0-f196.google.com with SMTP id p185so3779658pfb.0
        for <linux-pm@vger.kernel.org>; Sun, 26 Feb 2017 23:12:15 -0800 (PST)
In-Reply-To: <20170227071117.18934-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Previously there was no way to configure chip registers in the event that the
defaults didn't match the battery in question.

BQ27xxx driver now calls power_supply_get_battery_info, checks the inputs,
and writes battery data to chip RAM or non-volatile memory.

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c | 458 ++++++++++++++++++++++++++++++++-
 1 file changed, 456 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 7475a5f..41d4ce7 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -51,7 +51,7 @@
 
 #include <linux/power/bq27xxx_battery.h>
 
-#define DRIVER_VERSION		"1.2.0"
+#define DRIVER_VERSION		"1.3.0"
 
 #define BQ27XXX_MANUFACTURER	"Texas Instruments"
 
@@ -59,6 +59,7 @@
 #define BQ27XXX_FLAG_DSC	BIT(0)
 #define BQ27XXX_FLAG_SOCF	BIT(1) /* State-of-Charge threshold final */
 #define BQ27XXX_FLAG_SOC1	BIT(2) /* State-of-Charge threshold 1 */
+#define BQ27XXX_FLAG_CFGUP	BIT(5)
 #define BQ27XXX_FLAG_FC		BIT(9)
 #define BQ27XXX_FLAG_OTD	BIT(14)
 #define BQ27XXX_FLAG_OTC	BIT(15)
@@ -72,6 +73,11 @@
 #define BQ27000_FLAG_FC		BIT(5)
 #define BQ27000_FLAG_CHGS	BIT(7) /* Charge state flag */
 
+/* control register params */
+#define BQ27XXX_SEALED			0x20
+#define BQ27XXX_SET_CFGUPDATE		0x13
+#define BQ27XXX_SOFT_RESET		0x42
+
 #define BQ27XXX_RS			(20) /* Resistor sense mOhm */
 #define BQ27XXX_POWER_CONSTANT		(29200) /* 29.2 µV^2 * 1000 */
 #define BQ27XXX_CURRENT_CONSTANT	(3570) /* 3.57 µV * 1000 */
@@ -102,6 +108,11 @@ enum bq27xxx_reg_index {
 	BQ27XXX_REG_SOC,	/* State-of-Charge */
 	BQ27XXX_REG_DCAP,	/* Design Capacity */
 	BQ27XXX_REG_AP,		/* Average Power */
+	BQ27XXX_DM_CTRL,	/* BlockDataControl() */
+	BQ27XXX_DM_CLASS,	/* DataClass() */
+	BQ27XXX_DM_BLOCK,	/* DataBlock() */
+	BQ27XXX_DM_DATA,	/* BlockData() */
+	BQ27XXX_DM_CKSUM,	/* BlockDataChecksum() */
 	BQ27XXX_REG_MAX,	/* sentinel */
 };
 
@@ -125,6 +136,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
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
@@ -144,6 +160,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x0b,
 		[BQ27XXX_REG_DCAP] = 0x76,
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_CTRL] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_CLASS] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_BLOCK] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_DATA] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_CKSUM] = INVALID_REG_ADDR,
 	},
 	[BQ27500] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -163,6 +184,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x2c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_CTRL] = 0x61,
+		[BQ27XXX_DM_CLASS] = 0x3e,
+		[BQ27XXX_DM_BLOCK] = 0x3f,
+		[BQ27XXX_DM_DATA] = 0x40,
+		[BQ27XXX_DM_CKSUM] = 0x60,
 	},
 	[BQ27510] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -182,6 +208,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x20,
 		[BQ27XXX_REG_DCAP] = 0x2e,
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_CTRL] = 0x61,
+		[BQ27XXX_DM_CLASS] = 0x3e,
+		[BQ27XXX_DM_BLOCK] = 0x3f,
+		[BQ27XXX_DM_DATA] = 0x40,
+		[BQ27XXX_DM_CKSUM] = 0x60,
 	},
 	[BQ27530] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -201,6 +232,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
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
@@ -220,6 +256,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
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
@@ -239,6 +280,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
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
@@ -258,6 +304,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_SOC] = 0x1c,
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x18,
+		[BQ27XXX_DM_CTRL] = 0x61,
+		[BQ27XXX_DM_CLASS] = 0x3e,
+		[BQ27XXX_DM_BLOCK] = 0x3f,
+		[BQ27XXX_DM_DATA] = 0x40,
+		[BQ27XXX_DM_CKSUM] = 0x60,
 	},
 	[BQ27425] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
@@ -277,6 +328,11 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
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
 
@@ -452,6 +508,81 @@ static struct {
 static DEFINE_MUTEX(bq27xxx_list_lock);
 static LIST_HEAD(bq27xxx_battery_devices);
 
+#define BQ27XXX_DM_SZ			32
+
+#define BQ27XXX_MSLEEP(i) usleep_range((i)*1000, (i)*1000+500)
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
+	u8 a[BQ27XXX_DM_SZ];
+	bool full, updt;
+};
+
+#define BQ27XXX_DM_BUF(di, i) { \
+	.class = bq27xxx_dm_regs[(di)->chip][i].subclass_id, \
+	.block = bq27xxx_dm_regs[(di)->chip][i].offset / BQ27XXX_DM_SZ, \
+}
+
+static inline u16* bq27xxx_dm_buf_ptr(struct bq27xxx_dm_buf *buf,
+				      struct bq27xxx_dm_reg *reg) {
+	if (buf->class == reg->subclass_id
+	 && buf->block == reg->offset / BQ27XXX_DM_SZ)
+		return (u16*) (buf->a + reg->offset % BQ27XXX_DM_SZ);
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
+static struct bq27xxx_dm_reg bq27425_dm_regs[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 12, 2,    0, 32767 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 14, 2,    0, 32767 },
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 18, 2, 2800,  3700 },
+};
+
+static struct bq27xxx_dm_reg bq27421_dm_regs[] = { /* not tested */
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0,  8000 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 16, 2, 2500,  3700 },
+};
+
+//static struct bq27xxx_dm_reg bq27621_dm_regs[] = { /* not tested */
+//	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 3, 2,    0,  8000 },
+//	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 5, 2,    0, 32767 },
+//	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 9, 2, 2500,  3700 },
+//};
+
+static struct bq27xxx_dm_reg *bq27xxx_dm_regs[] = {
+	[BQ27421] = bq27421_dm_regs, /* and BQ27441 */
+	[BQ27425] = bq27425_dm_regs,
+//	[BQ27621] = bq27621_dm_regs,
+};
+
+static u32 bq27xxx_unseal_keys[] = {
+	[BQ27421] = 0x80008000, /* and BQ27441 */
+	[BQ27425] = 0x04143672,
+//	[BQ27621] = 0x80008000,
+};
+
+
 static int poll_interval_param_set(const char *val, const struct kernel_param *kp)
 {
 	struct bq27xxx_device_info *di;
@@ -496,6 +627,318 @@ static inline int bq27xxx_read(struct bq27xxx_device_info *di, int reg_index,
 	return di->bus.read(di, di->regs[reg_index], single);
 }
 
+static int bq27xxx_battery_set_seal_state(struct bq27xxx_device_info *di,
+					  bool state)
+{
+	int ret;
+
+	if (state) {
+		ret = di->bus.write(di, di->regs[BQ27XXX_REG_CTRL], BQ27XXX_SEALED, false);
+		if (ret < 0)
+			goto out;
+	} else {
+		u32 key = bq27xxx_unseal_keys[di->chip];
+
+		ret = di->bus.write(di, di->regs[BQ27XXX_REG_CTRL], (u16)(key >> 16), false);
+		if (ret < 0)
+			goto out;
+
+		ret = di->bus.write(di, di->regs[BQ27XXX_REG_CTRL], (u16)key, false);
+		if (ret < 0)
+			goto out;
+	}
+	return 0;
+
+out:
+	dev_err(di->dev, "bus error on %s: %d\n", state ? "seal" : "unseal", ret);
+	return ret;
+}
+
+static u8 bq27xxx_battery_checksum(struct bq27xxx_dm_buf *buf)
+{
+	u16 sum = 0;
+	int i;
+
+	for (i = 0; i < BQ27XXX_DM_SZ; i++)
+		sum += buf->a[i];
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
+	ret = di->bus.write(di, di->regs[BQ27XXX_DM_CLASS], buf->class, true);
+	if (ret < 0)
+		goto out;
+
+	ret = di->bus.write(di, di->regs[BQ27XXX_DM_BLOCK], buf->block, true);
+	if (ret < 0)
+		goto out;
+
+	BQ27XXX_MSLEEP(1);
+
+	ret = di->bus.read_bulk(di, di->regs[BQ27XXX_DM_DATA], buf->a, BQ27XXX_DM_SZ);
+	if (ret < 0)
+		goto out;
+
+	ret = di->bus.read(di, di->regs[BQ27XXX_DM_CKSUM], true);
+	if (ret < 0)
+		goto out;
+
+	if ((u8)ret != bq27xxx_battery_checksum(buf)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	buf->full = true;
+	buf->updt = false;
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
+	struct bq27xxx_dm_reg *reg = &bq27xxx_dm_regs[di->chip][reg_id];
+	const char* str = bq27xxx_dm_reg_name[reg_id];
+	u16 *prev = bq27xxx_dm_buf_ptr(buf, reg);
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
+static int bq27xxx_battery_set_cfgupdate(struct bq27xxx_device_info *di,
+					 bool state)
+{
+	int ret, try=100;
+
+	ret = di->bus.write(di, di->regs[BQ27XXX_REG_CTRL],
+			    state ? BQ27XXX_SET_CFGUPDATE : BQ27XXX_SOFT_RESET,
+			    false);
+	if (ret < 0)
+		goto out;
+
+	if (di->chip == BQ27425) /* chip fails to set/clear flag */
+		return 0;
+
+	do {
+		BQ27XXX_MSLEEP(5);
+		ret = di->bus.read(di, di->regs[BQ27XXX_REG_FLAGS], false);
+		if (ret < 0)
+			goto out;
+	} while (!(ret & BQ27XXX_FLAG_CFGUP) == state && --try);
+
+	if (100-try) /* remove after other cfgupdate parts are tested */
+		dev_info(di->dev, "cfgupdate %d, retries %d\n", state, 100-try);
+
+	if (try)
+		return 0;
+
+	dev_err(di->dev, "timed out waiting for cfgupdate flag %d\n", state);
+	return -EINVAL;
+
+out:
+	dev_err(di->dev, "bus error on %s: %d\n", state ? "set_cfgupdate" : "soft_reset", ret);
+	return ret;
+}
+
+static int bq27xxx_battery_write_dm_block(struct bq27xxx_device_info *di,
+					  struct bq27xxx_dm_buf *buf)
+{
+	bool cfgup = di->chip == BQ27425 || di->chip == BQ27421; /* || BQ27441 || BQ27621 */
+	int ret;
+
+	if (!buf->updt)
+		return 0;
+
+	if (cfgup) {
+		ret = bq27xxx_battery_set_cfgupdate(di, true);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = di->bus.write(di, di->regs[BQ27XXX_DM_CTRL], 0, true);
+	if (ret < 0)
+		goto out;
+
+	ret = di->bus.write(di, di->regs[BQ27XXX_DM_CLASS], buf->class, true);
+	if (ret < 0)
+		goto out;
+
+	ret = di->bus.write(di, di->regs[BQ27XXX_DM_BLOCK], buf->block, true);
+	if (ret < 0)
+		goto out;
+
+	BQ27XXX_MSLEEP(1);
+
+	ret = di->bus.write_bulk(di, di->regs[BQ27XXX_DM_DATA], buf->a, BQ27XXX_DM_SZ);
+	if (ret < 0)
+		goto out;
+
+	ret = di->bus.write(di, di->regs[BQ27XXX_DM_CKSUM],
+			    bq27xxx_battery_checksum(buf), true);
+	if (ret < 0)
+		goto out;
+
+	/* THE FOLLOWING SEQUENCE IS TOXIC. DO NOT USE!
+	 * If the 'time' delay is insufficient, NVM corruption results on
+	 * the '425 chip (and perhaps others), which could damage the chip.
+	 * It was suggested in this TI tool:
+	 *   http://git.ti.com/bms-linux/bqtool/blobs/master/gauge.c#line328
+	 *
+	 * 1. sleep 'time' after above write(BQ27XXX_DM_CKSUM, ...)
+	 * 2. write(BQ27XXX_DM_BLOCK, buf->block)
+	 * 3. sum = read(BQ27XXX_DM_CKSUM)
+	 * 4. if (sum != bq27xxx_battery_checksum(buf))
+	 *      error
+	 */
+
+	if (cfgup) {
+		BQ27XXX_MSLEEP(1);
+		ret = bq27xxx_battery_set_cfgupdate(di, false);
+		if (ret < 0)
+			return ret;
+	}
+
+	buf->updt = false;
+	return 0;
+
+out:
+	if (cfgup)
+		bq27xxx_battery_set_cfgupdate(di, false);
+
+	dev_err(di->dev, "bus error writing chip memory: %d\n", ret);
+	return ret;
+}
+
+static void bq27xxx_battery_set_config(struct bq27xxx_device_info *di,
+				       struct power_supply_battery_info *info)
+{
+	struct bq27xxx_dm_buf bd = BQ27XXX_DM_BUF(di, BQ27XXX_DM_DESIGN_ENERGY);
+	struct bq27xxx_dm_buf bt = BQ27XXX_DM_BUF(di, BQ27XXX_DM_TERMINATE_VOLTAGE);
+
+	if (info->charge_full_design_uah != -EINVAL
+	 && info->energy_full_design_uwh != -EINVAL) {
+		bq27xxx_battery_read_dm_block(di, &bd);
+		/* assume design energy & capacity are in same block */
+		bq27xxx_battery_update_dm_block(di, &bd,
+					BQ27XXX_DM_DESIGN_CAPACITY,
+					info->charge_full_design_uah / 1000);
+		bq27xxx_battery_update_dm_block(di, &bd,
+					BQ27XXX_DM_DESIGN_ENERGY,
+					info->energy_full_design_uwh / 1000);
+	}
+
+	if (info->voltage_min_design_uv != -EINVAL) {
+		bool same = bd.class == bt.class && bd.block == bt.block;
+		if (!same)
+			bq27xxx_battery_read_dm_block(di, &bt);
+		bq27xxx_battery_update_dm_block(di, same ? &bd : &bt,
+					BQ27XXX_DM_TERMINATE_VOLTAGE,
+					info->voltage_min_design_uv / 1000);
+	}
+
+	bq27xxx_battery_write_dm_block(di, &bd);
+	bq27xxx_battery_write_dm_block(di, &bt);
+}
+
+void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
+{
+	struct power_supply_battery_info info = {};
+	unsigned int min, max;
+
+	/* functions don't exist for writing data so abort */
+	if (!di->bus.write || !di->bus.write_bulk)
+		return;
+
+	/* no settings to be set for this chipset so abort */
+	if (!bq27xxx_dm_regs[di->chip])
+		return;
+
+	if (bq27xxx_battery_set_seal_state(di, false) < 0)
+		return;
+
+	if (power_supply_get_battery_info(di->bat, &info) < 0)
+		goto out;
+
+	if (info.energy_full_design_uwh != info.charge_full_design_uah) {
+		if (info.energy_full_design_uwh == -EINVAL)
+			dev_warn(di->dev,
+				"missing battery:energy-full-design-microwatt-hours\n");
+		else if (info.charge_full_design_uah == -EINVAL)
+			dev_warn(di->dev,
+				"missing battery:charge-full-design-microamp-hours\n");
+	}
+
+	/* assume min == 0 */
+	max = bq27xxx_dm_regs[di->chip][BQ27XXX_DM_DESIGN_ENERGY].max;
+	if (info.energy_full_design_uwh > max * 1000) {
+		dev_err(di->dev,
+		       "invalid battery:energy-full-design-microwatt-hours %d\n",
+			info.energy_full_design_uwh);
+		info.energy_full_design_uwh = -EINVAL;
+	}
+
+	/* assume min == 0 */
+	max = bq27xxx_dm_regs[di->chip][BQ27XXX_DM_DESIGN_CAPACITY].max;
+	if (info.charge_full_design_uah > max * 1000) {
+		dev_err(di->dev,
+		       "invalid battery:charge-full-design-microamp-hours %d\n",
+			info.charge_full_design_uah);
+		info.charge_full_design_uah = -EINVAL;
+	}
+
+	min = bq27xxx_dm_regs[di->chip][BQ27XXX_DM_TERMINATE_VOLTAGE].min;
+	max = bq27xxx_dm_regs[di->chip][BQ27XXX_DM_TERMINATE_VOLTAGE].max;
+	if ((info.voltage_min_design_uv < min * 1000
+	  || info.voltage_min_design_uv > max * 1000)
+	  && info.voltage_min_design_uv != -EINVAL) {
+		dev_err(di->dev,
+		       "invalid battery:voltage-min-design-microvolt %d\n",
+			info.voltage_min_design_uv);
+		info.voltage_min_design_uv = -EINVAL;
+	}
+
+	if ((info.energy_full_design_uwh == -EINVAL
+	  || info.charge_full_design_uah == -EINVAL)
+	  && info.voltage_min_design_uv  == -EINVAL)
+		goto out;
+
+	bq27xxx_battery_set_config(di, &info);
+
+out:
+	bq27xxx_battery_set_seal_state(di, true);
+}
+
 /*
  * Return the battery State-of-Charge
  * Or < 0 if something fails.
@@ -1006,6 +1449,13 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 		ret = bq27xxx_simple_value(di->charge_design_full, val);
 		break;
+	/*
+	 * TODO: Implement these to make registers set from
+	 * power_supply_battery_info visible in sysfs.
+	 */
+	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		return -EINVAL;
 	case POWER_SUPPLY_PROP_CYCLE_COUNT:
 		ret = bq27xxx_simple_value(di->cache.cycle_count, val);
 		break;
@@ -1039,7 +1489,10 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
 int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 {
 	struct power_supply_desc *psy_desc;
-	struct power_supply_config psy_cfg = { .drv_data = di, };
+	struct power_supply_config psy_cfg = {
+		.of_node = di->dev->of_node,
+		.drv_data = di,
+	};
 
 	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
 	mutex_init(&di->lock);
@@ -1064,6 +1517,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 
 	dev_info(di->dev, "support ver. %s enabled\n", DRIVER_VERSION);
 
+	bq27xxx_battery_settings(di);
 	bq27xxx_battery_update(di);
 
 	mutex_lock(&bq27xxx_list_lock);
-- 
2.9.3
