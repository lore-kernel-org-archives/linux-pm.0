From: Ognjen Galic <smclt30p@gmail.com>
Subject: [PATCH v11 5/5] pm: Remove to_power_supply impl in ds278*
Date: Sun, 31 Dec 2017 15:17:57 +0100
Message-ID: <20171231141757.GA4674@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

This patch fixes a issue introduced by patch:
pm: add to_power_supply macro to the API

In that patch a new macro has been defined in the
power_supply.h header with the same name as the private
function name in the ds278* battery modules that does the
same thing, thus clashing and producing build errors.

This patch removes that private implementation.

Signed-off-by: Ognjen Galic <smclt30p@gmail.com>

v11:
* Fix build error pointed out by the Intel automated
kernel build daemon/bot
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
