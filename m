From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 3/4] power: supply: axp288_fuel_gauge: Unregister duplicate ACPI battery supply
Date: Mon, 20 Mar 2017 14:21:49 +0100
Message-ID: <20170320132150.18771-3-hdegoede@redhat.com>
References: <20170320132150.18771-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753936AbdCTNV6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Mar 2017 09:21:58 -0400
In-Reply-To: <20170320132150.18771-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On some systems with axp288 PMIC the dsdt also exports an ACPI battery
device (PNP0C0A device). This leads to there being 2 battery
power_supply-s registed like this:

~$ acpi
Battery 0: Charging, 84%, 00:49:39 until charged
Battery 1: Unknown, 0%, rate information unavailable

Note that the ACPI battery device does not work properly this is due
to Linux missing support for the vendor specific BMOP ACPI opregion.
But even if the ACPI battery where to function fine we still do not
want to export the same battery to userspace twice.

Therefor this commit calls acpi_battery_unregister() after successfully
registering the axp288-fuel-gauge power_supply to remove the duplicate
(and often broken) ACPI battery power_supply.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=194811
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Sergei Trusov <t.rus76@ya.ru>
---
 drivers/power/supply/Kconfig             | 2 ++
 drivers/power/supply/axp288_fuel_gauge.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index d978d75..ae8363b 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -242,6 +242,8 @@ config AXP288_CHARGER
 config AXP288_FUEL_GAUGE
 	tristate "X-Powers AXP288 Fuel Gauge"
 	depends on MFD_AXP20X && IIO
+	# if ACPI_BATTERY=m, this can't be 'y'
+	depends on ACPI_BATTERY || !ACPI_BATTERY
 	help
 	  Say yes here to have support for X-Power power management IC (PMIC)
 	  Fuel Gauge. The device provides battery statistics and status
diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index a8dcabc..b6efe7d 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -25,6 +25,7 @@
 #include <linux/workqueue.h>
 #include <linux/mfd/axp20x.h>
 #include <linux/platform_device.h>
+#include <linux/power/acpi.h>
 #include <linux/power_supply.h>
 #include <linux/iio/consumer.h>
 #include <linux/debugfs.h>
@@ -754,6 +755,8 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	acpi_battery_unregister();
+
 	fuel_gauge_create_debugfs(info);
 	fuel_gauge_init_irq(info);
 	schedule_delayed_work(&info->status_monitor, STATUS_MON_DELAY_JIFFIES);
-- 
2.9.3
