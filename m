From: Jenny TC <jenny.tc@intel.com>
Subject: [RFC 2/4] power: core: Add generic interface to get battery specification.
Date: Fri,  6 Mar 2015 16:03:25 +0530
Message-ID: <1425638007-9411-3-git-send-email-jenny.tc@intel.com>
References: <1425638007-9411-1-git-send-email-jenny.tc@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425638007-9411-1-git-send-email-jenny.tc@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: Anton Vorontsov <anton.vorontsov@linaro.org>, David Woodhouse <dwmw2@infradead.org>, jonghwa3.lee@samsung.com, myungjoo.ham@gmail.com, Pallala Ramakrishna <ramakrishna.pallala@intel.com>, Jenny TC <jenny.tc@intel.com>
List-Id: linux-pm@vger.kernel.org

In power supply system, battery specification's dealt as static
information regardless of battery chainging. And it often assumed
fuelgauge's role to hold battery specification even same driver is
used with different batteries. To make subsystem handles above cases
properly, this patch adds helper functions to manager the battery
specification.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Jenny TC <jenny.tc@intel.com>
---
 drivers/power/power_supply_core.c |   86 +++++++++++++++++++++++++++++++++++++
 include/linux/power_supply.h      |   12 ++++++
 2 files changed, 98 insertions(+)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 694e8cd..99c3455 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -650,6 +650,92 @@ static void __exit power_supply_class_exit(void)
 subsys_initcall(power_supply_class_init);
 module_exit(power_supply_class_exit);
 
+/****************************************************************
+ *                   Battery information interface              *
+ ****************************************************************/
+
+ATOMIC_NOTIFIER_HEAD(psy_battery_info_notifier);
+static LIST_HEAD(psy_battery_info_list);
+
+struct psy_battery_info {
+	struct list_head entry;
+	struct psy_charging_obj *info;
+};
+
+int psy_battery_info_notifier_register(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&psy_battery_info_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(psy_battery_info_notifier_register);
+
+void psy_battery_info_notifier_unregister(struct notifier_block *nb)
+{
+	atomic_notifier_chain_unregister(&psy_battery_info_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(psy_battery_info_notifier_unregister);
+
+struct psy_charging_obj *psy_get_battery_info(const char *name)
+{
+	struct psy_battery_info *battery;
+
+	/* Sanity check */
+	if (!name)
+		goto err_out;
+
+	list_for_each_entry(battery, &psy_battery_info_list, entry) {
+		if (!strcmp(battery->info->name, name))
+			return battery->info;
+	}
+
+err_out:
+	return NULL;
+}
+EXPORT_SYMBOL(psy_get_battery_info);
+
+int psy_register_battery_info(struct psy_charging_obj *info)
+{
+	struct psy_battery_info *battery;
+
+	/* Sanity check */
+	if (!info->name)
+		return -EINVAL;
+
+	/* Check if same data is existed */
+	list_for_each_entry(battery, &psy_battery_info_list, entry)
+		if (!strcmp(battery->info->name, info->name))
+			return -EEXIST;
+
+	battery = kzalloc(sizeof(*battery), GFP_KERNEL);
+	if (!battery)
+		return -ENOMEM;
+
+	battery->info = info;
+	list_add_tail(&battery->entry, &psy_battery_info_list);
+
+	atomic_notifier_call_chain(&psy_battery_info_notifier,
+				PSY_BATT_INFO_REGISTERED, info);
+
+	return 0;
+}
+EXPORT_SYMBOL(psy_register_battery_info);
+
+void psy_unregister_battery_info(struct psy_charging_obj *info)
+{
+	struct psy_battery_info *battery, *tmp;
+
+	list_for_each_entry_safe(battery, tmp, &psy_battery_info_list, entry) {
+		if (battery->info == info) {
+			list_del(&battery->entry);
+			kfree(battery);
+			return;
+		}
+	}
+
+	atomic_notifier_call_chain(&psy_battery_info_notifier,
+				PSY_BATT_INFO_UNREGISTERED, info);
+}
+EXPORT_SYMBOL(psy_unregister_battery_info);
+
 MODULE_DESCRIPTION("Universal power supply monitor class");
 MODULE_AUTHOR("Ian Molton <spyro@f2s.com>, "
 	      "Szabolcs Gyurko, "
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 7aada44..30145d8e 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -279,6 +279,11 @@ struct psy_charging_obj {
 	struct psy_temp_mon_table temp_mon_table[PSY_MAX_TEMP_ZONE];
 };
 
+enum battery_info_notifier_events {
+	PSY_BATT_INFO_REGISTERED,
+	PSY_BATT_INFO_UNREGISTERED,
+};
+
 extern struct atomic_notifier_head power_supply_notifier;
 extern int power_supply_reg_notifier(struct notifier_block *nb);
 extern void power_supply_unreg_notifier(struct notifier_block *nb);
@@ -311,6 +316,13 @@ extern int power_supply_powers(struct power_supply *psy, struct device *dev);
 /* For APM emulation, think legacy userspace. */
 extern struct class *power_supply_class;
 
+/* Battery information helper */
+extern int psy_battery_info_notifier_register(struct notifier_block *);
+extern void psy_battery_info_notifier_unregister(struct notifier_block *);
+extern struct psy_charging_obj *psy_get_battery_info(const char *);
+extern int psy_register_battery_info(struct psy_charging_obj *);
+extern void psy_unregister_battery_info(struct psy_charging_obj *);
+
 static inline bool power_supply_is_amp_property(enum power_supply_property psp)
 {
 	switch (psp) {
-- 
1.7.9.5
