From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v14 08/11] power: supply: bq27xxx: Add power_supply_battery_info support
Date: Wed,  7 Jun 2017 11:37:56 -0700
Message-ID: <20170607183759.20261-9-liam@networkimprov.net>
References: <20170607183759.20261-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33913 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbdFGSie (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 14:38:34 -0400
Received: by mail-pg0-f68.google.com with SMTP id v14so2163096pgn.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2017 11:38:33 -0700 (PDT)
In-Reply-To: <20170607183759.20261-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org
Cc: Enric Balletbo <enric.balletbo@collabora.com>, Paul Kocialkowski <contact@paulk.fr>, Quentin Schulz <quentin.schulz@free-electrons.com>, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Previously there was no way to configure these chips in the event that the
defaults didn't match the battery in question.

For chips with RAM data memory (and also those with flash/NVM data memory
if CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is defined and the user has not
set module param dt_monitored_battery_updates_nvm=0) we now call
power_supply_get_battery_info(), check its values, and write battery
properties to chip data memory if there is a dm_regs table for the chip.

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/Kconfig           |  11 ++
 drivers/power/supply/bq27xxx_battery.c | 204 ++++++++++++++++++++++++++++++++-
 include/linux/power/bq27xxx_battery.h  |   2 +
 3 files changed, 216 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 76806a0b..38fae108 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -178,6 +178,17 @@ config BATTERY_BQ27XXX_I2C
 	  Say Y here to enable support for batteries with BQ27xxx chips
 	  connected over an I2C bus.
 
+config BATTERY_BQ27XXX_DT_UPDATES_NVM
+	bool "BQ27xxx support for update of NVM/flash data memory"
+	depends on BATTERY_BQ27XXX_I2C
+	help
+	  Say Y here to enable devicetree monitored-battery config to update
+	  NVM/flash data memory. Only enable this option for devices with a
+	  fuel gauge mounted on the circuit board, and a battery that cannot
+	  easily be replaced with one of a different type. Not for
+	  general-purpose kernels, as this can cause misconfiguration of a
+	  smart battery with embedded NVM/flash.
+
 config BATTERY_DA9030
 	tristate "DA9030 battery driver"
 	depends on PMIC_DA903X
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 6a4ac14c..ed44439d 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -805,6 +805,13 @@ static LIST_HEAD(bq27xxx_battery_devices);
 
 #define BQ27XXX_DM_SZ	32
 
+struct bq27xxx_dm_reg {
+	u8 subclass_id;
+	u8 offset;
+	u8 bytes;
+	u16 min, max;
+};
+
 /**
  * struct bq27xxx_dm_buf - chip data memory buffer
  * @class: data memory subclass_id
@@ -822,6 +829,44 @@ struct bq27xxx_dm_buf {
 	bool has_data, dirty;
 };
 
+#define BQ27XXX_DM_BUF(di, i) { \
+	.class = (di)->dm_regs[i].subclass_id, \
+	.block = (di)->dm_regs[i].offset / BQ27XXX_DM_SZ, \
+}
+
+static inline u16 *bq27xxx_dm_reg_ptr(struct bq27xxx_dm_buf *buf,
+				      struct bq27xxx_dm_reg *reg)
+{
+	if (buf->class == reg->subclass_id &&
+	    buf->block == reg->offset / BQ27XXX_DM_SZ)
+		return (u16 *) (buf->data + reg->offset % BQ27XXX_DM_SZ);
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
+static const char * const bq27xxx_dm_reg_name[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY] = "design-capacity",
+	[BQ27XXX_DM_DESIGN_ENERGY] = "design-energy",
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = "terminate-voltage",
+};
+
+
+static bool bq27xxx_dt_to_nvm = true;
+module_param_named(dt_monitored_battery_updates_nvm, bq27xxx_dt_to_nvm, bool, 0444);
+MODULE_PARM_DESC(dt_monitored_battery_updates_nvm,
+	"Devicetree monitored-battery config updates data memory on NVM/flash chips.\n"
+	"Users must set this =0 when installing a different type of battery!\n"
+	"Default is =1."
+#ifndef CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM
+	"\nSetting this affects future kernel updates, not the current configuration."
+#endif
+);
 
 static int poll_interval_param_set(const char *val, const struct kernel_param *kp)
 {
@@ -1019,6 +1064,55 @@ static int bq27xxx_battery_read_dm_block(struct bq27xxx_device_info *di,
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
+#ifdef CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM
+	if (!di->ram_chip && !bq27xxx_dt_to_nvm) {
+#else
+	if (!di->ram_chip) {
+#endif
+		/* devicetree and NVM differ; defer to NVM */
+		dev_warn(di->dev, "%s has %u; update to %u disallowed "
+#ifdef CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM
+			 "by dt_monitored_battery_updates_nvm=0"
+#else
+			 "for flash/NVM data memory"
+#endif
+			 "\n", str, be16_to_cpup(prev), val);
+		return;
+	}
+
+	dev_info(di->dev, "update %s to %u\n", str, val);
+
+	*prev = cpu_to_be16(val);
+	buf->dirty = true;
+}
+
 static int bq27xxx_battery_cfgupdate_priv(struct bq27xxx_device_info *di, bool active)
 {
 	const int limit = 100;
@@ -1129,6 +1223,103 @@ static int bq27xxx_battery_write_dm_block(struct bq27xxx_device_info *di,
 	return ret;
 }
 
+static void bq27xxx_battery_set_config(struct bq27xxx_device_info *di,
+				       struct power_supply_battery_info *info)
+{
+	struct bq27xxx_dm_buf bd = BQ27XXX_DM_BUF(di, BQ27XXX_DM_DESIGN_CAPACITY);
+	struct bq27xxx_dm_buf bt = BQ27XXX_DM_BUF(di, BQ27XXX_DM_TERMINATE_VOLTAGE);
+	bool updated;
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
+	updated = bd.dirty || bt.dirty;
+
+	bq27xxx_battery_write_dm_block(di, &bd);
+	bq27xxx_battery_write_dm_block(di, &bt);
+
+	bq27xxx_battery_seal(di);
+
+	if (updated && di->chip != BQ27421) { /* not a cfgupdate chip, so reset */
+		bq27xxx_write(di, BQ27XXX_REG_CTRL, BQ27XXX_RESET, false);
+		BQ27XXX_MSLEEP(300); /* reset time is not documented */
+	}
+	/* assume bq27xxx_battery_update() is called hereafter */
+}
+
+static void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
+{
+	struct power_supply_battery_info info = {};
+	unsigned int min, max;
+
+	if (power_supply_get_battery_info(di->bat, &info) < 0)
+		return;
+
+	if (!di->dm_regs) {
+		dev_warn(di->dev, "data memory update not supported for chip\n");
+		return;
+	}
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
@@ -1646,6 +1837,13 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
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
@@ -1679,7 +1877,10 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
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
@@ -1704,6 +1905,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 
 	dev_info(di->dev, "support ver. %s enabled\n", DRIVER_VERSION);
 
+	bq27xxx_battery_settings(di);
 	bq27xxx_battery_update(di);
 
 	mutex_lock(&bq27xxx_list_lock);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index b1defb86..11e11685 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -63,7 +63,9 @@ struct bq27xxx_device_info {
 	struct device *dev;
 	int id;
 	enum bq27xxx_chip chip;
+	bool ram_chip;
 	const char *name;
+	struct bq27xxx_dm_reg *dm_regs;
 	u32 unseal_key;
 	struct bq27xxx_access_methods bus;
 	struct bq27xxx_reg_cache cache;
-- 
2.13.0
