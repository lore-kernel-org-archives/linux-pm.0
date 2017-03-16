From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] power: supply: axp288_charger: Only wait for INT3496 device if present
Date: Thu, 16 Mar 2017 17:17:36 +0100
Message-ID: <20170316161736.339-3-hdegoede@redhat.com>
References: <20170316161736.339-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753235AbdCPQRo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Mar 2017 12:17:44 -0400
In-Reply-To: <20170316161736.339-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On some devices with an axp288 pmic setting vbus path based on the
id-pin is handled by an ACPI _AIE interrupt on the gpio and the
INT3496 device is disabled.

Instead of returning -EPROBE_DEFER on these devices waiting for the
never to show up INT3496 device, check for its presence and only
request and monitor the matching extcon if the device is there,
otherwise let the firmware handle the vbus path control.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index d3bf4b2..6c4ad66 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -14,6 +14,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/regmap.h>
@@ -114,7 +115,8 @@
 #define ILIM_3000MA			3000	/* 3000mA */
 
 #define AXP288_EXTCON_DEV_NAME		"axp288_extcon"
-#define USB_HOST_EXTCON_DEV_NAME	"INT3496:00"
+#define USB_HOST_EXTCON_HID		"INT3496"
+#define USB_HOST_EXTCON_NAME		"INT3496:00"
 
 static const unsigned int cable_ids[] =
 	{ EXTCON_CHG_USB_SDP, EXTCON_CHG_USB_CDP, EXTCON_CHG_USB_DCP };
@@ -808,10 +810,12 @@ static int axp288_charger_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 	}
 
-	info->otg.cable = extcon_get_extcon_dev(USB_HOST_EXTCON_DEV_NAME);
-	if (info->otg.cable == NULL) {
-		dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
-		return -EPROBE_DEFER;
+	if (acpi_dev_present(USB_HOST_EXTCON_HID)) {
+		info->otg.cable = extcon_get_extcon_dev(USB_HOST_EXTCON_NAME);
+		if (info->otg.cable == NULL) {
+			dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
+			return -EPROBE_DEFER;
+		}
 	}
 
 	platform_set_drvdata(pdev, info);
@@ -850,11 +854,13 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	/* Register for OTG notification */
 	INIT_WORK(&info->otg.work, axp288_charger_otg_evt_worker);
 	info->otg.id_nb.notifier_call = axp288_charger_handle_otg_evt;
-	ret = devm_extcon_register_notifier(&pdev->dev, info->otg.cable,
+	if (info->otg.cable) {
+		ret = devm_extcon_register_notifier(&pdev->dev, info->otg.cable,
 					EXTCON_USB_HOST, &info->otg.id_nb);
-	if (ret) {
-		dev_err(dev, "failed to register EXTCON_USB_HOST notifier\n");
-		return ret;
+		if (ret) {
+			dev_err(dev, "failed to register EXTCON_USB_HOST notifier\n");
+			return ret;
+		}
 	}
 	schedule_work(&info->otg.work);
 
-- 
2.9.3
