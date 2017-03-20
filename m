From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 4/4] power: supply: axp288_charger: Unregister duplicate ACPI ac supply
Date: Mon, 20 Mar 2017 14:21:50 +0100
Message-ID: <20170320132150.18771-4-hdegoede@redhat.com>
References: <20170320132150.18771-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753957AbdCTNWA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Mar 2017 09:22:00 -0400
In-Reply-To: <20170320132150.18771-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On some systems with an axp288 PMIC the dsdt exports a non functional (*)
ACPI AC device (ACPI0003 device), which results in a Mains power_supply
which reports itself as being always online.

This commit calls acpi_ac_unregister() after successfully registering the
axp288_charger power_supply to remove the broken Mains power_supply.

*) It depends on a vendor specific BMOP ACPI opregion we do not implement

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/Kconfig          | 2 ++
 drivers/power/supply/axp288_charger.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index ae8363b..fe53edd 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -235,6 +235,8 @@ config CHARGER_AXP20X
 config AXP288_CHARGER
 	tristate "X-Powers AXP288 Charger"
 	depends on MFD_AXP20X && EXTCON_AXP288
+	# if ACPI_AC=m, this can't be 'y'
+	depends on ACPI_AC || !ACPI_AC
 	help
 	  Say yes here to have support X-Power AXP288 power management IC (PMIC)
 	  integrated charger.
diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 5037d98..b3b5680 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/usb/otg.h>
 #include <linux/notifier.h>
+#include <linux/power/acpi.h>
 #include <linux/power_supply.h>
 #include <linux/property.h>
 #include <linux/mfd/axp20x.h>
@@ -882,6 +883,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
 		}
 	}
 
+	acpi_ac_unregister();
 	return 0;
 }
 
-- 
2.9.3
