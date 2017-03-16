From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/4] power: supply: axp288_charger: Unregister duplicate ACPI ac supply
Date: Thu, 16 Mar 2017 17:16:01 +0100
Message-ID: <20170316161601.32267-5-hdegoede@redhat.com>
References: <20170316161601.32267-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170316161601.32267-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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
index e504644..8ee03d7 100644
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
index 6be2fe2..d3bf4b2 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -23,6 +23,7 @@
 #include <linux/usb/otg.h>
 #include <linux/notifier.h>
 #include <linux/power_supply.h>
+#include <linux/power/acpi.h>
 #include <linux/property.h>
 #include <linux/mfd/axp20x.h>
 #include <linux/extcon.h>
@@ -876,6 +877,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
 		}
 	}
 
+	acpi_ac_unregister();
 	return 0;
 }
 
-- 
2.9.3

