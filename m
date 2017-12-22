From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 16/16] power: supply: axp288_fuel_gauge: Do not register our psy on (some) HDMI sticks
Date: Fri, 22 Dec 2017 13:37:54 +0100
Message-ID: <20171222123754.9622-16-hdegoede@redhat.com>
References: <20171222123754.9622-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753398AbdLVMiS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Dec 2017 07:38:18 -0500
In-Reply-To: <20171222123754.9622-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

The Intel Compute Stick (Cherry Trail version) and the Meegopad T08 HDMI
stick, both use an axp288 PMIC.  They also both have this wired up in such
a way that the detection logic in the PMIC claims that a valid battery is
present, resuling in GNOME and KDE showing a full-battery in their status
bar and power-settings, while these devices do not have a battery.

For lack of a better fix add a DMI blacklist and do not register the
axp288_fuel_gauge psy on devices on the blacklist.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 5750b6caecd4..94f93cd757ac 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -17,6 +17,7 @@
  *
  */
 
+#include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
@@ -694,6 +695,37 @@ static void fuel_gauge_init_irq(struct axp288_fg_info *info)
 	}
 }
 
+/*
+ * Some devices have no battery (HDMI sticks) and the axp288 battery's
+ * detection reports one despite it not being there.
+ */
+static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
+	{
+		/* Intel Cherry Trail Compute Stick, Windows version */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "STK1AW32SC"),
+		},
+	},
+	{
+		/* Intel Cherry Trail Compute Stick, version without an OS */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "STK1A32SC"),
+		},
+	},
+	{
+		/* Meegopad T08 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Default string"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "To be filled by OEM."),
+			DMI_MATCH(DMI_BOARD_NAME, "T3 MRD"),
+			DMI_MATCH(DMI_BOARD_VERSION, "V1.1"),
+		},
+	},
+	{}
+};
+
 static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 {
 	int i, ret = 0;
@@ -709,6 +741,9 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 		[BAT_VOLT] = "axp288-batt-volt",
 	};
 
+	if (dmi_check_system(axp288_fuel_gauge_blacklist))
+		return -ENODEV;
+
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-- 
2.14.3
