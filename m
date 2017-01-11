From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Subject: [PATCH v3 7/7] power: bq27xxx_battery: add initial state machine support
Date: Tue, 10 Jan 2017 22:20:03 -0800
Message-ID: <20170111062003.10110-8-matt@ranostay.consulting>
References: <20170111062003.10110-1-matt@ranostay.consulting>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170111062003.10110-1-matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
---
 drivers/power/supply/bq27xxx_battery.c | 230 ++++++++++++++++++++++++++++++++-
 1 file changed, 229 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 7475a5f31c53..edb4bc78ae4d 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -37,6 +37,7 @@
  * http://www.ti.com/product/bq27621-g1
  */
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -452,6 +453,46 @@ static struct {
 static DEFINE_MUTEX(bq27xxx_list_lock);
 static LIST_HEAD(bq27xxx_battery_devices);
 
+#define BQ27XXX_TERM_V_MIN	2800
+#define BQ27XXX_TERM_V_MAX	3700
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
 static int poll_interval_param_set(const char *val, const struct kernel_param *kp)
 {
 	struct bq27xxx_device_info *di;
@@ -496,6 +537,165 @@ static inline int bq27xxx_read(struct bq27xxx_device_info *di, int reg_index,
 	return di->bus.read(di, di->regs[reg_index], single);
 }
 
+static int bq27xxx_battery_set_seal_state(struct bq27xxx_device_info *di,
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
+static int bq27xxx_battery_read_dm_block(struct bq27xxx_device_info *di,
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
+static int bq27xxx_battery_print_config(struct bq27xxx_device_info *di)
+{
+	struct bq27xxx_dm_regs *reg = bq27xxx_dm_subclass_regs[di->chip];
+	int ret, i;
+
+	ret = bq27xxx_battery_read_dm_block(di,
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
+static int bq27xxx_battery_write_nvram(struct bq27xxx_device_info *di,
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
+static int bq27xxx_battery_set_config(struct bq27xxx_device_info *di,
+				      struct power_supply_battery_info *info)
+{
+	int ret = bq27xxx_battery_read_dm_block(di,
+				BQ27XXX_GAS_GAUGING_STATE_SUBCLASS);
+
+	if (ret < 0)
+		return ret;
+
+	ret  = bq27xxx_battery_update_dm_setting(di, BQ27XXX_DM_DESIGN_CAP,
+						 info->power / 1000);
+	ret |= bq27xxx_battery_update_dm_setting(di, BQ27XXX_DM_DESIGN_ENERGY,
+						 info->energy / 1000);
+	ret |= bq27xxx_battery_update_dm_setting(di, BQ27XXX_DM_TERMINATE_VOLTAGE,
+						 info->nominal_voltage / 1000);
+
+	if (ret) {
+		dev_info(di->dev, "updating NVM settings\n");
+		return bq27xxx_battery_write_nvram(di,
+				BQ27XXX_GAS_GAUGING_STATE_SUBCLASS);
+	}
+
+	return 0;
+}
+
 /*
  * Return the battery State-of-Charge
  * Or < 0 if something fails.
@@ -757,6 +957,30 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 	return POWER_SUPPLY_HEALTH_GOOD;
 }
 
+void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
+{
+	struct power_supply_battery_info info = {};
+
+	/* functions don't exist for writing data so abort */
+	if (!di->bus.write || !di->bus.write_bulk)
+		return;
+
+	/* no settings to be set for this chipset so abort */
+	if (!bq27xxx_dm_subclass_regs[di->chip])
+		return;
+
+	bq27xxx_battery_set_seal_state(di, false);
+
+	if (power_supply_get_battery_info(di->bat, &info, "monitored-battery") < 0)
+		goto out;
+
+	bq27xxx_battery_set_config(di, &info);
+
+out:
+	bq27xxx_battery_print_config(di);
+	bq27xxx_battery_set_seal_state(di, true);
+}
+
 void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 {
 	struct bq27xxx_reg_cache cache = {0, };
@@ -1039,7 +1263,10 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
 int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 {
 	struct power_supply_desc *psy_desc;
-	struct power_supply_config psy_cfg = { .drv_data = di, };
+	struct power_supply_config psy_cfg;
+
+	psy_cfg.of_node = di->dev->of_node;
+	psy_cfg.drv_data = di;
 
 	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
 	mutex_init(&di->lock);
@@ -1064,6 +1291,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 
 	dev_info(di->dev, "support ver. %s enabled\n", DRIVER_VERSION);
 
+	bq27xxx_battery_settings(di);
 	bq27xxx_battery_update(di);
 
 	mutex_lock(&bq27xxx_list_lock);
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
