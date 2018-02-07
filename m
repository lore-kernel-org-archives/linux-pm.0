From: Ognjen Galic <smclt30p@gmail.com>
Subject: [PATCH v13 2/4] pm: add to_power_supply macro to the API
Date: Wed, 7 Feb 2018 15:58:27 +0100
Message-ID: <20180207145827.yvramuiotxguff2a@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

This patch adds the to_power_supply macro to upcast
a device to a power_supply struct.

This is needed because the same piece of code using
container_of is used in various other places, so we
abstract away such low-level operations via a macro.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
---

Notes:
    v9:
    * Split the pm changes from the thinkpad_acpi patch
      into its own patch
    
    v10:
    * No changes in this patch in v10
    
    v11:
    * Fix changelog formatting
    
    v12:
    * Fix build issues in ds2781 and ds2780 battery driver
    
    v13:
    * No changes in this patch in v13

 drivers/power/supply/ds2780_battery.c    | 5 -----
 drivers/power/supply/ds2781_battery.c    | 5 -----
 drivers/power/supply/power_supply_core.c | 2 +-
 include/linux/power_supply.h             | 2 ++
 4 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply/ds2780_battery.c
index e5d81b493..370e91093 100644
--- a/drivers/power/supply/ds2780_battery.c
+++ b/drivers/power/supply/ds2780_battery.c
@@ -56,11 +56,6 @@ to_ds2780_device_info(struct power_supply *psy)
 	return power_supply_get_drvdata(psy);
 }
 
-static inline struct power_supply *to_power_supply(struct device *dev)
-{
-	return dev_get_drvdata(dev);
-}
-
 static inline int ds2780_battery_io(struct ds2780_device_info *dev_info,
 	char *buf, int addr, size_t count, int io)
 {
diff --git a/drivers/power/supply/ds2781_battery.c b/drivers/power/supply/ds2781_battery.c
index efe83ef86..d1b5a19aa 100644
--- a/drivers/power/supply/ds2781_battery.c
+++ b/drivers/power/supply/ds2781_battery.c
@@ -54,11 +54,6 @@ to_ds2781_device_info(struct power_supply *psy)
 	return power_supply_get_drvdata(psy);
 }
 
-static inline struct power_supply *to_power_supply(struct device *dev)
-{
-	return dev_get_drvdata(dev);
-}
-
 static inline int ds2781_battery_io(struct ds2781_device_info *dev_info,
 	char *buf, int addr, size_t count, int io)
 {
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 82f998ab5..feac7b066 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -668,7 +668,7 @@ EXPORT_SYMBOL_GPL(power_supply_powers);
 
 static void power_supply_dev_release(struct device *dev)
 {
-	struct power_supply *psy = container_of(dev, struct power_supply, dev);
+	struct power_supply *psy = to_power_supply(dev);
 	dev_dbg(dev, "%s\n", __func__);
 	kfree(psy);
 }
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 79e90b3d3..f0139b460 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -371,6 +371,8 @@ devm_power_supply_register_no_ws(struct device *parent,
 extern void power_supply_unregister(struct power_supply *psy);
 extern int power_supply_powers(struct power_supply *psy, struct device *dev);
 
+#define to_power_supply(device) container_of(device, struct power_supply, dev)
+
 extern void *power_supply_get_drvdata(struct power_supply *psy);
 /* For APM emulation, think legacy userspace. */
 extern struct class *power_supply_class;
-- 
2.14.1
