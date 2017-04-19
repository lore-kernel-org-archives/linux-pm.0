From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v7 5/5] power: supply: axp288_charger: Only wait for INT3496 device if present
Date: Wed, 19 Apr 2017 14:02:12 +0200
Message-ID: <20170419120212.24949-6-hdegoede@redhat.com>
References: <20170419120212.24949-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170419120212.24949-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On some devices with an axp288 pmic setting vbus path based on the
id-pin is handled by an ACPI _AIE interrupt on the gpio and the
INT3496 device is disabled.

Instead of returning -EPROBE_DEFER on these devices waiting for the
never to show up INT3496 device, check for its presence and only
request and monitor the matching extcon if the device is there,
otherwise let the firmware handle the vbus path control.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Sebastian Reichel <sre@kernel.org>
---
Changes in v2:
-Do not schedule otg.work to sync the id-pin state when we don't have
 the extcon, this avoids turning off charging as soon as the driver loads
 on devices without the extcon
---
 drivers/power/supply/axp288_charger.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 6be2fe2..d51ebd1 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -14,6 +14,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/regmap.h>
@@ -113,7 +114,8 @@
 #define ILIM_3000MA			3000	/* 3000mA */
 
 #define AXP288_EXTCON_DEV_NAME		"axp288_extcon"
-#define USB_HOST_EXTCON_DEV_NAME	"INT3496:00"
+#define USB_HOST_EXTCON_HID		"INT3496"
+#define USB_HOST_EXTCON_NAME		"INT3496:00"
 
 static const unsigned int cable_ids[] =
 	{ EXTCON_CHG_USB_SDP, EXTCON_CHG_USB_CDP, EXTCON_CHG_USB_DCP };
@@ -807,10 +809,14 @@ static int axp288_charger_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 	}
 
-	info->otg.cable = extcon_get_extcon_dev(USB_HOST_EXTCON_DEV_NAME);
-	if (info->otg.cable == NULL) {
-		dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
-		return -EPROBE_DEFER;
+	if (acpi_dev_present(USB_HOST_EXTCON_HID, NULL, -1)) {
+		info->otg.cable = extcon_get_extcon_dev(USB_HOST_EXTCON_NAME);
+		if (info->otg.cable == NULL) {
+			dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
+			return -EPROBE_DEFER;
+		}
+		dev_info(&pdev->dev,
+			 "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
 	}
 
 	platform_set_drvdata(pdev, info);
@@ -849,13 +855,15 @@ static int axp288_charger_probe(struct platform_device *pdev)
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
+		schedule_work(&info->otg.work);
 	}
-	schedule_work(&info->otg.work);
 
 	/* Register charger interrupts */
 	for (i = 0; i < CHRG_INTR_END; i++) {
-- 
2.9.3

