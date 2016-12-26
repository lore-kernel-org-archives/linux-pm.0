From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Subject: [PATCH 3/3] power: bq27xxx: add support for NVRAM R/W access
Date: Sun, 25 Dec 2016 21:44:42 -0800
Message-ID: <20161226054442.23599-4-matt@ranostay.consulting>
References: <20161226054442.23599-1-matt@ranostay.consulting>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161226054442.23599-1-matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Initial support for access and modification of the non-volatile regions
of the bq27425 fuel gauge DesignEnergy, DesignCapacity, and
TerminateVoltage settings.

This is intended for fine tuning the fuel gauge state machine for the
respective battery specifications.

Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
---
 drivers/power/supply/bq27xxx_battery_i2c.c | 334 +++++++++++++++++++++++++++++
 include/linux/power/bq27xxx_battery.h      |   4 +
 2 files changed, 338 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 27143230839a..c6f641cd3940 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -14,9 +14,11 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <asm/unaligned.h>
 
 #include <linux/power/bq27xxx_battery.h>
@@ -24,6 +26,48 @@
 static DEFINE_IDR(battery_id);
 static DEFINE_MUTEX(battery_mutex);
 
+#define BQ27XXX_TERM_V_MIN	2800
+#define BQ27XXX_TERM_V_MAX	3700
+
+#define BQ27XXX_REG_CTRL		0
+
+#define BQ27XXX_BLOCK_DATA_CLASS	0x3E
+#define BQ27XXX_DATA_BLOCK		0x3F
+#define BQ27XXX_BLOCK_DATA		0x40
+#define BQ27XXX_BLOCK_DATA_CHECKSUM	0x60
+#define BQ27XXX_BLOCK_DATA_CONTROL	0x61
+#define BQ27XXX_SET_CFGUPDATE		0x13
+#define BQ27XXX_SOFT_RESET		0x42
+
+enum bq27xxx_dm_subclass_index {
+	BQ27XXX_DM_DESIGN_CAP = 0,
+	BQ27XXX_DM_DESIGN_ENERGY,
+	BQ27XXX_DM_TERMINATE_VOLTAGE,
+	BQ27XXX_NUM_IDX,
+};
+
+struct bq27xxx_dm_regs {
+	unsigned int subclass_id;
+	unsigned int offset;
+	char *name;
+};
+
+#define BQ27XXX_GAS_GAUGING_STATE_SUBCLASS	82
+
+static struct bq27xxx_dm_regs bq27425_dm_subclass_regs[] = {
+	{ BQ27XXX_GAS_GAUGING_STATE_SUBCLASS, 12, "design-capacity" },
+	{ BQ27XXX_GAS_GAUGING_STATE_SUBCLASS, 14, "design-energy" },
+	{ BQ27XXX_GAS_GAUGING_STATE_SUBCLASS, 18, "terminate-voltage" },
+};
+
+static struct bq27xxx_dm_regs *bq27xxx_dm_subclass_regs[] = {
+	[BQ27425] = bq27425_dm_subclass_regs,
+};
+
+static unsigned int bq27xxx_unseal_keys[] = {
+	[BQ27425] = 0x04143672,
+};
+
 static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void *data)
 {
 	struct bq27xxx_device_info *di = data;
@@ -68,6 +112,288 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
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
+static int bq27xxx_battery_i2c_set_seal_state(struct bq27xxx_device_info *di,
+					      bool state)
+{
+	unsigned int key = bq27xxx_unseal_keys[di->chip];
+	int ret;
+
+	if (state)
+		return di->bus.write(di, BQ27XXX_REG_CTRL, 0x20, false);
+
+	ret = di->bus.write(di, BQ27XXX_REG_CTRL, (key >> 16) & 0xffff, false);
+	if (ret < 0)
+		return ret;
+
+	return di->bus.write(di, BQ27XXX_REG_CTRL, key & 0xffff, false);
+}
+
+static int bq27xxx_battery_i2c_read_dm_block(struct bq27xxx_device_info *di,
+					     int subclass)
+{
+	int ret = di->bus.write(di, BQ27XXX_REG_CTRL, 0, false);
+
+	if (ret < 0)
+		return ret;
+
+	ret = di->bus.write(di, BQ27XXX_BLOCK_DATA_CONTROL, 0, true);
+	if (ret < 0)
+		return ret;
+
+	ret = di->bus.write(di, BQ27XXX_BLOCK_DATA_CLASS, subclass, true);
+	if (ret < 0)
+		return ret;
+
+	ret = di->bus.write(di, BQ27XXX_DATA_BLOCK, 0, true);
+	if (ret < 0)
+		return ret;
+
+	usleep_range(1000, 1500);
+
+	return di->bus.read_bulk(di, BQ27XXX_BLOCK_DATA,
+				(u8 *) &di->buffer, sizeof(di->buffer));
+}
+
+static int bq27xxx_battery_i2c_print_config(struct bq27xxx_device_info *di)
+{
+	struct bq27xxx_dm_regs *reg = bq27xxx_dm_subclass_regs[di->chip];
+	int ret, i;
+
+	ret = bq27xxx_battery_i2c_read_dm_block(di,
+			BQ27XXX_GAS_GAUGING_STATE_SUBCLASS);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < BQ27XXX_NUM_IDX; i++) {
+		int val;
+
+		if (reg->subclass_id != BQ27XXX_GAS_GAUGING_STATE_SUBCLASS)
+			continue;
+
+		val = be16_to_cpup((u16 *) &di->buffer[reg->offset]);
+
+		dev_info(di->dev, "settings for %s set at %d\n", reg->name, val);
+
+		reg++;
+	}
+
+	return 0;
+}
+
+static bool bq27xxx_battery_update_dm_setting(struct bq27xxx_device_info *di,
+			      unsigned int reg, unsigned int val)
+{
+	struct bq27xxx_dm_regs *dm_reg = &bq27xxx_dm_subclass_regs[di->chip][reg];
+	u16 *prev = (u16 *) &di->buffer[dm_reg->offset];
+
+	if (be16_to_cpup(prev) == val)
+		return false;
+
+	*prev = cpu_to_be16(val);
+
+	return true;
+}
+
+static u8 bq27xxx_battery_checksum(struct bq27xxx_device_info *di)
+{
+	u8 *data = (u8 *) &di->buffer;
+	u16 sum = 0;
+	int i;
+
+	for (i = 0; i < sizeof(di->buffer); i++) {
+		sum += data[i];
+		sum &= 0xff;
+	}
+
+	return 0xff - sum;
+}
+
+static int bq27xxx_battery_i2c_write_nvram(struct bq27xxx_device_info *di,
+					   unsigned int subclass)
+{
+	int ret;
+
+	ret = di->bus.write(di, BQ27XXX_REG_CTRL, BQ27XXX_SET_CFGUPDATE, false);
+	if (ret)
+		return ret;
+
+	ret = di->bus.write(di, BQ27XXX_BLOCK_DATA_CONTROL, 0, true);
+	if (ret)
+		return ret;
+
+	ret = di->bus.write(di, BQ27XXX_BLOCK_DATA_CLASS, subclass, true);
+	if (ret)
+		return ret;
+
+	ret = di->bus.write(di, BQ27XXX_DATA_BLOCK, 0, true);
+	if (ret)
+		return ret;
+
+	ret = di->bus.write_bulk(di, BQ27XXX_BLOCK_DATA,
+				(u8 *) &di->buffer, sizeof(di->buffer));
+	if (ret < 0)
+		return ret;
+
+	usleep_range(1000, 1500);
+
+	di->bus.write(di, BQ27XXX_BLOCK_DATA_CHECKSUM,
+				bq27xxx_battery_checksum(di), true);
+
+	usleep_range(1000, 1500);
+
+	di->bus.write(di, BQ27XXX_REG_CTRL, BQ27XXX_SOFT_RESET, false);
+
+	return 0;
+}
+
+static int bq27xxx_battery_i2c_set_config(struct bq27xxx_device_info *di,
+					  unsigned int cap, unsigned int energy,
+					  unsigned int voltage)
+{
+	int ret = bq27xxx_battery_i2c_read_dm_block(di,
+				BQ27XXX_GAS_GAUGING_STATE_SUBCLASS);
+
+	if (ret < 0)
+		return ret;
+
+	ret  = bq27xxx_battery_update_dm_setting(di, BQ27XXX_DM_DESIGN_CAP, cap);
+	ret |= bq27xxx_battery_update_dm_setting(di, BQ27XXX_DM_DESIGN_ENERGY,
+						 energy);
+	ret |= bq27xxx_battery_update_dm_setting(di, BQ27XXX_DM_TERMINATE_VOLTAGE,
+						 voltage);
+
+	if (ret) {
+		dev_info(di->dev, "updating NVM settings\n");
+		return bq27xxx_battery_i2c_write_nvram(di,
+				BQ27XXX_GAS_GAUGING_STATE_SUBCLASS);
+	}
+
+	return 0;
+}
+
+static int bq27xxx_battery_i2c_parse_dt(struct bq27xxx_device_info *di)
+{
+	struct device_node *np = di->dev->of_node;
+	int cap, energy, voltage = -EINVAL;
+	int ret = 0;
+
+	/* no settings to be set for this chipset so abort */
+	if (!bq27xxx_dm_subclass_regs[di->chip])
+		return 0;
+
+	bq27xxx_battery_i2c_set_seal_state(di, false);
+
+	if (np) {
+		ret = of_property_read_u32(np, "ti,design-capacity", &cap);
+		if (ret < 0 || cap > 0x7fff) {
+			if (!ret)
+				dev_err(di->dev,
+					"invalid ti,design-capacity %d\n",
+					cap);
+			cap = -EINVAL;
+		}
+
+		ret = of_property_read_u32(np, "ti,design-energy", &energy);
+		if (ret < 0 || energy > 0x7fff) {
+			if (!ret)
+				dev_err(di->dev,
+					"invalid ti,design-energy %d\n",
+					energy);
+			energy = -EINVAL;
+		}
+
+		ret = of_property_read_u32(np, "ti,terminate-voltage", &voltage);
+		if (ret < 0 || voltage < BQ27XXX_TERM_V_MIN
+			    || voltage > BQ27XXX_TERM_V_MAX) {
+			if (!ret)
+				dev_err(di->dev,
+					"invalid ti,terminate-voltage %d\n",
+					voltage);
+			voltage = -EINVAL;
+		}
+
+		/* assume that we want the defaults */
+		if (cap < 0 && energy < 0 && voltage < 0) {
+			ret = 0;
+			goto out;
+		}
+
+		/* we need all three settings for safety reasons */
+		if (cap < 0 || energy < 0 || voltage < 0) {
+			dev_err(di->dev,
+				"missing or invalid devicetree values; NVM not updated\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = bq27xxx_battery_i2c_set_config(di, cap, energy, voltage);
+	}
+
+out:
+	bq27xxx_battery_i2c_print_config(di);
+	bq27xxx_battery_i2c_set_seal_state(di, true);
+
+	return ret;
+}
+
 static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 				     const struct i2c_device_id *id)
 {
@@ -95,7 +421,15 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 	di->dev = &client->dev;
 	di->chip = id->driver_data;
 	di->name = name;
+
 	di->bus.read = bq27xxx_battery_i2c_read;
+	di->bus.write = bq27xxx_battery_i2c_write;
+	di->bus.read_bulk = bq27xxx_battery_i2c_bulk_read;
+	di->bus.write_bulk = bq27xxx_battery_i2c_bulk_write;
+
+	ret = bq27xxx_battery_i2c_parse_dt(di);
+	if (ret)
+		goto err_failed;
 
 	ret = bq27xxx_battery_setup(di);
 	if (ret)
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 14ecac158150..22b4cfc3acab 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -33,6 +33,9 @@ struct bq27xxx_platform_data {
 struct bq27xxx_device_info;
 struct bq27xxx_access_methods {
 	int (*read)(struct bq27xxx_device_info *di, u8 reg, bool single);
+	int (*write)(struct bq27xxx_device_info *di, u8 reg, int value, bool single);
+	int (*read_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);
+	int (*write_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);
 };
 
 struct bq27xxx_reg_cache {
@@ -62,6 +65,7 @@ struct bq27xxx_device_info {
 	struct power_supply *bat;
 	struct list_head list;
 	struct mutex lock;
+	u8 buffer[32];
 	u8 *regs;
 };
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
