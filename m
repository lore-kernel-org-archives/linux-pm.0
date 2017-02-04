From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v5 5/8] power: bq27xxx_battery: Add power_supply_battery_info support
Date: Sat,  4 Feb 2017 01:16:00 -0800
Message-ID: <20170204091603.32242-6-liam@networkimprov.net>
References: <20170204091603.32242-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36491 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753745AbdBDJSl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Feb 2017 04:18:41 -0500
Received: by mail-pf0-f193.google.com with SMTP id 19so3235823pfo.3
        for <linux-pm@vger.kernel.org>; Sat, 04 Feb 2017 01:18:40 -0800 (PST)
In-Reply-To: <20170204091603.32242-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, Matt Ranostay <matt@ranostay.consulting>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

From: Matt Ranostay <matt@ranostay.consulting>

From: Matt Ranostay <matt@ranostay.consulting>

Previously there was no way to set chip registers in the event that the
defaults didn't match the battery in question.

BQ27xxx driver now calls power_supply_get_battery_info, checks the inputs,
and writes battery data to NVRAM.

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c | 303 ++++++++++++++++++++++++++++++++-
 include/linux/power/bq27xxx_battery.h  |   1 +
 2 files changed, 303 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 7272d1e..54ef18a 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -37,6 +37,7 @@
  * http://www.ti.com/product/bq27621-g1
  */
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -432,6 +433,54 @@ static struct {
 static DEFINE_MUTEX(bq27xxx_list_lock);
 static LIST_HEAD(bq27xxx_battery_devices);
 
+#define BQ27XXX_MIN_V_MIN	2800
+#define BQ27XXX_MIN_V_MAX	3700
+#define BQ27XXX_MAX_V_MIN	0
+#define BQ27XXX_MAX_V_MAX	5000
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
+	BQ27XXX_DM_DESIGN_CAPACITY = 0,
+	BQ27XXX_DM_DESIGN_ENERGY,
+	BQ27XXX_DM_TERMINATE_VOLTAGE,
+	BQ27XXX_DM_V_AT_CHARGE_TERM,
+	BQ27XXX_DM_END,
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
+	[BQ27XXX_DM_DESIGN_CAPACITY] =
+		{ BQ27XXX_GAS_GAUGING_STATE_SUBCLASS, 12, "design-capacity" },
+	[BQ27XXX_DM_DESIGN_ENERGY] =
+		{ BQ27XXX_GAS_GAUGING_STATE_SUBCLASS, 14, "design-energy" },
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] =
+		{ BQ27XXX_GAS_GAUGING_STATE_SUBCLASS, 18, "terminate-voltage" },
+	[BQ27XXX_DM_V_AT_CHARGE_TERM] =
+		{ BQ27XXX_GAS_GAUGING_STATE_SUBCLASS, 36, "v-at-charge-termination" },
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
@@ -476,6 +525,179 @@ static inline int bq27xxx_read(struct bq27xxx_device_info *di, int reg_index,
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
+	for (i = 0; i < BQ27XXX_DM_END; i++) {
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
+	int ret;
+
+	ret = bq27xxx_battery_read_dm_block(di,
+				BQ27XXX_GAS_GAUGING_STATE_SUBCLASS);
+	if (ret < 0)
+		return ret;
+
+	if (info->charge_full_design_uah != -EINVAL
+	 && info->energy_full_design_uwh != -EINVAL) {
+		ret |= bq27xxx_battery_update_dm_setting(di,
+					BQ27XXX_DM_DESIGN_CAPACITY,
+					info->charge_full_design_uah / 1000);
+		ret |= bq27xxx_battery_update_dm_setting(di,
+					BQ27XXX_DM_DESIGN_ENERGY,
+					info->energy_full_design_uwh / 1000);
+	}
+
+	if (info->voltage_min_design_uv != -EINVAL)
+		ret |= bq27xxx_battery_update_dm_setting(di,
+					BQ27XXX_DM_TERMINATE_VOLTAGE,
+					info->voltage_min_design_uv / 1000);
+
+	if (info->voltage_max_design_uv != -EINVAL)
+		ret |= bq27xxx_battery_update_dm_setting(di,
+					BQ27XXX_DM_V_AT_CHARGE_TERM,
+					info->voltage_max_design_uv / 1000);
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
@@ -736,6 +958,73 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
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
+	if (info.energy_full_design_uwh > 0x7fff * 1000) {
+		dev_err(di->dev, "invalid battery:energy-full-design-microwatt-hours %d\n",
+			info.energy_full_design_uwh);
+		info.energy_full_design_uwh = -EINVAL;
+	}
+
+	if (info.charge_full_design_uah > 0x7fff * 1000) {
+		dev_err(di->dev, "invalid battery:charge-full-design-microamp-hours %d\n",
+			info.charge_full_design_uah);
+		info.charge_full_design_uah = -EINVAL;
+	}
+
+	if ((info.voltage_min_design_uv < BQ27XXX_MIN_V_MIN * 1000
+	  || info.voltage_min_design_uv > BQ27XXX_MIN_V_MAX * 1000)
+	  && info.voltage_min_design_uv != -EINVAL) {
+		dev_err(di->dev, "invalid battery:voltage-min-design-microvolt %d\n",
+			info.voltage_min_design_uv);
+		info.voltage_min_design_uv = -EINVAL;
+	}
+
+	if ((info.voltage_max_design_uv < BQ27XXX_MAX_V_MIN * 1000
+	  || info.voltage_max_design_uv > BQ27XXX_MAX_V_MAX * 1000)
+	  && info.voltage_max_design_uv != -EINVAL) {
+		dev_err(di->dev, "invalid battery:voltage-max-design-microvolt %d\n",
+			info.voltage_max_design_uv);
+		info.voltage_max_design_uv = -EINVAL;
+	}
+
+	if ((info.energy_full_design_uwh == -EINVAL
+	  || info.charge_full_design_uah == -EINVAL)
+	  && info.voltage_min_design_uv  == -EINVAL
+	  && info.voltage_max_design_uv  == -EINVAL)
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
@@ -985,6 +1274,14 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 		ret = bq27xxx_simple_value(di->charge_design_full, val);
 		break;
+	/*
+	 * TODO: Implement these to make registers set from
+	 * power_supply_battery_info visible in sysfs.
+	 */
+	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		return -EINVAL;
 	case POWER_SUPPLY_PROP_CYCLE_COUNT:
 		ret = bq27xxx_simple_value(di->cache.cycle_count, val);
 		break;
@@ -1018,7 +1315,10 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
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
@@ -1043,6 +1343,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 
 	dev_info(di->dev, "support ver. %s enabled\n", DRIVER_VERSION);
 
+	bq27xxx_battery_settings(di);
 	bq27xxx_battery_update(di);
 
 	mutex_lock(&bq27xxx_list_lock);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index bed9557..c433815 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -62,6 +62,7 @@ struct bq27xxx_device_info {
 	struct list_head list;
 	struct mutex lock;
 	u8 *regs;
+	u8 buffer[32];
 };
 
 void bq27xxx_battery_update(struct bq27xxx_device_info *di);
-- 
2.9.3

