From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v7 2/6] power: supply: core: Add one field to present the battery internal resistance
Date: Mon,  5 Nov 2018 15:39:07 +0800
Message-ID: <5253c12da08295914dda82d47a130916d0ed0407.1541393063.git.baolin.wang@linaro.org>
References: <5640f29e0b7f46f9ee77d80745f8c93eda355c34.1541393063.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5640f29e0b7f46f9ee77d80745f8c93eda355c34.1541393063.git.baolin.wang@linaro.org>
In-Reply-To: <5640f29e0b7f46f9ee77d80745f8c93eda355c34.1541393063.git.baolin.wang@linaro.org>
References: <5640f29e0b7f46f9ee77d80745f8c93eda355c34.1541393063.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com, linus.walleij@linaro.org, quentin.schulz@bootlin.com
List-Id: linux-pm@vger.kernel.org

Add one field for 'struct power_supply_battery_info' to present the battery
factory internal resistance.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes from v6:
 - None.

Changes from v5:
 - None.

Changes from v4:
 - None.

Changes from v3:
 - New patch in v3, which splits code into one separate patch.
 - Add Linusw reviewed tag.
---
 drivers/power/supply/power_supply_core.c |    3 +++
 include/linux/power_supply.h             |    1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index e853618..307e0995 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -579,6 +579,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->charge_term_current_ua         = -EINVAL;
 	info->constant_charge_current_max_ua = -EINVAL;
 	info->constant_charge_voltage_max_uv = -EINVAL;
+	info->factory_internal_resistance_uohm  = -EINVAL;
 
 	if (!psy->of_node) {
 		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
@@ -616,6 +617,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			     &info->constant_charge_current_max_ua);
 	of_property_read_u32(battery_np, "constant_charge_voltage_max_microvolt",
 			     &info->constant_charge_voltage_max_uv);
+	of_property_read_u32(battery_np, "factory-internal-resistance-micro-ohms",
+			     &info->factory_internal_resistance_uohm);
 
 	return 0;
 }
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index f807691..d089566 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -326,6 +326,7 @@ struct power_supply_battery_info {
 	int charge_term_current_ua;	    /* microAmps */
 	int constant_charge_current_max_ua; /* microAmps */
 	int constant_charge_voltage_max_uv; /* microVolts */
+	int factory_internal_resistance_uohm;   /* microOhms */
 };
 
 extern struct atomic_notifier_head power_supply_notifier;
-- 
1.7.9.5
