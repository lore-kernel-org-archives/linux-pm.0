From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v12.2 7/9] power: bq27xxx_battery: Add power_supply_battery_info support
Date: Thu, 30 Mar 2017 02:02:14 -0700
Message-ID: <20170330090216.12381-4-liam@networkimprov.net>
References: <20170330090216.12381-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35417 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932706AbdC3JCb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2017 05:02:31 -0400
Received: by mail-pg0-f67.google.com with SMTP id g2so8465260pge.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2017 02:02:30 -0700 (PDT)
In-Reply-To: <20170330090216.12381-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org
Cc: Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Previously there was no way to configure these chips in the event that the
defaults didn't match the battery in question.

We now call power_supply_get_battery_info(), check its values, and write
battery data to chip data memory (flash/RAM/NVM).

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c | 172 ++++++++++++++++++++++++++++++++-
 include/linux/power/bq27xxx_battery.h  |   1 +
 2 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index dbcf14a..4c7a13e 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -853,6 +853,13 @@ static LIST_HEAD(bq27xxx_battery_devices);
 
 #define BQ27XXX_DM_SZ	32
 
+struct bq27xxx_dm_reg {
+	u8 subclass_id;
+	u8 offset;
+	u8 bytes;
+	u16 min, max;
+};
+
 struct bq27xxx_dm_buf {
 	u8 class;
 	u8 block;
@@ -860,6 +867,33 @@ struct bq27xxx_dm_buf {
 	bool has_data, dirty;
 };
 
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
 
 static int poll_interval_param_set(const char *val, const struct kernel_param *kp)
 {
@@ -1042,6 +1076,39 @@ static int bq27xxx_battery_read_dm_block(struct bq27xxx_device_info *di,
 	return ret;
 }
 
+static void bq27xxx_battery_update_dm_block(struct bq27xxx_device_info *di,
+					    struct bq27xxx_dm_buf *buf,
+					    enum bq27xxx_dm_reg_id reg_id,
+					    unsigned int val)
+{
+	struct bq27xxx_dm_reg *reg = &di->dm_regs[reg_id];
+	const char *str = bq27xxx_dm_reg_name[reg_id];
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
+	if (!buf->has_data)
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
+	buf->dirty = true;
+}
+
 static int bq27xxx_battery_set_cfgupdate(struct bq27xxx_device_info *di, u16 state)
 {
 	const int limit = 100;
@@ -1140,6 +1207,98 @@ static int bq27xxx_battery_write_dm_block(struct bq27xxx_device_info *di,
 	return ret;
 }
 
+static void bq27xxx_battery_set_config(struct bq27xxx_device_info *di,
+				       struct power_supply_battery_info *info)
+{
+	struct bq27xxx_dm_buf bd = BQ27XXX_DM_BUF(di, BQ27XXX_DM_DESIGN_CAPACITY);
+	struct bq27xxx_dm_buf bt = BQ27XXX_DM_BUF(di, BQ27XXX_DM_TERMINATE_VOLTAGE);
+
+	if (bq27xxx_battery_unseal(di) < 0)
+		return;
+
+	if (info->charge_full_design_uah != -EINVAL &&
+	    info->energy_full_design_uwh != -EINVAL) {
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
+
+	bq27xxx_battery_seal(di);
+
+	if (di->chip != BQ27421) { /* not a cfgupdate chip, so reset */
+		bq27xxx_write(di, BQ27XXX_REG_CTRL, BQ27XXX_RESET, false);
+		BQ27XXX_MSLEEP(300); /* reset time is not documented */
+	}
+	/* assume bq27xxx_battery_update() is called hereafter */
+}
+
+void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
+{
+	struct power_supply_battery_info info = {};
+	unsigned int min, max;
+
+	if (!di->dm_regs)
+		return;
+
+	if (power_supply_get_battery_info(di->bat, &info) < 0)
+		return;
+
+	if (info.energy_full_design_uwh != info.charge_full_design_uah) {
+		if (info.energy_full_design_uwh == -EINVAL)
+			dev_warn(di->dev, "missing battery:energy-full-design-microwatt-hours\n");
+		else if (info.charge_full_design_uah == -EINVAL)
+			dev_warn(di->dev, "missing battery:charge-full-design-microamp-hours\n");
+	}
+
+	/* assume min == 0 */
+	max = di->dm_regs[BQ27XXX_DM_DESIGN_ENERGY].max;
+	if (info.energy_full_design_uwh > max * 1000) {
+		dev_err(di->dev, "invalid battery:energy-full-design-microwatt-hours %d\n",
+			info.energy_full_design_uwh);
+		info.energy_full_design_uwh = -EINVAL;
+	}
+
+	/* assume min == 0 */
+	max = di->dm_regs[BQ27XXX_DM_DESIGN_CAPACITY].max;
+	if (info.charge_full_design_uah > max * 1000) {
+		dev_err(di->dev, "invalid battery:charge-full-design-microamp-hours %d\n",
+			info.charge_full_design_uah);
+		info.charge_full_design_uah = -EINVAL;
+	}
+
+	min = di->dm_regs[BQ27XXX_DM_TERMINATE_VOLTAGE].min;
+	max = di->dm_regs[BQ27XXX_DM_TERMINATE_VOLTAGE].max;
+	if ((info.voltage_min_design_uv < min * 1000 ||
+	     info.voltage_min_design_uv > max * 1000) &&
+	     info.voltage_min_design_uv != -EINVAL) {
+		dev_err(di->dev, "invalid battery:voltage-min-design-microvolt %d\n",
+			info.voltage_min_design_uv);
+		info.voltage_min_design_uv = -EINVAL;
+	}
+
+	if ((info.energy_full_design_uwh != -EINVAL &&
+	     info.charge_full_design_uah != -EINVAL) ||
+	     info.voltage_min_design_uv  != -EINVAL)
+		bq27xxx_battery_set_config(di, &info);
+}
+
 /*
  * Return the battery State-of-Charge
  * Or < 0 if something fails.
@@ -1657,6 +1816,13 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
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
@@ -1690,7 +1856,10 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
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
@@ -1715,6 +1884,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 
 	dev_info(di->dev, "support ver. %s enabled\n", DRIVER_VERSION);
 
+	bq27xxx_battery_settings(di);
 	bq27xxx_battery_update(di);
 
 	mutex_lock(&bq27xxx_list_lock);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index b1defb8..227eb08 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -64,6 +64,7 @@ struct bq27xxx_device_info {
 	int id;
 	enum bq27xxx_chip chip;
 	const char *name;
+	struct bq27xxx_dm_reg *dm_regs;
 	u32 unseal_key;
 	struct bq27xxx_access_methods bus;
 	struct bq27xxx_reg_cache cache;
-- 
2.9.3
