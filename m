From: Ognjen Galic <smclt30p@gmail.com>
Subject: [PATCH] pm: Fix build issues in ds278* (thinkpad_acpi)
Date: Sun, 24 Dec 2017 11:06:47 +0100
Message-ID: <20171224100647.GA13797@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

This patch fixes a issue introduced by the thinkpad_acpi
and battery patch series for charging thresholds.

In that series, a new macro has been added to
"include/linux/power_supply.h:374" called to_power_supply
which is used to upcast from a struct device to a struct
power_supply. That change conflicts with the private
implementation of to_power_supply inside the ds2780
and ds2781 battery modules.

This patch removes those private implementations and
uses the new header one.

After applying the thinkpad_acpi and battery patch
series this must be applied to fix the build issues.

This patch depends on:

"[PATCH v10 2/4] pm: add to_power_supply macro to the API"

Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
---
 drivers/power/supply/ds2780_battery.c | 5 -----
 drivers/power/supply/ds2781_battery.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply/ds2780_battery.c
index e5d81b4..370e910 100644
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
index efe83ef..d1b5a19 100644
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
-- 
2.7.4

